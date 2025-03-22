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
  (laura home services audio)
  (laura home services ai))

(include "src/secrets.scm")

(define %hashes
  (list (list "kernelpanicroom"
              "4a50a59372b8f2951440b469b1057dcfd12f94c2"
              "19kn0bzgalhvplp9y8f3azni4i23nib9m8qvlvclx09z61pa4py6")
        (list "dalaptop"
              "1f53d7dd08c3da90bdfadd33263dc46c92822810"
              "19sksaywr25bvfbbp74xiv737f5rnxkv8gymdw9a8p909p760jsd")))

(define %flags
  (list (list "kernelpanicroom" 'base 'opt 'graphic)
        (list "dalaptop" 'base 'graphic)
        (list "s-laura" 'base)))

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
    (append
      (if (memq 'base (assoc-ref %flags (gethostname)))
        (list (specification->package "mumi")
              (specification->package "sbctl")
              (specification->package "rocm-toolchain")
              (list (specification->package "openjdk") "jdk")
              (specification->package "go")
              (specification->package "dos2unix")
              (list (specification->package "elfutils") "bin")
              (specification->package "elfutils")
              (list (specification->package "libgit2") "debug")
              (specification->package "guile")
              (specification->package "polkit")
              (specification->package "efivar")
              (specification->package "distrobox")
              (specification->package "podman")
              (specification->package "duf")
              (specification->package "kubo")
              (specification->package "docker")
              (specification->package "node")
              (specification->package "age")
              (specification->package "encpipe")
              (specification->package "openmpi")
              (specification->package "polkit-kde-agent")
              (specification->package "zig")
              (specification->package "ent")
              (specification->package "parted")
              (specification->package "gptfdisk")
              (specification->package "msgpack-c")
              (specification->package "rust")
              (list (specification->package "rust") "rust-src")
              (list (specification->package "rust") "tools")
              (list (specification->package "rust") "cargo")
              (specification->package "pinentry")
              (list (specification->package "glibc") "static")
              (specification->package "grub-efi")
              (specification->package "efibootmgr")
              (specification->package "uefitool")
              (specification->package "ffmpeg@6")
              (specification->package "perf")
              (specification->package "ruby")
              (specification->package "rsync")
              (specification->package "radare2")
              (specification->package "drand-rs")
              (specification->package "rust-cargo")
              (specification->package "docker-compose")
              (specification->package "nomadnet")
              (specification->package "magic-wormhole")
              (specification->package "cmake")
              (specification->package "b3sum")
              (specification->package "mosquitto")
              (specification->package "aircrack-ng")
              (specification->package "udftools")
              (specification->package "vlang")
              (specification->package "lld")
              (specification->package "mtools")
              (specification->package "python-next")
              (specification->package "pkgconf")
              (specification->package "tig")
              (specification->package "tor")
              (specification->package "ddrescue")
              (specification->package "mpc")
              (specification->package "libxml2")
              (specification->package "nanomsg")
              (specification->package "libgfshare")
              (specification->package "valgrind")
              (specification->package "masscan")
              (specification->package "cowsay")
              (specification->package "htop")
              (specification->package "gnutls")
              (specification->package "pari-gp")
              (specification->package "ntl")
              (specification->package "dosfstools")
              (specification->package "screen")
              (specification->package "pv")
              (specification->package "imagemagick")
              (specification->package "swig")
              (specification->package "qdl")
              (specification->package "fastboot")
              (specification->package "flashrom")
              (specification->package "graphviz")
              (specification->package "gdb")
              (specification->package "binwalk")
              (specification->package "po4a")
              (specification->package "asciidoc")
              (specification->package "signify")
              (specification->package "cpio")
              (specification->package "progress")
              (specification->package "lz4")
              (specification->package "libdwarf")
              (specification->package "minisign")
              (specification->package "adb")
              (specification->package "lsof")
              (specification->package "libnsl")
              (specification->package "dmidecode")
              (specification->package "gmp-ecm")
              (specification->package "gflags")
              (specification->package "glog")
              (specification->package "doxygen")
              (specification->package "bmon")
              (specification->package "gperftools")
              (specification->package "netcat")
              (specification->package "unrar-free")
              (specification->package "gperf")
              (specification->package "capstone")
              (specification->package "intltool")
              (specification->package "perl-image-exiftool")
              (specification->package "nmap")
              (specification->package "iverilog")
              (specification->package "hexedit")
              (specification->package "p7zip")
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
              (specification->package "fastfetch")
              (specification->package "gsl")
              (specification->package "unzip")
              (specification->package "zip")
              (specification->package "grub")
              (specification->package "docker-cli")
              (specification->package "python-dbus")
              (specification->package "dbus")
              (specification->package "openssh")
              (specification->package "git")
              (specification->package "subversion")
              (specification->package "pkg-config")
              (specification->package "zlib")
              (specification->package "pciutils")
              (specification->package "nss")
              (specification->package "cups")
              (specification->package "cryptsetup")
              (specification->package "lvm2")
              (specification->package "libbsd")
              (specification->package "libuv")
              (specification->package "libpcap")
              (specification->package "meson")
              (specification->package "mdadm")
              (specification->package "python-pip")
              (specification->package "ninja")
              (specification->package "libgc")
              (specification->package "libedit")
              (specification->package "fuse")
              (specification->package "ntp")
              (specification->package "openh264")
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
              (specification->package "popt")
              (specification->package "libusb")
              (specification->package "mtdev")
              (specification->package "syncthing")
              (specification->package "vim-guix-vim")
              (specification->package "nss-certs")
              (specification->package "fatfsck-static")
              (specification->package "verilator")
              (list (specification->package "bind") "utils")
              (specification->package "yt-dlp")
              (specification->package "mutt")
              (specification->package "shepherd-run")
              (specification->package "diffoscope")
              (specification->package "git-lfs")
              (specification->package "ollama")
              (specification->package "libevent"))
        '())
      (if (memq 'opt (assoc-ref %flags (gethostname)))
        (list (specification->package "haunt")
              (list (specification->package "guile") "debug")
              (specification->package "dotnet")
              (specification->package "pesign")
              (specification->package "yggdrasil")
              (specification->package "yosys")
              (specification->package "mpd")
              (specification->package "cryptominisat")
              (specification->package "minisat")
              (specification->package "pngcrush")
              (specification->package "wayvnc")
              (specification->package "gzdoom")
              (specification->package "maven")
              (specification->package "hyperrogue")
              (specification->package "fceux")
              (specification->package "sonata")
              (specification->package "boinc-client")
              (specification->package "python-pymol")
              (specification->package "transmission")
              (specification->package "x11vnc")
              (specification->package "cantata")
              (specification->package "xen")
              (specification->package "java-apache-ivy")
              (specification->package "zsnes")
              (specification->package "Amogus-File-Encoder")
              (specification->package "hashcat")
              (specification->package "borg")
              (specification->package "dwarfs")
              (specification->package "uesave")
              (specification->package "ant")
              (specification->package "units")
              (specification->package "mpd-mpc")
              (specification->package "rogue")
              (specification->package "tcptrack")
              (specification->package "paper-age")
              (specification->package "tpm2-tools")
              (specification->package "sl")
              (specification->package "enchive")
              (specification->package "yara")
              (specification->package "sshfs")
              (specification->package "ccache")
              (specification->package "cabal-install")
              (specification->package "mympd")
              (specification->package "python-pystache")
              (specification->package "testdisk")
              (specification->package "xdotool")
              (specification->package "clamav")
              (specification->package "libsixel")
              (specification->package "bsdiff")
              (specification->package "lrzip")
              (specification->package "john-the-ripper-jumbo")
              (specification->package "gifsicle")
              (specification->package "texlive")
              (specification->package "freehdl")
              (specification->package "debootstrap")
              (specification->package "catimg")
              (specification->package "gnucobol")
              (specification->package "z3")
              (specification->package "jmtpfs")
              (specification->package "mescc-tools")
              (specification->package "i2c-tools")
              (specification->package "texinfo")
              (specification->package "torsocks")
              (specification->package "mkp224o")
              (specification->package "par2cmdline")
              (specification->package "minetest-mineclone")
              (specification->package "iucode-tool")
              (specification->package "i2pd")
              (specification->package "libmpdclient")
              (specification->package "dtc")
              (specification->package "wasmtime")
              (specification->package "hipify")
              (specification->package "leopard")
              (specification->package "ricochet-refresh")
              (specification->package "git-repo")
              (specification->package "bkcrack")
              (specification->package "cpu-rec-rs"))
        '())
      (if (memq 'graphic (assoc-ref %flags (gethostname)))
        (list (specification->package "dragon-drop")
              (specification->package "calibre")
              (specification->package "dino")
              (specification->package "qemu")
              (specification->package "torbrowser")
              (specification->package "librewolf")
              (specification->package "atril")
              (specification->package "libreoffice")
              (specification->package "gqrx")
              (specification->package "obs")
              (specification->package "obs-wlrobs")
              (specification->package "vtk")
              (specification->package "vscodium")
              (specification->package "waybar")
              (specification->package "krita")
              (specification->package "xwaylandvideobridge")
              (specification->package "kdenlive")
              (specification->package "krdc")
              (specification->package "xdot")
              (specification->package "wireshark")
              (specification->package "xdg-desktop-portal")
              (specification->package
                "xdg-desktop-portal-hyprland")
              (specification->package "libappindicator")
              (specification->package "pipewire")
              (specification->package "wireplumber")
              (specification->package "ydotool")
              (specification->package "tpt")
              (specification->package "minetest")
              (specification->package "vala")
              (specification->package "keepassxc")
              (specification->package "vlc")
              (specification->package "pamixer")
              (specification->package "wofi")
              (specification->package "dunst")
              (specification->package "wxwidgets")
              (specification->package "audacity")
              (specification->package "golly")
              (specification->package "winetricks")
              (specification->package "libxfce4ui")
              (specification->package "flatpak")
              (specification->package "gparted")
              (specification->package "qdirstat")
              (specification->package
                "webkitgtk-with-libsoup2")
              (specification->package "xournalpp")
              (specification->package "wine64")
              (specification->package "lxappearance")
              (specification->package "gimp")
              (specification->package "pavucontrol")
              (specification->package "qbittorrent")
              (specification->package "inkscape")
              (specification->package "sdl-gfx")
              (specification->package "sdl-ttf")
              (specification->package "sdl-mixer")
              (specification->package "sdl2-image")
              (specification->package "sdl2")
              (specification->package "gtk+")
              (specification->package "qtsvg")
              (specification->package "qtbase")
              (list (specification->package "gtk") "bin")
              (specification->package "gnome-keyring")
              (specification->package "hyprland")
              (specification->package "swww")
              (specification->package "clipmon")
              (specification->package "feh")
              (list (specification->package "python-next")
                    "tk")
              (specification->package "dmenu")
              (specification->package "xeyes")
              (specification->package "wl-clipboard")
              (specification->package "xhost")
              (specification->package "playerctl")
              (specification->package "xsel")
              (specification->package "xdg-utils")
              (specification->package "gqrx-scanner")
              (specification->package "tigervnc-client")
              (specification->package "rocm-opencl-runtime")
              (specification->package "rocm-bandwidth-test")
              (specification->package "rocminfo")
              (specification->package "rocr-runtime")
              (specification->package "gstreamer")
              (specification->package "flatpak-xdg-utils")
              (specification->package "rdesktop")
              (specification->package "xrandr")
              (specification->package "xinput")
              (specification->package "xclip")
              (specification->package "libxpm")
              (specification->package "xcb-util-renderutil")
              (specification->package "xcb-util-keysyms")
              (specification->package "xcb-util-image")
              (specification->package "xcb-util-wm")
              (specification->package "swaylock")
              (specification->package "grim")
              (specification->package "slurp")
              (specification->package "gobject-introspection")
              (specification->package "gdk-pixbuf")
              (specification->package "freeglut")
              (specification->package "glu")
              (specification->package "mesa-utils")
              (list (specification->package "mesa") "bin")
              (specification->package "mesa")
              (specification->package "xauth")
              (specification->package "libsm")
              (specification->package "libice")
              (specification->package "setxkbmap")
              (specification->package "rtl-sdr")
              (specification->package "clinfo")
              (specification->package "opencl-icd-loader")
              (specification->package "alsa-lib")
              (specification->package "java-openjfx-base")
              (specification->package "font-gnu-freefont")
              (specification->package "gtkwave")
              (specification->package "openscad")
              (specification->package "alacritty")
              (specification->package "qtwayland")
              (specification->package "kdeconnect")
              (specification->package "libfive")
              (specification->package "wl-screenrec")
              (specification->package "kate")
              (specification->package "okular")
              (specification->package "mpv")
              (specification->package "CasioEmu")
              (specification->package "heimdall")
              (specification->package "flatpak-builder")
              (specification->package "avogadro2")
              (specification->package "openbabel"))
        '())))
  (services
    (append
      %base-home-services
      (list (service
              home-zsh-service-type
              (home-zsh-configuration
                (zshrc (list (local-file "./files/zshrc" "zshrc")))))
            (service home-wineserver-service-type)
            (service home-pulseaudio-service-type)
            (service home-ollama-service-type)
            (service
              home-shepherd-service-type
              (home-shepherd-configuration
                (shepherd (specification->package "shepherd"))))
            (simple-service
              'config-service
              home-files-service-type
              `(,(if (memq 'graphic (assoc-ref %flags (gethostname)))
                   `(".config/hypr"
                     ,(origin
                        (method git-fetch)
                        (uri (git-reference
                               (url "https://github.com/jakiki6/hyprland-config.git")
                               (commit
                                 (car (assoc-ref %hashes (gethostname))))))
                        (sha256
                          (base32 (cadr (assoc-ref %hashes (gethostname))))))))
                (".config/guix/channels.scm"
                 ,(local-file "files/channels.scm"))
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
                (".icons/BreezeX" ,breezex-cursor)))))))
