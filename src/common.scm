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
  (nongnu packages firmware)
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
  (gnu services admin)
  (gnu services dbus)
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
  (gnu packages hardware)
  (gnu packages bootloaders)
  (gnu packages curl)
  (gnu packages glib)
  (gnu packages gnome)
  (gnu packages backup)
  (gnu packages xml)
  (gnu packages sqlite)
  (gnu packages polkit)
  (gnu packages elf)
  (gnu packages protobuf)
  (gnu packages mingw)
  (gnu packages efi)
  (gnu packages check)
  (gnu packages man)
  (gnu packages gettext)
  (laura services utils)
  (gnu system setuid)
  (gnu system image)
  (gnu image)
  (guix platform)
  (guix download)
  (guix git-download)
  (guix build-system trivial)
  (guix build-system gnu)
  (guix build-system python)
  (guix build-system pyproject)
  (guix build-system cargo)
  (guix build-system go)
  (guix build-system cmake)
  (guix build-system meson)
  (guix transformations)
  ((guix licenses) #:prefix license:)
  (guix channels)
  (guix inferior)
  (guix packages)
  (guix store)
  (guix utils)
  (ice-9 match)
  (srfi srfi-1)
  (srfi srfi-9 gnu)
  (system base syntax))

(include "secrets.scm")
(include "symlinks.scm")
(include "kernel.scm")
(include "packages.scm")
(include "services.scm")

(define gdm-patch-file
  (with-store
    store
    (run-with-store
      store
      (text-file "gdm.patch" secret-gdm-patch))))

(define (apply-base OS)
  (operating-system
    (inherit OS)
    (kernel linux)
    (initrd microcode-initrd)
    (firmware (list linux-firmware))
    (kernel-arguments
      (list "modprobe.blacklist=dvb_usb_rtl28xxu"
            "mitigations=off"
            "iomem=relaxed"))
    (locale "en_US.utf8")
    (timezone "Europe/Berlin")
    (keyboard-layout (keyboard-layout "de" "us"))
    (packages
      (filter
        (lambda (x) (not (eq? x nvi)))
        (operating-system-packages OS)))))

(define (apply-personal-config OS)
  (operating-system
    (inherit OS)
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
                  (operating-system-users OS)))
    (groups
      (cons* (user-group (name "adbusers"))
             (operating-system-groups OS)))
    (sudoers-file
      (plain-file
        "sudoers"
        (string-append
          (plain-file-content %sudoers-specification)
          (format #f "~a ALL = NOPASSWD: ALL~%" "laura"))))))

(define (add-base-packages OS)
  (operating-system
    (inherit OS)
    (packages
      (append
        (map specification->package
             (list "vim"
                   "curl"
                   "python"
                   "kexec-tools"
                   "zsh"
                   "git"
                   "linux-libre-headers"
                   "openssh"
                   "iproute2"
                   "iptables"))
        (list fuse-2
              openjdk17
              (list openjdk17 "jdk")
              (list gcc "lib")
              (list git "send-email"))
        (list vim-as-vi
              shutdown-as-poweroff
              python3-as-python
              fwupd-patched)
        (operating-system-packages OS)))
    (name-service-switch %mdns-host-lookup-nss)
    (skeletons
      (append
        `((".zshrc" ,(local-file "../files/zshrc")))
        (operating-system-skeletons OS)))))

(define (add-desktop-packages OS)
  (operating-system
    (inherit OS)
    (packages
      (append
        (map specification->package
             '("mesa"
               "mesa-utils"
               "hyprland"
               "swaylock"
               "xdg-desktop-portal-hyprland"
               "distrobox"
               "waydroid"
               "konsole"))
        (list (list gtk "bin") (list mesa "bin"))
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
              font-xfree86-type1)
        (operating-system-packages OS)))
    (setuid-programs
      (cons (setuid-program
              (program
                (file-append cifs-utils "/sbin/mount.cifs")))
            (operating-system-setuid-programs OS)))))

(define (add-base-services OS)
  (operating-system
    (inherit OS)
    (services
      (modify-services
        (filter
          (lambda (x)
            (not (memq (service-kind x) '(sddm-service-type))))
          (append
            (list (service docker-service-type)
                  (service containerd-service-type)
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
                  (extra-special-file
                    "/usr/share"
                    "/run/current-system/profile/share")
                  (extra-special-file
                    "/lib/ld-linux-x86-64.so.2"
                    (file-append glibc "/lib/ld-linux-x86-64.so.2"))
                  (extra-special-file
                    "/lib64/ld-linux-x86-64.so.2"
                    (file-append glibc "/lib/ld-linux-x86-64.so.2"))
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
            (operating-system-user-services OS)))
        (guix-service-type
          config
          =>
          (guix-configuration
            (inherit config)
            (substitute-urls
              (append
                (list "https://substitutes.nonguix.org"
                      "https://guix.bordeaux.inria.fr")
                %default-substitute-urls))
            (authorized-keys
              (append
                (list (plain-file
                        "non-guix.pub"
                        "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
                      (plain-file
                        "hpc.pub"
                        "(public-key (ecc (curve Ed25519) (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))"))
                %default-authorized-guix-keys))))
        (gdm-service-type
          config
          =>
          (gdm-configuration
            (gdm ((options->transformation
                    `((with-patch
                        unquote
                        (string-append "gdm=" gdm-patch-file))))
                  gdm))
            (auto-suspend? #f)
            (wayland? #t)))
        (special-files-service-type
          config
          =>
          (list (car config)))
        (sysctl-service-type
          config
          =>
          (sysctl-configuration
            (settings
              (append
                '(("net.ipv4.ip_forward" . "1")
                  ("kernel.dmesg_restrict" . "0")
                  ("kernel.unprivileged_userns_clone" . "1"))
                %default-sysctl-settings))))))
    (essential-services
      (modify-services
        (operating-system-default-essential-services
          this-operating-system)
        (shepherd-root-service-type
          config
          =>
          (shepherd-configuration
            (inherit config)
            (shepherd kexec-shepherd)))))))

(define (add-desktop-services OS)
  (operating-system
    (inherit OS)
    (services
      (append
        (list (service gnome-keyring-service-type)
              (service waydroid-service-type)
              (simple-service
                'fwupd-dbus
                dbus-root-service-type
                (list fwupd-patched))
              (simple-service
                'fwupd-polkit
                polkit-service-type
                (list fwupd-patched))
              (service
                syncthing-service-type
                (syncthing-configuration (user "laura")))
              (service kubo-service-type))
        (operating-system-user-services OS)))))

(define (add-laptop-services OS)
  (operating-system
    (inherit OS)
    (services
      (append
        (list (service
                wpa-supplicant-service-type
                (wpa-supplicant-configuration
                  (config-file
                    (plain-file
                      "wpa_supplicant.cfg"
                      secrets-wpa-config)))))
        (operating-system-user-services OS)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (prepare-base OS)
  (add-base-services
    (add-base-packages (apply-base OS))))

(define (prepare-desktop OS)
  (add-desktop-services
    (add-desktop-packages (prepare-base OS))))

(define (prepare-laptop OS)
  (add-laptop-services OS))

(define (personalize OS)
  (apply-personal-config OS))
