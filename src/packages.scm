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
          (list (local-file "../patches/shepherd-reboot-kexec.patch")))))))

(define-public python-rns
  (package
    (name "python-rns")
    (version "0.6.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "rns" version))
       (sha256
        (base32 "1mqhdp0cjj5kvmzfa1i4bvg9ixknyb7cslvxg5ah0qfw5wxhjynb"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-cryptography python-pyserial))
    (arguments
      `(#:tests? #f
        #:phases (modify-phases %standard-phases
                   (delete 'sanity-check))))
    (home-page "https://reticulum.network/")
    (synopsis
     "Self-configuring, encrypted and resilient mesh networking stack for LoRa, packet radio, WiFi and everything in between")
    (description
     "Reticulum is the cryptography-based networking stack for building local and wide-area networks with readily available hardware.
Reticulum can continue to operate even in adverse conditions with very high latency and extremely low bandwidth.")
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
        (base32 "1mrny6mxvvsrlvriz2bmsjvy0cf0b0ch83sjvn84881hanzi09vs"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-rns))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/markqvist/lxmf")
    (synopsis "Lightweight Extensible Message Format for Reticulum")
    (description "Lightweight Extensible Message Format for Reticulum")
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
        (base32 "160xnpfwdi67iw8r0cyjwmmv12xiz5lf8wiyh1wnsnc337k4vwsh"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-lxmf python-qrcode python-rns python-urwid))
    (arguments `(#:tests? #f))
    (home-page "https://github.com/markqvist/nomadnet")
    (synopsis "Communicate Freely")
    (description "Off-grid, resilient mesh communication with strong encryption, forward secrecy and extreme privacy.")
    (license license:gpl3)))
