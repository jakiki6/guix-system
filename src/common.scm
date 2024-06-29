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
  audio
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
  (gnu packages commencement)
  (gnu packages linux)
  (gnu packages java)
  (gnu packages gtk)
  (gnu packages gawk)
  (gnu packages golang)
  (gnu services virtualization)
  (gnu services shepherd)
  (gnu services syncthing)
  (gnu packages python-xyz)
  (gnu packages python-crypto)
  (gnu packages version-control)
  (gnu packages gl)
  (gnu packages android)
  (gnu packages crates-io)
  (gnu packages autotools)
  (gnu packages cross-base)
  (gnu packages golang-check)
  (gnu packages crates-graphics)
  (gnu packages crypto)
  (gnu packages xdisorg)
  (gnu packages qt)
  (gnu packages pkg-config)
  (gnu packages compression)
  (gnu packages sdl)
  (gnu packages logging)
  (gnu packages popt)
  (gnu packages tls)
  (gnu packages linux)
  (gnu packages llvm)
  (gnu packages containers)
  (gnu packages cpio)
  (gnu packages crates-vcs)
  (gnu packages crates-web)
  (gnu packages crates-apple)
  (gnu packages crates-windows)
  (gnu packages crates-crypto)
  (gnu packages crates-tls)
  (gnu packages fonts)
  (gnu packages xorg)
  (gnu packages ipfs)
  (gnu system setuid)
  (gnu system image)
  (gnu image)
  (guix download)
  (guix git-download)
  (guix build-system trivial)
  (guix build-system gnu)
  (guix build-system python)
  (guix build-system pyproject)
  (guix build-system cargo)
  (guix build-system go)
  (guix build-system cmake)
  ((guix licenses) #:prefix license:)
  (guix channels)
  (guix inferior)
  (guix packages)
  (guix store)
  (guix utils)
  (ice-9 match)
  (srfi srfi-1))

(include "secrets.scm")
(include "symlinks.scm")
(include "kernel.scm")
(include "packages.scm")

(define base-os
  (operating-system
    (kernel linux)
    (initrd microcode-initrd)
    (firmware (list linux-firmware))
    (kernel-arguments
      '("modprobe.blacklist=dvb_usb_rtl28xxu"
        "mitigations=off"
        "iomem=relaxed"))
    (locale "en_US.utf8")
    (timezone "Europe/Berlin")
    (keyboard-layout (keyboard-layout "de" "us"))
    (host-name #f)
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
                        "dialout"
                        "adbusers"
                        "docker"))
                    (shell (file-append zsh "/bin/zsh"))
                    (password (crypt secret-password "laura")))
                  %base-user-accounts))
    (groups
      (cons* (user-group (name "adbusers"))
             %base-groups))
    (packages
      (filter
        (lambda (x) (not (eq? x nvi)))
        (append
          (append
            (map specification->package
                 '("vim"
                   "curl"
                   "python"
                   "kexec-tools"
                   "zsh"
                   "git"
                   "mesa-utils"
                   "mesa"
                   "linux-libre-headers"
                   "openssh"
                   "hyprland"
                   "xdg-desktop-portal-hyprland"
                   "distrobox"))
            (list fuse-2
                  openjdk17
                  (list openjdk17 "jdk")
                  (list gcc "lib")
                  (list git "send-email")
                  (list gtk "bin")
                  (list mesa "bin"))
            %base-packages)
          (list vim-as-vi
                shutdown-as-poweroff
                python3-as-python)
          (list font-adobe-source-code-pro
                font-adobe-source-han-sans
                font-adobe-source-sans-pro
                font-adobe-source-serif-pro
                font-anonymous-pro
                font-anonymous-pro-minus
                font-awesome
                font-bitstream-vera
                font-blackfoundry-inria
                font-cns11643
                font-cns11643-swjz
                font-comic-neue
                font-culmus
                font-dejavu
                font-dosis
                font-dseg
                font-fantasque-sans
                font-fira-code
                font-fira-mono
                font-fira-sans
                font-fontna-yasashisa-antique
                font-gnu-freefont
                font-gnu-unifont
                font-go
                font-google-material-design-icons
                font-google-noto
                font-google-roboto
                font-hack
                font-hermit
                font-ibm-plex
                font-inconsolata
                font-iosevka
                font-iosevka-aile
                font-iosevka-etoile
                font-iosevka-slab
                font-iosevka-term
                font-iosevka-term-slab
                font-ipa-mj-mincho
                font-jetbrains-mono
                font-lato
                font-liberation
                font-linuxlibertine
                font-lohit
                font-meera-inimai
                font-mononoki
                font-mplus-testflight
                font-opendyslexic
                font-public-sans
                font-rachana
                font-sarasa-gothic
                font-sil-andika
                font-sil-charis
                font-sil-gentium
                font-tamzen
                font-terminus
                font-tex-gyre
                font-un
                font-vazir
                font-wqy-microhei
                font-wqy-zenhei
                font-adobe100dpi
                font-adobe75dpi
                font-cronyx-cyrillic
                font-dec-misc
                font-isas-misc
                font-micro-misc
                font-misc-cyrillic
                font-misc-ethiopic
                font-misc-misc
                font-mutt-misc
                font-schumacher-misc
                font-screen-cyrillic
                font-sony-misc
                font-sun-misc
                font-util
                font-winitzki-cyrillic
                font-xfree86-type1))))
    (services
      (remove
        (lambda (service)
          (memq (service-kind service)
                (list sddm-service-type)))
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
                (service gnome-keyring-service-type)
                (service docker-service-type)
                (service
                  syncthing-service-type
                  (syncthing-configuration (user "laura")))
                (extra-special-file
                  "/bin/kill"
                  (file-append coreutils "/bin/kill"))
                (extra-special-file
                  "/bin/bash"
                  (file-append bash "/bin/bash"))
                (extra-special-file
                  "/bin/pwd"
                  (file-append coreutils "/bin/pwd"))
                (extra-special-file
                  "/usr/lib"
                  "/run/current-system/profile/lib")
                (extra-special-file
                  "/usr/bin"
                  "/run/current-system/profile/bin")
                (udev-rules-service 'rtl-sdr rtl-sdr)
                (udev-rules-service 'android android-udev-rules)
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
                        "s390x"
                        "sparc"
                        "sparc64"
                        "alpha"
                        "ppc"
                        "ppc64")))))
          (modify-services
            %desktop-services
            (guix-service-type
              config
              =>
              (guix-configuration
                (inherit config)
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
            (special-files-service-type
              config
              =>
              (list (car config)))
            (gdm-service-type
              config
              =>
              (gdm-configuration
                (auto-suspend? #f)
                (wayland? #t)))
            (sysctl-service-type
              config
              =>
              (sysctl-configuration
                (settings
                  (append
                    '(("net.ipv4.ip_forward" . "1")
                      ("kernel.dmesg_restrict" . "0")
                      ("kernel.unprivileged_userns_clone" . "1")
                      ("net.ipv4.conf.enp2s0.send_redirects" . "0"))
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
    (bootloader #f)
    (mapped-devices #f)
    (file-systems #f)
    (setuid-programs
      (cons (setuid-program
              (program
                (file-append cifs-utils "/sbin/mount.cifs")))
            %setuid-programs))
    (name-service-switch %mdns-host-lookup-nss)
    (skeletons
      (append
        `((".zshrc" ,(local-file "../files/zshrc_pre"))
          (".zshrc.post"
           ,(local-file "../files/zshrc_post"))
          ("channels.scm"
           ,(local-file "../files/channels.scm")))
        (default-skeletons)))
    (sudoers-file
      (plain-file
        "sudoers"
        (string-append
          (plain-file-content %sudoers-specification)
          (format #f "~a ALL = NOPASSWD: ALL~%" "laura"))))))
