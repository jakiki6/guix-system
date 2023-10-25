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
  (gnu packages commencement)
  (gnu packages linux)
  (gnu packages java)
  (gnu packages gtk)
  (gnu services virtualization)
  (gnu services shepherd)
  (gnu packages python-xyz)
  (gnu packages python-crypto)
  (gnu packages version-control)
  (gnu packages gl)
  (gnu system setuid)
  (gnu system image)
  (gnu image)
  (guix download)
  (guix git-download)
  (guix build-system trivial)
  (guix build-system python)
  (guix build-system pyproject)
  ((guix licenses) #:prefix license:)
  (guix channels)
  (guix inferior)
  (guix packages)
  (guix store)
  (srfi srfi-1))

(include "secrets.scm")
(include "symlinks.scm")
(include "kernel.scm")
(include "packages.scm")

(define my-os
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
    (host-name "kernelpanicroom")
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
                    (password (crypt secret-password "laura")))
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
                   "socat"
                   "catimg"
                   "webkitgtk-with-libsoup2"
                   "gtk+"
                   "simplescreenrecorder"
                   "xdg-desktop-portal-wlr"
                   "ffmpeg"
                   "nmap"
                   "cmatrix"
                   "pinentry"
                   "libappindicator"
                   "neofetch"
                   "zstd"
                   "upx"
                   "perl-image-exiftool"
                   "unzip"
                   "rust-cargo"
                   "inkscape"
                   "gqrx"
                   "atril"
                   "gparted"
                   "python-asdf"
                   "qemu"
                   "qbittorrent"
                   "gimp"
                   "xdg-desktop-portal-kde"
                   "xdg-desktop-portal-gtk"
                   "xdg-desktop-portal"
                   "vlc"
                   "pavucontrol"
                   "flatpak"
                   "firefox"
                   "debootstrap"
                   "cmake"
                   "feh"
                   "sdl2-image"
                   "sdl2"
                   "gnome-keyring"
                   "git"
                   "wine64"
                   "xen"
                   "rust"
                   "i2pd"
                   "age"
                   "signify"
                   "ghc"
                   "gstreamer"
                   "openh264"
                   "gmp"
                   "iptables"
                   "cryptsetup"
                   "zlib"
                   "freeglut"
                   "glu"
                   "zig"
                   "ddd"
                   "xrandr"
                   "xinput"
                   "rocm-bandwidth-test"
                   "rocminfo"
                   "rocm-opencl-runtime"
                   "rocr-runtime"
                   "xclip"
                   "node"
                   "python-pip"
                   "binwalk"
                   "mesa-utils"
                   "mesa"
                   "ninja"
                   "linux-libre-headers"
                   "setxkbmap"
                   "meson"
                   "gdk-pixbuf"
                   "openssh"
                   "mtdev"
                   "zip"
                   "gdb"
                   "nasm"
                   "cloc"
                   "traceroute"
                   "iverilog"
                   "help2man"
                   "po4a"
                   "texinfo"
                   "libgcrypt"
                   "msr-tools"
                   "hexedit"
                   "gqrx-scanner"
                   "lua"
                   "tig"
                   "readline"
                   "htop"
                   "radare2"
                   "jq"
                   "pkg-config"
                   "ncurses"
                   "acpica"
                   "perl"
                   "flex"
                   "bison"
                   "libtool"
                   "m4"
                   "automake"
                   "autoconf"
                   "rsync"
                   "bc"
                   "p7zip"
                   "go"
                   "make"
                   "binutils"
                   "strace"
                   "patchelf"
                   "libtree"
                   "file"
                   "flatpak-xdg-utils"
                   "openssl"
                   "alsa-lib"
                   "nss-certs"
                   "rtl-sdr"))
            (list (list gcc "lib")
                  fuse-2
                  openjdk17
                  (list openjdk17 "jdk")
                  (list git "send-email")
                  (list gtk "bin")
                  (list mesa "bin"))
            %base-packages)
          (list nomadnet
                vim-as-vi
                gcc-as-cc
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
      (if (getenv "LIVE_IMAGE")
        (cons* (file-system
                 (mount-point "/")
                 (device (file-system-label "GUIX_IMAGE"))
                 (type "iso9660"))
               %base-file-systems)
        (cons* (file-system
                 (mount-point "/")
                 (device (file-system-label "guix_root"))
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
                 (options
                   (string-append
                     "username=jakob,password="
                     secret-smb-password
                     ",_netdev"))
                 (mount? #f))
               %base-file-systems)))
    (setuid-programs
      (cons (setuid-program
              (program
                (file-append cifs-utils "/sbin/mount.cifs")))
            %setuid-programs))
    (name-service-switch %mdns-host-lookup-nss)
    (skeletons
      (append
        `((".zshrc" ,(local-file "../files/zshrc")))
        (default-skeletons)))
    (sudoers-file
      (plain-file
        "sudoers"
        (string-append
          (plain-file-content %sudoers-specification)
          (format #f "~a ALL = NOPASSWD: ALL~%" "laura"))))))
