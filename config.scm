(include "secrets.scm")

(use-modules (gnu))
(use-service-modules
  cups
  desktop
  networking
  ssh
  xorg
  sddm
  linux
  docker
  sysctl)

(use-modules
  (nongnu packages linux)
  (nongnu system linux-initrd)
  (gnu packages shells)
  (gnu packages hurd)
  (gnu packages nvi)
  (gnu packages vim)
  (gnu packages samba)
  (gnu packages file)
  (gnu packages admin)
  (gnu packages bash)
  (gnu packages radio)
  (gnu packages gcc)
  (gnu packages python)
  (gnu packages package-management)
  (gnu services virtualization)
  (gnu services shepherd)
  (gnu system setuid)
  (guix download)
  (guix git-download)
  (guix build-system trivial)
  (guix channels)
  (guix inferior)
  (guix packages)
  (guix store)
  (srfi srfi-1))

(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define vim-as-vi
  (package
    (name "vim-as-vi")
    (version (package-version vim))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (vim (assoc-ref %build-inputs "vim")))
            (mkdir out)
            (mkdir (string-append out "/bin"))
            (chdir (string-append out "/bin"))
            (symlink (string-append vim "/bin/vim") "vi")))))
    (inputs (list vim))
    (synopsis "Symlink vi to vim")
    (description
      "Make vi a symlink to vim. This collides with nvi.")
    (home-page (package-home-page vim))
    (license (package-license vim))))

(define python3-as-python
  (package
    (name "python3-as-python")
    (version (package-version python-3))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (python (assoc-ref %build-inputs "python")))
            (mkdir out)
            (mkdir (string-append out "/bin"))
            (chdir (string-append out "/bin"))
            (symlink
              (string-append python "/bin/python3")
              "python")))))
    (inputs (list python-3))
    (synopsis "Python 3 + symlink to python")
    (description "Make python a symlink to python3.")
    (home-page (package-home-page python-3))
    (license (package-license python-3))))

(define shutdown-as-poweroff
  (package
    (name "shutdown-as-poweroff")
    (version (package-version shepherd))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (shepherd (assoc-ref %build-inputs "shepherd")))
            (mkdir out)
            (mkdir (string-append out "/sbin"))
            (chdir (string-append out "/sbin"))
            (symlink
              (string-append shepherd "/sbin/shutdown")
              "poweroff")))))
    (inputs (list shepherd))
    (synopsis "Symlink poweroff to shutdown")
    (description
      "Make poweroff a symlink to shutdown.")
    (home-page (package-home-page shepherd))
    (license (package-license shepherd))))

(define kexec-shepherd
  (package
    (inherit shepherd-0.10)
    (source
      (origin
        (method (origin-method (package-source shepherd-0.10)))
        (uri (origin-uri (package-source shepherd-0.10)))
        (sha256
          (base32
            "0v9ld9gbqdp5ya380fbkdsxa0iqr90gi6yk004ccz3n792nq6wlj"))
        (patches
          (list (local-file "patches/shepherd-reboot-kexec.patch")))))))

(define guix-patched
  (package
    (inherit guix)
    (source
      (origin
        (method (origin-method (package-source guix)))
        (uri (origin-uri (package-source guix)))
        (sha256
          (base32
            "0g8p0w9qrqbzz3b4fzbvvqpdfgwhlxpz75n3ysa6haima5s19mp3"))
        (patches
         (list (local-file "patches/guix-riscv32-system.patch")))))))

(define linux-zen
  (package
    (inherit linux)
    (name "linux-zen")
    (version "6.5.7-zen2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0qy3xn7kr16crm7iw1zhm3kpgxpmn66xc4g1yalvghwn6si0n81l"))))))

(operating-system
  (kernel linux-zen)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (kernel-arguments
    '("modprobe.blacklist=dvb_usb_rtl28xxu"))
  (locale "en_US.utf8")
  (timezone "Europe/Berlin")
  (keyboard-layout
    (keyboard-layout "us" "altgr-intl"))
  (host-name "guix")
  (users (cons* (user-account
                  (name "laura")
                  (comment "Laura")
                  (group "users")
                  (home-directory "/home/laura")
                  (supplementary-groups
                    '("wheel"
                      "netdev"
                      "audio"
                      "video"
                      "kvm"
                      "dialout"))
                  (shell (file-append zsh "/bin/zsh"))
                  (password
                    (crypt secret-password "laura")))
                %base-user-accounts))
  (packages
    (filter
      (lambda (x) (not (eq? x nvi)))
      (append
        (append
          (map specification->package
               '("nss-certs"
                 "vim"
                 "curl"
                 "python"
                 "kexec-tools"
                 "zsh"
                 "git"
                 "rtl-sdr"))
          (list (list gcc "lib"))
          %base-packages)
        (list vim-as-vi
              shutdown-as-poweroff
              python3-as-python))))
  (services
    (remove
      (lambda (service)
        (memq (service-kind service)
              (list gdm-service-type sddm-service-type)))
      (append
        (list (service plasma-desktop-service-type)
              (service
                sddm-service-type
                (sddm-configuration (theme "breeze")))
              (set-xorg-configuration
                (xorg-configuration
                  (keyboard-layout keyboard-layout)
                  (extra-config
                    (list "Section \"Monitor\"\n\tIdentifier\t\"HDMI-A-0\"\n\tOption\t\t\"Position\"\t\"1280 0\"\n\tOption\t\t\"Primary\"\t\"true\"\nEndSection\n\nSection \"Monitor\"\n\tIdentifier\t\"DVI-D-0\"\n\tOption\t\t\"Position\"\t\"0 13\"\nEndSection\n"))))
              (service
                guix-publish-service-type
                (guix-publish-configuration (advertise? #t)))
              (service gnome-keyring-service-type)
              (service earlyoom-service-type)
              (service docker-service-type)
              (extra-special-file
                "/usr/bin/file"
                (file-append file "/bin/file"))
              (extra-special-file
                "/bin/kill"
                (file-append coreutils "/bin/kill"))
              (extra-special-file
                "/bin/bash"
                (file-append bash "/bin/bash"))
              (udev-rules-service 'rtl-sdr rtl-sdr)
              (service
                qemu-binfmt-service-type
                (qemu-binfmt-configuration
                  (platforms
                    (lookup-qemu-platforms
                      "arm"
                      "aarch64"
                      "riscv32"
                      "riscv64"
                      "mips"
                      "mips64"
                      "mips64el"
                      "mipsel"
                      "mipsn32"
                      "mipsn32el"
                      "s390x"
                      "sparc"
                      "sparc32plus"
                      "sparc64"
                      "alpha"
                      "ppc"
                      "ppc64"
                      "ppc64le")))))
        (modify-services
          %desktop-services
          (guix-service-type
            config
            =>
            (guix-configuration
              (inherit config)
              (guix guix-patched)
              (substitute-urls
                (append
                  (list "https://substitutes.nonguix.org")
                  %default-substitute-urls))
              (authorized-keys
                (append
                  (list (plain-file
                          "non-guix.pub"
                          "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                  %default-authorized-guix-keys))))
          (sysctl-service-type
            config
            =>
            (sysctl-configuration
              (settings
                (append
                  '(("net.ipv4.ip_forward" . "1"))
                  %default-sysctl-settings))))))))
  (essential-services
    (modify-services
      (operating-system-default-essential-services
        this-operating-system)
      (shepherd-root-service-type
        config
        =>
        (shepherd-configuration
          (inherit config)
          (shepherd kexec-shepherd)))))
  (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (targets (list "/dev/sda" "/dev/sdb"))
      (keyboard-layout keyboard-layout)
      (menu-entries
        (list (menu-entry
                (label "GNU Mach")
                (multiboot-kernel
                  (file-append cross-mach "/boot/gnumach")))))))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device
               (uuid "94564faf-9ed7-4f74-bd7d-3a6ce3c4a512"
                     'btrfs))
             (type "btrfs"))
           (file-system
             (mount-point "/data")
             (device
               (uuid "d883b77a-1f15-48ea-94e1-af4e64be9951"
                     'xfs))
             (type "xfs")
             (mount? #f))
           (file-system
             (mount-point "/smb")
             (device "//s-files.fritz.box/jakob")
             (type "cifs")
             (options (string-append "username=jakob,password=" secret-smb-password ",_netdev"))
             (mount? #f))
           %base-file-systems))
  (setuid-programs
    (cons (setuid-program
            (program
              (file-append cifs-utils "/sbin/mount.cifs")))
          %setuid-programs))
  (name-service-switch %mdns-host-lookup-nss)
  (skeletons
    (append
      `((".zshrc"
         ,(plain-file
            "zshrc"
            "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended\necho \"autoload -U compinit && compinit\\nsource ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh\" >> ~/.zshrc\ngit clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions\nexec zsh")))
      (default-skeletons)))
  (sudoers-file
    (plain-file
      "sudoers"
      (string-append
        (plain-file-content %sudoers-specification)
        (format #f "~a ALL = NOPASSWD: ALL~%" "laura")))))
