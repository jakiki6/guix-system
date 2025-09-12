(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (guix channels)
             (guix packages)
             (guix git-download)
             (guix download)
             (guix build-system copy)
             ((guix licenses)
              #:prefix license:)
             (gnu home services shells)
             (gnu home services guix)
             (gnu home services shepherd)
             (gnu home services sound)
             (gnu home services desktop)
             (gnu home services)
             (laura home services wine)
             (laura home services audio)
             (laura home services ai)
             (laura home services radicle))

(include "src/secrets.scm")

(define %hashes
  (list (list "kernelpanicroom"
              "6683ad374c83aff55d7c908b192f482c9da2c4b1"
              "11r1gw1r8h8l3j3h4is24z2zglnbil96ncmidic0w0rz4gwg6ibg")
        (list "dalaptop"
              "d0aa2c0f2836bf815fc7f8c5d12aec0f2cca65eb"
              "1r54im071war2ra4gnxgkii67ha4gshr30vl75w6qxwzvz9lnawl")))

(define breezex-cursor
  (package
    (name "breezex-cursor")
    (version "2.0.1")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.1/BreezeX-Dark.tar.xz")
       (sha256
        (base32 "0lxnam952dv4qly0v3a5g0bxj0jcxx4dv47jwmgmdwdhcqs79pwc"))))
    (build-system copy-build-system)
    (home-page "https://github.com/ful1e5/BreezeX_Cursor")
    (synopsis "")
    (description "")
    (license license:gpl3)))

(home-environment
  (packages (map (lambda (package
                           )
                   (if (pair? package)
                       (cons (specification->package (car package))
                             (cdr package))
                       (specification->package package)))
                 '("sbctl" "clang-toolchain"
                   ("openjdk" "jdk")
                   "go"
                   "dos2unix"
                   ("elfutils" "bin")
                   "elfutils"
                   "guile"
                   "polkit"
                   "efivar"
                   "distrobox"
                   "podman"
                   "duf"
                   "kubo"
                   "docker"
                   "node"
                   "age"
                   "openmpi"
                   "polkit-kde-agent"
                   "zig"
                   "ent"
                   "parted"
                   "gptfdisk"
                   "msgpack-c"
                   "rust"
                   ("rust" "rust-src")
                   ("rust" "tools")
                   ("rust" "cargo")
                   "pinentry"
                   ("glibc" "static")
                   "grub-efi"
                   "efibootmgr"
                   "uefitool"
                   "ffmpeg@6"
                   "perf"
                   "ruby"
                   "rsync"
                   "radare2"
                   "drand-rs"
                   "docker-compose"
                   "nomadnet"
                   "magic-wormhole"
                   "cmake"
                   "b3sum"
                   "mosquitto"
                   "udftools"
                   "lld"
                   "mtools"
                   "python-next"
                   "pkgconf"
                   "tig"
                   "tor"
                   "ddrescue"
                   "mpc"
                   "nanomsg"
                   "libgfshare"
                   "valgrind"
                   "masscan"
                   "cowsay"
                   "htop"
                   "gnutls"
                   "pari-gp"
                   "ntl"
                   "dosfstools"
                   "screen"
                   "pv"
                   "imagemagick"
                   "swig"
                   "qdl"
                   "fastboot"
                   "flashrom"
                   "graphviz"
                   "gdb"
                   "binwalk"
                   "po4a"
                   "asciidoc"
                   "signify"
                   "cpio"
                   "progress"
                   "lz4"
                   "libdwarf"
                   "minisign"
                   "adb"
                   "lsof"
                   "libnsl"
                   "dmidecode"
                   "gmp-ecm"
                   "gflags"
                   "glog"
                   "doxygen"
                   "bmon"
                   "gperftools"
                   "netcat"
                   "unrar-free"
                   "gperf"
                   "capstone"
                   "intltool"
                   "perl-image-exiftool"
                   "nmap"
                   "iverilog"
                   "hexedit"
                   "p7zip"
                   "upx"
                   ("openssl" "doc")
                   "socat"
                   "cmatrix"
                   "cloc"
                   "libgcrypt"
                   "readline"
                   "flex"
                   "bison"
                   "autoconf"
                   "bc"
                   "make"
                   "strace"
                   "patchelf"
                   "traceroute"
                   "gmp"
                   "nasm"
                   "msr-tools"
                   "ncurses"
                   "acpica"
                   "libtree"
                   "fastfetch"
                   "gsl"
                   "unzip"
                   "zip"
                   "docker-cli"
                   "python-dbus"
                   "dbus"
                   "openssh"
                   "git"
                   "subversion"
                   "pkg-config"
                   "zlib"
                   "pciutils"
                   "nss"
                   "cups"
                   "cryptsetup"
                   "lvm2"
                   "libbsd"
                   "libuv"
                   "libpcap"
                   "meson"
                   "mdadm"
                   "ninja"
                   "libgc"
                   "libedit"
                   "fuse"
                   "ntp"
                   "openh264"
                   "jq"
                   "bzip2"
                   "net-tools"
                   "fftwf"
                   "fftw"
                   "ntfs-3g"
                   "iptables"
                   "help2man"
                   "perl"
                   "libtool"
                   "m4"
                   "automake"
                   "file"
                   "popt"
                   "libusb"
                   "mtdev"
                   "syncthing"
                   "vim-guix-vim"
                   "nss-certs"
                   "verilator"
                   ("bind" "utils")
                   "yt-dlp"
                   "mutt"
                   "shepherd-run"
                   "diffoscope"
                   "git-lfs"
                   "libevent"
                   "radicle"
                   "dumpasn1"
                   "luajit"
                   "tlp"
                   "bluedevil"
                   "haunt"
                   ("guile" "debug")
                   "yosys"
                   "mpd"
                   "cryptominisat"
                   "minisat"
                   "pngcrush"
                   "wayvnc"
                   "maven"
                   "fceux"
                   "sonata"
                   "boinc-client"
                   "python-pymol"
                   "transmission"
                   "x11vnc"
                   "cantata"
                   "xen"
                   "java-apache-ivy"
                   "zsnes"
                   "Amogus-File-Encoder"
                   "hashcat"
                   "borg"
                   "uesave"
                   "ant"
                   "units"
                   "mpd-mpc"
                   "rogue"
                   "tcptrack"
                   "paper-age"
                   "tpm2-tools"
                   "sl"
                   "enchive"
                   "yara"
                   "sshfs"
                   "ccache"
                   "cabal-install"
                   "mympd"
                   "python-pystache"
                   "testdisk"
                   "xdotool"
                   "clamav"
                   "libsixel"
                   "bsdiff"
                   "lrzip"
                   "john-the-ripper-jumbo"
                   "gifsicle"
                   "texlive"
                   "debootstrap"
                   "catimg"
                   "gnucobol"
                   "z3"
                   "jmtpfs"
                   "mescc-tools"
                   "i2c-tools"
                   "texinfo"
                   "torsocks"
                   "mkp224o"
                   "par2cmdline"
                   "iucode-tool"
                   "i2pd"
                   "libmpdclient"
                   "dtc"
                   "leopard"
                   "ricochet-refresh"
                   "git-repo"
                   "bkcrack"
                   "cpu-rec-rs"
                   "boost"
                   "cgal"
                   "double-conversion"
                   "opencsg"
                   "glew"
                   "libzip"
                   "eigen"
                   "cbonsai"
                   "amdgpu-top"
                   "electrum"
                   "die-engine"
                   "ioquake3"
                   "lean4"
                   "monero-gui"
                   "dragon-drop"
                   "calibre"
                   "brightnessctl"
                   "dino"
                   "qemu"
                   "torbrowser"
                   "librewolf"
                   "atril"
                   "libreoffice"
                   "gqrx"
                   "obs"
                   "obs-wlrobs"
                   "vtk"
                   "vscodium"
                   "waybar"
                   "krita"
                   "xwaylandvideobridge"
                   "kdenlive"
                   "krdc"
                   "xdot"
                   "wireshark"
                   "xdg-desktop-portal"
                   "xdg-desktop-portal-hyprland"
                   "libappindicator"
                   "pipewire"
                   "wireplumber"
                   "ydotool"
                   "tpt"
                   "vala"
                   "keepassxc"
                   "vlc"
                   "pamixer"
                   "wofi"
                   "dunst"
                   "wxwidgets"
                   "audacity"
                   "golly"
                   "libxfce4ui"
                   "flatpak"
                   "gparted"
                   "qdirstat"
                   "webkitgtk-with-libsoup2"
                   "xournalpp"
                   "wine64"
                   "lxappearance"
                   "gimp"
                   "pavucontrol"
                   "qbittorrent"
                   "inkscape"
                   "sdl-gfx"
                   "sdl-ttf"
                   "sdl-mixer"
                   "sdl2-image"
                   "sdl2"
                   "gtk+"
                   "qtbase@5"
                   "qtmultimedia@5"
                   "qtsvg@5"
                   "qscintilla"
                   ("gtk" "bin")
                   "gnome-keyring"
                   "hyprland"
                   "hypridle"
                   "hyprlock"
                   "swww"
                   "clipmon"
                   "feh"
                   ("python-next" "tk")
                   "dmenu"
                   "xeyes"
                   "wl-clipboard"
                   "xhost"
                   "playerctl"
                   "xsel"
                   "gqrx-scanner"
                   "tigervnc-client"
                   "rocm-opencl-runtime"
                   "rocm-bandwidth-test"
                   "rocminfo"
                   "rocr-runtime"
                   "gstreamer"
                   "flatpak-xdg-utils"
                   "xrandr"
                   "xinput"
                   "xclip"
                   "libxpm"
                   "xcb-util-renderutil"
                   "xcb-util-keysyms"
                   "xcb-util-image"
                   "xcb-util-wm"
                   "swaylock"
                   "grim"
                   "slurp"
                   "gobject-introspection"
                   "gdk-pixbuf"
                   "freeglut"
                   "glu"
                   "mesa-utils"
                   ("mesa" "bin")
                   "mesa"
                   "xauth"
                   "libsm"
                   "libice"
                   "setxkbmap"
                   "rtl-sdr"
                   "clinfo"
                   "opencl-icd-loader"
                   "alsa-lib"
                   "java-openjfx-base"
                   "font-gnu-freefont"
                   "gtkwave"
                   "openscad"
                   "alacritty"
                   "qtwayland"
                   "kdeconnect"
                   "libfive"
                   "wl-screenrec"
                   "kate"
                   "okular"
                   "mpv"
                   "CasioEmu"
                   "heimdall"
                   "flatpak-builder"
                   "avogadro2"
                   "openbabel"
                   "imhex"
                   "vulkan-loader"
                   "vulkan-headers")))
  (services
   (append %base-home-services
           (list (service home-zsh-service-type
                          (home-zsh-configuration (zshrc (list (local-file
                                                                "./files/zshrc"
                                                                "zshrc")))))
                 (service home-wineserver-service-type)
                 (service home-pipewire-service-type)
                 (service home-dbus-service-type)
                 (service home-radicle-service-type)
                 (service home-shepherd-service-type
                          (home-shepherd-configuration (shepherd (specification->package
                                                                  "shepherd"))))
                 (simple-service 'config-service home-files-service-type
                                 `((".config/hypr" ,(origin
                                                      (method git-fetch)
                                                      (uri (git-reference (url
                                                                           "https://github.com/jakiki6/hyprland-config.git")
                                                                          (commit
                                                                           (car
                                                                            (assoc-ref
                                                                             %hashes
                                                                             (gethostname))))))
                                                      (sha256 (base32 (cadr (assoc-ref
                                                                             %hashes
                                                                             (gethostname)))))))
                                   (".config/guix/channels.scm" ,(local-file
                                                                  "files/channels.scm"))
                                   (".vimrc" ,(local-file "files/vimrc"))
                                   (".local/bin/scmfmt" ,(local-file
                                                          "files/scmfmt"
                                                          #:recursive? #t))
                                   (".oh-my-zsh" ,(origin
                                                    (method git-fetch)
                                                    (uri (git-reference (url
                                                                         "https://github.com/ohmyzsh/ohmyzsh.git")
                                                                        (commit
                                                                         "a72a26406ad3aa9a47c3f5227291bad23494bed0")))
                                                    (sha256 (base32
                                                             "0jx4bhdrcxgapk7jf2s9c8y82wadk9wsick1gcn1ik0dadhga2dq"))))
                                   (".zsh/zsh-autosuggestions" ,(origin
                                                                  (method
                                                                   git-fetch)
                                                                  (uri (git-reference
                                                                        (url
                                                                         "https://github.com/zsh-users/zsh-autosuggestions")
                                                                        (commit
                                                                         "c3d4e576c9c86eac62884bd47c01f6faed043fc5")))
                                                                  (sha256 (base32
                                                                           "1m8yawj7skbjw0c5ym59r1y88klhjl6abvbwzy6b1xyx3vfb7qh7"))))
                                   (".mutt/muttrc" ,(plain-file "muttrc"
                                                                secret-muttrc))
                                   (".icons/BreezeX" ,breezex-cursor)))))))
