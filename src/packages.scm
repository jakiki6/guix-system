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
    (version "0.6.2")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "rns" version))
        (sha256
          (base32
            "1mqhdp0cjj5kvmzfa1i4bvg9ixknyb7cslvxg5ah0qfw5wxhjynb"))))
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
    (version "0.3.6")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "lxmf" version))
        (sha256
          (base32
            "1mrny6mxvvsrlvriz2bmsjvy0cf0b0ch83sjvn84881hanzi09vs"))))
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
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "nomadnet" version))
        (sha256
          (base32
            "160xnpfwdi67iw8r0cyjwmmv12xiz5lf8wiyh1wnsnc337k4vwsh"))))
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
