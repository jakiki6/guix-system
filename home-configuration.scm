;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(use-modules
  (gnu home)
  (gnu packages)
  (gnu services)
  (guix gexp)
  (guix channels)
  (guix packages)
  (guix git-download)
  (guix download)
  (guix build-system copy)
  ((guix licenses) #:prefix license:)
  (gnu home services shells)
  (gnu home services guix)
  (gnu home services shepherd)
  (gnu home services)
  (laura home services wine)
  (laura home services audio))

(include "src/secrets.scm")

(define %hashes
  (list (list "kernelpanicroom"
              "1350b2a6e55cb1ffd4192e13fb1f18d89040aafd"
              "02kds6igmybnclx9rdwxld1k4ys5mplm7x4xxi410ckch0a3h46v")
        (list "dalaptop"
              "e8ad9682bb5f0e50883eb1573e6686f40a4b26a2"
              "1wfzrkz7bh0prgwx3kixwvryy873h9fl301b09wrf33n7ky63wmf")))

(define breezex-cursor
  (package
    (name "breezex-cursor")
    (version "2.0.1")
    (source
      (origin
        (method url-fetch)
        (uri "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.1/BreezeX-Dark.tar.xz")
        (sha256
          (base32
            "0lxnam952dv4qly0v3a5g0bxj0jcxx4dv47jwmgmdwdhcqs79pwc"))))
    (build-system copy-build-system)
    (home-page
      "https://github.com/ful1e5/BreezeX_Cursor")
    (synopsis "")
    (description "")
    (license license:gpl3)))

(home-environment
  (packages
    (list (specification->package "dragon-drop")
          (specification->package "mumi")
          (specification->package "calibre")
          (specification->package "sbctl")
          (specification->package "rocm-toolchain")
          (list (specification->package "openjdk") "jdk")
          (specification->package "go")
          (specification->package "haunt")
          (specification->package "dos2unix")
          (list (specification->package "elfutils") "bin")
          (specification->package "elfutils")
          (list (specification->package "libgit2") "debug")
          (specification->package "guile")
          (list (specification->package "guile") "debug")
          (specification->package "dino")
          (specification->package "polkit")
          (specification->package "dotnet")
          (specification->package "pesign")
          (specification->package "efivar")
          (specification->package "distrobox")
          (specification->package "podman")
          (specification->package "qemu")
          (specification->package "torbrowser")
          (specification->package "firefox")
          (specification->package "yggdrasil")
          (specification->package "atril")
          (specification->package "libreoffice")
          (specification->package "duf")
          (specification->package "kubo")
          (specification->package "docker")
          (specification->package "gqrx")
          (specification->package "node")
          (specification->package "age")
          (specification->package "age-keygen")
          (specification->package "encpipe")
          (specification->package "obs")
          (specification->package "obs-wlrobs")
          (specification->package "vtk")
          (specification->package "openmpi")
          (specification->package "vscodium")
          (specification->package "waybar")
          (specification->package "krita")
          (specification->package "xwaylandvideobridge")
          (specification->package "kdenlive")
          (specification->package "krdc")
          (specification->package "polkit-kde-agent")
          (specification->package "xdot")
          (specification->package "yosys")
          (specification->package "wireshark")
          (specification->package "mpd")
          (specification->package "wireplumber")
          (specification->package "zig")
          (specification->package "xdg-desktop-portal")
          (specification->package
            "xdg-desktop-portal-hyprland")
          (specification->package "libappindicator")
          (specification->package "pipewire")
          (specification->package "cryptominisat")
          (specification->package "minisat")
          (specification->package "ent")
          (specification->package "parted")
          (specification->package "gptfdisk")
          (specification->package "msgpack-c")
          (specification->package "ydotool")
          (specification->package "tpt")
          (specification->package "minetest")
          (specification->package "vala")
          (specification->package "pngcrush")
          (specification->package "rust")
          (list (specification->package "rust") "rust-src")
          (list (specification->package "rust") "tools")
          (list (specification->package "rust") "cargo")
          (specification->package "wayvnc")
          (specification->package "gzdoom")
          (specification->package "maven")
          (specification->package "hyperrogue")
          (specification->package "keepassxc")
          (specification->package "vlc")
          (specification->package "fceux")
          (specification->package "sonata")
          (specification->package "pamixer")
          (specification->package "wofi")
          (specification->package "dunst")
          (specification->package "wxwidgets")
          (specification->package "boinc-client")
          (specification->package "audacity")
          (specification->package "golly")
          (specification->package "python-pymol")
          (specification->package "transmission")
          (specification->package "x11vnc")
          (specification->package "winetricks")
          (specification->package "libxfce4ui")
          (specification->package "flatpak")
          (specification->package "gparted")
          (specification->package "cantata")
          (specification->package "qdirstat")
          (specification->package
            "webkitgtk-with-libsoup2")
          (specification->package "xournalpp")
          (specification->package "wine64")
          (specification->package "lxappearance")
          (specification->package "uefitool")
          (specification->package "gimp")
          (specification->package "simplescreenrecorder")
          (specification->package "pavucontrol")
          (specification->package "qbittorrent")
          (specification->package "pinentry")
          (specification->package "inkscape")
          (specification->package "sdl-gfx")
          (specification->package "sdl-ttf")
          (specification->package "sdl-mixer")
          (specification->package "ffmpeg@6")
          (specification->package "sdl2-image")
          (specification->package "sdl2")
          (specification->package "xen")
          (specification->package "java-apache-ivy")
          (specification->package "zsnes")
          (specification->package "gtk+")
          (specification->package "qtsvg")
          (specification->package "qtbase")
          (list (specification->package "gtk") "bin")
          (specification->package "gnome-keyring")
          (list (specification->package "glibc") "static")
          (specification->package "grub-efi")
          (specification->package "efibootmgr")
          (specification->package "perf")
          (specification->package "Amogus-File-Encoder")
          (specification->package "ruby")
          (specification->package "hashcat")
          (specification->package "borg")
          (specification->package "dwarfs")
          (specification->package "rsync")
          (specification->package "radare2")
          (specification->package "hyprland")
          (specification->package "freetalk")
          (specification->package "swww")
          (specification->package "drand-rs")
          (specification->package "uesave")
          (specification->package "rust-cargo")
          (specification->package "ant")
          (specification->package "conda")
          (specification->package "docker-compose")
          (specification->package "clipmon")
          (specification->package "nomadnet")
          (specification->package "units")
          (specification->package "mpd-mpc")
          (specification->package "magic-wormhole")
          (specification->package "cmake")
          (specification->package "b3sum")
          (specification->package "rogue")
          (specification->package "tcptrack")
          (specification->package "paper-age")
          (specification->package "tpm2-tools")
          (specification->package "nix")
          (specification->package "sl")
          (specification->package "enchive")
          (specification->package "mosquitto")
          (specification->package "aircrack-ng")
          (specification->package "yara")
          (specification->package "sshfs")
          (specification->package "ccache")
          (specification->package "feh")
          (specification->package "cabal-install")
          (specification->package "udftools")
          (specification->package "clang")
          (specification->package "mympd")
          (specification->package "vlang")
          (specification->package "lld")
          (specification->package "mtools")
          (specification->package "python-next")
          (list (specification->package "python-next")
                "tk")
          (specification->package "python-pystache")
          (specification->package "testdisk")
          (specification->package "pkgconf")
          (specification->package "tig")
          (specification->package "xdotool")
          (specification->package "dmenu")
          (specification->package "tor")
          (specification->package "clamav")
          (specification->package "ddrescue")
          (specification->package "mpc")
          (specification->package "libxml2")
          (specification->package "nanomsg")
          (specification->package "libsixel")
          (specification->package "bsdiff")
          (specification->package "libgfshare")
          (specification->package "valgrind")
          (specification->package "xeyes")
          (specification->package "wl-clipboard")
          (specification->package "xhost")
          (specification->package "playerctl")
          (specification->package "lrzip")
          (specification->package "john-the-ripper-jumbo")
          (specification->package "masscan")
          (specification->package "gifsicle")
          (specification->package "cowsay")
          (specification->package "xsel")
          (specification->package "htop")
          (specification->package "gnutls")
          (specification->package "pari-gp")
          (specification->package "ntl")
          (specification->package "dosfstools")
          (specification->package "screen")
          (specification->package "xdg-utils")
          (specification->package "gqrx-scanner")
          (specification->package "pv")
          (specification->package "mariadb")
          (specification->package "tigervnc-client")
          (specification->package "imagemagick")
          (specification->package "texlive")
          (specification->package "xfce4-dev-tools")
          (specification->package "swig")
          (specification->package "qdl")
          (specification->package "fastboot")
          (specification->package "flashrom")
          (specification->package "graphviz")
          (specification->package "freehdl")
          (specification->package "rocm-opencl-runtime")
          (specification->package "rocm-bandwidth-test")
          (specification->package "rocminfo")
          (specification->package "rocr-runtime")
          (specification->package "ddd")
          (specification->package "gdb")
          (specification->package "debootstrap")
          (specification->package "catimg")
          (specification->package "gstreamer")
          (specification->package "binwalk")
          (specification->package "po4a")
          (specification->package "flatpak-xdg-utils")
          (specification->package "asciidoc")
          (specification->package "signify")
          (specification->package "cpio")
          (specification->package "gnucobol")
          (specification->package "z3")
          (specification->package "jmtpfs")
          (specification->package "progress")
          (specification->package "lz4")
          (specification->package "libdwarf")
          (specification->package "minisign")
          (specification->package "adb")
          (specification->package "lsof")
          (specification->package "libnsl")
          (specification->package "dmidecode")
          (specification->package "gmp-ecm")
          (specification->package "mescc-tools")
          (specification->package "i2c-tools")
          (specification->package "rdesktop")
          (specification->package "gflags")
          (specification->package "texinfo")
          (specification->package "torsocks")
          (specification->package "xset")
          (specification->package "glog")
          (specification->package "doxygen")
          (specification->package "bmon")
          (specification->package "gperftools")
          (specification->package "mkp224o")
          (specification->package "netcat")
          (specification->package "par2cmdline")
          (specification->package "unrar-free")
          (specification->package "minetest-mineclone")
          (specification->package "iucode-tool")
          (specification->package "gperf")
          (specification->package "capstone")
          (specification->package "intltool")
          (specification->package "perl-image-exiftool")
          (specification->package "i2pd")
          (specification->package "nmap")
          (specification->package "xrandr")
          (specification->package "xinput")
          (specification->package "xclip")
          (specification->package "iverilog")
          (specification->package "hexedit")
          (specification->package "p7zip")
          (specification->package "libxpm")
          (specification->package "libmpdclient")
          (specification->package "upx")
          (list (specification->package "openssl") "doc")
          (specification->package "socat")
          (specification->package "cmatrix")
          (specification->package "cloc")
          (specification->package "libgcrypt")
          (specification->package "readline")
          (specification->package "flex")
          (specification->package "bison")
          (specification->package "autoconf")
          (specification->package "bc")
          (specification->package "make")
          (specification->package "strace")
          (specification->package "patchelf")
          (specification->package "traceroute")
          (specification->package "gmp")
          (specification->package "nasm")
          (specification->package "msr-tools")
          (specification->package "ncurses")
          (specification->package "acpica")
          (specification->package "libtree")
          (specification->package "openssl")
          (specification->package "neofetch")
          (specification->package "fastfetch")
          (specification->package "gsl")
          (specification->package "unzip")
          (specification->package "zip")
          (specification->package "grub")
          (specification->package "docker-cli")
          (specification->package "xcb-util-renderutil")
          (specification->package "xcb-util-keysyms")
          (specification->package "xcb-util-image")
          (specification->package "xcb-util-wm")
          (specification->package "python-dbus")
          (specification->package "dbus")
          (specification->package "openssh")
          (list (specification->package "git")
                "send-email")
          (specification->package "git")
          (specification->package "subversion")
          (specification->package "pkg-config")
          (specification->package "zlib")
          (specification->package "pciutils")
          (specification->package "swaylock")
          (specification->package "grim")
          (specification->package "slurp")
          (specification->package "nss")
          (specification->package "gobject-introspection")
          (specification->package "cups")
          (specification->package "cryptsetup")
          (specification->package "lvm2")
          (specification->package "libbsd")
          (specification->package "libuv")
          (specification->package "libpcap")
          (specification->package "meson")
          (specification->package "gdk-pixbuf")
          (specification->package "freeglut")
          (specification->package "glu")
          (specification->package "mesa-utils")
          (list (specification->package "mesa") "bin")
          (specification->package "mesa")
          (specification->package "mdadm")
          (specification->package "python-pip")
          (specification->package "ninja")
          (specification->package "libgc")
          (specification->package "libedit")
          (specification->package "xauth")
          (specification->package "dtc")
          (specification->package "libsm")
          (specification->package "libice")
          (specification->package "fuse")
          (specification->package "setxkbmap")
          (specification->package "rtl-sdr")
          (specification->package "clinfo")
          (specification->package "ntp")
          (specification->package "openh264")
          (specification->package "opencl-icd-loader")
          (specification->package "jq")
          (specification->package "bzip2")
          (specification->package "net-tools")
          (specification->package "fftwf")
          (specification->package "fftw")
          (specification->package "ntfs-3g")
          (specification->package "iptables")
          (specification->package "help2man")
          (specification->package "perl")
          (specification->package "libtool")
          (specification->package "m4")
          (specification->package "automake")
          (specification->package "file")
          (specification->package "alsa-lib")
          (specification->package "popt")
          (specification->package "libusb")
          (specification->package "mtdev")
          (specification->package "java-openjfx-base")
          (specification->package "syncthing")
          (specification->package "vim-guix-vim")
          (specification->package "font-gnu-freefont")
          (specification->package "nss-certs")
          (list (specification->package
                  "font-adobe-source-han-sans")
                "tw")
          (list (specification->package
                  "font-adobe-source-han-sans")
                "jp")
          (list (specification->package
                  "font-adobe-source-han-sans")
                "kr")
          (list (specification->package
                  "font-adobe-source-han-sans")
                "cn")
          (specification->package
            "font-adobe-source-han-sans")
          (specification->package "font-dejavu")
          (specification->package "font-ghostscript")
          (specification->package "font-hack")
          (specification->package "font-fira-code")
          (specification->package "font-comic-neue")
          (specification->package "font-liberation")
          (specification->package "fatfsck-static")
          (specification->package "gtkwave")
          (specification->package "wasmtime")
          (specification->package "perl-io-socket-ssl")
          (specification->package "perl-mime-base64")
          (specification->package "perl-authen-sasl")
          (specification->package "verilator")
          (specification->package
            "gcc-cross-riscv64-linux-gnu-toolchain")
          (specification->package "hipify")
          (list (specification->package "bind") "utils")
          (specification->package "leopard")
          (specification->package "ricochet-refresh")
          (specification->package "openscad")
          (specification->package "yt-dlp")
          (specification->package "mutt")
          (specification->package "git-repo")
          (specification->package "libusb")
          (specification->package "alacritty")
          (specification->package "qtwayland")
          (specification->package "kdeconnect")
          (specification->package "libfive")
          (specification->package "wl-screenrec")
          (specification->package "kate")
          (specification->package "okular")
          (specification->package "mpv")
          (specification->package "CasioEmu")
          (specification->package "shepherd-run")
          (specification->package "flatpak-builder")
          (specification->package "diffoscope")
          (specification->package "git-lfs")))
  (services
    (list (service
            home-zsh-service-type
            (home-zsh-configuration
              (zshrc (list (local-file "./files/zshrc" "zshrc")))))
          (service home-wineserver-service-type)
          (service home-pulseaudio-service-type)
          (service
            home-shepherd-service-type
            (home-shepherd-configuration
              (shepherd (specification->package "shepherd"))))
          (simple-service
            'config-service
            home-files-service-type
            `((".config/hypr"
               ,(origin
                  (method git-fetch)
                  (uri (git-reference
                         (url "https://github.com/jakiki6/hyprland-config.git")
                         (commit (car (assoc-ref %hashes (gethostname))))))
                  (sha256
                    (base32 (cadr (assoc-ref %hashes (gethostname)))))))
              (".oh-my-zsh"
               ,(origin
                  (method git-fetch)
                  (uri (git-reference
                         (url "https://github.com/ohmyzsh/ohmyzsh.git")
                         (commit
                           "a72a26406ad3aa9a47c3f5227291bad23494bed0")))
                  (sha256
                    (base32
                      "0jx4bhdrcxgapk7jf2s9c8y82wadk9wsick1gcn1ik0dadhga2dq"))))
              (".zsh/zsh-autosuggestions"
               ,(origin
                  (method git-fetch)
                  (uri (git-reference
                         (url "https://github.com/zsh-users/zsh-autosuggestions")
                         (commit
                           "c3d4e576c9c86eac62884bd47c01f6faed043fc5")))
                  (sha256
                    (base32
                      "1m8yawj7skbjw0c5ym59r1y88klhjl6abvbwzy6b1xyx3vfb7qh7"))))
              (".mutt/muttrc"
               ,(plain-file "muttrc" secret-muttrc))
              (".icons/BreezeX" ,breezex-cursor)))
          (simple-service
            'variant-packages-service
            home-channels-service-type
            (cons* (channel
                     (name 'nonguix)
                     (url "https://gitlab.com/nonguix/nonguix")
                     (introduction
                       (make-channel-introduction
                         "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
                         (openpgp-fingerprint
                           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
                   (channel
                     (name 'rosenthal)
                     (url "https://codeberg.org/hako/rosenthal.git")
                     (branch "trunk"))
                   (channel
                     (name 'lauras-channel)
                     (url "https://github.com/jakiki6/lauras-channel"))
                   (channel
                     (name 'guix-hpc)
                     (url "https://gitlab.inria.fr/guix-hpc/guix-hpc.git")
                     (branch "master"))
                   (channel
                     (name 'guix-science)
                     (url "https://codeberg.org/guix-science/guix-science.git")
                     (introduction
                       (make-channel-introduction
                         "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
                         (openpgp-fingerprint
                           "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))
                   (channel
                     (name 'shepherd)
                     (url "https://git.savannah.gnu.org/git/shepherd.git")
                     (branch "main")
                     (introduction
                       (make-channel-introduction
                         "788a6d6f1d5c170db68aa4bbfb77024fdc468ed3"
                         (openpgp-fingerprint
                           "3CE464558A84FDC69DB40CFB090B11993D9AEBB5"))))
                    (channel
                      (name 'efraim-dfsg)
                      (url "https://git.sr.ht/~efraim/my-guix"))
                   %default-channels)))))
