(define kexec-shepherd
  (package
    (inherit shepherd-0.10)
    (source
      (origin
        (method
          (origin-method (package-source shepherd-0.10)))
        (uri (origin-uri (package-source shepherd-0.10)))
        (sha256
          (base32
            "0v9ld9gbqdp5ya380fbkdsxa0iqr90gi6yk004ccz3n792nq6wlj"))
        (patches
          (list (local-file
                  "../patches/shepherd-reboot-kexec.patch")))))))

(define-public python-rns
  (package
    (name "python-rns")
    (version "0.6.5")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "rns" version))
        (sha256
          (base32
            "0vxvhfiq8li7paxdwz2as2y0pvf0vpvshzcimmx4mn4gv872d8iv"))))
    (build-system pyproject-build-system)
    (propagated-inputs
      (list python-cryptography python-pyserial))
    (arguments
      `(#:tests?
        #f
        #:phases
        (modify-phases
          %standard-phases
          (delete 'sanity-check))))
    (home-page "https://reticulum.network/")
    (synopsis
      "Self-configuring, encrypted and resilient mesh networking stack for LoRa, packet radio, WiFi and everything in between")
    (description
      "Reticulum is the cryptography-based networking stack for building local and wide-area networks with readily available hardware.\nReticulum can continue to operate even in adverse conditions with very high latency and extremely low bandwidth.")
    (license license:expat)))

(define-public python-lxmf
  (package
    (name "python-lxmf")
    (version "0.3.8")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "lxmf" version))
        (sha256
          (base32
            "1806wvrgs95pli3qjw0svg4vaz29x96vyjs6zilnwja9sflq19ki"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-rns))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/markqvist/lxmf")
    (synopsis
      "Lightweight Extensible Message Format for Reticulum")
    (description
      "Lightweight Extensible Message Format for Reticulum")
    (license license:expat)))

(define-public nomadnet
  (package
    (name "nomadnet")
    (version "0.4.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "nomadnet" version))
        (sha256
          (base32
            "0jyi8v1qqymgi5b20a1gjj5mcsrbfzign8b3vijpkjp926w1azlm"))))
    (build-system pyproject-build-system)
    (propagated-inputs
      (list python-lxmf
            python-qrcode
            python-rns
            python-urwid))
    (arguments `(#:tests? #f))
    (home-page
      "https://github.com/markqvist/nomadnet")
    (synopsis "Communicate Freely")
    (description
      "Off-grid, resilient mesh communication with strong encryption, forward secrecy and extreme privacy.")
    (license license:gpl3)))

(define-public rust-thiserror-impl-1
  (package
    (name "rust-thiserror-impl")
    (version "1.0.50")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "thiserror-impl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1f0lmam4765sfnwr4b1n00y14vxh10g0311mkk0adr80pi02wsr6"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/dtolnay/thiserror")
    (synopsis
      "Implementation detail of the `thiserror` crate")
    (description
      "Implementation detail of the `thiserror` crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-thiserror-1
  (package
    (name "rust-thiserror")
    (version "1.0.50")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "thiserror" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ll2sfbrxks8jja161zh1pgm3yssr7aawdmaa2xmcwcsbh7j39zr"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-thiserror-impl" ,rust-thiserror-impl-1))))
    (home-page
      "https://github.com/dtolnay/thiserror")
    (synopsis "derive(Error)")
    (description "derive(Error)")
    (license (list license:expat license:asl2.0))))

(define-public rust-edit-0.1
  (package
    (name "rust-edit")
    (version "0.1.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "edit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1d7v2yd2jckqr1v4rd1fgihqnad5wlxgkxbb9kg1ysdwyxqslqn5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-shell-words" ,rust-shell-words-1)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-which" ,rust-which-4))))
    (home-page
      "https://github.com/milkey-mouse/edit")
    (synopsis
      "Open a file in the default text editor")
    (description
      "Open a file in the default text editor")
    (license license:cc0)))

(define-public uesave
  (package
    (name "uesave")
    (version "0.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "uesave" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0cj3xhx43if01llss1k265zyjq191yk1xn9xcbic7afnn4apggc0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-anyhow" ,rust-anyhow-1)
         ("rust-byteorder" ,rust-byteorder-1)
         ("rust-clap" ,rust-clap-4)
         ("rust-edit" ,rust-edit-0.1)
         ("rust-indexmap" ,rust-indexmap-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-shell-words" ,rust-shell-words-1)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-uuid" ,rust-uuid-1))
        #:cargo-development-inputs
        (("rust-pretty-assertions"
          ,rust-pretty-assertions-1))))
    (home-page
      "https://github.com/trumank/uesave-rs")
    (synopsis
      "Unreal Engine save file (GVAS) reading/writing")
    (description
      "Unreal Engine save file (GVAS) reading/writing")
    (license license:expat)))

(define-public libgfshare
  (package
    (name "libgfshare")
    (version "1.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/jcushman/libgfshare")
               (commit
                 "beeebe381a3953a3535295b0121e13c0aae1112e")))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "053gzsy5sv7yjzbnnql2a89f5y0bab173m057z7xxwrpkvqkvcq5"))))
    (build-system gnu-build-system)
    (inputs '())
    (native-inputs (list autoconf automake libtool))
    (synopsis
      "Library for Shamir Secret Sharing in the Galois Field 2**8")
    (description
      "This library implements what is known as Shamir Secret Sharing.")
    (home-page
      "https://github.com/jcushman/libgfshare")
    (license license:expat)))

(define-public bsdiff
  (package
    (name "bsdiff")
    (version "4.3")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/mendsley/bsdiff")
               (commit
                 "b817e9491cf7b8699c8462ef9e2657ca4ccd7667")))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "1f72rpivnvkim2xr4j7p2inm8a84g2kbzbs0shfcbi2qpgxmm8m1"))))
    (build-system gnu-build-system)
    (inputs '())
    (native-inputs (list autoconf automake libtool))
    (synopsis
      "Libraries for building and applying patches to binary files.")
    (description
      "bsdiff and bspatch are libraries for building and applying patches to binary files.")
    (home-page "https://github.com/mendsley/bsdiff")
    (license license:bsd-3)))

(define-public libsixel
  (package
    (name "libsixel")
    (version "1.8.6")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/saitoha/libsixel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "1saxdj6sldv01g6w6yk8vr7px4bl31xca3a82j6v1j3fw5rbfphy"))))
    (build-system gnu-build-system)
    (inputs '())
    (synopsis
      "A SIXEL encoder/decoder implementation.")
    (description
      "This package provides encoder/decoder implementation for DEC SIXEL graphics, and some converter programs.")
    (home-page "https://github.com/saitoha/libsixel")
    (license license:expat)))
