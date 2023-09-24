(use-modules (gnu))
(use-service-modules cups desktop networking ssh xorg sddm linux docker sysctl)

(use-modules (nongnu packages linux)
             (nongnu system linux-initrd)
	     (gnu packages shells)
	     (gnu packages hurd)
	     (gnu packages nvi)
	     (gnu packages vim)
             (gnu packages samba)
	     (gnu services virtualization)
             (gnu system setuid)
	     (guix build-system trivial)
	     (guix channels)
	     (guix inferior)
	     (guix packages)
	     (guix store)
	     (srfi srfi-1))

(define cross-mach (package-cross-derivation (open-connection) gnumach "i586-pc-gnu"))

(define vim-as-vi
  (package
    (name "vim-as-vi")
    (version (package-version vim))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules ((guix build utils))
	#:builder
        (begin
          (use-modules (guix build utils))

	  (let* ((out (assoc-ref %outputs "out")) (vim (assoc-ref %build-inputs "vim")))
            (mkdir out)
            (mkdir (string-append out "/bin"))
            (chdir (string-append out "/bin"))
            (symlink (string-append vim "/bin/vim") "vi")))))
    (inputs (list vim))
    (synopsis "Symlink vi to vim")
    (description "Make vi as symlink to vim. This collides with nvi.")
    (home-page (package-home-page vim))
    (license (package-license vim))))

(operating-system
  (kernel
   (let*
    ((channels
     (list
      (channel
       (name 'nonguix)
       (url "https://gitlab.com/nonguix/nonguix")
       (commit "bb184bd0a8f91beec3a00718759e96c7828853de")
       (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
       (name 'guix)
       (url "https://git.savannah.gnu.org/git/guix.git")
       (commit "c5657608c6eded81dd064271690a507118342328"))))
     (inferior
      (inferior-for-channels channels)))
     (first (lookup-inferior-packages inferior "linux" "6.4.16"))))
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))
  (host-name "guix")

  (users (cons* (user-account
                  (name "laura")
                  (comment "Laura")
                  (group "users")
                  (home-directory "/home/laura")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "kvm"))
		  (shell (file-append zsh "/bin/zsh"))
	          (password "$6$laura$fD5qdRCoSiQu4XHSx6l2SBy2OekYfU40jRfIaUUfdFQJXKj3yoyHB3KdQXj/5O9.un48wTKCwYrAXOsUKjJrk0"))
                %base-user-accounts))

  (packages (filter (lambda (x) (not (eq? x nvi))) (append (append (map specification->package '(
	"nss-certs" "vim" "curl" "python" "kexec-tools" "zsh" "git"
    )) %base-packages) (list vim-as-vi))))

  (services
   (remove (lambda (service) (memq (service-kind service) (list gdm-service-type sddm-service-type)))
   (append (list (service plasma-desktop-service-type)
		 (service sddm-service-type
			  (sddm-configuration
			    (theme "breeze")))

                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout)))

                 (service guix-publish-service-type
		  (guix-publish-configuration
		   (advertise? #t)))

                 (service gnome-keyring-service-type)

                 (service earlyoom-service-type)

                 (service docker-service-type)

		 (service qemu-binfmt-service-type
	          (qemu-binfmt-configuration
                   (platforms (lookup-qemu-platforms "arm" "aarch64" "riscv32" "riscv64" "mips" "mips64" "mips64el" "mipsel" "mipsn32" "mipsn32el" "s390x" "sparc" "sparc32plus" "sparc64" "alpha" "ppc" "ppc64" "ppc64le")))))

                (modify-services %desktop-services
                 (guix-service-type config => (guix-configuration
                   (inherit config)
                   (substitute-urls
                    (append (list "https://substitutes.nonguix.org")
                      %default-substitute-urls))
                   (authorized-keys
                    (append (list (plain-file "non-guix.pub" "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                      %default-authorized-guix-keys))))
                  (sysctl-service-type config =>
                    (sysctl-configuration
                      (settings (append '(("net.ipv4.ip_forward" . "1"))
                        %default-sysctl-settings))))))))

  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list))
                (keyboard-layout keyboard-layout)
		(menu-entries (list
		  (menu-entry
		    (label "GNU Mach")
		    (multiboot-kernel (file-append cross-mach "/boot/gnumach")))))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "94564faf-9ed7-4f74-bd7d-3a6ce3c4a512"
                                  'btrfs))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/smb")
                         (device "//s-files.fritz.box/jakob")
                         (type "cifs")
                         (options "username=jakob,password=kira,_netdev")
                         (mount? #f)) %base-file-systems))

  (setuid-programs (cons (setuid-program (program (file-append cifs-utils "/sbin/mount.cifs")))
    %setuid-programs))

  (name-service-switch %mdns-host-lookup-nss)

  (skeletons (append `((".zshrc" ,(plain-file "zshrc" "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended\necho \"autoload -U compinit && compinit\\nsource ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh\" >> ~/.zshrc\ngit clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions\nexec zsh"))) (default-skeletons)))

  (sudoers-file
   (plain-file "sudoers"
    (string-append (plain-file-content %sudoers-specification)
     (format #f "~a ALL = NOPASSWD: ALL~%" "laura")))))
