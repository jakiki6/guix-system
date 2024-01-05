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

(define-public rust-gix-worktree-state-0.4
  (package
    (name "rust-gix-worktree-state")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-worktree-state" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1m5y0qsf8r7sl6ffvi5ymd6497a5mb4k3pq31b072g5gvk6gr8il"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-filter" ,rust-gix-filter-0.6)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-gix-glob" ,rust-gix-glob-0.14)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-index" ,rust-gix-index-0.26)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-worktree" ,rust-gix-worktree-0.27)
         ("rust-io-close" ,rust-io-close-0.3)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project implementing setting the worktree to a particular state")
    (description
      "This package provides a crate of the gitoxide project implementing setting the\nworktree to a particular state")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-submodule-0.5
  (package
    (name "rust-gix-submodule")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-submodule" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hm1d7a9qb3zylln44bxcnmdy27zfajc6gj5g00kf95a2a6qr9xv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-gix-config" ,rust-gix-config-0.31)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-pathspec" ,rust-gix-pathspec-0.4)
         ("rust-gix-refspec" ,rust-gix-refspec-0.19)
         ("rust-gix-url" ,rust-gix-url-0.25)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing git submodules")
    (description
      "This package provides a crate of the gitoxide project dealing git submodules")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-worktree-0.27
  (package
    (name "rust-gix-worktree")
    (version "0.27.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-worktree" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1zfpqbrxxwjjhjk1rn60rmajxm4f7ix2jbx44vklz9nv47kpkbyx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-attributes" ,rust-gix-attributes-0.20)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-gix-glob" ,rust-gix-glob-0.14)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-ignore" ,rust-gix-ignore-0.9)
         ("rust-gix-index" ,rust-gix-index-0.26)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project for shared worktree related types and utilities.")
    (description
      "This package provides a crate of the gitoxide project for shared worktree\nrelated types and utilities.")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-status-0.2
  (package
    (name "rust-gix-status")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-status" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1c3a1y91444vdl1krhhybhlcb5fmjcwll8g9df1fbg27zcgjfm0w"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-filetime" ,rust-filetime-0.2)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-filter" ,rust-gix-filter-0.6)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-index" ,rust-gix-index-0.26)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-pathspec" ,rust-gix-pathspec-0.4)
         ("rust-gix-worktree" ,rust-gix-worktree-0.27)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing with 'git status'-like functionality")
    (description
      "This package provides a crate of the gitoxide project dealing with git\nstatus'-like functionality")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-revision-0.23
  (package
    (name "rust-gix-revision")
    (version "0.23.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-revision" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1215fz886j5gzf31kg32g566vm9pds5679d4d9vg79sr6k3pma9c"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-hashtable" ,rust-gix-hashtable-0.4)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-revwalk" ,rust-gix-revwalk-0.9)
         ("rust-gix-trace" ,rust-gix-trace-0.1)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing with finding names for revisions and parsing specifications")
    (description
      "This package provides a crate of the gitoxide project dealing with finding names\nfor revisions and parsing specifications")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-refspec-0.19
  (package
    (name "rust-gix-refspec")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-refspec" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1rx6q4k13zciaajz9a6g1wb1w70y92m6fzqc30xb9g8xqi69gc6c"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-revision" ,rust-gix-revision-0.23)
         ("rust-gix-validate" ,rust-gix-validate-0.8)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project for parsing and representing refspecs")
    (description
      "This package provides a crate of the gitoxide project for parsing and\nrepresenting refspecs")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-transport-0.38
  (package
    (name "rust-gix-transport")
    (version "0.38.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-transport" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0lp7bg7pj9l2na92bdrbx0zjybi7j88c26vm341z492f6s9rl81g"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-std" ,rust-async-std-1)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-base64" ,rust-base64-0.21)
         ("rust-bstr" ,rust-bstr-1)
         ("rust-curl" ,rust-curl-0.4)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-gix-command" ,rust-gix-command-0.2)
         ("rust-gix-credentials"
          ,rust-gix-credentials-0.21)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-packetline" ,rust-gix-packetline-0.16)
         ("rust-gix-quote" ,rust-gix-quote-0.4)
         ("rust-gix-sec" ,rust-gix-sec-0.10)
         ("rust-gix-url" ,rust-gix-url-0.25)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-reqwest" ,rust-reqwest-0.11)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dedicated to implementing the git transport layer")
    (description
      "This package provides a crate of the gitoxide project dedicated to implementing\nthe git transport layer")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-protocol-0.41
  (package
    (name "rust-gix-protocol")
    (version "0.41.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-protocol" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "03hy77hbszssdkc4iwig3f82ib4i6agfag37svd90pzsppm3y7ir"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-bstr" ,rust-bstr-1)
         ("rust-btoi" ,rust-btoi-0.4)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-gix-credentials"
          ,rust-gix-credentials-0.21)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-transport" ,rust-gix-transport-0.38)
         ("rust-maybe-async" ,rust-maybe-async-0.2)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-winnow" ,rust-winnow-0.5))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project for implementing git protocols")
    (description
      "This package provides a crate of the gitoxide project for implementing git\nprotocols")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-config-value-0.14
  (package
    (name "rust-gix-config-value")
    (version "0.14.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-config-value" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "13h1xpsb129zlcv2kbsl96hqm01csrzszc77qxcgnkd85rcdn6b4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project providing git-config value parsing")
    (description
      "This package provides a crate of the gitoxide project providing git-config value\nparsing")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-pathspec-0.4
  (package
    (name "rust-gix-pathspec")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-pathspec" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ka9h2lfgbfbby5rciipgy6nkl1qkcrhp0xvr11z13m3flpvkfqx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-bstr" ,rust-bstr-1)
         ("rust-gix-attributes" ,rust-gix-attributes-0.20)
         ("rust-gix-config-value"
          ,rust-gix-config-value-0.14)
         ("rust-gix-glob" ,rust-gix-glob-0.14)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing magical pathspecs")
    (description
      "This package provides a crate of the gitoxide project dealing magical pathspecs")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-pack-0.44
  (package
    (name "rust-gix-pack")
    (version "0.44.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-pack" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hwphs7ks8pf6v4wrmhd4iy8vj1in95db4q6j82i9zyy60pblc8l"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-clru" ,rust-clru-0.6)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-chunk" ,rust-gix-chunk-0.4)
         ("rust-gix-diff" ,rust-gix-diff-0.37)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-hashtable" ,rust-gix-hashtable-0.4)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-tempfile" ,rust-gix-tempfile-11)
         ("rust-gix-traverse" ,rust-gix-traverse-0.34)
         ("rust-memmap2" ,rust-memmap2-0.7)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-uluru" ,rust-uluru-3))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Implements git packs and related data structures")
    (description
      "This package implements git packs and related data structures")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-odb-0.54
  (package
    (name "rust-gix-odb")
    (version "0.54.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-odb" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0fql2p0xinkdaq7bybz12j1yw0b4lq3d1nl3sf2ad3qdp1nbac46"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arc-swap" ,rust-arc-swap-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-pack" ,rust-gix-pack-0.44)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-quote" ,rust-gix-quote-0.4)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-serde" ,rust-serde-1)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Implements various git object databases")
    (description
      "This package implements various git object databases")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-negotiate-0.9
  (package
    (name "rust-gix-negotiate")
    (version "0.9.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-negotiate" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0zxnxfjjqxap8plkhz5f4h0gwm83ain229y2vhwwxjgcj7sdqp1a"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-gix-commitgraph"
          ,rust-gix-commitgraph-0.22)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-revwalk" ,rust-gix-revwalk-0.9)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project implementing negotiation algorithms")
    (description
      "This package provides a crate of the gitoxide project implementing negotiation\nalgorithms")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-mailmap-0.20
  (package
    (name "rust-gix-mailmap")
    (version "0.20.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-mailmap" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "01wzzs8gifl6i4vzwbx1ywzwgazy1db6yfh8b3bjsssy1pn5ycp2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-actor" ,rust-gix-actor-0.28)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project for parsing mailmap files")
    (description
      "This package provides a crate of the gitoxide project for parsing mailmap files")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-index-0.26
  (package
    (name "rust-gix-index")
    (version "0.26.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-index" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0l0n7cld8m5fq1cnd3lyygmsirw5kzw7gxl8j082wbqv2b64yfn8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-bstr" ,rust-bstr-1)
         ("rust-btoi" ,rust-btoi-0.4)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-filetime" ,rust-filetime-0.2)
         ("rust-gix-bitmap" ,rust-gix-bitmap-0.2)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-lock" ,rust-gix-lock-11)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-traverse" ,rust-gix-traverse-0.34)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-memmap2" ,rust-memmap2-0.7)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A work-in-progress crate of the gitoxide project dedicated implementing the git index file")
    (description
      "This package provides a work-in-progress crate of the gitoxide project dedicated\nimplementing the git index file")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-ignore-0.9
  (package
    (name "rust-gix-ignore")
    (version "0.9.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-ignore" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ydq53isj75vf7gjggnv8yf2jimx7sfk5xpw66hvqi8nya6cq5d2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-glob" ,rust-gix-glob-0.14)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-serde" ,rust-serde-1)
         ("rust-unicode-bom" ,rust-unicode-bom-2))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing .gitignore files")
    (description
      "This package provides a crate of the gitoxide project dealing .gitignore files")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-discover-0.26
  (package
    (name "rust-gix-discover")
    (version "0.26.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-discover" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1wlhqkrfyln97arr3hyllw4xc9gnk2qb4nkh70z8hy0i6bq5qpd4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-dunce" ,rust-dunce-1)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-ref" ,rust-gix-ref-0.38)
         ("rust-gix-sec" ,rust-gix-sec-0.10)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Discover git repositories and check if a directory is a git repository")
    (description
      "Discover git repositories and check if a directory is a git repository")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-diff-0.37
  (package
    (name "rust-gix-diff")
    (version "0.37.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-diff" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0m055q3sywj4i3c3xhdw75ir77l6pn3k9bhazimfvjdqkzv984wk"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-getrandom" ,rust-getrandom-0.2)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-imara-diff" ,rust-imara-diff-0.1)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Calculate differences between various git objects")
    (description
      "Calculate differences between various git objects")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-url-0.25
  (package
    (name "rust-gix-url")
    (version "0.25.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-url" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "01a0phpk3f0lrhavqm51cgpdwh925i2djiyslaj57ync24d7lhhc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-home" ,rust-home-0.5)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-url" ,rust-url-2))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project implementing parsing and serialization of gix-url")
    (description
      "This package provides a crate of the gitoxide project implementing parsing and\nserialization of gix-url")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-credentials-0.21
  (package
    (name "rust-gix-credentials")
    (version "0.21.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-credentials" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1956pmz4sj25kydwh4ardzv9zbdpqrx050g5c4c2m14v0rs5sp0w"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-command" ,rust-gix-command-0.2)
         ("rust-gix-config-value"
          ,rust-gix-config-value-0.14)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-prompt" ,rust-gix-prompt-0.7)
         ("rust-gix-sec" ,rust-gix-sec-0.10)
         ("rust-gix-url" ,rust-gix-url-0.25)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project to interact with git credentials helpers")
    (description
      "This package provides a crate of the gitoxide project to interact with git\ncredentials helpers")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-utils-0.1
  (package
    (name "rust-gix-utils")
    (version "0.1.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-utils" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0gkaiilalddy83s2pzq78izzg88cgwq5a2ybyshia3ph6wcw90lz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-fastrand" ,rust-fastrand-2))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate with `gitoxide` utilities that don't need feature toggles")
    (description
      "This package provides a crate with `gitoxide` utilities that don't need feature\ntoggles")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-tempfile-11
  (package
    (name "rust-gix-tempfile")
    (version "11.0.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-tempfile" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "08vykvfdgxvqqm63zav1rw730qm6cdnnvqni52dwcvm82j8x539q"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-dashmap" ,rust-dashmap-5)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-signal-hook" ,rust-signal-hook-0.3)
         ("rust-signal-hook-registry"
          ,rust-signal-hook-registry-1)
         ("rust-tempfile" ,rust-tempfile-3))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A tempfile implementation with a global registry to assure cleanup")
    (description
      "This package provides a tempfile implementation with a global registry to assure\ncleanup")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-lock-11
  (package
    (name "rust-gix-lock")
    (version "11.0.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-lock" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0drgl9qhkvlhjl0jc0lh2h7h3by1yg9wx4a8cqss8c4qlbk6ap3y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gix-tempfile" ,rust-gix-tempfile-11)
         ("rust-gix-utils" ,rust-gix-utils-0.1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis "A git-style lock-file implementation")
    (description
      "This package provides a git-style lock-file implementation")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-ref-0.38
  (package
    (name "rust-gix-ref")
    (version "0.38.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-ref" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ljasz4v4bikrb06wdp7hafznmhqh0zgmqvy02w2z3f8gb8gdhhf"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-actor" ,rust-gix-actor-0.28)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-lock" ,rust-gix-lock-11)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-tempfile" ,rust-gix-tempfile-11)
         ("rust-gix-validate" ,rust-gix-validate-0.8)
         ("rust-memmap2" ,rust-memmap2-0.7)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-winnow" ,rust-winnow-0.5))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis "A crate to handle git references")
    (description
      "This package provides a crate to handle git references")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-config-0.31
  (package
    (name "rust-gix-config")
    (version "0.31.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-config" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1fzraij8rb98j71id939qc56nzaqfaqp8ln3kcvhjv66nk39ibjw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-config-value"
          ,rust-gix-config-value-0.14)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-glob" ,rust-gix-glob-0.14)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-ref" ,rust-gix-ref-0.38)
         ("rust-gix-sec" ,rust-gix-sec-0.10)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-unicode-bom" ,rust-unicode-bom-2)
         ("rust-winnow" ,rust-winnow-0.5))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A git-config file parser and editor from the gitoxide project")
    (description
      "This package provides a git-config file parser and editor from the gitoxide\nproject")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-revwalk-0.9
  (package
    (name "rust-gix-revwalk")
    (version "0.9.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-revwalk" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1q7sgvkm0zdpp09v51jgv7c77zff82fvyr82dzc7dmjc5s4qqvd1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gix-commitgraph"
          ,rust-gix-commitgraph-0.22)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-hashtable" ,rust-gix-hashtable-0.4)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate providing utilities for walking the revision graph")
    (description
      "This package provides a crate providing utilities for walking the revision graph")
    (license (list license:expat license:asl2.0))))

(define-public rust-memmap2-0.9
  (package
    (name "rust-memmap2")
    (version "0.9.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "memmap2" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0pmq5jq3835i30vlwap81d95jkff2701bv843fxjn0j1mxbh31cg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-stable-deref-trait"
          ,rust-stable-deref-trait-1))))
    (home-page
      "https://github.com/RazrFalcon/memmap2-rs")
    (synopsis
      "Cross-platform Rust API for memory-mapped file IO")
    (description
      "Cross-platform Rust API for memory-mapped file IO")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-chunk-0.4
  (package
    (name "rust-gix-chunk")
    (version "0.4.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-chunk" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0pxm5mpaqssjzra4jchq3p2ap3n4xq4y9dsj685w5c2qnpcyq4fl"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Interact with the git chunk file format used in multi-pack index and commit-graph files")
    (description
      "Interact with the git chunk file format used in multi-pack index and\ncommit-graph files")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-commitgraph-0.22
  (package
    (name "rust-gix-commitgraph")
    (version "0.22.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-commitgraph" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0dpcdj9s5pkdvqpc22jm42y2lhkji2jgixps7a05kw11l1xh19w5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-chunk" ,rust-gix-chunk-0.4)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-memmap2" ,rust-memmap2-0.9)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Read-only access to the git commitgraph file format")
    (description
      "Read-only access to the git commitgraph file format")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-traverse-0.34
  (package
    (name "rust-gix-traverse")
    (version "0.34.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-traverse" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "12pk1w89kj978jdfsg2fwmq5p4gv0i0wydh6pxmbf6sfgpn51l0l"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gix-commitgraph"
          ,rust-gix-commitgraph-0.22)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-hashtable" ,rust-gix-hashtable-0.4)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-revwalk" ,rust-gix-revwalk-0.9)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis "A crate of the gitoxide project")
    (description
      "This package provides a crate of the gitoxide project")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-fs-0.8
  (package
    (name "rust-gix-fs")
    (version "0.8.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-fs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "01z1whm3qn0pinw4inbpvf53kbfw3kjq48h9vrd6lxzm82q6xs10"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate providing file system specific utilities to `gitoxide`")
    (description
      "This package provides a crate providing file system specific utilities to\n`gitoxide`")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-filter-0.6
  (package
    (name "rust-gix-filter")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-filter" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1zs288v2l7n8qcbvsjrc3xkm11mynyjwj7jj0ixricdnzp9p9xlj"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-encoding-rs" ,rust-encoding-rs-0.8)
         ("rust-gix-attributes" ,rust-gix-attributes-0.20)
         ("rust-gix-command" ,rust-gix-command-0.2)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-packetline-blocking"
          ,rust-gix-packetline-blocking-0.16)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-quote" ,rust-gix-quote-0.4)
         ("rust-gix-trace" ,rust-gix-trace-0.1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project implementing git filters")
    (description
      "This package provides a crate of the gitoxide project implementing git filters")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-quote-0.4
  (package
    (name "rust-gix-quote")
    (version "0.4.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-quote" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1wl64zksgnm5cl1wz3iw66h1v7r156fppa65g6y6hm2kz9g8912g"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-btoi" ,rust-btoi-0.4)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing with various quotations used by git")
    (description
      "This package provides a crate of the gitoxide project dealing with various\nquotations used by git")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-path-0.10
  (package
    (name "rust-gix-path")
    (version "0.10.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-path" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1q85yd7fl8p79zlwmbhsm88qpxkifp84cpw3nxkppq5b5yn6yvfq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-gix-trace" ,rust-gix-trace-0.1)
         ("rust-home" ,rust-home-0.5)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing paths and their conversions")
    (description
      "This package provides a crate of the gitoxide project dealing paths and their\nconversions")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-glob-0.14
  (package
    (name "rust-gix-glob")
    (version "0.14.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-glob" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "06gz18spc8p4b3rbbbh2i2dz1ld2cw3ikgxkwmhjkspfqnc95cax"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing with pattern matching")
    (description
      "This package provides a crate of the gitoxide project dealing with pattern\nmatching")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-attributes-0.20
  (package
    (name "rust-gix-attributes")
    (version "0.20.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-attributes" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "109kciz3cssfbx9zgslngdrkzwf3zd9mlv0srm3yqxlcsdlm8f8g"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-glob" ,rust-gix-glob-0.14)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-quote" ,rust-gix-quote-0.4)
         ("rust-gix-trace" ,rust-gix-trace-0.1)
         ("rust-kstring" ,rust-kstring-2)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-unicode-bom" ,rust-unicode-bom-2))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project dealing .gitattributes files")
    (description
      "This package provides a crate of the gitoxide project dealing .gitattributes\nfiles")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-worktree-stream-0.6
  (package
    (name "rust-gix-worktree-stream")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-worktree-stream" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0b5gf6pq9ypxhg0x9dj9b1agrhbj7rz64r10d0kp6d69z2v38jzf"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gix-attributes" ,rust-gix-attributes-0.20)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-filter" ,rust-gix-filter-0.6)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-traverse" ,rust-gix-traverse-0.34)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "generate a byte-stream from a git-tree")
    (description
      "generate a byte-stream from a git-tree")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-object-0.38
  (package
    (name "rust-gix-object")
    (version "0.38.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-object" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0lbaz0mzsg5vvm5qvi1nf6f0hyz62hfx18xk3h57fn3z4r22l3vl"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-btoi" ,rust-btoi-0.4)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-actor" ,rust-gix-actor-0.28)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-validate" ,rust-gix-validate-0.8)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-winnow" ,rust-winnow-0.5))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Immutable and mutable git objects with decoding and encoding support")
    (description
      "Immutable and mutable git objects with decoding and encoding support")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-archive-0.6
  (package
    (name "rust-gix-archive")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-archive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17gh1wzs1jrmywbchrqdmkma2c0saik7k52fralfdfkf6hbq97wh"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-flate2" ,rust-flate2-1)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-worktree-stream"
          ,rust-gix-worktree-stream-0.6)
         ("rust-tar" ,rust-tar-0.4)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-time" ,rust-time-0.3)
         ("rust-zip" ,rust-zip-0.6))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "archive generation from of a worktree stream")
    (description
      "archive generation from of a worktree stream")
    (license (list license:expat license:asl2.0))))

(define-public rust-terminal-size-0.2
  (package
    (name "rust-terminal-size")
    (version "0.2.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "terminal_size" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0drj7gb77kay5r1cv53ysq3g9g4f8n0jkhld0kadi3lzkvqzcswf"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-rustix" ,rust-rustix-0.37)
         ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page
      "https://github.com/eminence/terminal-size")
    (synopsis
      "Gets the size of your Linux or Windows terminal")
    (description
      "Gets the size of your Linux or Windows terminal")
    (license (list license:expat license:asl2.0))))

(define-public rust-anstyle-1
  (package
    (name "rust-anstyle")
    (version "1.0.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "anstyle" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "11yxw02b6parn29s757z96rgiqbn8qy0fk9a3p3bhczm85dhfybh"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/rust-cli/anstyle")
    (synopsis "ANSI text styling")
    (description "ANSI text styling")
    (license (list license:expat license:asl2.0))))

(define-public rust-winnow-0.5
  (package
    (name "rust-winnow")
    (version "0.5.28")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "winnow" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1qhzp7mg9m22qy7hjvdm178c9lyv16kjf3hsgb92y33jyy30g0vc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-anstream" ,rust-anstream-0.3)
         ("rust-anstyle" ,rust-anstyle-1)
         ("rust-is-terminal" ,rust-is-terminal-0.4)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-terminal-size" ,rust-terminal-size-0.2))))
    (home-page "https://github.com/winnow-rs/winnow")
    (synopsis
      "A byte-oriented, zero-copy, parser combinators library")
    (description
      "This package provides a byte-oriented, zero-copy, parser combinators library")
    (license license:expat)))

(define-public rust-gix-trace-0.1
  (package
    (name "rust-gix-trace")
    (version "0.1.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-trace" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "15xlc23pmmnxypy7znf416j5786hh5jg18swawjrhfmmk5bs71mn"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-tracing-core" ,rust-tracing-core-0.1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate to provide minimal `tracing` support that can be turned off to zero cost")
    (description
      "This package provides a crate to provide minimal `tracing` support that can be\nturned off to zero cost")
    (license (list license:expat license:asl2.0))))

(define-public rust-faster-hex-0.9
  (package
    (name "rust-faster-hex")
    (version "0.9.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "faster-hex" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "10wi4vqbdpkamw4qvra1ijp4as2j7j1zc66g4rdr6h0xv8gb38m2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/NervosFoundation/faster-hex")
    (synopsis "Fast hex encoding.")
    (description "Fast hex encoding.")
    (license license:expat)))

(define-public rust-gix-hash-0.13
  (package
    (name "rust-gix-hash")
    (version "0.13.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-hash" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1q1xcp8f5prpyr4x62jixrlgm99snscnf87bny1faqvg4v1gi30z"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-faster-hex" ,rust-faster-hex-0.9)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Borrowed and owned git hash digests used to identify git objects")
    (description
      "Borrowed and owned git hash digests used to identify git objects")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-features-0.36
  (package
    (name "rust-gix-features")
    (version "0.36.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-features" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ckilzixrfylgnw5by3wpmym3ri0v9dbc60dkknfnnxvqsjs8ijd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytes" ,rust-bytes-1)
         ("rust-bytesize" ,rust-bytesize-1)
         ("rust-crc32fast" ,rust-crc32fast-1)
         ("rust-crossbeam-channel"
          ,rust-crossbeam-channel-0.5)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-flate2" ,rust-flate2-1)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-trace" ,rust-gix-trace-0.1)
         ("rust-jwalk" ,rust-jwalk-0.8)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-prodash" ,rust-prodash-26)
         ("rust-sha1" ,rust-sha1-0.10)
         ("rust-sha1-smol" ,rust-sha1-smol-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-walkdir" ,rust-walkdir-2))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate to integrate various capabilities using compile-time feature flags")
    (description
      "This package provides a crate to integrate various capabilities using\ncompile-time feature flags")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-date-0.8
  (package
    (name "rust-gix-date")
    (version "0.8.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-date" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1gihdc405xb0f9sgm4ss0xr7g3kzf9qj4dd14laz0dgk27jgp3a6"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-time" ,rust-time-0.3))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "A crate of the gitoxide project parsing dates the way git does")
    (description
      "This package provides a crate of the gitoxide project parsing dates the way git\ndoes")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-actor-0.28
  (package
    (name "rust-gix-actor")
    (version "0.28.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix-actor" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "05xldn3aq58kjx2i87xsb2gdw7qhxvvikyvsiwvv85ppkq1cmb9f"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-btoi" ,rust-btoi-0.4)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-winnow" ,rust-winnow-0.5))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis "A way to identify git actors")
    (description
      "This package provides a way to identify git actors")
    (license (list license:expat license:asl2.0))))

(define-public rust-gix-0.55
  (package
    (name "rust-gix")
    (version "0.55.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gix" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1spf1hgpbn76y2am0q4i1qxwy8987g9f7byhs09r6y5v3v6nf9h0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-std" ,rust-async-std-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-gix-actor" ,rust-gix-actor-0.28)
         ("rust-gix-archive" ,rust-gix-archive-0.6)
         ("rust-gix-attributes" ,rust-gix-attributes-0.20)
         ("rust-gix-commitgraph"
          ,rust-gix-commitgraph-0.22)
         ("rust-gix-config" ,rust-gix-config-0.31)
         ("rust-gix-credentials"
          ,rust-gix-credentials-0.21)
         ("rust-gix-date" ,rust-gix-date-0.8)
         ("rust-gix-diff" ,rust-gix-diff-0.37)
         ("rust-gix-discover" ,rust-gix-discover-0.26)
         ("rust-gix-features" ,rust-gix-features-0.36)
         ("rust-gix-filter" ,rust-gix-filter-0.6)
         ("rust-gix-fs" ,rust-gix-fs-0.8)
         ("rust-gix-glob" ,rust-gix-glob-0.14)
         ("rust-gix-hash" ,rust-gix-hash-0.13)
         ("rust-gix-hashtable" ,rust-gix-hashtable-0.4)
         ("rust-gix-ignore" ,rust-gix-ignore-0.9)
         ("rust-gix-index" ,rust-gix-index-0.26)
         ("rust-gix-lock" ,rust-gix-lock-11)
         ("rust-gix-macros" ,rust-gix-macros-0.1)
         ("rust-gix-mailmap" ,rust-gix-mailmap-0.20)
         ("rust-gix-negotiate" ,rust-gix-negotiate-0.9)
         ("rust-gix-object" ,rust-gix-object-0.38)
         ("rust-gix-odb" ,rust-gix-odb-0.54)
         ("rust-gix-pack" ,rust-gix-pack-0.44)
         ("rust-gix-path" ,rust-gix-path-0.10)
         ("rust-gix-pathspec" ,rust-gix-pathspec-0.4)
         ("rust-gix-prompt" ,rust-gix-prompt-0.7)
         ("rust-gix-protocol" ,rust-gix-protocol-0.41)
         ("rust-gix-ref" ,rust-gix-ref-0.38)
         ("rust-gix-refspec" ,rust-gix-refspec-0.19)
         ("rust-gix-revision" ,rust-gix-revision-0.23)
         ("rust-gix-revwalk" ,rust-gix-revwalk-0.9)
         ("rust-gix-sec" ,rust-gix-sec-0.10)
         ("rust-gix-status" ,rust-gix-status-0.2)
         ("rust-gix-submodule" ,rust-gix-submodule-0.5)
         ("rust-gix-tempfile" ,rust-gix-tempfile-11)
         ("rust-gix-trace" ,rust-gix-trace-0.1)
         ("rust-gix-transport" ,rust-gix-transport-0.38)
         ("rust-gix-traverse" ,rust-gix-traverse-0.34)
         ("rust-gix-url" ,rust-gix-url-0.25)
         ("rust-gix-utils" ,rust-gix-utils-0.1)
         ("rust-gix-validate" ,rust-gix-validate-0.8)
         ("rust-gix-worktree" ,rust-gix-worktree-0.27)
         ("rust-gix-worktree-state"
          ,rust-gix-worktree-state-0.4)
         ("rust-gix-worktree-stream"
          ,rust-gix-worktree-stream-0.6)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-prodash" ,rust-prodash-26)
         ("rust-regex" ,rust-regex-1)
         ("rust-reqwest" ,rust-reqwest-0.11)
         ("rust-serde" ,rust-serde-1)
         ("rust-signal-hook" ,rust-signal-hook-0.3)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-unicode-normalization"
          ,rust-unicode-normalization-0.1))))
    (home-page "https://github.com/Byron/gitoxide")
    (synopsis
      "Interact with git repositories just like git would")
    (description
      "Interact with git repositories just like git would")
    (license (list license:expat license:asl2.0))))

(define-public rust-ncurses-5
  (package
    (name "rust-ncurses")
    (version "5.101.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ncurses" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ci0flh7j8v7yir2y1lrqvqy90df1ba2a74acd5xqmr6sws5sb2y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cc" ,rust-cc-1)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pkg-config" ,rust-pkg-config-0.3))))
    (home-page "https://github.com/jeaye/ncurses-rs")
    (synopsis
      "A very thin wrapper around the ncurses TUI library")
    (description
      "This package provides a very thin wrapper around the ncurses TUI library")
    (license license:expat)))

(define-public rust-pancurses-0.17
  (package
    (name "rust-pancurses")
    (version "0.17.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pancurses" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1nqkkmsljdk3z2bifxapmx1yv2w1vfwhkdxzk7pbkb6b6rf9flh3"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-log" ,rust-log-0.4)
         ("rust-ncurses" ,rust-ncurses-5)
         ("rust-pdcurses-sys" ,rust-pdcurses-sys-0.7)
         ("rust-winreg" ,rust-winreg-0.5))))
    (home-page
      "https://github.com/ihalila/pancurses")
    (synopsis
      "pancurses is a curses libary for Rust that supports both Unix and Windows\nplatforms by abstracting away the backend that it uses\n(ncurses-rs and pdcurses-sys respectively).\n")
    (description
      "pancurses is a curses libary for Rust that supports both Unix and Windows\nplatforms by abstracting away the backend that it uses (ncurses-rs and\npdcurses-sys respectively).")
    (license license:expat)))

(define-public rust-enum-map-derive-0.17
  (package
    (name "rust-enum-map-derive")
    (version "0.17.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "enum-map-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1sv4mb343rsz4lc3rh7cyn0pdhf7fk18k1dgq8kfn5i5x7gwz0pj"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "https://codeberg.org/xfix/enum-map")
    (synopsis
      "Macros 1.1 implementation of #[derive(Enum)]")
    (description
      "Macros 1.1 implementation of #[derive(Enum)]")
    (license (list license:expat license:asl2.0))))

(define-public rust-enum-map-2
  (package
    (name "rust-enum-map")
    (version "2.7.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "enum-map" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1sgjgl4mmz93jdkfdsmapc3dmaq8gddagw9s0fd501w2vyzz6rk8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arbitrary" ,rust-arbitrary-1)
         ("rust-enum-map-derive"
          ,rust-enum-map-derive-0.17)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://codeberg.org/xfix/enum-map")
    (synopsis
      "A map with C-like enum keys represented internally as an array")
    (description
      "This package provides a map with C-like enum keys represented internally as an\narray")
    (license (list license:expat license:asl2.0))))

(define-public rust-cursive-core-0.3
  (package
    (name "rust-cursive-core")
    (version "0.3.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "cursive_core" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0kfr5jm62w6msy5fb0w9kv9kmw63fig8r5n78p5hv392c60vbcsd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ahash" ,rust-ahash-0.8)
         ("rust-ansi-parser" ,rust-ansi-parser-0.8)
         ("rust-crossbeam-channel"
          ,rust-crossbeam-channel-0.5)
         ("rust-enum-map" ,rust-enum-map-2)
         ("rust-enumset" ,rust-enumset-1)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-num" ,rust-num-0.4)
         ("rust-owning-ref" ,rust-owning-ref-0.4)
         ("rust-pulldown-cmark" ,rust-pulldown-cmark-0.9)
         ("rust-time" ,rust-time-0.3)
         ("rust-toml" ,rust-toml-0.5)
         ("rust-unicode-segmentation"
          ,rust-unicode-segmentation-1)
         ("rust-unicode-width" ,rust-unicode-width-0.1)
         ("rust-xi-unicode" ,rust-xi-unicode-0.3))))
    (home-page "https://github.com/gyscos/cursive")
    (synopsis "Core components for the Cursive TUI")
    (description
      "Core components for the Cursive TUI")
    (license license:expat)))

(define-public rust-bear-lib-terminal-sys-1
  (package
    (name "rust-bear-lib-terminal-sys")
    (version "1.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "bear-lib-terminal-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17r71abbdz4l0vkwwv9p3lsmvy21sai8xabz2wl73w025hxwh11s"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2))))
    (home-page
      "https://github.com/nabijaczleweli/BearLibTerminal-sys.rs")
    (synopsis "Pure BearLibTerminal FFI for Rust")
    (description
      "Pure @code{BearLibTerminal} FFI for Rust")
    (license license:expat)))

(define-public rust-bear-lib-terminal-2
  (package
    (name "rust-bear-lib-terminal")
    (version "2.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "bear-lib-terminal" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "05kij0gr0i0phikh1qc5mdgi73f3ly9x1fhy3snzizm3jpv4jm9i"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bear-lib-terminal-sys"
          ,rust-bear-lib-terminal-sys-1))))
    (home-page
      "https://github.com/nabijaczleweli/BearLibTerminal.rs")
    (synopsis "BearLibTerminal FFI for Rust")
    (description
      "@code{BearLibTerminal} FFI for Rust")
    (license license:expat)))

(define-public rust-cursive-0.20
  (package
    (name "rust-cursive")
    (version "0.20.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "cursive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0faqb53cw4cxbjkjpj2yg8i614habpplyxkl3srm3byqplbfnf2l"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ahash" ,rust-ahash-0.8)
         ("rust-bear-lib-terminal"
          ,rust-bear-lib-terminal-2)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-crossbeam-channel"
          ,rust-crossbeam-channel-0.5)
         ("rust-crossterm" ,rust-crossterm-0.25)
         ("rust-cursive-core" ,rust-cursive-core-0.3)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-log" ,rust-log-0.4)
         ("rust-maplit" ,rust-maplit-1)
         ("rust-ncurses" ,rust-ncurses-5)
         ("rust-pancurses" ,rust-pancurses-0.17)
         ("rust-signal-hook" ,rust-signal-hook-0.3)
         ("rust-term-size" ,rust-term-size-0.3)
         ("rust-termion" ,rust-termion-1)
         ("rust-unicode-segmentation"
          ,rust-unicode-segmentation-1)
         ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page "https://github.com/gyscos/cursive")
    (synopsis
      "A TUI (Text User Interface) library focused on ease-of-use.")
    (description
      "This package provides a TUI (Text User Interface) library focused on\nease-of-use.")
    (license license:expat)))

(define-public rust-amdgpu-top-tui-0.5
  (package
    (name "rust-amdgpu-top-tui")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "amdgpu_top_tui" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1k59bix8rzr8h37sdypbjipfb2w3wc0nlqmf2f0m1cbqywmir193"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cursive" ,rust-cursive-0.20)
         ("rust-libamdgpu-top" ,rust-libamdgpu-top-0.5))))
    (home-page
      "https://github.com/Umio-Yasuno/amdgpu_top")
    (synopsis "TUI library for amdgpu_top")
    (description "TUI library for amdgpu_top")
    (license license:expat)))

(define-public rust-amdgpu-top-json-0.5
  (package
    (name "rust-amdgpu-top-json")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "amdgpu_top_json" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1lnghiz4r1klzm2am2m3231vlasymzwr56lvdpizbn9lfpbpl6rp"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libamdgpu-top" ,rust-libamdgpu-top-0.5)
         ("rust-serde-json" ,rust-serde-json-1))))
    (home-page
      "https://github.com/Umio-Yasuno/amdgpu_top")
    (synopsis
      "Library for JSON output function of amdgpu_top")
    (description
      "Library for JSON output function of amdgpu_top")
    (license license:expat)))

(define-public rust-prettyplease-0.2
  (package
    (name "rust-prettyplease")
    (version "0.2.15")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "prettyplease" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17az47j29q76gnyqvd5giryjz2fp7zw7vzcka1rb8ndbfgbmn05f"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/dtolnay/prettyplease")
    (synopsis
      "A minimal `syn` syntax tree pretty-printer")
    (description
      "This package provides a minimal `syn` syntax tree pretty-printer")
    (license (list license:expat license:asl2.0))))

(define-public rust-yansi-term-0.1
  (package
    (name "rust-yansi-term")
    (version "0.1.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "yansi-term" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1w8vjlvxba6yvidqdvxddx3crl6z66h39qxj8xi6aqayw2nk0p7y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page
      "https://github.com/botika/yansi-term")
    (synopsis
      "Library for ANSI terminal colours and styles (bold, underline)")
    (description
      "Library for ANSI terminal colours and styles (bold, underline)")
    (license license:expat)))

(define-public rust-annotate-snippets-0.9
  (package
    (name "rust-annotate-snippets")
    (version "0.9.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "annotate-snippets" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "07p8r6jzb7nqydq0kr5pllckqcdxlyld2g275v425axnzffpxbyc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-unicode-width" ,rust-unicode-width-0.1)
         ("rust-yansi-term" ,rust-yansi-term-0.1))))
    (home-page
      "https://github.com/rust-lang/annotate-snippets-rs")
    (synopsis
      "Library for building code annotations")
    (description
      "Library for building code annotations")
    (license (list license:asl2.0 license:expat))))

(define-public rust-bindgen-0.68
  (package
    (name "rust-bindgen")
    (version "0.68.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "bindgen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0y40gndyay1fj8d3d8gsd9fyfzjlbghx92i560kmvhvfxc9l6vkj"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-annotate-snippets"
          ,rust-annotate-snippets-0.9)
         ("rust-bitflags" ,rust-bitflags-2)
         ("rust-cexpr" ,rust-cexpr-0.6)
         ("rust-clang-sys" ,rust-clang-sys-1)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-lazycell" ,rust-lazycell-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-peeking-take-while"
          ,rust-peeking-take-while-0.1)
         ("rust-prettyplease" ,rust-prettyplease-0.2)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-regex" ,rust-regex-1)
         ("rust-rustc-hash" ,rust-rustc-hash-1)
         ("rust-shlex" ,rust-shlex-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-which" ,rust-which-4))))
    (home-page
      "https://rust-lang.github.io/rust-bindgen/")
    (synopsis
      "Automatically generates Rust FFI bindings to C and C++ libraries.")
    (description
      "Automatically generates Rust FFI bindings to C and C++ libraries.")
    (license license:bsd-3)))

(define-public rust-libdrm-amdgpu-sys-0.4
  (package
    (name "rust-libdrm-amdgpu-sys")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "libdrm_amdgpu_sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1xwnyj40f7i1brb1nk0kqzk1yp7vf25hgw9z7k9wwi0j0xpb2gl0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bindgen" ,rust-bindgen-0.68)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pkg-config" ,rust-pkg-config-0.3))))
    (home-page
      "https://github.com/Umio-Yasuno/libdrm-amdgpu-sys-rs")
    (synopsis
      "libdrm_amdgpu bindings for Rust, and some methods ported from Mesa3D.")
    (description
      "libdrm_amdgpu bindings for Rust, and some methods ported from Mesa3D.")
    (license license:expat)))

(define-public rust-libamdgpu-top-0.5
  (package
    (name "rust-libamdgpu-top")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "libamdgpu_top" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1kdh081jwsvjmymxf1abvs9ck4ywq8j9jr4996nlwnzdgidshlzh"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-anyhow" ,rust-anyhow-1)
         ("rust-libdrm-amdgpu-sys"
          ,rust-libdrm-amdgpu-sys-0.4))))
    (home-page
      "https://github.com/Umio-Yasuno/amdgpu_top")
    (synopsis "A library for amdgpu_top")
    (description
      "This package provides a library for amdgpu_top")
    (license license:expat)))

(define-public rust-i18n-embed-fl-0.7
  (package
    (name "rust-i18n-embed-fl")
    (version "0.7.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "i18n-embed-fl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "18nm8w031jani3m0cxhki9fzw5fs50qwzwfwmm6grpwma5qzihcz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-dashmap" ,rust-dashmap-5)
         ("rust-find-crate" ,rust-find-crate-0.6)
         ("rust-fluent" ,rust-fluent-0.16)
         ("rust-fluent-syntax" ,rust-fluent-syntax-0.11)
         ("rust-i18n-config" ,rust-i18n-config-0.4)
         ("rust-i18n-embed" ,rust-i18n-embed-0.14)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-proc-macro-error"
          ,rust-proc-macro-error-1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-strsim" ,rust-strsim-0.10)
         ("rust-syn" ,rust-syn-2)
         ("rust-unic-langid" ,rust-unic-langid-0.9))))
    (home-page "")
    (synopsis
      "Macro to perform compile time checks when using the i18n-embed crate and the fluent localization system")
    (description
      "Macro to perform compile time checks when using the i18n-embed crate and the\nfluent localization system")
    (license license:expat)))

(define-public rust-tr-0.1
  (package
    (name "rust-tr")
    (version "0.1.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tr" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xksi7qq5h8i779ik51i81147858d5nxr3ng39pm47l9asg1s491"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gettext" ,rust-gettext-0.4)
         ("rust-gettext-rs" ,rust-gettext-rs-0.7)
         ("rust-lazy-static" ,rust-lazy-static-1))))
    (home-page "https://github.com/woboq/tr")
    (synopsis "tr! macro for localisation")
    (description "tr! macro for localisation")
    (license license:expat)))

(define-public rust-warp-0.3
  (package
    (name "rust-warp")
    (version "0.3.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "warp" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0sfimrpxkyka1mavfhg5wa4x977qs8vyxa510c627w9zw0i2xsf1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-compression"
          ,rust-async-compression-0.3)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-futures-channel"
          ,rust-futures-channel-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-headers" ,rust-headers-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-log" ,rust-log-0.4)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-mime-guess" ,rust-mime-guess-2)
         ("rust-multer" ,rust-multer-2)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project" ,rust-pin-project-1)
         ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
         ("rust-scoped-tls" ,rust-scoped-tls-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-serde-urlencoded"
          ,rust-serde-urlencoded-0.7)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
         ("rust-tokio-stream" ,rust-tokio-stream-0.1)
         ("rust-tokio-tungstenite"
          ,rust-tokio-tungstenite-0.20)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-tower-service" ,rust-tower-service-0.3)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/seanmonstar/warp")
    (synopsis "serve the web at warp speeds")
    (description "serve the web at warp speeds")
    (license license:expat)))

(define-public rust-tungstenite-0.16
  (package
    (name "rust-tungstenite")
    (version "0.16.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tungstenite" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1l9s7gi9kgl4zynhbyb7737lmwaxaim4b818lwi7y95f2hx73lva"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-base64" ,rust-base64-0.13)
         ("rust-byteorder" ,rust-byteorder-1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-http" ,rust-http-0.2)
         ("rust-httparse" ,rust-httparse-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-rustls" ,rust-rustls-0.20)
         ("rust-rustls-native-certs"
          ,rust-rustls-native-certs-0.6)
         ("rust-sha-1" ,rust-sha-1-0.9)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-url" ,rust-url-2)
         ("rust-utf-8" ,rust-utf-8-0.7)
         ("rust-webpki" ,rust-webpki-0.22)
         ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page
      "https://github.com/snapview/tungstenite-rs")
    (synopsis
      "Lightweight stream-based WebSocket implementation")
    (description
      "Lightweight stream-based @code{WebSocket} implementation")
    (license (list license:expat license:asl2.0))))

(define-public rust-tokio-tungstenite-0.16
  (package
    (name "rust-tokio-tungstenite")
    (version "0.16.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tokio-tungstenite" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0wnadcv9q2yi7bjkdp6z0g4rk7kbdblsv613fpgjrhgwdbgkj2z8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-rustls" ,rust-rustls-0.20)
         ("rust-rustls-native-certs"
          ,rust-rustls-native-certs-0.6)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
         ("rust-tungstenite" ,rust-tungstenite-0.16)
         ("rust-webpki" ,rust-webpki-0.22)
         ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page
      "https://github.com/snapview/tokio-tungstenite")
    (synopsis
      "Tokio binding for Tungstenite, the Lightweight stream-based WebSocket implementation")
    (description
      "Tokio binding for Tungstenite, the Lightweight stream-based @code{WebSocket}\nimplementation")
    (license license:expat)))

(define-public rust-simple-asn1-0.4
  (package
    (name "rust-simple-asn1")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "simple_asn1" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0jxy9as8nj65c2n27j843g4fpb95x4fjz31w6qx63q3wwlys2b39"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-chrono" ,rust-chrono-0.4)
         ("rust-num-bigint" ,rust-num-bigint-0.2)
         ("rust-num-traits" ,rust-num-traits-0.2))))
    (home-page "https://github.com/acw/simple_asn1")
    (synopsis
      "A simple DER/ASN.1 encoding/decoding library.")
    (description
      "This package provides a simple DER/ASN.1 encoding/decoding library.")
    (license license:isc)))

(define-public rust-jsonwebtoken-7
  (package
    (name "rust-jsonwebtoken")
    (version "7.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "jsonwebtoken" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ciz205wcjcn7n6i871zz5xlbzk863b0ybgiqi7li9ipwhawraxg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-base64" ,rust-base64-0.12)
         ("rust-pem" ,rust-pem-0.8)
         ("rust-ring" ,rust-ring-0.16)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-simple-asn1" ,rust-simple-asn1-0.4))))
    (home-page
      "https://github.com/Keats/jsonwebtoken")
    (synopsis
      "Create and decode JWTs in a strongly typed way.")
    (description
      "Create and decode JWTs in a strongly typed way.")
    (license license:expat)))

(define-public rust-async-session-3
  (package
    (name "rust-async-session")
    (version "3.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-session" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0c76vazdlcs2rsxq8gd8a6wnb913vxhnfx1hyfmfpqml4gjlrnh7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-anyhow" ,rust-anyhow-1)
         ("rust-async-lock" ,rust-async-lock-2)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-base64" ,rust-base64-0.13)
         ("rust-bincode" ,rust-bincode-1)
         ("rust-blake3" ,rust-blake3-0.3)
         ("rust-chrono" ,rust-chrono-0.4)
         ("rust-hmac" ,rust-hmac-0.11)
         ("rust-log" ,rust-log-0.4)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-sha2" ,rust-sha2-0.9))))
    (home-page
      "https://github.com/http-rs/async-session")
    (synopsis
      "Async session support with pluggable middleware")
    (description
      "Async session support with pluggable middleware")
    (license (list license:expat license:asl2.0))))

(define-public rust-salvo-extra-0.16
  (package
    (name "rust-salvo-extra")
    (version "0.16.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "salvo_extra" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "023wagm5mpkp1jnpggllbddqigsy5h4qnw2lk8m3j25fj61fl3iy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-compression"
          ,rust-async-compression-0.3)
         ("rust-async-session" ,rust-async-session-3)
         ("rust-base64" ,rust-base64-0.13)
         ("rust-chrono" ,rust-chrono-0.4)
         ("rust-cookie" ,rust-cookie-0.16)
         ("rust-csrf" ,rust-csrf-0.4)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-hkdf" ,rust-hkdf-0.12)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-hyper-rustls" ,rust-hyper-rustls-0.23)
         ("rust-jsonwebtoken" ,rust-jsonwebtoken-7)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project" ,rust-pin-project-1)
         ("rust-salvo-core" ,rust-salvo-core-0.16)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-derive" ,rust-serde-derive-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-sha2" ,rust-sha2-0.10)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-stream" ,rust-tokio-stream-0.1)
         ("rust-tokio-tungstenite"
          ,rust-tokio-tungstenite-0.16)
         ("rust-tokio-util" ,rust-tokio-util-0.6)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://salvo.rs")
    (synopsis
      "Salvo is a powerful web framework that can make your work easier.\n")
    (description
      "Salvo is a powerful web framework that can make your work easier.")
    (license (list license:expat license:asl2.0))))

(define-public rust-textnonce-1
  (package
    (name "rust-textnonce")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "textnonce" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "10v653sz0305dlzdqh6wh795hxypk24s21iiqcfyv16p1kbzhhvp"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-base64" ,rust-base64-0.12)
         ("rust-rand" ,rust-rand-0.7)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/mikedilger/textnonce")
    (synopsis "Text based random nonce generator")
    (description "Text based random nonce generator")
    (license (list license:expat license:asl2.0))))

(define-public rust-proc-quote-impl-0.3
  (package
    (name "rust-proc-quote-impl")
    (version "0.3.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "proc-quote-impl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "184ax14pyazv5g6yma60ls7x4hd5q6wah1kf677xng06idifrcvz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-hack"
          ,rust-proc-macro-hack-0.5)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1))))
    (home-page
      "https://github.com/Goncalerta/proc-quote")
    (synopsis
      "A procedural macro implementation of quote!.")
    (description
      "This package provides a procedural macro implementation of quote!.")
    (license (list license:expat license:asl2.0))))

(define-public rust-proc-quote-0.4
  (package
    (name "rust-proc-quote")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "proc-quote" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0051nax31x1yzr1imbp200l2gpz6pqcmlcna099r33773lbap12y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-hack"
          ,rust-proc-macro-hack-0.5)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-proc-quote-impl"
          ,rust-proc-quote-impl-0.3)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-1))))
    (home-page
      "https://github.com/Goncalerta/proc-quote")
    (synopsis
      "A procedural macro implementation of quote!.")
    (description
      "This package provides a procedural macro implementation of quote!.")
    (license (list license:expat license:asl2.0))))

(define-public rust-salvo-macros-0.16
  (package
    (name "rust-salvo-macros")
    (version "0.16.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "salvo_macros" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0hdlzvcv2vvbr60w1kmfr9bx8glx4xs9g0ry1pwa7yf7ig987z90"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-crate"
          ,rust-proc-macro-crate-1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-proc-quote" ,rust-proc-quote-0.4)
         ("rust-syn" ,rust-syn-1))))
    (home-page "https://salvo.rs")
    (synopsis "salvo proc macros")
    (description "salvo proc macros")
    (license (list license:expat license:asl2.0))))

(define-public rust-salvo-core-0.16
  (package
    (name "rust-salvo-core")
    (version "0.16.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "salvo_core" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "01dazprfzmjmvwgcrvqxjd12hgwwlk71mskwyl4cj2y2gm5p80bv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-anyhow" ,rust-anyhow-1)
         ("rust-async-compression"
          ,rust-async-compression-0.3)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-bitflags" ,rust-bitflags-1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-cookie" ,rust-cookie-0.16)
         ("rust-encoding-rs" ,rust-encoding-rs-0.8)
         ("rust-fastrand" ,rust-fastrand-1)
         ("rust-form-urlencoded" ,rust-form-urlencoded-1)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-headers" ,rust-headers-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-mime-guess" ,rust-mime-guess-2)
         ("rust-multer" ,rust-multer-2)
         ("rust-multimap" ,rust-multimap-0.8)
         ("rust-num-cpus" ,rust-num-cpus-1)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-pin-utils" ,rust-pin-utils-0.1)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-regex" ,rust-regex-1)
         ("rust-rustls-pemfile" ,rust-rustls-pemfile-0.2)
         ("rust-salvo-macros" ,rust-salvo-macros-0.16)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-tempdir" ,rust-tempdir-0.3)
         ("rust-textnonce" ,rust-textnonce-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
         ("rust-tokio-stream" ,rust-tokio-stream-0.1)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://salvo.rs")
    (synopsis
      "Salvo is a powerful web framework that can make your work easier.\n")
    (description
      "Salvo is a powerful web framework that can make your work easier.")
    (license (list license:expat license:asl2.0))))

(define-public rust-salvo-0.16
  (package
    (name "rust-salvo")
    (version "0.16.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "salvo" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1jw9h9aac4ms9shvssc8mw53q9842f5bfqv1a8aqkpcyd2j23n4b"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-salvo-core" ,rust-salvo-core-0.16)
         ("rust-salvo-extra" ,rust-salvo-extra-0.16))))
    (home-page "https://salvo.rs")
    (synopsis
      "Salvo is a powerful web framework that can make your work easier.\n")
    (description
      "Salvo is a powerful web framework that can make your work easier.")
    (license (list license:expat license:asl2.0))))

(define-public rust-shellexpand-3
  (package
    (name "rust-shellexpand")
    (version "3.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "shellexpand" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0jz1i14ziz8gbyj71212s7dqrw6q96f25i48zkmy66fcjhxzl0ys"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bstr" ,rust-bstr-1)
         ("rust-dirs" ,rust-dirs-5)
         ("rust-os-str-bytes" ,rust-os-str-bytes-6))))
    (home-page
      "https://gitlab.com/ijackson/rust-shellexpand")
    (synopsis "Shell-like expansions in strings")
    (description "Shell-like expansions in strings")
    (license (list license:expat license:asl2.0))))

(define-public rust-mime-guess-2
  (package
    (name "rust-mime-guess")
    (version "2.0.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "mime_guess" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1vs28rxnbfwil6f48hh58lfcx90klcvg68gxdc60spwa4cy2d4j1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-mime" ,rust-mime-0.3)
         ("rust-unicase" ,rust-unicase-2)
         ("rust-unicase" ,rust-unicase-2))))
    (home-page
      "https://github.com/abonander/mime_guess")
    (synopsis
      "A simple crate for detection of a file's MIME type by its extension.")
    (description
      "This package provides a simple crate for detection of a file's MIME type by its\nextension.")
    (license license:expat)))

(define-public rust-rust-embed-utils-8
  (package
    (name "rust-rust-embed-utils")
    (version "8.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rust-embed-utils" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0h0xz4p6rpszwbyxwcxfkggcnsa3zyy09f2lpgb564j3fm4csv41"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-globset" ,rust-globset-0.4)
         ("rust-mime-guess" ,rust-mime-guess-2)
         ("rust-sha2" ,rust-sha2-0.10)
         ("rust-walkdir" ,rust-walkdir-2))))
    (home-page
      "https://github.com/pyros2097/rust-embed")
    (synopsis "Utilities for rust-embed")
    (description "Utilities for rust-embed")
    (license license:expat)))

(define-public rust-rust-embed-impl-8
  (package
    (name "rust-rust-embed-impl")
    (version "8.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rust-embed-impl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0kk0fr30yvq8yq90b72n665qglcmasgx2z0xiixsc91i4yhl9hdz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-rust-embed-utils"
          ,rust-rust-embed-utils-8)
         ("rust-shellexpand" ,rust-shellexpand-3)
         ("rust-syn" ,rust-syn-2)
         ("rust-walkdir" ,rust-walkdir-2))))
    (home-page
      "https://github.com/pyros2097/rust-embed")
    (synopsis
      "Rust Custom Derive Macro which loads files into the rust binary at compile time during release and loads the file from the fs during dev")
    (description
      "Rust Custom Derive Macro which loads files into the rust binary at compile time\nduring release and loads the file from the fs during dev")
    (license license:expat)))

(define-public rust-ubyte-0.10
  (package
    (name "rust-ubyte")
    (version "0.10.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ubyte" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1spj3k9sx6xvfn7am9vm1b463hsr79nyvj8asi2grqhyrvvdw87p"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/SergioBenitez/ubyte")
    (synopsis
      "A simple, complete, const-everything, saturating, human-friendly, no_std library for byte units.\n")
    (description
      "This package provides a simple, complete, const-everything, saturating,\nhuman-friendly, no_std library for byte units.")
    (license (list license:expat license:asl2.0))))

(define-public rust-oid-registry-0.4
  (package
    (name "rust-oid-registry")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "oid-registry" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0akbah3j8231ayrp2l1y5d9zmvbvqcsj0sa6s6dz6h85z8bhgqiq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-asn1-rs" ,rust-asn1-rs-0.3))))
    (home-page
      "https://github.com/rusticata/oid-registry")
    (synopsis "Object Identifier (OID) database")
    (description "Object Identifier (OID) database")
    (license (list license:expat license:asl2.0))))

(define-public rust-der-parser-7
  (package
    (name "rust-der-parser")
    (version "7.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "der-parser" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "10kfa2gzl3x20mwgrd43cyi79xgkqxyzcyrh0xylv4apa33qlfgy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-asn1-rs" ,rust-asn1-rs-0.3)
         ("rust-cookie-factory" ,rust-cookie-factory-0.3)
         ("rust-displaydoc" ,rust-displaydoc-0.2)
         ("rust-nom" ,rust-nom-7)
         ("rust-num-bigint" ,rust-num-bigint-0.4)
         ("rust-num-traits" ,rust-num-traits-0.2)
         ("rust-rusticata-macros"
          ,rust-rusticata-macros-4))))
    (home-page
      "https://github.com/rusticata/der-parser")
    (synopsis
      "Parser/encoder for ASN.1 BER/DER data")
    (description
      "Parser/encoder for ASN.1 BER/DER data")
    (license (list license:expat license:asl2.0))))

(define-public rust-asn1-rs-derive-0.1
  (package
    (name "rust-asn1-rs-derive")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "asn1-rs-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1gzf9vab06lk0zjvbr07axx64fndkng2s28bnj27fnwd548pb2yv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-1)
         ("rust-synstructure" ,rust-synstructure-0.12))))
    (home-page
      "https://github.com/rusticata/asn1-rs")
    (synopsis
      "Derive macros for the `asn1-rs` crate")
    (description
      "Derive macros for the `asn1-rs` crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-asn1-rs-0.3
  (package
    (name "rust-asn1-rs")
    (version "0.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "asn1-rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0czsk1nd4dx2k83f7jzkn8klx05wbmblkx1jh51i4c170akhbzrh"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-asn1-rs-derive" ,rust-asn1-rs-derive-0.1)
         ("rust-asn1-rs-impl" ,rust-asn1-rs-impl-0.1)
         ("rust-bitvec" ,rust-bitvec-1)
         ("rust-cookie-factory" ,rust-cookie-factory-0.3)
         ("rust-displaydoc" ,rust-displaydoc-0.2)
         ("rust-nom" ,rust-nom-7)
         ("rust-num-bigint" ,rust-num-bigint-0.4)
         ("rust-num-traits" ,rust-num-traits-0.2)
         ("rust-rusticata-macros"
          ,rust-rusticata-macros-4)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-time" ,rust-time-0.3))))
    (home-page
      "https://github.com/rusticata/asn1-rs")
    (synopsis
      "Parser/encoder for ASN.1 BER/DER data")
    (description
      "Parser/encoder for ASN.1 BER/DER data")
    (license (list license:expat license:asl2.0))))

(define-public rust-x509-parser-0.13
  (package
    (name "rust-x509-parser")
    (version "0.13.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "x509-parser" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "077bi0xyaa8cmrqf3rrw1z6kkzscwd1nxdxgs7mgz2ambg7bmfcz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-asn1-rs" ,rust-asn1-rs-0.3)
         ("rust-base64" ,rust-base64-0.13)
         ("rust-data-encoding" ,rust-data-encoding-2)
         ("rust-der-parser" ,rust-der-parser-7)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-nom" ,rust-nom-7)
         ("rust-oid-registry" ,rust-oid-registry-0.4)
         ("rust-ring" ,rust-ring-0.16)
         ("rust-rusticata-macros"
          ,rust-rusticata-macros-4)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-time" ,rust-time-0.3))))
    (home-page
      "https://github.com/rusticata/x509-parser")
    (synopsis
      "Parser for the X.509 v3 format (RFC 5280 certificates)")
    (description
      "Parser for the X.509 v3 format (RFC 5280 certificates)")
    (license (list license:expat license:asl2.0))))

(define-public rust-state-0.6
  (package
    (name "rust-state")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "state" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1n3n2h324h1y5zhaajh6kplvzfvg1l6hsr8siggmf4yq8m24m31b"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-loom" ,rust-loom-0.5))))
    (home-page
      "https://github.com/SergioBenitez/state")
    (synopsis
      "A library for safe and effortless global and thread-local state management.\n")
    (description
      "This package provides a library for safe and effortless global and thread-local\nstate management.")
    (license (list license:expat license:asl2.0))))

(define-public rust-stable-pattern-0.1
  (package
    (name "rust-stable-pattern")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "stable-pattern" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0i8hq82vm82mqj02qqcsd7caibrih7x5w3a1xpm8hpv30261cr25"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-memchr" ,rust-memchr-2))))
    (home-page
      "https://github.com/SergioBenitez/stable-pattern")
    (synopsis
      "Stable port of std::str::Pattern and friends.")
    (description
      "Stable port of std::str::Pattern and friends.")
    (license (list license:expat license:asl2.0))))

(define-public rust-cookie-0.18
  (package
    (name "rust-cookie")
    (version "0.18.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "cookie" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1y2ywf9isq0dwpj7m7jq7r1g9cs3xr2i6qipw5v030hj2kv1rn9w"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-aes-gcm" ,rust-aes-gcm-0.10)
         ("rust-base64" ,rust-base64-0.21)
         ("rust-hkdf" ,rust-hkdf-0.12)
         ("rust-hmac" ,rust-hmac-0.12)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-sha2" ,rust-sha2-0.10)
         ("rust-subtle" ,rust-subtle-2)
         ("rust-time" ,rust-time-0.3)
         ("rust-version-check" ,rust-version-check-0.9))))
    (home-page
      "https://github.com/SergioBenitez/cookie-rs")
    (synopsis
      "HTTP cookie parsing and cookie jar management. Supports signed and private\n(encrypted, authenticated) jars.\n")
    (description
      "HTTP cookie parsing and cookie jar management.  Supports signed and private\n(encrypted, authenticated) jars.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rocket-http-0.5
  (package
    (name "rust-rocket-http")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rocket_http" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17iq208zf9rfxdnx8hfjxnn51074cc9li99yjigzwnfhjhv6d89p"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cookie" ,rust-cookie-0.18)
         ("rust-either" ,rust-either-1)
         ("rust-futures" ,rust-futures-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-indexmap" ,rust-indexmap-2)
         ("rust-log" ,rust-log-0.4)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-pear" ,rust-pear-0.2)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-ref-cast" ,rust-ref-cast-1)
         ("rust-rustls" ,rust-rustls-0.21)
         ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-stable-pattern" ,rust-stable-pattern-0.1)
         ("rust-state" ,rust-state-0.6)
         ("rust-time" ,rust-time-0.3)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
         ("rust-uncased" ,rust-uncased-0.9)
         ("rust-uuid" ,rust-uuid-1)
         ("rust-x509-parser" ,rust-x509-parser-0.13))))
    (home-page "https://rocket.rs")
    (synopsis
      "Types, traits, and parsers for HTTP requests, responses, and headers.\n")
    (description
      "Types, traits, and parsers for HTTP requests, responses, and headers.")
    (license (list license:expat license:asl2.0))))

(define-public rust-devise-core-0.4
  (package
    (name "rust-devise-core")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "devise_core" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0sp5idq0idng9i5kwjd8slvc724s97r28arrhyqq1jpx1ax0vd9m"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-proc-macro2-diagnostics"
          ,rust-proc-macro2-diagnostics-0.10)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/SergioBenitez/Devise")
    (synopsis
      "A library for devising derives and other procedural macros.")
    (description
      "This package provides a library for devising derives and other procedural\nmacros.")
    (license (list license:expat license:asl2.0))))

(define-public rust-devise-codegen-0.4
  (package
    (name "rust-devise-codegen")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "devise_codegen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1mpy5mmsigkj5f72gby82yk4advcqj97am2wzn0dwkj8vnwg934w"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-devise-core" ,rust-devise-core-0.4)
         ("rust-quote" ,rust-quote-1))))
    (home-page
      "https://github.com/SergioBenitez/Devise")
    (synopsis
      "A library for devising derives and other procedural macros.")
    (description
      "This package provides a library for devising derives and other procedural\nmacros.")
    (license (list license:expat license:asl2.0))))

(define-public rust-devise-0.4
  (package
    (name "rust-devise")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "devise" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1y45iag4hyvspkdsf6d856hf0ihf9vjnaga3c7y6c72l7zywxsnn"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-devise-codegen" ,rust-devise-codegen-0.4)
         ("rust-devise-core" ,rust-devise-core-0.4))))
    (home-page
      "https://github.com/SergioBenitez/Devise")
    (synopsis
      "A library for devising derives and other procedural macros.")
    (description
      "This package provides a library for devising derives and other procedural\nmacros.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rocket-codegen-0.5
  (package
    (name "rust-rocket-codegen")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rocket_codegen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0k6hdf9s9y73kzj89qs688gnfjj1sl4imp6pdjz22pzpmdk808x2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-devise" ,rust-devise-0.4)
         ("rust-glob" ,rust-glob-0.3)
         ("rust-indexmap" ,rust-indexmap-2)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-rocket-http" ,rust-rocket-http-0.5)
         ("rust-syn" ,rust-syn-2)
         ("rust-unicode-xid" ,rust-unicode-xid-0.2)
         ("rust-version-check" ,rust-version-check-0.9))))
    (home-page "https://rocket.rs")
    (synopsis
      "Procedural macros for the Rocket web framework.")
    (description
      "Procedural macros for the Rocket web framework.")
    (license (list license:expat license:asl2.0))))

(define-public rust-yansi-1
  (package
    (name "rust-yansi")
    (version "1.0.0-rc.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "yansi" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xr3n41j5v00scfkac2d6vhkxiq9nz3l5j6vw8f3g3bqixdjjrqk"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-is-terminal" ,rust-is-terminal-0.4))))
    (home-page
      "https://github.com/SergioBenitez/yansi")
    (synopsis
      "A dead simple ANSI terminal color painting library.")
    (description
      "This package provides a dead simple ANSI terminal color painting library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-proc-macro2-diagnostics-0.10
  (package
    (name "rust-proc-macro2-diagnostics")
    (version "0.10.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "proc-macro2-diagnostics" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1j48ipc80pykvhx6yhndfa774s58ax1h6sm6mlhf09ls76f6l1mg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-version-check" ,rust-version-check-0.9)
         ("rust-yansi" ,rust-yansi-1))))
    (home-page
      "https://github.com/SergioBenitez/proc-macro2-diagnostics")
    (synopsis "Diagnostics for proc-macro2.")
    (description "Diagnostics for proc-macro2.")
    (license (list license:expat license:asl2.0))))

(define-public rust-pear-codegen-0.2
  (package
    (name "rust-pear-codegen")
    (version "0.2.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pear_codegen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xrwnlncg7l64gfy82vf6kq55ww7p6krq6bc3pqwymxpiq76f8if"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-proc-macro2-diagnostics"
          ,rust-proc-macro2-diagnostics-0.10)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "")
    (synopsis "A (codegen) pear is a fruit.")
    (description
      "This package provides a (codegen) pear is a fruit.")
    (license (list license:expat license:asl2.0))))

(define-public rust-inlinable-string-0.1
  (package
    (name "rust-inlinable-string")
    (version "0.1.15")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "inlinable_string" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ysjci8yfvxgf51z0ny2nnwhxrclhmb3vbngin8v4bznhr3ybyn8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/fitzgen/inlinable_string")
    (synopsis
      "The `inlinable_string` crate provides the `InlinableString` type -- an owned, grow-able UTF-8 string that stores small strings inline and avoids heap-allocation -- and the `StringExt` trait which abstracts string operations over both `std::string::String` and `InlinableString` (or even your own custom string type).")
    (description
      "The `inlinable_string` crate provides the `@code{InlinableString`} type -- an\nowned, grow-able UTF-8 string that stores small strings inline and avoids\nheap-allocation -- and the `@code{StringExt`} trait which abstracts string\noperations over both `std::string::String` and `@code{InlinableString`} (or even\nyour own custom string type).")
    (license (list license:asl2.0 license:expat))))

(define-public rust-pear-0.2
  (package
    (name "rust-pear")
    (version "0.2.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pear" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1j03s6m80iqldnm6jzh3k1fbyk0lxirx8bi4ivgq3k3sq7va1k2c"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-inlinable-string"
          ,rust-inlinable-string-0.1)
         ("rust-pear-codegen" ,rust-pear-codegen-0.2)
         ("rust-yansi" ,rust-yansi-1))))
    (home-page "")
    (synopsis "A pear is a fruit.")
    (description
      "This package provides a pear is a fruit.")
    (license (list license:expat license:asl2.0))))

(define-public rust-atomic-0.6
  (package
    (name "rust-atomic")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "atomic" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "15193mfhmrq3p6vi1a10hw3n6kvzf5h32zikhby3mdj0ww1q10cd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1))))
    (home-page
      "https://github.com/Amanieu/atomic-rs")
    (synopsis "Generic Atomic<T> wrapper type")
    (description "Generic Atomic<T> wrapper type")
    (license (list license:asl2.0 license:expat))))

(define-public rust-figment-0.10
  (package
    (name "rust-figment")
    (version "0.10.12")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "figment" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1vps8n6nnn0ca2cww60bibm5ka4d9lq2d5jik9z0b535h9fkx7v4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-atomic" ,rust-atomic-0.6)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-pear" ,rust-pear-0.2)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-serde-yaml" ,rust-serde-yaml-0.9)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-toml" ,rust-toml-0.8)
         ("rust-uncased" ,rust-uncased-0.9)
         ("rust-version-check" ,rust-version-check-0.9))))
    (home-page
      "https://github.com/SergioBenitez/Figment")
    (synopsis
      "A configuration library so con-free, it's unreal.")
    (description
      "This package provides a configuration library so con-free, it's unreal.")
    (license (list license:expat license:asl2.0))))

(define-public rust-binascii-0.1
  (package
    (name "rust-binascii")
    (version "0.1.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "binascii" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0wnaglgl72pn5ilv61q6y34w76gbg7crb8ifqk6lsxnq2gajjg9q"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/naim94a/binascii-rs")
    (synopsis
      "Useful no-std binascii operations including base64, base32 and base16 (hex)")
    (description
      "Useful no-std binascii operations including base64, base32 and base16 (hex)")
    (license license:expat)))

(define-public rust-rocket-0.5
  (package
    (name "rust-rocket")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rocket" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0l4i93dai7pyzlkvdjkqg2g7ni1r6749cwx4nrrhsrr6rdybaywy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-stream" ,rust-async-stream-0.3)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-atomic" ,rust-atomic-0.5)
         ("rust-binascii" ,rust-binascii-0.1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-either" ,rust-either-1)
         ("rust-figment" ,rust-figment-0.10)
         ("rust-futures" ,rust-futures-0.3)
         ("rust-indexmap" ,rust-indexmap-2)
         ("rust-log" ,rust-log-0.4)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-multer" ,rust-multer-2)
         ("rust-num-cpus" ,rust-num-cpus-1)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-ref-cast" ,rust-ref-cast-1)
         ("rust-rmp-serde" ,rust-rmp-serde-1)
         ("rust-rocket-codegen" ,rust-rocket-codegen-0.5)
         ("rust-rocket-http" ,rust-rocket-http-0.5)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-state" ,rust-state-0.6)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-time" ,rust-time-0.3)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-stream" ,rust-tokio-stream-0.1)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-ubyte" ,rust-ubyte-0.10)
         ("rust-uuid" ,rust-uuid-1)
         ("rust-version-check" ,rust-version-check-0.9)
         ("rust-yansi" ,rust-yansi-1))))
    (home-page "https://rocket.rs")
    (synopsis
      "Web framework with a focus on usability, security, extensibility, and speed.\n")
    (description
      "Web framework with a focus on usability, security, extensibility, and speed.")
    (license (list license:expat license:asl2.0))))

(define-public rust-wildmatch-2
  (package
    (name "rust-wildmatch")
    (version "2.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wildmatch" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "11nv29caiay9cprayccbdf7rl263yhzvpdcx1sr9vkzibzf3nn7f"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/becheran/wildmatch")
    (synopsis
      "Simple string matching  with questionmark and star wildcard operator.")
    (description
      "Simple string matching with questionmark and star wildcard operator.")
    (license license:expat)))

(define-public rust-tokio-metrics-0.3
  (package
    (name "rust-tokio-metrics")
    (version "0.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tokio-metrics" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "04p1kf7sgcrs2n62331fm5yvv8scqv2x81qixdz8pjb23lj0kkpa"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-stream" ,rust-tokio-stream-0.1))))
    (home-page "https://tokio.rs")
    (synopsis
      "Runtime and task level metrics for Tokio applications.\n")
    (description
      "Runtime and task level metrics for Tokio applications.")
    (license license:expat)))

(define-public rust-futures-codec-0.4
  (package
    (name "rust-futures-codec")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "futures_codec" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0nzadpxhdxdlnlk2f0gfn0qbifqc3pbnzm10v4z04x8ciczxcm6f"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytes" ,rust-bytes-0.5)
         ("rust-futures" ,rust-futures-0.3)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-pin-project" ,rust-pin-project-0.4)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-cbor" ,rust-serde-cbor-0.11)
         ("rust-serde-json" ,rust-serde-json-1))))
    (home-page
      "https://github.com/matthunz/futures-codec")
    (synopsis
      "Utilities for encoding and decoding frames using `async/await`")
    (description
      "Utilities for encoding and decoding frames using `async/await`")
    (license license:expat)))

(define-public rust-sse-codec-0.3
  (package
    (name "rust-sse-codec")
    (version "0.3.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "sse-codec" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0nh8b1y2k5lsvcva15da4by935bavirfpavs0d54pi2h2f0rz9c4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arbitrary" ,rust-arbitrary-0.4)
         ("rust-bytes" ,rust-bytes-0.5)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-futures-codec" ,rust-futures-codec-0.4)
         ("rust-memchr" ,rust-memchr-2))))
    (home-page
      "https://github.com/goto-bus-stop/sse-codec")
    (synopsis
      "async Server-Sent Events protocol encoder/decoder")
    (description
      "async Server-Sent Events protocol encoder/decoder")
    (license license:mpl2.0)))

(define-public rust-rfc7239-0.1
  (package
    (name "rust-rfc7239")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rfc7239" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ixsyn8y2jfhfqnhwivgil3cvdr4jdr5s0nr7gqq3d3yryrifwq8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-uncased" ,rust-uncased-0.9))))
    (home-page
      "https://github.com/icewind1991/rfc7239")
    (synopsis
      "Parser for rfc7239 formatted Forwarded headers")
    (description
      "Parser for rfc7239 formatted Forwarded headers")
    (license (list license:expat license:asl2.0))))

(define-public rust-tokio-retry-0.3
  (package
    (name "rust-tokio-retry")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tokio-retry" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0kr1hnm5dmb9gfkby88yg2xj8g6x4i4gipva0c8ca3xyxhvfnmvz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-pin-project" ,rust-pin-project-1)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-tokio" ,rust-tokio-1))))
    (home-page
      "https://github.com/srijs/rust-tokio-retry")
    (synopsis
      "Extensible, asynchronous retry behaviours for futures/tokio")
    (description
      "Extensible, asynchronous retry behaviours for futures/tokio")
    (license license:expat)))

(define-public rust-futures-rustls-0.24
  (package
    (name "rust-futures-rustls")
    (version "0.24.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "futures-rustls" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0a1acak02s42wh6qjmjyviscc5j77qsh1qrqd023hdqqikv3rg9m"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-rustls" ,rust-rustls-0.21))))
    (home-page
      "https://github.com/quininer/futures-rustls")
    (synopsis
      "Asynchronous TLS/SSL streams for futures using Rustls.")
    (description
      "Asynchronous TLS/SSL streams for futures using Rustls.")
    (license (list license:expat license:asl2.0))))

(define-public rust-crc16-0.4
  (package
    (name "rust-crc16")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "crc16" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1zzwb5iv51wnh96532cxkk4aa8ys47rhzrjy98wqcys25ks8k01k"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/blackbeam/rust-crc16")
    (synopsis "A CRC16 implementation")
    (description
      "This package provides a CRC16 implementation")
    (license license:expat)))

(define-public rust-async-native-tls-0.4
  (package
    (name "rust-async-native-tls")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-native-tls" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1zhkka5azpr03wg2bswabmwcwcqbdia17h2d17hk4wk47kn4qzfm"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-url" ,rust-url-2))))
    (home-page
      "https://docs.rs/crate/async-native-tls/")
    (synopsis "Native TLS using futures\n")
    (description "Native TLS using futures")
    (license (list license:expat license:asl2.0))))

(define-public rust-redis-0.23
  (package
    (name "rust-redis")
    (version "0.23.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "redis" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1fpqnckjlrhl7jbr1flrqg2hpccy3pz91gfiwzw2nh9zpg0csjag"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ahash" ,rust-ahash-0.7)
         ("rust-arc-swap" ,rust-arc-swap-1)
         ("rust-async-native-tls"
          ,rust-async-native-tls-0.4)
         ("rust-async-std" ,rust-async-std-1)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-combine" ,rust-combine-4)
         ("rust-crc16" ,rust-crc16-0.4)
         ("rust-futures" ,rust-futures-0.3)
         ("rust-futures-rustls" ,rust-futures-rustls-0.24)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-r2d2" ,rust-r2d2-0.8)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-rustls" ,rust-rustls-0.21)
         ("rust-rustls-native-certs"
          ,rust-rustls-native-certs-0.6)
         ("rust-ryu" ,rust-ryu-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-sha1-smol" ,rust-sha1-smol-1)
         ("rust-socket2" ,rust-socket2-0.4)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-retry" ,rust-tokio-retry-0.3)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-url" ,rust-url-2)
         ("rust-webpki-roots" ,rust-webpki-roots-0.23))))
    (home-page
      "https://github.com/redis-rs/redis-rs")
    (synopsis "Redis driver for Rust.")
    (description "Redis driver for Rust.")
    (license license:bsd-3)))

(define-public rust-poem-derive-1
  (package
    (name "rust-poem-derive")
    (version "1.3.59")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "poem-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0cdvid2ryn4h9wj7087shf20ijvahh1n44bmwghngn6qh13czpa2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-crate"
          ,rust-proc-macro-crate-2)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/poem-web/poem")
    (synopsis "Macros for poem")
    (description "Macros for poem")
    (license (list license:expat license:asl2.0))))

(define-public rust-opentelemetry-semantic-conventions-0.13
  (package
    (name "rust-opentelemetry-semantic-conventions")
    (version "0.13.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri
               "opentelemetry-semantic-conventions"
               version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "115wbgk840dklyhpg3lwp4x1m643qd7f0vkz8hmfz0pry4g4yxzm"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-opentelemetry" ,rust-opentelemetry-0.21))))
    (home-page
      "https://github.com/open-telemetry/opentelemetry-rust/tree/main/opentelemetry-semantic-conventions")
    (synopsis
      "Semantic conventions for OpenTelemetry")
    (description
      "Semantic conventions for @code{OpenTelemetry}")
    (license license:asl2.0)))

(define-public rust-procfs-0.14
  (package
    (name "rust-procfs")
    (version "0.14.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "procfs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0sdv4r3gikcz12qzb4020rlcq7vn8kh72vgwmvk7fgw7n2n8vpmi"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-backtrace" ,rust-backtrace-0.3)
         ("rust-bitflags" ,rust-bitflags-1)
         ("rust-byteorder" ,rust-byteorder-1)
         ("rust-chrono" ,rust-chrono-0.4)
         ("rust-flate2" ,rust-flate2-1)
         ("rust-hex" ,rust-hex-0.4)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-rustix" ,rust-rustix-0.36)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/eminence/procfs")
    (synopsis
      "Interface to the linux procfs pseudo-filesystem")
    (description
      "Interface to the linux procfs pseudo-filesystem")
    (license (list license:expat license:asl2.0))))

(define-public rust-prometheus-0.13
  (package
    (name "rust-prometheus")
    (version "0.13.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "prometheus" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "136gpgkh52kg3w6cxj1fdqqq5kr9ch31ci0lq6swxxdxbz8i3624"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-fnv" ,rust-fnv-1)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-procfs" ,rust-procfs-0.14)
         ("rust-protobuf" ,rust-protobuf-2)
         ("rust-protobuf-codegen-pure"
          ,rust-protobuf-codegen-pure-2)
         ("rust-reqwest" ,rust-reqwest-0.11)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page
      "https://github.com/tikv/rust-prometheus")
    (synopsis
      "Prometheus instrumentation library for Rust applications.")
    (description
      "Prometheus instrumentation library for Rust applications.")
    (license license:asl2.0)))

(define-public rust-syn-derive-0.1
  (package
    (name "rust-syn-derive")
    (version "0.1.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "syn_derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0yxydi22apcisjg0hff6dfm5x8hd6cqicav56sblx67z0af1ha8k"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-error"
          ,rust-proc-macro-error-1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/Kyuuhachi/syn_derive")
    (synopsis
      "Derive macros for `syn::Parse` and `quote::ToTokens`")
    (description
      "Derive macros for `syn::Parse` and `quote::@code{ToTokens`}")
    (license (list license:expat license:asl2.0))))

(define-public rust-toml-edit-0.20
  (package
    (name "rust-toml-edit")
    (version "0.20.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "toml_edit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0f7k5svmxw98fhi28jpcyv7ldr2s3c867pjbji65bdxjpd44svir"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-indexmap" ,rust-indexmap-2)
         ("rust-kstring" ,rust-kstring-2)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-spanned" ,rust-serde-spanned-0.6)
         ("rust-toml-datetime" ,rust-toml-datetime-0.6)
         ("rust-winnow" ,rust-winnow-0.5))))
    (home-page "https://github.com/toml-rs/toml")
    (synopsis
      "Yet another format-preserving TOML parser.")
    (description
      "Yet another format-preserving TOML parser.")
    (license (list license:expat license:asl2.0))))

(define-public rust-toml-datetime-0.6
  (package
    (name "rust-toml-datetime")
    (version "0.6.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "toml_datetime" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0jsy7v8bdvmzsci6imj8fzgd255fmy5fzp6zsri14yrry7i77nkw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/toml-rs/toml")
    (synopsis "A TOML-compatible datetime type")
    (description
      "This package provides a TOML-compatible datetime type")
    (license (list license:expat license:asl2.0))))

(define-public rust-proc-macro-crate-2
  (package
    (name "rust-proc-macro-crate")
    (version "2.0.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "proc-macro-crate" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "06jbv5w6s04dbjbwq0iv7zil12ildf3w8dvvb4pqvhig4gm5zp4p"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-toml-datetime" ,rust-toml-datetime-0.6)
         ("rust-toml-edit" ,rust-toml-edit-0.20))))
    (home-page
      "https://github.com/bkchr/proc-macro-crate")
    (synopsis
      "Replacement for crate (macro_rules keyword) in proc-macros\n")
    (description
      "Replacement for crate (macro_rules keyword) in proc-macros")
    (license (list license:expat license:asl2.0))))

(define-public rust-borsh-derive-1
  (package
    (name "rust-borsh-derive")
    (version "1.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "borsh-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "136y1010snv2ljpqn23mirm9gk55wamdmpzk621mqv150kzl32s7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-once-cell" ,rust-once-cell-1)
         ("rust-proc-macro-crate"
          ,rust-proc-macro-crate-2)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-syn-derive" ,rust-syn-derive-0.1))))
    (home-page "https://borsh.io")
    (synopsis
      "Binary Object Representation Serializer for Hashing\n")
    (description
      "Binary Object Representation Serializer for Hashing")
    (license license:asl2.0)))

(define-public rust-ascii-1
  (package
    (name "rust-ascii")
    (version "1.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ascii" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "05nyyp39x4wzc1959kv7ckwqpkdzjd9dw4slzyjh73qbhjcfqayr"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1)
         ("rust-serde-test" ,rust-serde-test-1))))
    (home-page
      "https://github.com/tomprogrammer/rust-ascii")
    (synopsis
      "ASCII-only equivalents to `char`, `str` and `String`.")
    (description
      "ASCII-only equivalents to `char`, `str` and `String`.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-borsh-1
  (package
    (name "rust-borsh")
    (version "1.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "borsh" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1l89yf34vqsbbyvls7kxbl4c2z93l9p46zkdvrlj2dnj3c7yz5wq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ascii" ,rust-ascii-1)
         ("rust-borsh-derive" ,rust-borsh-derive-1)
         ("rust-bson" ,rust-bson-2)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-cfg-aliases" ,rust-cfg-aliases-0.1)
         ("rust-hashbrown" ,rust-hashbrown-0.14))))
    (home-page "https://borsh.io")
    (synopsis
      "Binary Object Representation Serializer for Hashing\n")
    (description
      "Binary Object Representation Serializer for Hashing")
    (license (list license:expat license:asl2.0))))

(define-public rust-ordered-float-4
  (package
    (name "rust-ordered-float")
    (version "4.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ordered-float" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0kjqcvvbcsibbx3hnj7ag06bd9gv2zfi5ja6rgyh2kbxbh3zfvd7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arbitrary" ,rust-arbitrary-1)
         ("rust-borsh" ,rust-borsh-1)
         ("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-num-traits" ,rust-num-traits-0.2)
         ("rust-proptest" ,rust-proptest-1)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-rkyv" ,rust-rkyv-0.7)
         ("rust-schemars" ,rust-schemars-0.8)
         ("rust-serde" ,rust-serde-1)
         ("rust-speedy" ,rust-speedy-0.8))))
    (home-page
      "https://github.com/reem/rust-ordered-float")
    (synopsis
      "Wrappers for total ordering on floats")
    (description
      "Wrappers for total ordering on floats")
    (license license:expat)))

(define-public rust-opentelemetry-sdk-0.21
  (package
    (name "rust-opentelemetry-sdk")
    (version "0.21.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "opentelemetry_sdk" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1rbxgcxwmxg5ijf7i1xfcg0z5xqyg5ng9r7mhx8hxs83rbra72wn"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-std" ,rust-async-std-1)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-crossbeam-channel"
          ,rust-crossbeam-channel-0.5)
         ("rust-futures-channel"
          ,rust-futures-channel-0.3)
         ("rust-futures-executor"
          ,rust-futures-executor-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-glob" ,rust-glob-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-opentelemetry" ,rust-opentelemetry-0.21)
         ("rust-opentelemetry-http"
          ,rust-opentelemetry-http-0.10)
         ("rust-ordered-float" ,rust-ordered-float-4)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-stream" ,rust-tokio-stream-0.1)
         ("rust-url" ,rust-url-2))))
    (home-page
      "https://github.com/open-telemetry/opentelemetry-rust")
    (synopsis
      "The SDK for the OpenTelemetry metrics collection and distributed tracing framework")
    (description
      "The SDK for the @code{OpenTelemetry} metrics collection and distributed tracing\nframework")
    (license license:asl2.0)))

(define-public rust-opentelemetry-prometheus-0.14
  (package
    (name "rust-opentelemetry-prometheus")
    (version "0.14.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "opentelemetry-prometheus" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1gbrl3kgn8l4wik29m0s7ab8yavrp383x7l2a2rdrc0ml4nhi3vg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-once-cell" ,rust-once-cell-1)
         ("rust-opentelemetry" ,rust-opentelemetry-0.21)
         ("rust-opentelemetry-sdk"
          ,rust-opentelemetry-sdk-0.21)
         ("rust-prometheus" ,rust-prometheus-0.13)
         ("rust-protobuf" ,rust-protobuf-2))))
    (home-page
      "https://github.com/open-telemetry/opentelemetry-rust")
    (synopsis
      "Prometheus exporter for OpenTelemetry")
    (description
      "Prometheus exporter for @code{OpenTelemetry}")
    (license license:asl2.0)))

(define-public rust-sluice-0.5
  (package
    (name "rust-sluice")
    (version "0.5.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "sluice" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1d9ywr5039ibgaby8sc72f8fs5lpp8j5y6p3npya4jplxz000x3d"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-channel" ,rust-async-channel-1)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-io" ,rust-futures-io-0.3))))
    (home-page "https://github.com/sagebind/sluice")
    (synopsis
      "Efficient ring buffer for byte buffers, FIFO queues, and SPSC channels")
    (description
      "Efficient ring buffer for byte buffers, FIFO queues, and SPSC channels")
    (license license:expat)))

(define-public rust-castaway-0.1
  (package
    (name "rust-castaway")
    (version "0.1.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "castaway" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1xhspwy477qy5yg9c3jp713asxckjpx0vfrmz5l7r5zg7naqysd2"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/sagebind/castaway")
    (synopsis
      "Safe, zero-cost downcasting for limited compile-time specialization.")
    (description
      "Safe, zero-cost downcasting for limited compile-time specialization.")
    (license license:expat)))

(define-public rust-isahc-1
  (package
    (name "rust-isahc")
    (version "1.7.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "isahc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1scfgyv3dpjbkqa9im25cd12cs6rbd8ygcaw67f3dx41sys08kik"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-channel" ,rust-async-channel-1)
         ("rust-castaway" ,rust-castaway-0.1)
         ("rust-crossbeam-utils"
          ,rust-crossbeam-utils-0.8)
         ("rust-curl" ,rust-curl-0.4)
         ("rust-curl-sys" ,rust-curl-sys-0.4)
         ("rust-encoding-rs" ,rust-encoding-rs-0.8)
         ("rust-event-listener" ,rust-event-listener-2)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-http" ,rust-http-0.2)
         ("rust-httpdate" ,rust-httpdate-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-parking-lot" ,rust-parking-lot-0.11)
         ("rust-polling" ,rust-polling-2)
         ("rust-publicsuffix" ,rust-publicsuffix-2)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-slab" ,rust-slab-0.4)
         ("rust-sluice" ,rust-sluice-0.5)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-tracing-futures"
          ,rust-tracing-futures-0.2)
         ("rust-url" ,rust-url-2)
         ("rust-waker-fn" ,rust-waker-fn-1))))
    (home-page "https://github.com/sagebind/isahc")
    (synopsis
      "The practical HTTP client that is fun to use.")
    (description
      "The practical HTTP client that is fun to use.")
    (license license:expat)))

(define-public rust-opentelemetry-http-0.10
  (package
    (name "rust-opentelemetry-http")
    (version "0.10.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "opentelemetry-http" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17irqlgsqr1f0in5rhvgl224x2gdcycy8w3ybydlyrdyx2f1hlbz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-http" ,rust-http-0.2)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-isahc" ,rust-isahc-1)
         ("rust-opentelemetry" ,rust-opentelemetry-0.21)
         ("rust-reqwest" ,rust-reqwest-0.11)
         ("rust-surf" ,rust-surf-2)
         ("rust-tokio" ,rust-tokio-1))))
    (home-page
      "https://github.com/open-telemetry/opentelemetry-rust")
    (synopsis
      "Helper implementations for exchange of traces and metrics over HTTP")
    (description
      "Helper implementations for exchange of traces and metrics over HTTP")
    (license license:asl2.0)))

(define-public rust-urlencoding-2
  (package
    (name "rust-urlencoding")
    (version "2.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "urlencoding" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1nj99jp37k47n0hvaz5fvz7z6jd0sb4ppvfy3nphr1zbnyixpy6s"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://lib.rs/urlencoding")
    (synopsis
      "A Rust library for doing URL percentage encoding.")
    (description
      "This package provides a Rust library for doing URL percentage encoding.")
    (license license:expat)))

(define-public rust-opentelemetry-0.21
  (package
    (name "rust-opentelemetry")
    (version "0.21.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "opentelemetry" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "12jfmyx8k9q2sjlx4wp76ddzaf94i7lnkliv1c9mj164bnd36chy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-sink" ,rust-futures-sink-0.3)
         ("rust-indexmap" ,rust-indexmap-2)
         ("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-urlencoding" ,rust-urlencoding-2))))
    (home-page
      "https://github.com/open-telemetry/opentelemetry-rust")
    (synopsis
      "A metrics collection and distributed tracing framework")
    (description
      "This package provides a metrics collection and distributed tracing framework")
    (license license:asl2.0)))

(define-public rust-hyper-rustls-0.24
  (package
    (name "rust-hyper-rustls")
    (version "0.24.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "hyper-rustls" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1475j4a2nczz4aajzzsq3hpwg1zacmzbqg393a14j80ff8izsgpc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-log" ,rust-log-0.4)
         ("rust-rustls" ,rust-rustls-0.21)
         ("rust-rustls-native-certs"
          ,rust-rustls-native-certs-0.6)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
         ("rust-webpki-roots" ,rust-webpki-roots-0.25))))
    (home-page
      "https://github.com/rustls/hyper-rustls")
    (synopsis
      "Rustls+hyper integration for pure rust HTTPS")
    (description
      "Rustls+hyper integration for pure rust HTTPS")
    (license
      (list license:asl2.0 license:isc license:expat))))

(define-public rust-chacha20-0.7
  (package
    (name "rust-chacha20")
    (version "0.7.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "chacha20" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1c8h4sp9zh13v8p9arydjcj92xc6j3mccrjc4mizrvq7fzx9717h"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-cipher" ,rust-cipher-0.3)
         ("rust-cpufeatures" ,rust-cpufeatures-0.2)
         ("rust-rand-core" ,rust-rand-core-0.6)
         ("rust-zeroize" ,rust-zeroize-1))))
    (home-page
      "https://github.com/RustCrypto/stream-ciphers")
    (synopsis
      "The ChaCha20 stream cipher (RFC 8439) implemented in pure Rust using traits\nfrom the RustCrypto `cipher` crate, with optional architecture-specific\nhardware acceleration (AVX2, SSE2). Additionally provides the ChaCha8, ChaCha12,\nXChaCha20, XChaCha12 and XChaCha8 stream ciphers, and also optional\nrand_core-compatible RNGs based on those ciphers.\n")
    (description
      "The @code{ChaCha20} stream cipher (RFC 8439) implemented in pure Rust using\ntraits from the @code{RustCrypto} `cipher` crate, with optional\narchitecture-specific hardware acceleration (AVX2, SSE2).  Additionally provides\nthe @code{ChaCha8}, @code{ChaCha12}, X@code{ChaCha20}, X@code{ChaCha12} and\nX@code{ChaCha8} stream ciphers, and also optional rand_core-compatible RNGs\nbased on those ciphers.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-chacha20poly1305-0.8
  (package
    (name "rust-chacha20poly1305")
    (version "0.8.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "chacha20poly1305" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "18mb6k1w71dqv5q50an4rvp19l6yg8ssmvfrmknjfh2z0az7lm5n"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-aead" ,rust-aead-0.4)
         ("rust-chacha20" ,rust-chacha20-0.7)
         ("rust-cipher" ,rust-cipher-0.3)
         ("rust-poly1305" ,rust-poly1305-0.7)
         ("rust-zeroize" ,rust-zeroize-1))))
    (home-page
      "https://github.com/RustCrypto/AEADs/tree/master/chacha20poly1305")
    (synopsis
      "Pure Rust implementation of the ChaCha20Poly1305 Authenticated Encryption\nwith Additional Data Cipher (RFC 8439) with optional architecture-specific\nhardware acceleration. Also contains implementations of the XChaCha20Poly1305\nextended nonce variant of ChaCha20Poly1305, and the reduced-round\nChaCha8Poly1305 and ChaCha12Poly1305 lightweight variants.\n")
    (description
      "Pure Rust implementation of the @code{ChaCha20Poly1305} Authenticated Encryption\nwith Additional Data Cipher (RFC 8439) with optional architecture-specific\nhardware acceleration.  Also contains implementations of the\nX@code{ChaCha20Poly1305} extended nonce variant of @code{ChaCha20Poly1305}, and\nthe reduced-round @code{ChaCha8Poly1305} and @code{ChaCha12Poly1305} lightweight\nvariants.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-zeroize-1
  (package
    (name "rust-zeroize")
    (version "1.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zeroize" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1z8yix823b6lz878qwg6bvwhg3lb0cbw3c9yij9p8mbv7zdzfmj7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-zeroize-derive" ,rust-zeroize-derive-1))))
    (home-page
      "https://github.com/RustCrypto/utils/tree/master/zeroize")
    (synopsis
      "Securely clear secrets from memory with a simple trait built on\nstable Rust primitives which guarantee memory is zeroed using an\noperation will not be 'optimized away' by the compiler.\nUses a portable pure Rust implementation that works everywhere,\neven WASM!\n")
    (description
      "Securely clear secrets from memory with a simple trait built on stable Rust\nprimitives which guarantee memory is zeroed using an operation will not be\noptimized away by the compiler.  Uses a portable pure Rust implementation that\nworks everywhere, even WASM!")
    (license (list license:asl2.0 license:expat))))

(define-public rust-polyval-0.5
  (package
    (name "rust-polyval")
    (version "0.5.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "polyval" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1890wqvc0csc9y9k9k4gsbz91rgdnhn6xnfmy9pqkh674fvd46c4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-cpufeatures" ,rust-cpufeatures-0.2)
         ("rust-opaque-debug" ,rust-opaque-debug-0.3)
         ("rust-universal-hash" ,rust-universal-hash-0.4)
         ("rust-zeroize" ,rust-zeroize-1))))
    (home-page
      "https://github.com/RustCrypto/universal-hashes")
    (synopsis
      "POLYVAL is a GHASH-like universal hash over GF(2^128) useful for constructing\na Message Authentication Code (MAC)\n")
    (description
      "POLYVAL is a GHASH-like universal hash over GF(2^128) useful for constructing a\nMessage Authentication Code (MAC)")
    (license (list license:asl2.0 license:expat))))

(define-public rust-ghash-0.4
  (package
    (name "rust-ghash")
    (version "0.4.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ghash" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "169wvrc2k9lw776x3pmqp76kc0w5717wz01bfg9rz0ypaqbcr0qm"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-opaque-debug" ,rust-opaque-debug-0.3)
         ("rust-polyval" ,rust-polyval-0.5)
         ("rust-zeroize" ,rust-zeroize-1))))
    (home-page
      "https://github.com/RustCrypto/universal-hashes")
    (synopsis
      "Universal hash over GF(2^128) useful for constructing a Message Authentication Code (MAC),\nas in the AES-GCM authenticated encryption cipher.\n")
    (description
      "Universal hash over GF(2^128) useful for constructing a Message Authentication\nCode (MAC), as in the AES-GCM authenticated encryption cipher.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-aes-gcm-0.9
  (package
    (name "rust-aes-gcm")
    (version "0.9.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "aes-gcm" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1xndncn1phjb7pjam63vl0yp7h8jh95m0yxanr1092vx7al8apyz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-aead" ,rust-aead-0.4)
         ("rust-aes" ,rust-aes-0.7)
         ("rust-cipher" ,rust-cipher-0.3)
         ("rust-ctr" ,rust-ctr-0.8)
         ("rust-ghash" ,rust-ghash-0.4)
         ("rust-subtle" ,rust-subtle-2)
         ("rust-zeroize" ,rust-zeroize-1))))
    (home-page "https://github.com/RustCrypto/AEADs")
    (synopsis
      "Pure Rust implementation of the AES-GCM (Galois/Counter Mode)\nAuthenticated Encryption with Associated Data (AEAD) Cipher\nwith optional architecture-specific hardware acceleration\n")
    (description
      "Pure Rust implementation of the AES-GCM (Galois/Counter Mode) Authenticated\nEncryption with Associated Data (AEAD) Cipher with optional\narchitecture-specific hardware acceleration")
    (license (list license:asl2.0 license:expat))))

(define-public rust-csrf-0.4
  (package
    (name "rust-csrf")
    (version "0.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "csrf" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1q7ixhshj6a7x2vgsr4d4iqa5mgp4fwkr4lx2hgvnj9xcy1py9dh"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-aead" ,rust-aead-0.4)
         ("rust-aes-gcm" ,rust-aes-gcm-0.9)
         ("rust-byteorder" ,rust-byteorder-1)
         ("rust-chacha20poly1305"
          ,rust-chacha20poly1305-0.8)
         ("rust-chrono" ,rust-chrono-0.4)
         ("rust-data-encoding" ,rust-data-encoding-2)
         ("rust-generic-array" ,rust-generic-array-0.14)
         ("rust-hmac" ,rust-hmac-0.11)
         ("rust-log" ,rust-log-0.4)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-sha2" ,rust-sha2-0.9)
         ("rust-typemap" ,rust-typemap-0.3))))
    (home-page
      "https://github.com/heartsucker/rust-csrf")
    (synopsis "CSRF protection primitives")
    (description "CSRF protection primitives")
    (license license:expat)))

(define-public rust-poem-1
  (package
    (name "rust-poem")
    (version "1.3.59")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "poem" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0159agmjig6s45sjf1jcbira8icpbakfadwa23pc2i07gg4p8ish"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-anyhow" ,rust-anyhow-1)
         ("rust-async-compression"
          ,rust-async-compression-0.4)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-base64" ,rust-base64-0.21)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-chrono" ,rust-chrono-0.4)
         ("rust-cookie" ,rust-cookie-0.17)
         ("rust-csrf" ,rust-csrf-0.4)
         ("rust-eyre" ,rust-eyre-0.6)
         ("rust-fluent" ,rust-fluent-0.16)
         ("rust-fluent-langneg" ,rust-fluent-langneg-0.13)
         ("rust-fluent-syntax" ,rust-fluent-syntax-0.11)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-headers" ,rust-headers-0.3)
         ("rust-hex" ,rust-hex-0.4)
         ("rust-http" ,rust-http-0.2)
         ("rust-httpdate" ,rust-httpdate-1)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-hyper-rustls" ,rust-hyper-rustls-0.24)
         ("rust-intl-memoizer" ,rust-intl-memoizer-0.5)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-mime-guess" ,rust-mime-guess-2)
         ("rust-multer" ,rust-multer-2)
         ("rust-nix" ,rust-nix-0.27)
         ("rust-openssl" ,rust-openssl-0.10)
         ("rust-opentelemetry" ,rust-opentelemetry-0.21)
         ("rust-opentelemetry-http"
          ,rust-opentelemetry-http-0.10)
         ("rust-opentelemetry-prometheus"
          ,rust-opentelemetry-prometheus-0.14)
         ("rust-opentelemetry-semantic-conventions"
          ,rust-opentelemetry-semantic-conventions-0.13)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-poem-derive" ,rust-poem-derive-1)
         ("rust-priority-queue" ,rust-priority-queue-1)
         ("rust-prometheus" ,rust-prometheus-0.13)
         ("rust-quick-xml" ,rust-quick-xml-0.30)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-rcgen" ,rust-rcgen-0.11)
         ("rust-redis" ,rust-redis-0.23)
         ("rust-regex" ,rust-regex-1)
         ("rust-rfc7239" ,rust-rfc7239-0.1)
         ("rust-ring" ,rust-ring-0.16)
         ("rust-rust-embed" ,rust-rust-embed-8)
         ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-serde-urlencoded"
          ,rust-serde-urlencoded-0.7)
         ("rust-serde-yaml" ,rust-serde-yaml-0.9)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-sse-codec" ,rust-sse-codec-0.3)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-time" ,rust-time-0.3)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-metrics" ,rust-tokio-metrics-0.3)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-openssl" ,rust-tokio-openssl-0.6)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
         ("rust-tokio-stream" ,rust-tokio-stream-0.1)
         ("rust-tokio-tungstenite"
          ,rust-tokio-tungstenite-0.20)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-tower" ,rust-tower-0.4)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-unic-langid" ,rust-unic-langid-0.9)
         ("rust-wildmatch" ,rust-wildmatch-2)
         ("rust-x509-parser" ,rust-x509-parser-0.15))))
    (home-page "https://github.com/poem-web/poem")
    (synopsis
      "Poem is a full-featured and easy-to-use web framework with the Rust programming language.")
    (description
      "Poem is a full-featured and easy-to-use web framework with the Rust programming\nlanguage.")
    (license (list license:expat license:asl2.0))))

(define-public rust-include-flate-codegen-0.1
  (package
    (name "rust-include-flate-codegen")
    (version "0.1.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "include-flate-codegen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1s34ssq0l3d2sn8n3mxmkz3jbm600fbckd0213mjjcgs34a6wz9s"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libflate" ,rust-libflate-1)
         ("rust-proc-macro-hack"
          ,rust-proc-macro-hack-0.5)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-1))))
    (home-page
      "https://github.com/SOF3/include-flate")
    (synopsis
      "Macro codegen for the include-flate crate")
    (description
      "Macro codegen for the include-flate crate")
    (license license:asl2.0)))

(define-public rust-include-flate-codegen-exports-0.1
  (package
    (name "rust-include-flate-codegen-exports")
    (version "0.1.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri
               "include-flate-codegen-exports"
               version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "00qswg7avv92mjp0p3kmswp3jask0psz1bmq3h7jin73zx1p0rbm"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-include-flate-codegen"
          ,rust-include-flate-codegen-0.1)
         ("rust-proc-macro-hack"
          ,rust-proc-macro-hack-0.5))))
    (home-page
      "https://github.com/SOF3/include-flate")
    (synopsis
      "Macro codegen for the include-flate crate")
    (description
      "Macro codegen for the include-flate crate")
    (license license:asl2.0)))

(define-public rust-include-flate-0.2
  (package
    (name "rust-include-flate")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "include-flate" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1c5dsx6j9jwrd6calhxdgip85qjy45hc8v1740fr61k46ilibqf2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-include-flate-codegen-exports"
          ,rust-include-flate-codegen-exports-0.1)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-libflate" ,rust-libflate-1))))
    (home-page
      "https://github.com/SOF3/include-flate")
    (synopsis
      "A variant of include_bytes!/include_str! with compile-time deflation and runtime lazy inflation")
    (description
      "This package provides a variant of include_bytes!/include_str! with compile-time\ndeflation and runtime lazy inflation")
    (license license:asl2.0)))

(define-public rust-webpki-roots-0.25
  (package
    (name "rust-webpki-roots")
    (version "0.25.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "webpki-roots" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "045g7az4mj1002m55iydln4jhyah4br2n0zms3wbz41vicpa8y0p"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/rustls/webpki-roots")
    (synopsis
      "Mozilla's CA root certificates for use with webpki")
    (description
      "Mozilla's CA root certificates for use with webpki")
    (license license:mpl2.0)))

(define-public rust-webpki-roots-0.24
  (package
    (name "rust-webpki-roots")
    (version "0.24.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "webpki-roots" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "120q85pvzpckvvrg085a5jhh91fby94pgiv9y1san7lxbmnm94dj"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-rustls-webpki" ,rust-rustls-webpki-0.101))))
    (home-page
      "https://github.com/rustls/webpki-roots")
    (synopsis
      "Mozilla's CA root certificates for use with webpki")
    (description
      "Mozilla's CA root certificates for use with webpki")
    (license license:mpl2.0)))

(define-public rust-tungstenite-0.20
  (package
    (name "rust-tungstenite")
    (version "0.20.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tungstenite" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1fbgcv3h4h1bhhf5sqbwqsp7jnc44bi4m41sgmhzdsk2zl8aqgcy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-byteorder" ,rust-byteorder-1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-data-encoding" ,rust-data-encoding-2)
         ("rust-http" ,rust-http-0.2)
         ("rust-httparse" ,rust-httparse-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-rustls" ,rust-rustls-0.21)
         ("rust-rustls-native-certs"
          ,rust-rustls-native-certs-0.6)
         ("rust-sha1" ,rust-sha1-0.10)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-url" ,rust-url-2)
         ("rust-utf-8" ,rust-utf-8-0.7)
         ("rust-webpki-roots" ,rust-webpki-roots-0.24))))
    (home-page
      "https://github.com/snapview/tungstenite-rs")
    (synopsis
      "Lightweight stream-based WebSocket implementation")
    (description
      "Lightweight stream-based @code{WebSocket} implementation")
    (license (list license:expat license:asl2.0))))

(define-public rust-rustls-native-certs-0.6
  (package
    (name "rust-rustls-native-certs")
    (version "0.6.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rustls-native-certs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "007zind70rd5rfsrkdcfm8vn09j8sg02phg9334kark6rdscxam9"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-openssl-probe" ,rust-openssl-probe-0.1)
         ("rust-rustls-pemfile" ,rust-rustls-pemfile-1)
         ("rust-schannel" ,rust-schannel-0.1)
         ("rust-security-framework"
          ,rust-security-framework-2))))
    (home-page
      "https://github.com/rustls/rustls-native-certs")
    (synopsis
      "rustls-native-certs allows rustls to use the platform native certificate store")
    (description
      "rustls-native-certs allows rustls to use the platform native certificate store")
    (license
      (list license:asl2.0 license:isc license:expat))))

(define-public rust-tokio-tungstenite-0.20
  (package
    (name "rust-tokio-tungstenite")
    (version "0.20.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tokio-tungstenite" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0v1v24l27hxi5hlchs7hfd5rgzi167x0ygbw220nvq0w5b5msb91"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-native-tls" ,rust-native-tls-0.2)
         ("rust-rustls" ,rust-rustls-0.21)
         ("rust-rustls-native-certs"
          ,rust-rustls-native-certs-0.6)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
         ("rust-tungstenite" ,rust-tungstenite-0.20)
         ("rust-webpki-roots" ,rust-webpki-roots-0.25))))
    (home-page
      "https://github.com/snapview/tokio-tungstenite")
    (synopsis
      "Tokio binding for Tungstenite, the Lightweight stream-based WebSocket implementation")
    (description
      "Tokio binding for Tungstenite, the Lightweight stream-based @code{WebSocket}\nimplementation")
    (license license:expat)))

(define-public rust-sync-wrapper-0.1
  (package
    (name "rust-sync-wrapper")
    (version "0.1.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "sync_wrapper" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0q01lyj0gr9a93n10nxsn8lwbzq97jqd6b768x17c8f7v7gccir0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-core" ,rust-futures-core-0.3))))
    (home-page "https://docs.rs/sync_wrapper")
    (synopsis
      "A tool for enlisting the compilerâ\x80\x99s help in proving the absence of concurrency")
    (description
      "This package provides a tool for enlisting the compilerâ\x80\x99s help in proving the\nabsence of concurrency")
    (license license:asl2.0)))

(define-public rust-multer-2
  (package
    (name "rust-multer")
    (version "2.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "multer" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hjiphaypj3phqaj5igrzcia9xfmf4rr4ddigbh8zzb96k1bvb01"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytes" ,rust-bytes-1)
         ("rust-encoding-rs" ,rust-encoding-rs-0.8)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-httparse" ,rust-httparse-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-spin" ,rust-spin-0.9)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-version-check" ,rust-version-check-0.9))))
    (home-page "https://github.com/rousan/multer-rs")
    (synopsis
      "An async parser for `multipart/form-data` content-type in Rust.")
    (description
      "An async parser for `multipart/form-data` content-type in Rust.")
    (license license:expat)))

(define-public rust-matchit-0.7
  (package
    (name "rust-matchit")
    (version "0.7.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "matchit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "156bgdmmlv4crib31qhgg49nsjk88dxkdqp80ha2pk2rk6n6ax0f"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/ibraheemdev/matchit")
    (synopsis
      "A high performance, zero-copy URL router.")
    (description
      "This package provides a high performance, zero-copy URL router.")
    (license (list license:expat license:bsd-3))))

(define-public rust-headers-0.3
  (package
    (name "rust-headers")
    (version "0.3.9")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "headers" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0w62gnwh2p1lml0zqdkrx9dp438881nhz32zrzdy61qa0a9kns06"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-base64" ,rust-base64-0.21)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-headers-core" ,rust-headers-core-0.2)
         ("rust-http" ,rust-http-0.2)
         ("rust-httpdate" ,rust-httpdate-1)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-sha1" ,rust-sha1-0.10))))
    (home-page "https://hyper.rs")
    (synopsis "typed HTTP headers")
    (description "typed HTTP headers")
    (license license:expat)))

(define-public rust-axum-macros-0.3
  (package
    (name "rust-axum-macros")
    (version "0.3.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "axum-macros" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0qkb5cg06bnp8994ay0smk57shd5hpphcmp90kd7p65dxh86mjnd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-heck" ,rust-heck-0.4)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/tokio-rs/axum")
    (synopsis "Macros for axum")
    (description "Macros for axum")
    (license license:expat)))

(define-public rust-mime-0.3
  (package
    (name "rust-mime")
    (version "0.3.17")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "mime" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "16hkibgvb9klh0w0jk5crr5xv90l3wlf77ggymzjmvl1818vnxv8"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/hyperium/mime")
    (synopsis "Strongly Typed Mimes")
    (description "Strongly Typed Mimes")
    (license (list license:expat license:asl2.0))))

(define-public rust-iri-string-0.7
  (package
    (name "rust-iri-string")
    (version "0.7.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "iri-string" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1h07hkfkkjjvgzlaqpr5fia7hrgv7qxqdw4xrpdc3936gmk9p191"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-memchr" ,rust-memchr-2)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/lo48576/iri-string")
    (synopsis "IRI as string types")
    (description "IRI as string types")
    (license (list license:expat license:asl2.0))))

(define-public rust-http-range-header-0.3
  (package
    (name "rust-http-range-header")
    (version "0.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "http-range-header" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "13vm511vq3bhschkw2xi9nhxzkw53m55gn9vxg7qigfxc29spl5d"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/MarcusGrass/parse-range-headers")
    (synopsis "No-dep range header parser")
    (description "No-dep range header parser")
    (license license:expat)))

(define-public rust-zstd-safe-7
  (package
    (name "rust-zstd-safe")
    (version "7.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zstd-safe" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0gpav2lcibrpmyslmjkcn3w0w64qif3jjljd2h8lr4p249s7qx23"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-zstd-sys" ,rust-zstd-sys-2))))
    (home-page "https://github.com/gyscos/zstd-rs")
    (synopsis
      "Safe low-level bindings for the zstd compression library.")
    (description
      "Safe low-level bindings for the zstd compression library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-zstd-0.13
  (package
    (name "rust-zstd")
    (version "0.13.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zstd" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0401q54s9r35x2i7m1kwppgkj79g0pb6xz3xpby7qlkdb44k7yxz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-zstd-safe" ,rust-zstd-safe-7))))
    (home-page "https://github.com/gyscos/zstd-rs")
    (synopsis
      "Binding for the zstd compression library.")
    (description
      "Binding for the zstd compression library.")
    (license license:expat)))

(define-public rust-deflate64-0.1
  (package
    (name "rust-deflate64")
    (version "0.1.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "deflate64" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1aagh5mmyr8p08if33hizqwiq2as90v9smla89nydq6pivsfy766"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/anatawa12/deflate64-rs#readme")
    (synopsis
      "Deflate64 implementation based on .NET's implementation")
    (description
      "Deflate64 implementation based on .NET's implementation")
    (license license:expat)))

(define-public rust-async-compression-0.4
  (package
    (name "rust-async-compression")
    (version "0.4.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-compression" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "19f2mdiz7jrmpbhjxmpfmixfv5640iknhxhfb57x723k5bxhqbdw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-brotli" ,rust-brotli-3)
         ("rust-bzip2" ,rust-bzip2-0.4)
         ("rust-deflate64" ,rust-deflate64-0.1)
         ("rust-flate2" ,rust-flate2-1)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-xz2" ,rust-xz2-0.1)
         ("rust-zstd" ,rust-zstd-0.13)
         ("rust-zstd-safe" ,rust-zstd-safe-7))))
    (home-page
      "https://github.com/Nullus157/async-compression")
    (synopsis
      "Adaptors between compression crates and Rust's modern asynchronous IO types.\n")
    (description
      "Adaptors between compression crates and Rust's modern asynchronous IO types.")
    (license (list license:expat license:asl2.0))))

(define-public rust-tower-http-0.4
  (package
    (name "rust-tower-http")
    (version "0.4.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tower-http" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0h0i2flrw25zwxv72sifq4v5mwcb030spksy7r2a4xl2d4fvpib1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-compression"
          ,rust-async-compression-0.4)
         ("rust-base64" ,rust-base64-0.21)
         ("rust-bitflags" ,rust-bitflags-2)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-http-body" ,rust-http-body-0.4)
         ("rust-http-range-header"
          ,rust-http-range-header-0.3)
         ("rust-httpdate" ,rust-httpdate-1)
         ("rust-iri-string" ,rust-iri-string-0.7)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-mime-guess" ,rust-mime-guess-2)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-tower" ,rust-tower-0.4)
         ("rust-tower-layer" ,rust-tower-layer-0.3)
         ("rust-tower-service" ,rust-tower-service-0.3)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-uuid" ,rust-uuid-1))))
    (home-page
      "https://github.com/tower-rs/tower-http")
    (synopsis
      "Tower middleware and utilities for HTTP clients and servers")
    (description
      "Tower middleware and utilities for HTTP clients and servers")
    (license license:expat)))

(define-public rust-http-body-0.4
  (package
    (name "rust-http-body")
    (version "0.4.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "http-body" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1lmyjfk6bqk6k9gkn1dxq770sb78pqbqshga241hr5p995bb5skw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytes" ,rust-bytes-1)
         ("rust-http" ,rust-http-0.2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page
      "https://github.com/hyperium/http-body")
    (synopsis
      "Trait representing an asynchronous, streaming, HTTP request or response body.\n")
    (description
      "Trait representing an asynchronous, streaming, HTTP request or response body.")
    (license license:expat)))

(define-public rust-axum-core-0.3
  (package
    (name "rust-axum-core")
    (version "0.3.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "axum-core" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0b1d9nkqb8znaba4qqzxzc968qwj4ybn4vgpyz9lz4a7l9vsb7vm"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-http-body" ,rust-http-body-0.4)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-rustversion" ,rust-rustversion-1)
         ("rust-tower-http" ,rust-tower-http-0.4)
         ("rust-tower-layer" ,rust-tower-layer-0.3)
         ("rust-tower-service" ,rust-tower-service-0.3)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/tokio-rs/axum")
    (synopsis "Core types and traits for axum")
    (description "Core types and traits for axum")
    (license license:expat)))

(define-public rust-axum-0.6
  (package
    (name "rust-axum")
    (version "0.6.20")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "axum" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1gynqkg3dcy1zd7il69h8a3zax86v6qq5zpawqyn87mr6979x0iv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-axum-core" ,rust-axum-core-0.3)
         ("rust-axum-macros" ,rust-axum-macros-0.3)
         ("rust-base64" ,rust-base64-0.21)
         ("rust-bitflags" ,rust-bitflags-1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-headers" ,rust-headers-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-http-body" ,rust-http-body-0.4)
         ("rust-hyper" ,rust-hyper-0.14)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-matchit" ,rust-matchit-0.7)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-multer" ,rust-multer-2)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-rustversion" ,rust-rustversion-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-serde-path-to-error"
          ,rust-serde-path-to-error-0.1)
         ("rust-serde-urlencoded"
          ,rust-serde-urlencoded-0.7)
         ("rust-sha1" ,rust-sha1-0.10)
         ("rust-sync-wrapper" ,rust-sync-wrapper-0.1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-tungstenite"
          ,rust-tokio-tungstenite-0.20)
         ("rust-tower" ,rust-tower-0.4)
         ("rust-tower-http" ,rust-tower-http-0.4)
         ("rust-tower-layer" ,rust-tower-layer-0.3)
         ("rust-tower-service" ,rust-tower-service-0.3)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/tokio-rs/axum")
    (synopsis
      "Web framework that focuses on ergonomics and modularity")
    (description
      "Web framework that focuses on ergonomics and modularity")
    (license license:expat)))

(define-public rust-actix-web-codegen-4
  (package
    (name "rust-actix-web-codegen")
    (version "4.2.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-web-codegen" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1xalrv1s7imzfgxyql6zii5bpxxkk11rlcc8n4ia3v1hpgmm07zb"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-actix-router" ,rust-actix-router-0.5)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "https://actix.rs")
    (synopsis
      "Routing and runtime macros for Actix Web")
    (description
      "Routing and runtime macros for Actix Web")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-server-2
  (package
    (name "rust-actix-server")
    (version "2.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-server" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1m62qbg7vl1wddr6mm8sd4rnvd3w5v3zcn8fmdpfl8q4xxz3xc9y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-actix-rt" ,rust-actix-rt-2)
         ("rust-actix-service" ,rust-actix-service-2)
         ("rust-actix-utils" ,rust-actix-utils-3)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-mio" ,rust-mio-0.8)
         ("rust-socket2" ,rust-socket2-0.5)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-uring" ,rust-tokio-uring-0.4)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://actix.rs")
    (synopsis
      "General purpose TCP server built for the Actix ecosystem")
    (description
      "General purpose TCP server built for the Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-router-0.5
  (package
    (name "rust-actix-router")
    (version "0.5.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-router" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "16c7lcis96plz0rl23l44wsq61jpx1bn91m23y361cfj8z9g8vyn"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytestring" ,rust-bytestring-0.1)
         ("rust-http" ,rust-http-0.2)
         ("rust-regex" ,rust-regex-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page
      "https://github.com/actix/actix-web.git")
    (synopsis "Resource path matching and router")
    (description "Resource path matching and router")
    (license (list license:expat license:asl2.0))))

(define-public rust-local-channel-0.1
  (package
    (name "rust-local-channel")
    (version "0.1.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "local-channel" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1j1ywn459kl4fdmjfyljm379k40qwwscd7mqp25lppxqd5gcijxn"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-sink" ,rust-futures-sink-0.3)
         ("rust-local-waker" ,rust-local-waker-0.1))))
    (home-page "https://github.com/actix/actix-net")
    (synopsis
      "A non-threadsafe multi-producer, single-consumer, futures-aware, FIFO queue")
    (description
      "This package provides a non-threadsafe multi-producer, single-consumer,\nfutures-aware, FIFO queue")
    (license (list license:expat license:asl2.0))))

(define-public rust-h2-0.3
  (package
    (name "rust-h2")
    (version "0.3.22")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "h2" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0y41jlflvw8niifdirgng67zdmic62cjf5m2z69hzrpn5qr50qjd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytes" ,rust-bytes-1)
         ("rust-fnv" ,rust-fnv-1)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-sink" ,rust-futures-sink-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-indexmap" ,rust-indexmap-2)
         ("rust-slab" ,rust-slab-0.4)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/hyperium/h2")
    (synopsis "An HTTP/2 client and server")
    (description "An HTTP/2 client and server")
    (license license:expat)))

(define-public rust-bytestring-1
  (package
    (name "rust-bytestring")
    (version "1.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "bytestring" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0wpf0c5c72x3ycdb85vznkmcy8fy6ckzd512064dyabbx81h5n3l"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytes" ,rust-bytes-1)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://actix.rs")
    (synopsis
      "A UTF-8 encoded read-only string using `Bytes` as storage")
    (description
      "This package provides a UTF-8 encoded read-only string using `Bytes` as storage")
    (license (list license:expat license:asl2.0))))

(define-public rust-tokio-rustls-0.24
  (package
    (name "rust-tokio-rustls")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tokio-rustls" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "10bhibg57mqir7xjhb2xmf24xgfpx6fzpyw720a4ih8a737jg0y2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-rustls" ,rust-rustls-0.21)
         ("rust-tokio" ,rust-tokio-1))))
    (home-page
      "https://github.com/rustls/tokio-rustls")
    (synopsis
      "Asynchronous TLS/SSL streams for Tokio using Rustls.")
    (description
      "Asynchronous TLS/SSL streams for Tokio using Rustls.")
    (license (list license:expat license:asl2.0))))

(define-public rust-untrusted-0.9
  (package
    (name "rust-untrusted")
    (version "0.9.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "untrusted" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ha7ib98vkc538x0z60gfn0fc5whqdd85mb87dvisdcaifi6vjwf"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/briansmith/untrusted")
    (synopsis
      "Safe, fast, zero-panic, zero-crashing, zero-allocation parsing of untrusted inputs in Rust.")
    (description
      "Safe, fast, zero-panic, zero-crashing, zero-allocation parsing of untrusted\ninputs in Rust.")
    (license license:isc)))

(define-public rust-ring-0.17
  (package
    (name "rust-ring")
    (version "0.17.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ring" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0x5vvsp2424vll571xx085qf4hzljmwpz4x8n9l0j1c3akb67338"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cc" ,rust-cc-1)
         ("rust-getrandom" ,rust-getrandom-0.2)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-spin" ,rust-spin-0.9)
         ("rust-untrusted" ,rust-untrusted-0.9)
         ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page "https://github.com/briansmith/ring")
    (synopsis "Safe, fast, small crypto using Rust.")
    (description
      "Safe, fast, small crypto using Rust.")
    (license license:gpl3)))

(define-public rust-rustls-webpki-0.101
  (package
    (name "rust-rustls-webpki")
    (version "0.101.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rustls-webpki" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0rapfhpkqp75552i8r0y7f4vq7csb4k7gjjans0df73sxv8paqlb"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ring" ,rust-ring-0.17)
         ("rust-untrusted" ,rust-untrusted-0.9))))
    (home-page "https://github.com/rustls/webpki")
    (synopsis
      "Web PKI X.509 Certificate Verification.")
    (description
      "Web PKI X.509 Certificate Verification.")
    (license license:isc)))

(define-public rust-impl-more-0.1
  (package
    (name "rust-impl-more")
    (version "0.1.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "impl-more" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0bdv06br4p766rcgihhjwqyz8fcz31xyaq14rr53vfh3kifafv10"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/robjtede/impl-more")
    (synopsis
      "Concise, declarative trait implementation macros")
    (description
      "Concise, declarative trait implementation macros")
    (license (list license:expat license:asl2.0))))

(define-public rust-local-waker-0.1
  (package
    (name "rust-local-waker")
    (version "0.1.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "local-waker" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "11vlcm8q6dhdf0srkgjnwca48dn9zcz820fq20hv82ffcxy3v1sd"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/actix/actix-net")
    (synopsis
      "A synchronization primitive for thread-local task wakeup")
    (description
      "This package provides a synchronization primitive for thread-local task wakeup")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-utils-3
  (package
    (name "rust-actix-utils")
    (version "3.0.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-utils" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1n05nzwdkx6jhmzr6f9qsh57a8hqlwv5rjz1i0j3qvj6y7gxr8c8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-local-waker" ,rust-local-waker-0.1)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page "https://github.com/actix/actix-net")
    (synopsis
      "Various utilities used in the Actix ecosystem")
    (description
      "Various utilities used in the Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-tls-3
  (package
    (name "rust-actix-tls")
    (version "3.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-tls" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hzgw3rl8jl9mf6ck687dl1n0npz93x7fihnyg39kan0prznwqbj"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-actix-rt" ,rust-actix-rt-2)
         ("rust-actix-service" ,rust-actix-service-2)
         ("rust-actix-utils" ,rust-actix-utils-3)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-impl-more" ,rust-impl-more-0.1)
         ("rust-openssl" ,rust-openssl-0.10)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-rustls" ,rust-rustls-0.21)
         ("rust-rustls-webpki" ,rust-rustls-webpki-0.101)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-native-tls"
          ,rust-tokio-native-tls-0.3)
         ("rust-tokio-openssl" ,rust-tokio-openssl-0.6)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.23)
         ("rust-tokio-rustls" ,rust-tokio-rustls-0.24)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-webpki-roots" ,rust-webpki-roots-0.25)
         ("rust-webpki-roots" ,rust-webpki-roots-0.22))))
    (home-page
      "https://github.com/actix/actix-net.git")
    (synopsis
      "TLS acceptor and connector services for Actix ecosystem")
    (description
      "TLS acceptor and connector services for Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-service-2
  (package
    (name "rust-actix-service")
    (version "2.0.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-service" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0fipjcc5kma7j47jfrw55qm09dakgvx617jbriydrkqqz10lk29v"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-paste" ,rust-paste-1)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page "https://github.com/actix/actix-net")
    (synopsis
      "Service trait and combinators for representing asynchronous request/response operations.")
    (description
      "Service trait and combinators for representing asynchronous request/response\noperations.")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-http-3
  (package
    (name "rust-actix-http")
    (version "3.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-http" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1j8v6pc0l0093wwz6mbhgsd7rn367r9hzhgpwiv3z86bk5bzhbm9"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-actix-codec" ,rust-actix-codec-0.5)
         ("rust-actix-rt" ,rust-actix-rt-2)
         ("rust-actix-service" ,rust-actix-service-2)
         ("rust-actix-tls" ,rust-actix-tls-3)
         ("rust-actix-utils" ,rust-actix-utils-3)
         ("rust-ahash" ,rust-ahash-0.8)
         ("rust-base64" ,rust-base64-0.21)
         ("rust-bitflags" ,rust-bitflags-2)
         ("rust-brotli" ,rust-brotli-3)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-bytestring" ,rust-bytestring-1)
         ("rust-derive-more" ,rust-derive-more-0.99)
         ("rust-encoding-rs" ,rust-encoding-rs-0.8)
         ("rust-flate2" ,rust-flate2-1)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-h2" ,rust-h2-0.3)
         ("rust-http" ,rust-http-0.2)
         ("rust-httparse" ,rust-httparse-1)
         ("rust-httpdate" ,rust-httpdate-1)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-language-tags" ,rust-language-tags-0.3)
         ("rust-local-channel" ,rust-local-channel-0.1)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-sha1" ,rust-sha1-0.10)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-zstd" ,rust-zstd-0.12))))
    (home-page "https://actix.rs")
    (synopsis
      "HTTP primitives for the Actix ecosystem")
    (description
      "HTTP primitives for the Actix ecosystem")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-codec-0.5
  (package
    (name "rust-actix-codec")
    (version "0.5.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-codec" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1f749khww3p9a1kw4yzf4w4l1xlylky2bngar7cf2zskwdl84yk1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-sink" ,rust-futures-sink-0.3)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-util" ,rust-tokio-util-0.7)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page "https://github.com/actix/actix-net")
    (synopsis
      "Codec utilities for working with framed protocols")
    (description
      "Codec utilities for working with framed protocols")
    (license (list license:expat license:asl2.0))))

(define-public rust-actix-web-4
  (package
    (name "rust-actix-web")
    (version "4.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "actix-web" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1fb2yhd09kjabwz5qnic55hfp33ifkw5rikp9b4shg3055g5njhf"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-actix-codec" ,rust-actix-codec-0.5)
         ("rust-actix-http" ,rust-actix-http-3)
         ("rust-actix-macros" ,rust-actix-macros-0.2)
         ("rust-actix-router" ,rust-actix-router-0.5)
         ("rust-actix-rt" ,rust-actix-rt-2)
         ("rust-actix-server" ,rust-actix-server-2)
         ("rust-actix-service" ,rust-actix-service-2)
         ("rust-actix-tls" ,rust-actix-tls-3)
         ("rust-actix-utils" ,rust-actix-utils-3)
         ("rust-actix-web-codegen"
          ,rust-actix-web-codegen-4)
         ("rust-ahash" ,rust-ahash-0.8)
         ("rust-bytes" ,rust-bytes-1)
         ("rust-bytestring" ,rust-bytestring-1)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-cookie" ,rust-cookie-0.16)
         ("rust-derive-more" ,rust-derive-more-0.99)
         ("rust-encoding-rs" ,rust-encoding-rs-0.8)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-itoa" ,rust-itoa-1)
         ("rust-language-tags" ,rust-language-tags-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-mime" ,rust-mime-0.3)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-regex" ,rust-regex-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-serde-urlencoded"
          ,rust-serde-urlencoded-0.7)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-socket2" ,rust-socket2-0.5)
         ("rust-time" ,rust-time-0.3)
         ("rust-url" ,rust-url-2))))
    (home-page "https://actix.rs")
    (synopsis
      "Actix Web is a powerful, pragmatic, and extremely fast web framework for Rust")
    (description
      "Actix Web is a powerful, pragmatic, and extremely fast web framework for Rust")
    (license (list license:expat license:asl2.0))))

(define-public rust-rust-embed-8
  (package
    (name "rust-rust-embed")
    (version "8.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rust-embed" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0y33xdjqgsda1y7rv5zyqw3j2pwhg6q4pfg3310kv1d0ljl980l1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-actix-web" ,rust-actix-web-4)
         ("rust-axum" ,rust-axum-0.6)
         ("rust-hex" ,rust-hex-0.4)
         ("rust-include-flate" ,rust-include-flate-0.2)
         ("rust-mime-guess" ,rust-mime-guess-2)
         ("rust-poem" ,rust-poem-1)
         ("rust-rocket" ,rust-rocket-0.5)
         ("rust-rust-embed-impl" ,rust-rust-embed-impl-8)
         ("rust-rust-embed-utils"
          ,rust-rust-embed-utils-8)
         ("rust-salvo" ,rust-salvo-0.16)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-walkdir" ,rust-walkdir-2)
         ("rust-warp" ,rust-warp-0.3))))
    (home-page
      "https://github.com/pyros2097/rust-embed")
    (synopsis
      "Rust Custom Derive Macro which loads files into the rust binary at compile time during release and loads the file from the fs during dev")
    (description
      "Rust Custom Derive Macro which loads files into the rust binary at compile time\nduring release and loads the file from the fs during dev")
    (license license:expat)))

(define-public rust-i18n-config-0.4
  (package
    (name "rust-i18n-config")
    (version "0.4.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "i18n-config" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0h3ndvkk4ws2jgkrk6wnbpc6l7xmnlr1ycxr49dzs8dwik2f770c"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-log" ,rust-log-0.4)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-derive" ,rust-serde-derive-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-toml" ,rust-toml-0.8)
         ("rust-unic-langid" ,rust-unic-langid-0.9))))
    (home-page
      "https://github.com/kellpossible/cargo-i18n/tree/master/i18n-config")
    (synopsis
      "This library contains the configuration stucts (along with their parsing functions) for the cargo-i18n tool/system.")
    (description
      "This library contains the configuration stucts (along with their parsing\nfunctions) for the cargo-i18n tool/system.")
    (license license:expat)))

(define-public rust-find-crate-0.6
  (package
    (name "rust-find-crate")
    (version "0.6.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "find-crate" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ljpkh11gj7940xwz47xjhsvfbl93c2q0ql7l2v0w77amjx8paar"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-toml" ,rust-toml-0.5))))
    (home-page
      "https://github.com/taiki-e/find-crate")
    (synopsis
      "Find the crate name from the current Cargo.toml.\n")
    (description
      "Find the crate name from the current Cargo.toml.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-i18n-embed-impl-0.8
  (package
    (name "rust-i18n-embed-impl")
    (version "0.8.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "i18n-embed-impl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0n5ai88c34q7mnn11faxp8izs9k1cx2k3zl2cm0mjbv7053kq2c1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-find-crate" ,rust-find-crate-0.6)
         ("rust-i18n-config" ,rust-i18n-config-0.4)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/kellpossible/cargo-i18n/tree/master/i18n-embed")
    (synopsis "Macro implementations for i18n-embed")
    (description
      "Macro implementations for i18n-embed")
    (license license:expat)))

(define-public rust-gettext-0.4
  (package
    (name "rust-gettext")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gettext" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0wd9kfy7nmbrqx2znw186la99as8y265lvh3pvj9fn9xfm75kfwy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-byteorder" ,rust-byteorder-1)
         ("rust-encoding" ,rust-encoding-0.2))))
    (home-page "https://github.com/justinas/gettext")
    (synopsis
      "An implementation of Gettext translation framework for Rust")
    (description
      "An implementation of Gettext translation framework for Rust")
    (license license:expat)))

(define-public rust-fluent-pseudo-0.3
  (package
    (name "rust-fluent-pseudo")
    (version "0.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fluent-pseudo" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0byldssmzjdmynbh1yvdrxcj0xmhqznlmmgwnh8a1fhla7wn5vgx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-regex" ,rust-regex-1))))
    (home-page "http://www.projectfluent.org")
    (synopsis
      "Pseudolocalization transformation API for use with Project Fluent API.\n")
    (description
      "Pseudolocalization transformation API for use with Project Fluent API.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-self-cell-0.10
  (package
    (name "rust-self-cell")
    (version "0.10.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "self_cell" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0pci3zh23b7dg6jmlxbn8k4plb7hcg5jprd1qiz0rp04p1ilskp1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-self-cell" ,rust-self-cell-1))))
    (home-page
      "https://github.com/Voultapher/self_cell")
    (synopsis
      "Safe-to-use proc-macro-free self-referential structs in stable Rust.")
    (description
      "Safe-to-use proc-macro-free self-referential structs in stable Rust.")
    (license license:asl2.0)))

(define-public rust-intl-pluralrules-7
  (package
    (name "rust-intl-pluralrules")
    (version "7.0.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "intl_pluralrules" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0wprd3h6h8nfj62d8xk71h178q7zfn3srxm787w4sawsqavsg3h7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-unic-langid" ,rust-unic-langid-0.9))))
    (home-page
      "https://github.com/zbraniecki/pluralrules")
    (synopsis
      "Unicode Plural Rules categorizer for numeric input.")
    (description
      "Unicode Plural Rules categorizer for numeric input.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-type-map-0.4
  (package
    (name "rust-type-map")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "type-map" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ilsqq7pcl3k9ggxv2x5fbxxfd6x7ljsndrhc38jmjwnbr63dlxn"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-rustc-hash" ,rust-rustc-hash-1))))
    (home-page "https://github.com/kardeiz/type-map")
    (synopsis
      "Provides a typemap container with FxHashMap")
    (description
      "This package provides a typemap container with @code{FxHashMap}")
    (license (list license:expat license:asl2.0))))

(define-public rust-intl-memoizer-0.5
  (package
    (name "rust-intl-memoizer")
    (version "0.5.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "intl-memoizer" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0vx6cji8ifw77zrgipwmvy1i3v43dcm58hwjxpb1h29i98z46463"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-type-map" ,rust-type-map-0.4)
         ("rust-unic-langid" ,rust-unic-langid-0.9))))
    (home-page "http://www.projectfluent.org")
    (synopsis
      "A memoizer specifically tailored for storing lazy-initialized\nintl formatters.\n")
    (description
      "This package provides a memoizer specifically tailored for storing\nlazy-initialized intl formatters.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-fluent-syntax-0.11
  (package
    (name "rust-fluent-syntax")
    (version "0.11.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fluent-syntax" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0y6ac7z7sbv51nsa6km5z8rkjj4nvqk91vlghq1ck5c3cjbyvay0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "http://www.projectfluent.org")
    (synopsis
      "Parser/Serializer tools for Fluent Syntax. \n")
    (description
      "Parser/Serializer tools for Fluent Syntax.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-unic-langid-macros-impl-0.9
  (package
    (name "rust-unic-langid-macros-impl")
    (version "0.9.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unic-langid-macros-impl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1r0828l6h5p44b7ln8sjrsxl4dhyv4nmwszna75b6kzb1p4a98py"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-hack"
          ,rust-proc-macro-hack-0.5)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-unic-langid-impl"
          ,rust-unic-langid-impl-0.9))))
    (home-page
      "https://github.com/zbraniecki/unic-locale")
    (synopsis
      "API for managing Unicode Language Identifiers")
    (description
      "API for managing Unicode Language Identifiers")
    (license (list license:expat license:asl2.0))))

(define-public rust-unic-langid-macros-0.9
  (package
    (name "rust-unic-langid-macros")
    (version "0.9.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unic-langid-macros" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1v435dsl1412x6dv41q92ijz0fhvmp5nlq6f21j83wigp3plr1aw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-hack"
          ,rust-proc-macro-hack-0.5)
         ("rust-tinystr" ,rust-tinystr-0.7)
         ("rust-unic-langid-impl"
          ,rust-unic-langid-impl-0.9)
         ("rust-unic-langid-macros-impl"
          ,rust-unic-langid-macros-impl-0.9))))
    (home-page
      "https://github.com/zbraniecki/unic-locale")
    (synopsis
      "API for managing Unicode Language Identifiers")
    (description
      "API for managing Unicode Language Identifiers")
    (license (list license:expat license:asl2.0))))

(define-public rust-zerovec-derive-0.10
  (package
    (name "rust-zerovec-derive")
    (version "0.10.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zerovec-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "081clqqn1girazr4ma1kplg7xr05989fbw7i1rar12gmrfbmjkkv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis "Custom derive for the zerovec crate")
    (description
      "Custom derive for the zerovec crate")
    (license license:gpl3)))

(define-public rust-zerofrom-derive-0.1
  (package
    (name "rust-zerofrom-derive")
    (version "0.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zerofrom-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hqq5xw5a55623313p2gs9scbn24kqhvgrn2wvr75lvi0i8lg9p6"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-synstructure" ,rust-synstructure-0.13))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis "Custom derive for the zerofrom crate")
    (description
      "Custom derive for the zerofrom crate")
    (license license:gpl3)))

(define-public rust-zerofrom-0.1
  (package
    (name "rust-zerofrom")
    (version "0.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zerofrom" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1dq5dmls0gdlbxgzvh56754k0wq7ch60flbq97g9mcf0qla0hnv5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-zerofrom-derive"
          ,rust-zerofrom-derive-0.1))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis "ZeroFrom trait for constructing")
    (description
      "@code{ZeroFrom} trait for constructing")
    (license license:gpl3)))

(define-public rust-yoke-derive-0.7
  (package
    (name "rust-yoke-derive")
    (version "0.7.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "yoke-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1f52qcg6vmqh9l1wfa8i32hccmpmpq8ml90w4250jn74rkq3cscy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-synstructure" ,rust-synstructure-0.13))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis "Custom derive for the yoke crate")
    (description "Custom derive for the yoke crate")
    (license license:gpl3)))

(define-public rust-yoke-0.7
  (package
    (name "rust-yoke")
    (version "0.7.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "yoke" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1r07zy718h27qjhpk4427imp3wx5z2wf4wf6jivlczr89wp1prv5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1)
         ("rust-stable-deref-trait"
          ,rust-stable-deref-trait-1)
         ("rust-yoke-derive" ,rust-yoke-derive-0.7)
         ("rust-zerofrom" ,rust-zerofrom-0.1))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis
      "Abstraction allowing borrowed data to be carried along with the backing data it borrows from")
    (description
      "Abstraction allowing borrowed data to be carried along with the backing data it\nborrows from")
    (license license:gpl3)))

(define-public rust-t1ha-0.1
  (package
    (name "rust-t1ha")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "t1ha" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1k4w9fc3wkxq67sicj1q44gmjh5fajx332536ln4wm0smr8sli7s"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cfg-if" ,rust-cfg-if-0.1)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-num-traits" ,rust-num-traits-0.2)
         ("rust-rustc-version" ,rust-rustc-version-0.2))))
    (home-page "https://github.com/flier/rust-t1ha")
    (synopsis
      "An implementation of the T1AH (Fast Positive Hash) hash function.")
    (description
      "An implementation of the T1AH (Fast Positive Hash) hash function.")
    (license license:zlib)))

(define-public rust-zerovec-0.10
  (package
    (name "rust-zerovec")
    (version "0.10.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zerovec" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1si71vdxv648pjjzifdddrzd46zmvgrg64mwi8mwgd8zx6d47x7g"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-databake" ,rust-databake-0.1)
         ("rust-serde" ,rust-serde-1)
         ("rust-t1ha" ,rust-t1ha-0.1)
         ("rust-yoke" ,rust-yoke-0.7)
         ("rust-zerofrom" ,rust-zerofrom-0.1)
         ("rust-zerovec-derive" ,rust-zerovec-derive-0.10))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis
      "Zero-copy vector backed by a byte array")
    (description
      "Zero-copy vector backed by a byte array")
    (license license:gpl3)))

(define-public rust-synstructure-0.13
  (package
    (name "rust-synstructure")
    (version "0.13.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "synstructure" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "01jvj55fxgqa69sp1j9mma09p9vj6zwcvyvh8am81b1zfc7ahnr8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-unicode-xid" ,rust-unicode-xid-0.2))))
    (home-page
      "https://github.com/mystor/synstructure")
    (synopsis
      "Helper methods and macros for custom derives")
    (description
      "Helper methods and macros for custom derives")
    (license license:expat)))

(define-public rust-databake-derive-0.1
  (package
    (name "rust-databake-derive")
    (version "0.1.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "databake-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0hqsjizibp0bb5m4kiqk9g2gixywqlxn513w5a366dpjv20z4yip"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2)
         ("rust-synstructure" ,rust-synstructure-0.13))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis "Custom derive for the databake crate")
    (description
      "Custom derive for the databake crate")
    (license license:gpl3)))

(define-public rust-databake-0.1
  (package
    (name "rust-databake")
    (version "0.1.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "databake" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0flmvn7ym0sz6mkh5mg08vcbxa6kjiknhj9bpspww54lwrr5s5w2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-databake-derive"
          ,rust-databake-derive-0.1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis
      "Trait that lets structs represent themselves as (const) Rust expressions")
    (description
      "Trait that lets structs represent themselves as (const) Rust expressions")
    (license license:gpl3)))

(define-public rust-tinystr-0.7
  (package
    (name "rust-tinystr")
    (version "0.7.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tinystr" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1khf3j95bwwksj2hw76nlvwlwpwi4d1j421lj6x35arqqprjph43"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-databake" ,rust-databake-0.1)
         ("rust-displaydoc" ,rust-displaydoc-0.2)
         ("rust-serde" ,rust-serde-1)
         ("rust-zerovec" ,rust-zerovec-0.10))))
    (home-page
      "https://github.com/unicode-org/icu4x")
    (synopsis
      "A small ASCII-only bounded length string representation.")
    (description
      "This package provides a small ASCII-only bounded length string representation.")
    (license license:gpl3)))

(define-public rust-unic-langid-impl-0.9
  (package
    (name "rust-unic-langid-impl")
    (version "0.9.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unic-langid-impl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ijvqmsrg6qw3b1h9bh537pvwk2jn2kl6ck3z3qlxspxcch5mmab"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1)
         ("rust-serde-json" ,rust-serde-json-1)
         ("rust-tinystr" ,rust-tinystr-0.7))))
    (home-page
      "https://github.com/zbraniecki/unic-locale")
    (synopsis
      "API for managing Unicode Language Identifiers")
    (description
      "API for managing Unicode Language Identifiers")
    (license (list license:expat license:asl2.0))))

(define-public rust-unic-langid-0.9
  (package
    (name "rust-unic-langid")
    (version "0.9.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unic-langid" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "05pm5p3j29c9jw9a4dr3v64g3x6g3zh37splj47i7vclszk251r3"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-unic-langid-impl"
          ,rust-unic-langid-impl-0.9)
         ("rust-unic-langid-macros"
          ,rust-unic-langid-macros-0.9))))
    (home-page
      "https://github.com/zbraniecki/unic-locale")
    (synopsis
      "API for managing Unicode Language Identifiers")
    (description
      "API for managing Unicode Language Identifiers")
    (license (list license:expat license:asl2.0))))

(define-public rust-fluent-langneg-0.13
  (package
    (name "rust-fluent-langneg")
    (version "0.13.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fluent-langneg" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "152yxplc11vmxkslvmaqak9x86xnavnhdqyhrh38ym37jscd0jic"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-unic-langid" ,rust-unic-langid-0.9))))
    (home-page "http://projectfluent.org/")
    (synopsis
      "A library for language and locale negotiation.\n")
    (description
      "This package provides a library for language and locale negotiation.")
    (license license:asl2.0)))

(define-public rust-fluent-bundle-0.15
  (package
    (name "rust-fluent-bundle")
    (version "0.15.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fluent-bundle" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1zbzm13rfz7fay7bps7jd4j1pdnlxmdzzfymyq2iawf9vq0wchp2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-fluent-langneg" ,rust-fluent-langneg-0.13)
         ("rust-fluent-syntax" ,rust-fluent-syntax-0.11)
         ("rust-intl-memoizer" ,rust-intl-memoizer-0.5)
         ("rust-intl-pluralrules"
          ,rust-intl-pluralrules-7)
         ("rust-rustc-hash" ,rust-rustc-hash-1)
         ("rust-self-cell" ,rust-self-cell-0.10)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-unic-langid" ,rust-unic-langid-0.9))))
    (home-page "http://www.projectfluent.org")
    (synopsis
      "A localization system designed to unleash the entire expressive power of\nnatural language translations.\n")
    (description
      "This package provides a localization system designed to unleash the entire\nexpressive power of natural language translations.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-fluent-0.16
  (package
    (name "rust-fluent")
    (version "0.16.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fluent" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "19s7z0gw95qdsp9hhc00xcy11nwhnx93kknjmdvdnna435w97xk1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-fluent-bundle" ,rust-fluent-bundle-0.15)
         ("rust-fluent-pseudo" ,rust-fluent-pseudo-0.3)
         ("rust-unic-langid" ,rust-unic-langid-0.9))))
    (home-page "http://www.projectfluent.org")
    (synopsis
      "A localization system designed to unleash the entire expressive power of\nnatural language translations.\n")
    (description
      "This package provides a localization system designed to unleash the entire\nexpressive power of natural language translations.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-i18n-embed-0.14
  (package
    (name "rust-i18n-embed")
    (version "0.14.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "i18n-embed" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17251vazz8mybcgic9wffk56acv5i5zsg3x9kvdvjnsgfsams84l"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arc-swap" ,rust-arc-swap-1)
         ("rust-fluent" ,rust-fluent-0.16)
         ("rust-fluent-langneg" ,rust-fluent-langneg-0.13)
         ("rust-fluent-syntax" ,rust-fluent-syntax-0.11)
         ("rust-gettext" ,rust-gettext-0.4)
         ("rust-i18n-embed-impl"
          ,rust-i18n-embed-impl-0.8)
         ("rust-intl-memoizer" ,rust-intl-memoizer-0.5)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-locale-config" ,rust-locale-config-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-rust-embed" ,rust-rust-embed-8)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-tr" ,rust-tr-0.1)
         ("rust-unic-langid" ,rust-unic-langid-0.9)
         ("rust-walkdir" ,rust-walkdir-2)
         ("rust-web-sys" ,rust-web-sys-0.3))))
    (home-page
      "https://github.com/kellpossible/cargo-i18n/tree/master/i18n-embed")
    (synopsis
      "Traits and macros to conveniently embed localization assets into your application binary or library in order to localize it at runtime.")
    (description
      "Traits and macros to conveniently embed localization assets into your\napplication binary or library in order to localize it at runtime.")
    (license license:expat)))

(define-public rust-egui-plot-0.24
  (package
    (name "rust-egui-plot")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "egui_plot" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1lmr7qrfn1dcfliiah3bxfi1ynfpkfbyfsi64lcb8z8rvpf2wyxk"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-egui" ,rust-egui-0.24)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/emilk/egui")
    (synopsis
      "Immediate mode plotting for the egui GUI library")
    (description
      "Immediate mode plotting for the egui GUI library")
    (license (list license:expat license:asl2.0))))

(define-public rust-pollster-macro-0.1
  (package
    (name "rust-pollster-macro")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pollster-macro" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "00fk326pj6pam402ygh2srs13bbjnnyfck41155ml1ck87pz0y7a"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-1))))
    (home-page
      "https://github.com/zesterer/pollster")
    (synopsis "Proc-macro crate for pollster")
    (description "Proc-macro crate for pollster")
    (license (list license:asl2.0 license:expat))))

(define-public rust-pollster-0.3
  (package
    (name "rust-pollster")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pollster" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1wn73ljx1pcb4p69jyiz206idj7nkfqknfvdhp64yaphhm3nys12"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-pollster-macro" ,rust-pollster-macro-0.1))))
    (home-page
      "https://github.com/zesterer/pollster")
    (synopsis
      "Synchronously block the thread until a future completes")
    (description
      "Synchronously block the thread until a future completes")
    (license (list license:asl2.0 license:expat))))

(define-public rust-glutin-winit-0.3
  (package
    (name "rust-glutin-winit")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "glutin-winit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "194gb38qqi3119fldk1vw9qv7mxwfcvw15wgzq5q6qj0q0zqg6k2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cfg-aliases" ,rust-cfg-aliases-0.1)
         ("rust-glutin" ,rust-glutin-0.30)
         ("rust-raw-window-handle"
          ,rust-raw-window-handle-0.5)
         ("rust-winit" ,rust-winit-0.28))))
    (home-page
      "https://github.com/rust-windowing/glutin")
    (synopsis
      "Glutin bootstrapping helpers with winit")
    (description
      "Glutin bootstrapping helpers with winit")
    (license license:expat)))

(define-public rust-glow-0.12
  (package
    (name "rust-glow")
    (version "0.12.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "glow" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0a1p6c9nff09m4gn0xnnschcpjq35y7c12w69ar8l2mnwj0fa3ya"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-slotmap" ,rust-slotmap-1)
         ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
         ("rust-web-sys" ,rust-web-sys-0.3))))
    (home-page
      "https://github.com/grovesNL/glow.git")
    (synopsis
      "GL on Whatever: a set of bindings to run GL (Open GL, OpenGL ES, and WebGL) anywhere, and avoid target-specific code.")
    (description
      "GL on Whatever: a set of bindings to run GL (Open GL, @code{OpenGL} ES, and\n@code{WebGL}) anywhere, and avoid target-specific code.")
    (license
      (list license:expat license:asl2.0 license:zlib))))

(define-public rust-egui-glow-0.24
  (package
    (name "rust-egui-glow")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "egui_glow" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "12fl0jd53x66v774vf86n2q6w2h5krxz4ihalh17qmbwspwm2896"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-egui" ,rust-egui-0.24)
         ("rust-egui-winit" ,rust-egui-winit-0.24)
         ("rust-glow" ,rust-glow-0.12)
         ("rust-log" ,rust-log-0.4)
         ("rust-memoffset" ,rust-memoffset-0.7)
         ("rust-puffin" ,rust-puffin-0.18)
         ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
         ("rust-web-sys" ,rust-web-sys-0.3))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/egui_glow")
    (synopsis
      "Bindings for using egui natively using the glow library")
    (description
      "Bindings for using egui natively using the glow library")
    (license (list license:expat license:asl2.0))))

(define-public rust-wayland-protocols-wlr-0.2
  (package
    (name "rust-wayland-protocols-wlr")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wayland-protocols-wlr" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1mjww9psk2nc5hm2q4s3qas30rbzfg1sb6qgw518fbbcdfvn27xd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-wayland-backend"
          ,rust-wayland-backend-0.3)
         ("rust-wayland-client" ,rust-wayland-client-0.31)
         ("rust-wayland-protocols"
          ,rust-wayland-protocols-0.31)
         ("rust-wayland-scanner"
          ,rust-wayland-scanner-0.31)
         ("rust-wayland-server" ,rust-wayland-server-0.31))))
    (home-page
      "https://github.com/smithay/wayland-rs")
    (synopsis
      "Generated API for the WLR wayland protocol extensions")
    (description
      "Generated API for the WLR wayland protocol extensions")
    (license license:expat)))

(define-public rust-io-lifetimes-2
  (package
    (name "rust-io-lifetimes")
    (version "2.0.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "io-lifetimes" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1373iwawish51r5dbd7fav1hp89idk30wkmbphyrg60y8xqi6qas"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-std" ,rust-async-std-1)
         ("rust-hermit-abi" ,rust-hermit-abi-0.3)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-mio" ,rust-mio-0.8)
         ("rust-os-pipe" ,rust-os-pipe-1)
         ("rust-socket2" ,rust-socket2-0.5)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-windows-sys" ,rust-windows-sys-0.52))))
    (home-page
      "https://github.com/sunfishcode/io-lifetimes")
    (synopsis
      "A low-level I/O ownership and borrowing library")
    (description
      "This package provides a low-level I/O ownership and borrowing library")
    (license
      (list license:asl2.0
            license:gpl3
            license:asl2.0
            license:expat))))

(define-public rust-wayland-server-0.31
  (package
    (name "rust-wayland-server")
    (version "0.31.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wayland-server" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1kmiii32hi7h3r9q923q628rrbglkjkg362c32hnr4s5li90qgrz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-downcast-rs" ,rust-downcast-rs-1)
         ("rust-io-lifetimes" ,rust-io-lifetimes-2)
         ("rust-log" ,rust-log-0.4)
         ("rust-nix" ,rust-nix-0.26)
         ("rust-wayland-backend"
          ,rust-wayland-backend-0.3)
         ("rust-wayland-scanner"
          ,rust-wayland-scanner-0.31))))
    (home-page
      "https://github.com/smithay/wayland-rs")
    (synopsis
      "Bindings to the standard C implementation of the wayland protocol, server side.")
    (description
      "Bindings to the standard C implementation of the wayland protocol, server side.")
    (license license:expat)))

(define-public rust-wayland-protocols-0.31
  (package
    (name "rust-wayland-protocols")
    (version "0.31.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wayland-protocols" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "077257bxv21whi33wm0lz5jkq6jnx0spz5jkq8yr44x9gc8dflz2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-wayland-backend"
          ,rust-wayland-backend-0.3)
         ("rust-wayland-client" ,rust-wayland-client-0.31)
         ("rust-wayland-scanner"
          ,rust-wayland-scanner-0.31)
         ("rust-wayland-server" ,rust-wayland-server-0.31))))
    (home-page
      "https://github.com/smithay/wayland-rs")
    (synopsis
      "Generated API for the officials wayland protocol extensions")
    (description
      "Generated API for the officials wayland protocol extensions")
    (license license:expat)))

(define-public rust-quick-xml-0.30
  (package
    (name "rust-quick-xml")
    (version "0.30.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "quick-xml" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0mp9cqy06blsaka3r1n2p40ddmzhsf7bx37x22r5faw6hq753xpg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arbitrary" ,rust-arbitrary-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-encoding-rs" ,rust-encoding-rs-0.8)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-serde" ,rust-serde-1)
         ("rust-tokio" ,rust-tokio-1))))
    (home-page "https://github.com/tafia/quick-xml")
    (synopsis
      "High performance xml reader and writer")
    (description
      "High performance xml reader and writer")
    (license license:expat)))

(define-public rust-wayland-scanner-0.31
  (package
    (name "rust-wayland-scanner")
    (version "0.31.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wayland-scanner" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1760n887j18lzd1ni087q7jzsmpcf7ny3dq2698zkjb56r02i3pv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quick-xml" ,rust-quick-xml-0.30)
         ("rust-quote" ,rust-quote-1))))
    (home-page
      "https://github.com/smithay/wayland-rs")
    (synopsis
      "Wayland Scanner for generating rust APIs from XML wayland protocol files.")
    (description
      "Wayland Scanner for generating rust APIs from XML wayland protocol files.")
    (license license:expat)))

(define-public rust-wayland-client-0.31
  (package
    (name "rust-wayland-client")
    (version "0.31.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wayland-client" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1lryhibzmi4hb3jpbraj623l110f6rgp0migpxrm8vrl8wixb9qw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-log" ,rust-log-0.4)
         ("rust-nix" ,rust-nix-0.26)
         ("rust-wayland-backend"
          ,rust-wayland-backend-0.3)
         ("rust-wayland-scanner"
          ,rust-wayland-scanner-0.31))))
    (home-page
      "https://github.com/smithay/wayland-rs")
    (synopsis
      "Bindings to the standard C implementation of the wayland protocol, client side.")
    (description
      "Bindings to the standard C implementation of the wayland protocol, client side.")
    (license license:expat)))

(define-public rust-dlib-0.5
  (package
    (name "rust-dlib")
    (version "0.5.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "dlib" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "04m4zzybx804394dnqs1blz241xcy480bdwf3w9p4k6c3l46031k"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libloading" ,rust-libloading-0.8))))
    (home-page "https://github.com/elinorbgr/dlib")
    (synopsis
      "Helper macros for handling manually loading optional system libraries.")
    (description
      "Helper macros for handling manually loading optional system libraries.")
    (license license:expat)))

(define-public rust-wayland-sys-0.31
  (package
    (name "rust-wayland-sys")
    (version "0.31.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wayland-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1bxpwamgagpxa8p9m798gd3g6rwj2m4sbdvc49zx05jjzzmci80m"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-dlib" ,rust-dlib-0.5)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-log" ,rust-log-0.4)
         ("rust-memoffset" ,rust-memoffset-0.9)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-pkg-config" ,rust-pkg-config-0.3))))
    (home-page
      "https://github.com/smithay/wayland-rs")
    (synopsis
      "FFI bindings to the various libwayland-*.so libraries. You should only need this crate if you are working on custom wayland protocol extensions. Look at the crate wayland-client for usable bindings.")
    (description
      "FFI bindings to the various libwayland-*.so libraries.  You should only need\nthis crate if you are working on custom wayland protocol extensions.  Look at\nthe crate wayland-client for usable bindings.")
    (license license:expat)))

(define-public rust-wayland-backend-0.3
  (package
    (name "rust-wayland-backend")
    (version "0.3.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wayland-backend" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1r7vz56z6ixfbljraxl4q59g43jfb6i9qkaksi704pzlfgfjs58r"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cc" ,rust-cc-1)
         ("rust-downcast-rs" ,rust-downcast-rs-1)
         ("rust-log" ,rust-log-0.4)
         ("rust-nix" ,rust-nix-0.26)
         ("rust-raw-window-handle"
          ,rust-raw-window-handle-0.5)
         ("rust-scoped-tls" ,rust-scoped-tls-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-wayland-sys" ,rust-wayland-sys-0.31))))
    (home-page
      "https://github.com/smithay/wayland-rs")
    (synopsis
      "Low-level bindings to the Wayland protocol")
    (description
      "Low-level bindings to the Wayland protocol")
    (license license:expat)))

(define-public rust-tree-magic-db-3
  (package
    (name "rust-tree-magic-db")
    (version "3.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tree_magic_db" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "00kzsn98cv0r7yzwi2dcm0fzpbxmc7pxijhb5dgb3cr7ai5c4gz7"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "")
    (synopsis
      "Packages the FreeDesktop.org shared MIME database for optional use with tree_magic_mini")
    (description
      "Packages the @code{FreeDesktop.org} shared MIME database for optional use with\ntree_magic_mini")
    (license license:gpl2+)))

(define-public rust-tree-magic-mini-3
  (package
    (name "rust-tree-magic-mini")
    (version "3.0.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tree_magic_mini" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0vdazv3y1iggriwx5ksin72c2ds0xjdhx1yvmd5nxkya0w3gvbci"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytecount" ,rust-bytecount-0.6)
         ("rust-fnv" ,rust-fnv-1)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-nom" ,rust-nom-7)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-petgraph" ,rust-petgraph-0.6)
         ("rust-tree-magic-db" ,rust-tree-magic-db-3))))
    (home-page
      "https://github.com/mbrubeck/tree_magic/")
    (synopsis
      "Determines the MIME type of a file by traversing a filetype tree.")
    (description
      "Determines the MIME type of a file by traversing a filetype tree.")
    (license license:expat)))

(define-public rust-nix-0.26
  (package
    (name "rust-nix")
    (version "0.26.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "nix" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "06xgl4ybb8pvjrbmc3xggbgk3kbs1j0c4c0nzdfrmpbgrkrym2sr"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-memoffset" ,rust-memoffset-0.7)
         ("rust-pin-utils" ,rust-pin-utils-0.1))))
    (home-page "https://github.com/nix-rust/nix")
    (synopsis "Rust friendly bindings to *nix APIs")
    (description
      "Rust friendly bindings to *nix APIs")
    (license license:expat)))

(define-public rust-derive-new-0.5
  (package
    (name "rust-derive-new")
    (version "0.5.9")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "derive-new" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0d9m5kcj1rdmdjqfgj7rxxhdzx0as7p4rp1mjx5j6w5dl2f3461l"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/nrc/derive-new")
    (synopsis
      "`#[derive(new)]` implements simple constructor functions for structs and enums.")
    (description
      "`#[derive(new)]` implements simple constructor functions for structs and enums.")
    (license license:expat)))

(define-public rust-wl-clipboard-rs-0.8
  (package
    (name "rust-wl-clipboard-rs")
    (version "0.8.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wl-clipboard-rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ynj4d5kaicjlm23i3mbarl7csrf753kiiqmf5i0ipzafglpkbsp"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-derive-new" ,rust-derive-new-0.5)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-log" ,rust-log-0.4)
         ("rust-nix" ,rust-nix-0.26)
         ("rust-os-pipe" ,rust-os-pipe-1)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-tree-magic-mini" ,rust-tree-magic-mini-3)
         ("rust-wayland-backend"
          ,rust-wayland-backend-0.3)
         ("rust-wayland-client" ,rust-wayland-client-0.31)
         ("rust-wayland-protocols"
          ,rust-wayland-protocols-0.31)
         ("rust-wayland-protocols-wlr"
          ,rust-wayland-protocols-wlr-0.2))))
    (home-page
      "https://github.com/YaLTeR/wl-clipboard-rs")
    (synopsis
      "Access to the Wayland clipboard for terminal and other window-less applications.")
    (description
      "Access to the Wayland clipboard for terminal and other window-less applications.")
    (license (list license:expat license:asl2.0))))

(define-public rust-clipboard-win-4
  (package
    (name "rust-clipboard-win")
    (version "4.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "clipboard-win" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0qh3rypkf1lazniq4nr04hxsck0d55rigb5sjvpvgnap4dyc54bi"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-error-code" ,rust-error-code-2)
         ("rust-str-buf" ,rust-str-buf-1)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page
      "https://github.com/DoumanAsh/clipboard-win")
    (synopsis
      "Provides simple way to interact with Windows clipboard.")
    (description
      "This package provides simple way to interact with Windows clipboard.")
    (license license:boost1.0)))

(define-public rust-arboard-3
  (package
    (name "rust-arboard")
    (version "3.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "arboard" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "021w647fp6d1hy1cilysbh86wyn29aavh7accrva4nj30yqjkyxa"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-clipboard-win" ,rust-clipboard-win-4)
         ("rust-core-graphics" ,rust-core-graphics-0.22)
         ("rust-image" ,rust-image-0.24)
         ("rust-log" ,rust-log-0.4)
         ("rust-objc" ,rust-objc-0.2)
         ("rust-objc-foundation"
          ,rust-objc-foundation-0.1)
         ("rust-objc-id" ,rust-objc-id-0.1)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-winapi" ,rust-winapi-0.3)
         ("rust-wl-clipboard-rs"
          ,rust-wl-clipboard-rs-0.8)
         ("rust-x11rb" ,rust-x11rb-0.12))))
    (home-page
      "https://github.com/1Password/arboard")
    (synopsis
      "Image and text handling for the OS clipboard.")
    (description
      "Image and text handling for the OS clipboard.")
    (license (list license:expat license:asl2.0))))

(define-public rust-accesskit-windows-0.15
  (package
    (name "rust-accesskit-windows")
    (version "0.15.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "accesskit_windows" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "02sazww6l5h0wsgif0npdpkb5lczx0xph65kn31wfkwpq1zf5jmg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit" ,rust-accesskit-0.12)
         ("rust-accesskit-consumer"
          ,rust-accesskit-consumer-0.16)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-paste" ,rust-paste-1)
         ("rust-static-assertions"
          ,rust-static-assertions-1)
         ("rust-windows" ,rust-windows-0.48))))
    (home-page
      "https://github.com/AccessKit/accesskit")
    (synopsis
      "AccessKit UI accessibility infrastructure: Windows adapter")
    (description
      "@code{AccessKit} UI accessibility infrastructure: Windows adapter")
    (license (list license:expat license:asl2.0))))

(define-public rust-atspi-proxies-0.3
  (package
    (name "rust-atspi-proxies")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "atspi-proxies" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0lmvfycsrach6phz1ymcg9lks8iqiy6bxp2njci7lgkhfc96d5b4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-atspi-common" ,rust-atspi-common-0.3)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-zbus" ,rust-zbus-3))))
    (home-page "https://github.com/odilia-app/atspi")
    (synopsis
      "AT-SPI2 proxies to query or manipulate UI objects")
    (description
      "AT-SPI2 proxies to query or manipulate UI objects")
    (license (list license:asl2.0 license:expat))))

(define-public rust-atspi-connection-0.3
  (package
    (name "rust-atspi-connection")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "atspi-connection" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0fdrfsgjg3d84mkk6nk3knqz0ygryfdmsn1d7c74qvgqf1ymxim0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-atspi-common" ,rust-atspi-common-0.3)
         ("rust-atspi-proxies" ,rust-atspi-proxies-0.3)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-zbus" ,rust-zbus-3))))
    (home-page
      "https://github.com/odilia-app/atspi/")
    (synopsis
      "A method of connecting, querying, sending and receiving over AT-SPI.")
    (description
      "This package provides a method of connecting, querying, sending and receiving\nover AT-SPI.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-zbus-macros-3
  (package
    (name "rust-zbus-macros")
    (version "3.14.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zbus_macros" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17dwc1vvvwxlgn78cpds72hcf7y1hxqkjnpm0zlc0y38ji57kla1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro-crate"
          ,rust-proc-macro-crate-1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-regex" ,rust-regex-1)
         ("rust-syn" ,rust-syn-1)
         ("rust-zvariant-utils" ,rust-zvariant-utils-1))))
    (home-page "https://github.com/dbus2/zbus/")
    (synopsis "proc-macros for zbus")
    (description "proc-macros for zbus")
    (license license:expat)))

(define-public rust-xdg-home-1
  (package
    (name "rust-xdg-home")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "xdg-home" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1kbd1ks8bvpsay6lgk60yaf1w13daaf75ghmslan031ss4y20s97"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-nix" ,rust-nix-0.26)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/zeenix/xdg-home")
    (synopsis
      "The user's home directory as per XDG Specification")
    (description
      "The user's home directory as per XDG Specification")
    (license license:expat)))

(define-public rust-ordered-stream-0.2
  (package
    (name "rust-ordered-stream")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ordered-stream" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0l0xxp697q7wiix1gnfn66xsss7fdhfivl2k7bvpjs4i3lgb18ls"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page
      "https://github.com/danieldg/ordered-stream")
    (synopsis
      "Streams that are ordered relative to external events")
    (description
      "Streams that are ordered relative to external events")
    (license (list license:expat license:asl2.0))))

(define-public rust-event-listener-3
  (package
    (name "rust-event-listener")
    (version "3.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "event-listener" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hihkg6ihvb6p9yi7nq11di8mhd5y0iqv81ij6h0rf0fvsy7ff6r"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-concurrent-queue"
          ,rust-concurrent-queue-2)
         ("rust-parking" ,rust-parking-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-portable-atomic" ,rust-portable-atomic-1)
         ("rust-portable-atomic-util"
          ,rust-portable-atomic-util-0.1))))
    (home-page
      "https://github.com/smol-rs/event-listener")
    (synopsis "Notify async tasks or threads")
    (description "Notify async tasks or threads")
    (license (list license:asl2.0 license:expat))))

(define-public rust-windows-x86-64-msvc-0.52
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "012wfq37f18c09ij5m6rniw7xxn5fcvrxbqd0wd8vgnl3hfn9yfz"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnullvm-0.52
  (package
    (name "rust-windows-x86-64-gnullvm")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_gnullvm" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17lllq4l2k1lqgcnw1cccphxp9vs7inq99kjlm2lfl9zklg7wr8s"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnu-0.52
  (package
    (name "rust-windows-x86-64-gnu")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_gnu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1zdy4qn178sil5sdm63lm7f0kkcjg6gvdwmcprd2yjmwn8ns6vrx"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-msvc-0.52
  (package
    (name "rust-windows-i686-msvc")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_i686_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "16kvmbvx0vr0zbgnaz6nsks9ycvfh5xp05bjrhq65kj623iyirgz"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-gnu-0.52
  (package
    (name "rust-windows-i686-gnu")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_i686_gnu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "04zkglz4p3pjsns5gbz85v4s5aw102raz4spj4b0lmm33z5kg1m2"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-msvc-0.52
  (package
    (name "rust-windows-aarch64-msvc")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_aarch64_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1vvmy1ypvzdvxn9yf0b8ygfl85gl2gpcyvsvqppsmlpisil07amv"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-gnullvm-0.52
  (package
    (name "rust-windows-aarch64-gnullvm")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_aarch64_gnullvm" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1shmn1kbdc0bpphcxz0vlph96bxz0h1jlmh93s9agf2dbpin8xyb"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-targets-0.52
  (package
    (name "rust-windows-targets")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows-targets" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1kg7a27ynzw8zz3krdgy6w5gbqcji27j1sz4p7xk2j5j8082064a"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-windows-aarch64-gnullvm"
          ,rust-windows-aarch64-gnullvm-0.52)
         ("rust-windows-aarch64-msvc"
          ,rust-windows-aarch64-msvc-0.52)
         ("rust-windows-i686-gnu"
          ,rust-windows-i686-gnu-0.52)
         ("rust-windows-i686-msvc"
          ,rust-windows-i686-msvc-0.52)
         ("rust-windows-x86-64-gnu"
          ,rust-windows-x86-64-gnu-0.52)
         ("rust-windows-x86-64-gnullvm"
          ,rust-windows-x86-64-gnullvm-0.52)
         ("rust-windows-x86-64-msvc"
          ,rust-windows-x86-64-msvc-0.52))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import libs for Windows")
    (description "Import libs for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-sys-0.52
  (package
    (name "rust-windows-sys")
    (version "0.52.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0gd3v4ji88490zgb6b5mq5zgbvwv7zx1ibn8v3x83rwcdbryaar8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-windows-targets"
          ,rust-windows-targets-0.52))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-polling-3
  (package
    (name "rust-polling")
    (version "3.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "polling" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17hwk4g8qbdsyr0kqjddhw0l2v64pxhakkdlaqbc24xk99iglqyg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-concurrent-queue"
          ,rust-concurrent-queue-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-rustix" ,rust-rustix-0.38)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-windows-sys" ,rust-windows-sys-0.52))))
    (home-page "https://github.com/smol-rs/polling")
    (synopsis
      "Portable interface to epoll, kqueue, event ports, and IOCP")
    (description
      "Portable interface to epoll, kqueue, event ports, and IOCP")
    (license (list license:asl2.0 license:expat))))

(define-public rust-parking-2
  (package
    (name "rust-parking")
    (version "2.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "parking" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1blwbkq6im1hfxp5wlbr475mw98rsyc0bbr2d5n16m38z253p0dv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-loom" ,rust-loom-0.7))))
    (home-page "https://github.com/smol-rs/parking")
    (synopsis "Thread parking and unparking")
    (description "Thread parking and unparking")
    (license (list license:asl2.0 license:expat))))

(define-public rust-futures-lite-2
  (package
    (name "rust-futures-lite")
    (version "2.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "futures-lite" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0hw1mp3y1i7xfid032c1ygx5vsadsp965wh06zpypxw331x2dvmf"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-fastrand" ,rust-fastrand-2)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-parking" ,rust-parking-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page
      "https://github.com/smol-rs/futures-lite")
    (synopsis
      "Futures, streams, and async I/O combinators")
    (description
      "Futures, streams, and async I/O combinators")
    (license (list license:asl2.0 license:expat))))

(define-public rust-async-lock-3
  (package
    (name "rust-async-lock")
    (version "3.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-lock" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "031i8kx440v77cvr3lp4a5dcjdz92zpi4616akfvjgfmhwky89bi"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-event-listener" ,rust-event-listener-4)
         ("rust-event-listener-strategy"
          ,rust-event-listener-strategy-0.4)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page
      "https://github.com/smol-rs/async-lock")
    (synopsis "Async synchronization primitives")
    (description "Async synchronization primitives")
    (license (list license:asl2.0 license:expat))))

(define-public rust-async-io-2
  (package
    (name "rust-async-io")
    (version "2.2.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-io" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1iycg22ij8c1c87znvrpm8hfvb017icjqx3avhrhwqjs74vskyka"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-lock" ,rust-async-lock-3)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-concurrent-queue"
          ,rust-concurrent-queue-2)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-futures-lite" ,rust-futures-lite-2)
         ("rust-parking" ,rust-parking-2)
         ("rust-polling" ,rust-polling-3)
         ("rust-rustix" ,rust-rustix-0.38)
         ("rust-slab" ,rust-slab-0.4)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-windows-sys" ,rust-windows-sys-0.52))))
    (home-page "https://github.com/smol-rs/async-io")
    (synopsis "Async I/O and timers")
    (description "Async I/O and timers")
    (license (list license:asl2.0 license:expat))))

(define-public rust-async-signal-0.2
  (package
    (name "rust-async-signal")
    (version "0.2.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-signal" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1i9466hiqghhmljjnn83a8vnxi8z013xga03f59c89d2cl7xjiwy"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-io" ,rust-async-io-2)
         ("rust-async-lock" ,rust-async-lock-2)
         ("rust-atomic-waker" ,rust-atomic-waker-1)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-rustix" ,rust-rustix-0.38)
         ("rust-signal-hook-registry"
          ,rust-signal-hook-registry-1)
         ("rust-slab" ,rust-slab-0.4)
         ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page
      "https://github.com/smol-rs/async-signal")
    (synopsis "Async signal handling")
    (description "Async signal handling")
    (license (list license:asl2.0 license:expat))))

(define-public rust-async-process-1
  (package
    (name "rust-async-process")
    (version "1.8.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-process" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "126s968lvhg9rlwsnxp7wfzkfn7rl87p0dlvqqlibn081ax3hr7a"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-io" ,rust-async-io-1)
         ("rust-async-lock" ,rust-async-lock-2)
         ("rust-async-signal" ,rust-async-signal-0.2)
         ("rust-blocking" ,rust-blocking-1)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-event-listener" ,rust-event-listener-3)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-rustix" ,rust-rustix-0.38)
         ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page
      "https://github.com/smol-rs/async-process")
    (synopsis
      "Async interface for working with processes")
    (description
      "Async interface for working with processes")
    (license (list license:asl2.0 license:expat))))

(define-public rust-async-fs-1
  (package
    (name "rust-async-fs")
    (version "1.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-fs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "01if2h77mry9cnm91ql2md595108i2c1bfy9gaivzvjfcl2gk717"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-lock" ,rust-async-lock-2)
         ("rust-autocfg" ,rust-autocfg-1)
         ("rust-blocking" ,rust-blocking-1)
         ("rust-futures-lite" ,rust-futures-lite-1))))
    (home-page "https://github.com/smol-rs/async-fs")
    (synopsis "Async filesystem primitives")
    (description "Async filesystem primitives")
    (license (list license:asl2.0 license:expat))))

(define-public rust-zbus-3
  (package
    (name "rust-zbus")
    (version "3.14.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zbus" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0j5rxgszrmkk5pbpwccrvj3gflwqw8jv8wfx9v84qbl75l53kpii"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-broadcast"
          ,rust-async-broadcast-0.5)
         ("rust-async-executor" ,rust-async-executor-1)
         ("rust-async-fs" ,rust-async-fs-1)
         ("rust-async-io" ,rust-async-io-1)
         ("rust-async-lock" ,rust-async-lock-2)
         ("rust-async-process" ,rust-async-process-1)
         ("rust-async-recursion" ,rust-async-recursion-1)
         ("rust-async-task" ,rust-async-task-4)
         ("rust-async-trait" ,rust-async-trait-0.1)
         ("rust-blocking" ,rust-blocking-1)
         ("rust-byteorder" ,rust-byteorder-1)
         ("rust-derivative" ,rust-derivative-2)
         ("rust-enumflags2" ,rust-enumflags2-0.7)
         ("rust-event-listener" ,rust-event-listener-2)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-sink" ,rust-futures-sink-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-hex" ,rust-hex-0.4)
         ("rust-nix" ,rust-nix-0.26)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-ordered-stream" ,rust-ordered-stream-0.2)
         ("rust-quick-xml" ,rust-quick-xml-0.27)
         ("rust-rand" ,rust-rand-0.8)
         ("rust-serde" ,rust-serde-1)
         ("rust-serde-xml-rs" ,rust-serde-xml-rs-0.4)
         ("rust-serde-repr" ,rust-serde-repr-0.1)
         ("rust-sha1" ,rust-sha1-0.10)
         ("rust-static-assertions"
          ,rust-static-assertions-1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-tokio-vsock" ,rust-tokio-vsock-0.3)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-uds-windows" ,rust-uds-windows-1)
         ("rust-vsock" ,rust-vsock-0.3)
         ("rust-winapi" ,rust-winapi-0.3)
         ("rust-xdg-home" ,rust-xdg-home-1)
         ("rust-zbus-macros" ,rust-zbus-macros-3)
         ("rust-zbus-names" ,rust-zbus-names-2)
         ("rust-zvariant" ,rust-zvariant-3))))
    (home-page "https://github.com/dbus2/zbus/")
    (synopsis "API for D-Bus communication")
    (description "API for D-Bus communication")
    (license license:expat)))

(define-public rust-atspi-common-0.3
  (package
    (name "rust-atspi-common")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "atspi-common" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1xfdn94r697l98669gsq04rpfxysivkc4cn65fb1yhyjcvwrbbwj"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-enumflags2" ,rust-enumflags2-0.7)
         ("rust-serde" ,rust-serde-1)
         ("rust-static-assertions"
          ,rust-static-assertions-1)
         ("rust-zbus" ,rust-zbus-3)
         ("rust-zbus-names" ,rust-zbus-names-2)
         ("rust-zvariant" ,rust-zvariant-3))))
    (home-page "https://github.com/odilia-app/atspi")
    (synopsis
      "Primitive types used for sending and receiving Linux accessibility events.")
    (description
      "Primitive types used for sending and receiving Linux accessibility events.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-atspi-0.19
  (package
    (name "rust-atspi")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "atspi" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1jl7iv3bvnabg5jd4cpf8ba7zz2dbhk39cr70yh3wnbgmd8g6nb0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-atspi-common" ,rust-atspi-common-0.3)
         ("rust-atspi-connection"
          ,rust-atspi-connection-0.3)
         ("rust-atspi-proxies" ,rust-atspi-proxies-0.3))))
    (home-page "https://github.com/odilia-app/atspi")
    (synopsis
      "Pure-Rust, zbus-based AT-SPI2 protocol implementation.")
    (description
      "Pure-Rust, zbus-based AT-SPI2 protocol implementation.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-async-once-cell-0.5
  (package
    (name "rust-async-once-cell")
    (version "0.5.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-once-cell" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ss2ll9r92jiv4g0fdnwqggs3dn48sakij3fg0ba95dag077jf4k"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-critical-section"
          ,rust-critical-section-1))))
    (home-page
      "https://github.com/danieldg/async-once-cell")
    (synopsis
      "Async single assignment cells and lazy values.")
    (description
      "Async single assignment cells and lazy values.")
    (license (list license:expat license:asl2.0))))

(define-public rust-event-listener-strategy-0.4
  (package
    (name "rust-event-listener-strategy")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "event-listener-strategy" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1lwprdjqp2ibbxhgm9khw7s7y7k4xiqj5i5yprqiks6mnrq4v3lm"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-event-listener" ,rust-event-listener-4)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page
      "https://github.com/smol-rs/event-listener")
    (synopsis
      "Block or poll on event_listener easily")
    (description
      "Block or poll on event_listener easily")
    (license (list license:asl2.0 license:expat))))

(define-public rust-event-listener-4
  (package
    (name "rust-event-listener")
    (version "4.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "event-listener" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1bmsj83d3rsq5w4qgl04g83rl6gkay8ghnqzsq899ndm9619c3bp"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-concurrent-queue"
          ,rust-concurrent-queue-2)
         ("rust-parking" ,rust-parking-2)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-portable-atomic" ,rust-portable-atomic-1)
         ("rust-portable-atomic-util"
          ,rust-portable-atomic-util-0.1))))
    (home-page
      "https://github.com/smol-rs/event-listener")
    (synopsis "Notify async tasks or threads")
    (description "Notify async tasks or threads")
    (license (list license:asl2.0 license:expat))))

(define-public rust-async-channel-2
  (package
    (name "rust-async-channel")
    (version "2.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-channel" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1337ywc1paw03rdlwh100kh8pa0zyp0nrlya8bpsn6zdqi5kz8qw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-concurrent-queue"
          ,rust-concurrent-queue-2)
         ("rust-event-listener" ,rust-event-listener-4)
         ("rust-event-listener-strategy"
          ,rust-event-listener-strategy-0.4)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2))))
    (home-page
      "https://github.com/smol-rs/async-channel")
    (synopsis
      "Async multi-producer multi-consumer channel")
    (description
      "Async multi-producer multi-consumer channel")
    (license (list license:asl2.0 license:expat))))

(define-public rust-accesskit-unix-0.6
  (package
    (name "rust-accesskit-unix")
    (version "0.6.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "accesskit_unix" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "022a77nm8461v0f6mpzidamkci0h1kmkxl9x2bbim9lvv4c6rx09"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit" ,rust-accesskit-0.12)
         ("rust-accesskit-consumer"
          ,rust-accesskit-consumer-0.16)
         ("rust-async-channel" ,rust-async-channel-2)
         ("rust-async-once-cell"
          ,rust-async-once-cell-0.5)
         ("rust-atspi" ,rust-atspi-0.19)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-tokio" ,rust-tokio-1)
         ("rust-zbus" ,rust-zbus-3))))
    (home-page
      "https://github.com/AccessKit/accesskit")
    (synopsis
      "AccessKit UI accessibility infrastructure: Linux adapter")
    (description
      "@code{AccessKit} UI accessibility infrastructure: Linux adapter")
    (license (list license:expat license:asl2.0))))

(define-public rust-accesskit-consumer-0.16
  (package
    (name "rust-accesskit-consumer")
    (version "0.16.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "accesskit_consumer" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1rj5vsaxn9m5aazr22vzlb5bxfbl28h2mck7hqldgyq97jjwq5wc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit" ,rust-accesskit-0.12))))
    (home-page
      "https://github.com/AccessKit/accesskit")
    (synopsis
      "AccessKit consumer library (internal)")
    (description
      "@code{AccessKit} consumer library (internal)")
    (license (list license:expat license:asl2.0))))

(define-public rust-accesskit-macos-0.10
  (package
    (name "rust-accesskit-macos")
    (version "0.10.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "accesskit_macos" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "19vpwi1cnyxbjal4ngjb2x7yhfm9x3yd63w41v8wxyxvxbhnlfyd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit" ,rust-accesskit-0.12)
         ("rust-accesskit-consumer"
          ,rust-accesskit-consumer-0.16)
         ("rust-objc2" ,rust-objc2-0.3)
         ("rust-once-cell" ,rust-once-cell-1))))
    (home-page
      "https://github.com/AccessKit/accesskit")
    (synopsis
      "AccessKit UI accessibility infrastructure: macOS adapter")
    (description
      "@code{AccessKit} UI accessibility infrastructure: @code{macOS} adapter")
    (license (list license:expat license:asl2.0))))

(define-public rust-accesskit-winit-0.15
  (package
    (name "rust-accesskit-winit")
    (version "0.15.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "accesskit_winit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0f57zanvrgjyhn8lagcprkd4f1mnp9v7l2vki3hp22g1qb79zqw8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit" ,rust-accesskit-0.12)
         ("rust-accesskit-macos"
          ,rust-accesskit-macos-0.10)
         ("rust-accesskit-unix" ,rust-accesskit-unix-0.6)
         ("rust-accesskit-windows"
          ,rust-accesskit-windows-0.15)
         ("rust-winit" ,rust-winit-0.28))))
    (home-page
      "https://github.com/AccessKit/accesskit")
    (synopsis
      "AccessKit UI accessibility infrastructure: winit adapter")
    (description
      "@code{AccessKit} UI accessibility infrastructure: winit adapter")
    (license license:asl2.0)))

(define-public rust-egui-winit-0.24
  (package
    (name "rust-egui-winit")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "egui-winit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "112f5qs7qk0lp0haadnv0brwzx9bi3br8c9sbswi4sv0nq33crrv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit-winit"
          ,rust-accesskit-winit-0.15)
         ("rust-arboard" ,rust-arboard-3)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-egui" ,rust-egui-0.24)
         ("rust-log" ,rust-log-0.4)
         ("rust-puffin" ,rust-puffin-0.18)
         ("rust-raw-window-handle"
          ,rust-raw-window-handle-0.5)
         ("rust-serde" ,rust-serde-1)
         ("rust-smithay-clipboard"
          ,rust-smithay-clipboard-0.6)
         ("rust-web-time" ,rust-web-time-0.2)
         ("rust-webbrowser" ,rust-webbrowser-0.8)
         ("rust-winit" ,rust-winit-0.28))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/egui-winit")
    (synopsis "Bindings for using egui with winit")
    (description
      "Bindings for using egui with winit")
    (license (list license:expat license:asl2.0))))

(define-public rust-wgpu-types-0.18
  (package
    (name "rust-wgpu-types")
    (version "0.18.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wgpu-types" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1pdwfh3wgcy4y1njwjirdy3cw5b3k0237i8iwcgkbpphxpqdaphd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-serde" ,rust-serde-1)
         ("rust-web-sys" ,rust-web-sys-0.3))))
    (home-page "https://wgpu.rs/")
    (synopsis "WebGPU types")
    (description "@code{WebGPU} types")
    (license (list license:expat license:asl2.0))))

(define-public rust-renderdoc-sys-1
  (package
    (name "rust-renderdoc-sys")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "renderdoc-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "12v23c9z5xnpjgb0zdzwbj7kaj2cip0p6s58vls2569b72mq0q11"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/ebkalderon/renderdoc-rs/tree/master/renderdoc-sys")
    (synopsis
      "Low-level bindings to the RenderDoc API")
    (description
      "Low-level bindings to the @code{RenderDoc} API")
    (license (list license:expat license:asl2.0))))

(define-public rust-range-alloc-0.1
  (package
    (name "rust-range-alloc")
    (version "0.1.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "range-alloc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1azfwh89nd4idj0s272qgmw3x1cj6m7d3f44b2la02wzvkyrk2lw"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/gfx-rs/range-alloc")
    (synopsis "Generic range allocator")
    (description "Generic range allocator")
    (license (list license:expat license:asl2.0))))

(define-public rust-metal-0.27
  (package
    (name "rust-metal")
    (version "0.27.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "metal" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "09bz461vyi9kw69k55gy2fpd3hz17j6g2n0v08gm3glc7yap6gy4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-block" ,rust-block-0.1)
         ("rust-core-graphics-types"
          ,rust-core-graphics-types-0.1)
         ("rust-dispatch" ,rust-dispatch-0.2)
         ("rust-foreign-types" ,rust-foreign-types-0.5)
         ("rust-log" ,rust-log-0.4)
         ("rust-objc" ,rust-objc-0.2)
         ("rust-paste" ,rust-paste-1))))
    (home-page "https://github.com/gfx-rs/metal-rs")
    (synopsis "Rust bindings for Metal")
    (description "Rust bindings for Metal")
    (license (list license:expat license:asl2.0))))

(define-public rust-khronos-egl-6
  (package
    (name "rust-khronos-egl")
    (version "6.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "khronos-egl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xnzdx0n1bil06xmh8i1x6dbxvk7kd2m70bbm6nw1qzc43r1vbka"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-libloading" ,rust-libloading-0.8)
         ("rust-pkg-config" ,rust-pkg-config-0.3))))
    (home-page
      "https://github.com/timothee-haudebourg/khronos-egl")
    (synopsis "Rust bindings for EGL")
    (description "Rust bindings for EGL")
    (license (list license:expat license:asl2.0))))

(define-public rust-com-rs-0.2
  (package
    (name "rust-com-rs")
    (version "0.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "com-rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0hk6051kwpabjs2dx32qkkpy0xrliahpqfh9df292aa0fv2yshxz"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/Eljay/com-rs")
    (synopsis
      "Deprecated. Use the `com` crate instead.")
    (description
      "Deprecated.  Use the `com` crate instead.")
    (license (list license:expat license:asl2.0))))

(define-public rust-hassle-rs-0.10
  (package
    (name "rust-hassle-rs")
    (version "0.10.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "hassle-rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1c5kgi0car30i4ik132irjq725y61xzp047j1ld8ks0mwc76b5qk"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-com-rs" ,rust-com-rs-0.2)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-libloading" ,rust-libloading-0.7)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-widestring" ,rust-widestring-1)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page
      "https://github.com/Traverse-Research/hassle-rs")
    (synopsis
      "HLSL compiler library, this crate provides an FFI layer and idiomatic rust wrappers for the new DXC HLSL compiler and validator.")
    (description
      "HLSL compiler library, this crate provides an FFI layer and idiomatic rust\nwrappers for the new DXC HLSL compiler and validator.")
    (license license:expat)))

(define-public rust-gpu-descriptor-types-0.1
  (package
    (name "rust-gpu-descriptor-types")
    (version "0.1.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gpu-descriptor-types" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "135pp1b3bzyr7bfnb30rf9pkgy61h75w0jabi8fpw2q9dxpb7w3b"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2))))
    (home-page
      "https://github.com/zakarumych/gpu-descriptor")
    (synopsis "Core types of gpu-descriptor crate")
    (description
      "Core types of gpu-descriptor crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-gpu-descriptor-0.2
  (package
    (name "rust-gpu-descriptor")
    (version "0.2.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gpu-descriptor" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0b38pi460ajx8ksb61zxardwkpa27qgz8fpm252mczlfrqddy4fc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-gpu-descriptor-types"
          ,rust-gpu-descriptor-types-0.1)
         ("rust-hashbrown" ,rust-hashbrown-0.14)
         ("rust-serde" ,rust-serde-1)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page
      "https://github.com/zakarumych/gpu-descriptor")
    (synopsis
      "Implementation agnostic descriptor allocator for Vulkan like APIs")
    (description
      "Implementation agnostic descriptor allocator for Vulkan like APIs")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-interface-0.51
  (package
    (name "rust-windows-interface")
    (version "0.51.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows-interface" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xps1k3ii3cdiniv896mgcv3mbmm787gl4937m008k763hzfcih5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis
      "The interface macro for the windows crate")
    (description
      "The interface macro for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-implement-0.51
  (package
    (name "rust-windows-implement")
    (version "0.51.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows-implement" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0mg5q1rzfix05xvl4fhmp5b6azm8a0pn4dk8hkc21by5zs71aazv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis
      "The implement macro for the windows crate")
    (description
      "The implement macro for the windows crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-msvc-0.48
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnullvm-0.48
  (package
    (name "rust-windows-x86-64-gnullvm")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_gnullvm" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-x86-64-gnu-0.48
  (package
    (name "rust-windows-x86-64-gnu")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_gnu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-msvc-0.48
  (package
    (name "rust-windows-i686-msvc")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_i686_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-i686-gnu-0.48
  (package
    (name "rust-windows-i686-gnu")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_i686_gnu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-msvc-0.48
  (package
    (name "rust-windows-aarch64-msvc")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_aarch64_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-aarch64-gnullvm-0.48
  (package
    (name "rust-windows-aarch64-gnullvm")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_aarch64_gnullvm" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description "Import lib for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-targets-0.48
  (package
    (name "rust-windows-targets")
    (version "0.48.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows-targets" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-windows-aarch64-gnullvm"
          ,rust-windows-aarch64-gnullvm-0.48)
         ("rust-windows-aarch64-msvc"
          ,rust-windows-aarch64-msvc-0.48)
         ("rust-windows-i686-gnu"
          ,rust-windows-i686-gnu-0.48)
         ("rust-windows-i686-msvc"
          ,rust-windows-i686-msvc-0.48)
         ("rust-windows-x86-64-gnu"
          ,rust-windows-x86-64-gnu-0.48)
         ("rust-windows-x86-64-gnullvm"
          ,rust-windows-x86-64-gnullvm-0.48)
         ("rust-windows-x86-64-msvc"
          ,rust-windows-x86-64-msvc-0.48))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import libs for Windows")
    (description "Import libs for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-core-0.51
  (package
    (name "rust-windows-core")
    (version "0.51.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows-core" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0r1f57hsshsghjyc7ypp2s0i78f7b1vr93w68sdb8baxyf2czy7i"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-windows-targets"
          ,rust-windows-targets-0.48))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-windows-0.51
  (package
    (name "rust-windows")
    (version "0.51.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ja500kr2pdvz9lxqmcr7zclnnwpvw28z78ypkrc4f7fqlb9j8na"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-windows-core" ,rust-windows-core-0.51)
         ("rust-windows-implement"
          ,rust-windows-implement-0.51)
         ("rust-windows-interface"
          ,rust-windows-interface-0.51)
         ("rust-windows-targets"
          ,rust-windows-targets-0.48))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Rust for Windows")
    (description "Rust for Windows")
    (license (list license:expat license:asl2.0))))

(define-public rust-presser-0.3
  (package
    (name "rust-presser")
    (version "0.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "presser" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ykvqx861sjmhkdh540aafqba7i7li7gqgwrcczy6v56i9m8xkz8"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/EmbarkStudios/presser")
    (synopsis
      "A crate to help you copy things into raw buffers without invoking spooky action at a distance (undefined behavior).")
    (description
      "This package provides a crate to help you copy things into raw buffers without\ninvoking spooky action at a distance (undefined behavior).")
    (license (list license:expat license:asl2.0))))

(define-public rust-unicode-vo-0.1
  (package
    (name "rust-unicode-vo")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unicode-vo" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "151sha088v9jyfvbg5164xh4dk72g53b82xm4zzbf5dlagzqdlxi"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/RazrFalcon/unicode-vo")
    (synopsis
      "Unicode vertical orientation detection")
    (description
      "Unicode vertical orientation detection")
    (license (list license:expat license:asl2.0))))

(define-public rust-unicode-script-0.5
  (package
    (name "rust-unicode-script")
    (version "0.5.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unicode-script" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1k4fgc2lhn5x34w9xp2gqvxxqasds62qc9a7rbadzmmyw5ap50bx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-compiler-builtins"
          ,rust-compiler-builtins-0.1)
         ("rust-rustc-std-workspace-core"
          ,rust-rustc-std-workspace-core-1)
         ("rust-rustc-std-workspace-std"
          ,rust-rustc-std-workspace-std-1))))
    (home-page
      "https://github.com/unicode-rs/unicode-script")
    (synopsis
      "This crate exposes the Unicode `Script` and `Script_Extension` properties from [UAX #24](http://www.unicode.org/reports/tr24/)\n")
    (description
      "This crate exposes the Unicode `Script` and `Script_Extension` properties from\n[UAX #24](http://www.unicode.org/reports/tr24/)")
    (license (list license:expat license:asl2.0))))

(define-public rust-unicode-general-category-0.6
  (package
    (name "rust-unicode-general-category")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unicode-general-category" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1rv9715c94gfl0hzy4f2a9lw7i499756bq2968vqwhr1sb0wi092"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/yeslogic/unicode-general-category")
    (synopsis
      "Fast lookup of the Unicode General Category property for char")
    (description
      "Fast lookup of the Unicode General Category property for char")
    (license license:asl2.0)))

(define-public rust-unicode-ccc-0.1
  (package
    (name "rust-unicode-ccc")
    (version "0.1.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unicode-ccc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1wbwny92wzmck2cix5h3r97h9z57x9831kadrs6jdy24lvpj09fc"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/RazrFalcon/unicode-ccc")
    (synopsis
      "Unicode Canonical Combining Class detection")
    (description
      "Unicode Canonical Combining Class detection")
    (license (list license:expat license:asl2.0))))

(define-public rust-unicode-bidi-mirroring-0.1
  (package
    (name "rust-unicode-bidi-mirroring")
    (version "0.1.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "unicode-bidi-mirroring" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "150navn2n6barkzchv96n877i17m1754nzmy1282zmcjzdh25lan"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/RazrFalcon/unicode-bidi-mirroring")
    (synopsis
      "Unicode Bidi Mirroring propery detection")
    (description
      "Unicode Bidi Mirroring propery detection")
    (license (list license:expat license:asl2.0))))

(define-public rust-rustybuzz-0.6
  (package
    (name "rust-rustybuzz")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rustybuzz" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "12g40lnfsjjygv30grsdczz9k06n1gd1p9jm4d0ja1lhyvn397mb"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-libm" ,rust-libm-0.2)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-ttf-parser" ,rust-ttf-parser-0.17)
         ("rust-unicode-bidi-mirroring"
          ,rust-unicode-bidi-mirroring-0.1)
         ("rust-unicode-ccc" ,rust-unicode-ccc-0.1)
         ("rust-unicode-general-category"
          ,rust-unicode-general-category-0.6)
         ("rust-unicode-script" ,rust-unicode-script-0.5))))
    (home-page
      "https://github.com/RazrFalcon/rustybuzz")
    (synopsis
      "A complete harfbuzz shaping algorithm port to Rust.")
    (description
      "This package provides a complete harfbuzz shaping algorithm port to Rust.")
    (license license:expat)))

(define-public rust-ttf-parser-0.17
  (package
    (name "rust-ttf-parser")
    (version "0.17.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ttf-parser" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1zrbcjmyz3280wlbdbxskz0gd25lxizjzkcmq50xzdns8kx14n1p"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/RazrFalcon/ttf-parser")
    (synopsis
      "A high-level, safe, zero-allocation TrueType font parser.")
    (description
      "This package provides a high-level, safe, zero-allocation @code{TrueType} font\nparser.")
    (license (list license:expat license:asl2.0))))

(define-public rust-roxmltree-0.18
  (package
    (name "rust-roxmltree")
    (version "0.18.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "roxmltree" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "00mkd2xyrxm8ap39sxpkhzdzfn2m98q3zicf6wd2f6yfa7il08w6"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-xmlparser" ,rust-xmlparser-0.13))))
    (home-page
      "https://github.com/RazrFalcon/roxmltree")
    (synopsis
      "Represent an XML as a read-only tree.")
    (description
      "Represent an XML as a read-only tree.")
    (license (list license:expat license:asl2.0))))

(define-public rust-fontconfig-parser-0.5
  (package
    (name "rust-fontconfig-parser")
    (version "0.5.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fontconfig-parser" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1i21xxwivf6705vjz7gri9g5c7y52f2cc0cci1iwsbax9f7jakk7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-log" ,rust-log-0.4)
         ("rust-roxmltree" ,rust-roxmltree-0.18)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/Riey/fontconfig-parser")
    (synopsis "fontconfig file parser in pure Rust")
    (description
      "fontconfig file parser in pure Rust")
    (license license:expat)))

(define-public rust-fontdb-0.10
  (package
    (name "rust-fontdb")
    (version "0.10.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "fontdb" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1r8v0w0s52a4jnkal63dxkkxcxyi78ihhg9byhh6m1rv7wmpacc1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-fontconfig-parser"
          ,rust-fontconfig-parser-0.5)
         ("rust-log" ,rust-log-0.4)
         ("rust-memmap2" ,rust-memmap2-0.5)
         ("rust-ttf-parser" ,rust-ttf-parser-0.17))))
    (home-page
      "https://github.com/RazrFalcon/fontdb")
    (synopsis
      "A simple, in-memory font database with CSS-like queries.")
    (description
      "This package provides a simple, in-memory font database with CSS-like queries.")
    (license license:expat)))

(define-public rust-usvg-text-layout-0.28
  (package
    (name "rust-usvg-text-layout")
    (version "0.28.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "usvg-text-layout" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ms9qbi7hgw5n1zfxrqfy3bdrzr0qpshcswppx0qc0j811km15ac"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-fontdb" ,rust-fontdb-0.10)
         ("rust-kurbo" ,rust-kurbo-0.8)
         ("rust-log" ,rust-log-0.4)
         ("rust-rustybuzz" ,rust-rustybuzz-0.6)
         ("rust-unicode-bidi" ,rust-unicode-bidi-0.3)
         ("rust-unicode-script" ,rust-unicode-script-0.5)
         ("rust-unicode-vo" ,rust-unicode-vo-0.1)
         ("rust-usvg" ,rust-usvg-0.28))))
    (home-page "https://github.com/RazrFalcon/resvg")
    (synopsis "An SVG text layout implementation.")
    (description
      "An SVG text layout implementation.")
    (license license:mpl2.0)))

(define-public rust-simplecss-0.2
  (package
    (name "rust-simplecss")
    (version "0.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "simplecss" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17g8q1z9xrkd27ic9nrfirj6in4rai6l9ws0kxz45n97573ff6x1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-log" ,rust-log-0.4))))
    (home-page
      "https://github.com/RazrFalcon/simplecss")
    (synopsis "A simple CSS 2 parser and selector.")
    (description
      "This package provides a simple CSS 2 parser and selector.")
    (license (list license:expat license:asl2.0))))

(define-public rust-xmlparser-0.13
  (package
    (name "rust-xmlparser")
    (version "0.13.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "xmlparser" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1r796g21c70p983ax0j6rmhzmalg4rhx61mvd4farxdhfyvy1zk6"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/RazrFalcon/xmlparser")
    (synopsis
      "Pull-based, zero-allocation XML parser.")
    (description
      "Pull-based, zero-allocation XML parser.")
    (license (list license:expat license:asl2.0))))

(define-public rust-roxmltree-0.15
  (package
    (name "rust-roxmltree")
    (version "0.15.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "roxmltree" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "12p4vyg6c906pclhpgq8h21x1acza3dl5wk1gqp156qj3a1yk7bb"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-xmlparser" ,rust-xmlparser-0.13))))
    (home-page
      "https://github.com/RazrFalcon/roxmltree")
    (synopsis
      "Represent an XML as a read-only tree.")
    (description
      "Represent an XML as a read-only tree.")
    (license (list license:expat license:asl2.0))))

(define-public rust-kurbo-0.8
  (package
    (name "rust-kurbo")
    (version "0.8.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "kurbo" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0jgl678sygzs93lz6dr8qnpqhp24k01ay6662wxqgyqw4xnpflvs"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arrayvec" ,rust-arrayvec-0.7)
         ("rust-mint" ,rust-mint-0.5)
         ("rust-schemars" ,rust-schemars-0.8)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/linebender/kurbo")
    (synopsis "A 2D curves library")
    (description
      "This package provides a 2D curves library")
    (license (list license:expat license:asl2.0))))

(define-public rust-imagesize-0.10
  (package
    (name "rust-imagesize")
    (version "0.10.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "imagesize" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0lfrrjqk3pqjk6cyr051fbpg7cc1afaj5mlpr91w1zpvj8gdl6fz"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/Roughsketch/imagesize")
    (synopsis
      "Quick probing of image dimensions without loading the entire file.")
    (description
      "Quick probing of image dimensions without loading the entire file.")
    (license license:expat)))

(define-public rust-usvg-0.28
  (package
    (name "rust-usvg")
    (version "0.28.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "usvg" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1s9jyjmi51v9916cmw48q8ky7ihcw84kvjk7q1436nw460mpqnwb"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-base64" ,rust-base64-0.13)
         ("rust-data-url" ,rust-data-url-0.2)
         ("rust-flate2" ,rust-flate2-1)
         ("rust-imagesize" ,rust-imagesize-0.10)
         ("rust-kurbo" ,rust-kurbo-0.8)
         ("rust-log" ,rust-log-0.4)
         ("rust-rctree" ,rust-rctree-0.5)
         ("rust-roxmltree" ,rust-roxmltree-0.15)
         ("rust-simplecss" ,rust-simplecss-0.2)
         ("rust-siphasher" ,rust-siphasher-0.3)
         ("rust-strict-num" ,rust-strict-num-0.1)
         ("rust-svgtypes" ,rust-svgtypes-0.8))))
    (home-page "https://github.com/RazrFalcon/resvg")
    (synopsis "An SVG simplification library.")
    (description "An SVG simplification library.")
    (license license:mpl2.0)))

(define-public rust-svgtypes-0.8
  (package
    (name "rust-svgtypes")
    (version "0.8.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "svgtypes" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0r2mjyrsyrczd05hycw0ww03nqv4hyqsd67qajxpcsmc5f55x5r2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-siphasher" ,rust-siphasher-0.3))))
    (home-page
      "https://github.com/RazrFalcon/svgtypes")
    (synopsis "SVG types parser.")
    (description "SVG types parser.")
    (license (list license:expat license:asl2.0))))

(define-public rust-svgfilters-0.4
  (package
    (name "rust-svgfilters")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "svgfilters" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1kjbl0khhq548ciw2lnmkk3w2q6ncda6yzgkg7qjvp2zq7mvr6k3"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-float-cmp" ,rust-float-cmp-0.9)
         ("rust-rgb" ,rust-rgb-0.8))))
    (home-page
      "https://github.com/RazrFalcon/resvg/tree/master/svgfilters")
    (synopsis
      "Implementation of various SVG filters.")
    (description
      "Implementation of various SVG filters.")
    (license license:mpl2.0)))

(define-public rust-png-0.17
  (package
    (name "rust-png")
    (version "0.17.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "png" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "077hkp7az7w1hhlvibw03g4xcf9644a66l7fkhhgy9pcji67y3lg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-crc32fast" ,rust-crc32fast-1)
         ("rust-flate2" ,rust-flate2-1)
         ("rust-miniz-oxide" ,rust-miniz-oxide-0.5))))
    (home-page
      "https://github.com/image-rs/image-png.git")
    (synopsis
      "PNG decoding and encoding library in pure Rust")
    (description
      "PNG decoding and encoding library in pure Rust")
    (license (list license:expat license:asl2.0))))

(define-public rust-pico-args-0.5
  (package
    (name "rust-pico-args")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pico-args" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "05d30pvxd6zlnkg2i3ilr5a70v3f3z2in18m67z25vinmykngqav"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/RazrFalcon/pico-args")
    (synopsis
      "An ultra simple CLI arguments parser.")
    (description
      "An ultra simple CLI arguments parser.")
    (license license:expat)))

(define-public rust-resvg-0.28
  (package
    (name "rust-resvg")
    (version "0.28.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "resvg" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hcl2cw7f3bhvxs8r97nxzgh4r5ijay1iqw7y6f9j89n5lzqc5f1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gif" ,rust-gif-0.11)
         ("rust-jpeg-decoder" ,rust-jpeg-decoder-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-pico-args" ,rust-pico-args-0.5)
         ("rust-png" ,rust-png-0.17)
         ("rust-rgb" ,rust-rgb-0.8)
         ("rust-svgfilters" ,rust-svgfilters-0.4)
         ("rust-svgtypes" ,rust-svgtypes-0.8)
         ("rust-tiny-skia" ,rust-tiny-skia-0.8)
         ("rust-usvg" ,rust-usvg-0.28)
         ("rust-usvg-text-layout"
          ,rust-usvg-text-layout-0.28))))
    (home-page "https://github.com/RazrFalcon/resvg")
    (synopsis "An SVG rendering library.")
    (description "An SVG rendering library.")
    (license license:mpl2.0)))

(define-public rust-egui-extras-0.22
  (package
    (name "rust-egui-extras")
    (version "0.22.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "egui_extras" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "00nfz89syl5c45bwgz7rx1pgl4d381rmlpipwmbhsvsjgcrz8y4j"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-chrono" ,rust-chrono-0.4)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-egui" ,rust-egui-0.22)
         ("rust-image" ,rust-image-0.24)
         ("rust-log" ,rust-log-0.4)
         ("rust-resvg" ,rust-resvg-0.28)
         ("rust-serde" ,rust-serde-1)
         ("rust-tiny-skia" ,rust-tiny-skia-0.8)
         ("rust-usvg" ,rust-usvg-0.28))))
    (home-page "https://github.com/emilk/egui")
    (synopsis
      "Extra functionality and widgets for the egui GUI library")
    (description
      "Extra functionality and widgets for the egui GUI library")
    (license (list license:expat license:asl2.0))))

(define-public rust-emath-0.22
  (package
    (name "rust-emath")
    (version "0.22.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "emath" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0jqsfb4x41fr84xpj6ziz3spbsing96af8mnc3fiqx70lr1xfmrq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-mint" ,rust-mint-0.5)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/emath")
    (synopsis "Minimal 2D math library for GUI work")
    (description
      "Minimal 2D math library for GUI work")
    (license (list license:expat license:asl2.0))))

(define-public rust-ecolor-0.22
  (package
    (name "rust-ecolor")
    (version "0.22.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ecolor" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0qzbj6siq52y16f2rcfida44fknxd0sqnbwb9xwlwggjldzrlirf"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-cint" ,rust-cint-0.3)
         ("rust-color-hex" ,rust-color-hex-0.2)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/emilk/egui")
    (synopsis
      "Color structs and color conversion utilities")
    (description
      "Color structs and color conversion utilities")
    (license (list license:expat license:asl2.0))))

(define-public rust-atomic-refcell-0.1
  (package
    (name "rust-atomic-refcell")
    (version "0.1.13")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "atomic_refcell" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0z04ng59y22mwf315wamx78ybhjag0x6k7isc36hdgcv63c7rrj1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/bholley/atomic_refcell")
    (synopsis "Threadsafe RefCell")
    (description "Threadsafe @code{RefCell}")
    (license (list license:asl2.0 license:expat))))

(define-public rust-epaint-0.22
  (package
    (name "rust-epaint")
    (version "0.22.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "epaint" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0fsgqv2r2m5kcvczxp44n450f5j7xnjkrfiqafl40zymsij3jcq9"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ab-glyph" ,rust-ab-glyph-0.2)
         ("rust-ahash" ,rust-ahash-0.8)
         ("rust-atomic-refcell" ,rust-atomic-refcell-0.1)
         ("rust-backtrace" ,rust-backtrace-0.3)
         ("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-ecolor" ,rust-ecolor-0.22)
         ("rust-emath" ,rust-emath-0.22)
         ("rust-log" ,rust-log-0.4)
         ("rust-nohash-hasher" ,rust-nohash-hasher-0.2)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/epaint")
    (synopsis
      "Minimal 2D graphics library for GUI work")
    (description
      "Minimal 2D graphics library for GUI work")
    (license
      (list license:gpl3
            license:gpl3
            license:silofl1.1
            license:gpl3))))

(define-public rust-accesskit-0.11
  (package
    (name "rust-accesskit")
    (version "0.11.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "accesskit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1a18cwchb7yjm671fvq7h2cgl9ya7kaiz1drj22amg6513gimsvn"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-enumn" ,rust-enumn-0.1)
         ("rust-schemars" ,rust-schemars-0.8)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/AccessKit/accesskit")
    (synopsis
      "UI accessibility infrastructure across platforms")
    (description
      "UI accessibility infrastructure across platforms")
    (license (list license:expat license:asl2.0))))

(define-public rust-egui-0.22
  (package
    (name "rust-egui")
    (version "0.22.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "egui" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1rr32780ib6j8k41c09saj7w5f6m4yzna30p83rp5dz17bngibm3"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit" ,rust-accesskit-0.11)
         ("rust-ahash" ,rust-ahash-0.8)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-epaint" ,rust-epaint-0.22)
         ("rust-log" ,rust-log-0.4)
         ("rust-nohash-hasher" ,rust-nohash-hasher-0.2)
         ("rust-ron" ,rust-ron-0.8)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/emilk/egui")
    (synopsis
      "An easy-to-use immediate mode GUI that runs on both web and native")
    (description
      "An easy-to-use immediate mode GUI that runs on both web and native")
    (license (list license:expat license:asl2.0))))

(define-public rust-gpu-allocator-0.23
  (package
    (name "rust-gpu-allocator")
    (version "0.23.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gpu-allocator" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1bbzb93z1gilzdpxjrvcnxkfn71g5y03qnjf1a6c6q2xl341gzj0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ash" ,rust-ash-0.37)
         ("rust-backtrace" ,rust-backtrace-0.3)
         ("rust-egui" ,rust-egui-0.22)
         ("rust-egui-extras" ,rust-egui-extras-0.22)
         ("rust-log" ,rust-log-0.4)
         ("rust-presser" ,rust-presser-0.3)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-winapi" ,rust-winapi-0.3)
         ("rust-windows" ,rust-windows-0.51))))
    (home-page
      "https://github.com/Traverse-Research/gpu-allocator")
    (synopsis
      "Memory allocator for GPU memory in Vulkan and DirectX 12")
    (description
      "Memory allocator for GPU memory in Vulkan and @code{DirectX} 12")
    (license (list license:expat license:asl2.0))))

(define-public rust-gpu-alloc-types-0.3
  (package
    (name "rust-gpu-alloc-types")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gpu-alloc-types" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "190wxsp9q8c59xybkfrlzqqyrxj6z39zamadk1q7v0xad2s07zwq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2))))
    (home-page
      "https://github.com/zakarumych/gpu-alloc")
    (synopsis "Core types of gpu-alloc crate")
    (description "Core types of gpu-alloc crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-gpu-alloc-0.6
  (package
    (name "rust-gpu-alloc")
    (version "0.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gpu-alloc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0wd1wq7qs8ja0cp37ajm9p1r526sp6w0kvjp3xx24jsrjfx2vkgv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-gpu-alloc-types"
          ,rust-gpu-alloc-types-0.3)
         ("rust-serde" ,rust-serde-1)
         ("rust-tracing" ,rust-tracing-0.1))))
    (home-page
      "https://github.com/zakarumych/gpu-alloc")
    (synopsis
      "Implementation agnostic memory allocator for Vulkan like APIs")
    (description
      "Implementation agnostic memory allocator for Vulkan like APIs")
    (license (list license:expat license:asl2.0))))

(define-public rust-glutin-wgl-sys-0.5
  (package
    (name "rust-glutin-wgl-sys")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "glutin_wgl_sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1b9f6qjc8gwhfxac4fpxkvv524l493f6b6q764nslpwmmjnri03c"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gl-generator" ,rust-gl-generator-0.14))))
    (home-page
      "https://github.com/rust-windowing/glutin")
    (synopsis "The wgl bindings for glutin")
    (description "The wgl bindings for glutin")
    (license license:asl2.0)))

(define-public rust-glow-0.13
  (package
    (name "rust-glow")
    (version "0.13.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "glow" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1r01jrpxz7b9d976c7x7ijcbf9mm4q6471zrr3zcdi30n4q2lv48"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-slotmap" ,rust-slotmap-1)
         ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
         ("rust-web-sys" ,rust-web-sys-0.3))))
    (home-page
      "https://github.com/grovesNL/glow.git")
    (synopsis
      "GL on Whatever: a set of bindings to run GL (Open GL, OpenGL ES, and WebGL) anywhere, and avoid target-specific code.")
    (description
      "GL on Whatever: a set of bindings to run GL (Open GL, @code{OpenGL} ES, and\n@code{WebGL}) anywhere, and avoid target-specific code.")
    (license
      (list license:expat license:asl2.0 license:zlib))))

(define-public rust-d3d12-0.7
  (package
    (name "rust-d3d12")
    (version "0.7.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "d3d12" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "084z4nz0ddmsjn6qbrgxygr55pvpi3yjrrkvmzyxs79b56ml8vp1"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-libloading" ,rust-libloading-0.8)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/gfx-rs/d3d12-rs")
    (synopsis "Low level D3D12 API wrapper")
    (description "Low level D3D12 API wrapper")
    (license (list license:expat license:asl2.0))))

(define-public rust-ash-0.37
  (package
    (name "rust-ash")
    (version "0.37.3+1.3.251")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ash" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0jndbsi5c8xifh4fdp378xpbyzdhs7y38hmbhih0lsv8bn1w7s9r"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libloading" ,rust-libloading-0.7))))
    (home-page "https://github.com/MaikKlein/ash")
    (synopsis "Vulkan bindings for Rust")
    (description "Vulkan bindings for Rust")
    (license (list license:expat license:asl2.0))))

(define-public rust-wgpu-hal-0.18
  (package
    (name "rust-wgpu-hal")
    (version "0.18.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wgpu-hal" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1nfdqsf8m1j069f9ri762gplgfsvwipymn9xrys6gsx35n0cqkmq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-android-system-properties"
          ,rust-android-system-properties-0.1)
         ("rust-arrayvec" ,rust-arrayvec-0.7)
         ("rust-ash" ,rust-ash-0.37)
         ("rust-bit-set" ,rust-bit-set-0.5)
         ("rust-bitflags" ,rust-bitflags-2)
         ("rust-block" ,rust-block-0.1)
         ("rust-core-graphics-types"
          ,rust-core-graphics-types-0.1)
         ("rust-d3d12" ,rust-d3d12-0.7)
         ("rust-glow" ,rust-glow-0.13)
         ("rust-glutin-wgl-sys" ,rust-glutin-wgl-sys-0.5)
         ("rust-gpu-alloc" ,rust-gpu-alloc-0.6)
         ("rust-gpu-allocator" ,rust-gpu-allocator-0.23)
         ("rust-gpu-descriptor" ,rust-gpu-descriptor-0.2)
         ("rust-hassle-rs" ,rust-hassle-rs-0.10)
         ("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-khronos-egl" ,rust-khronos-egl-6)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-libloading" ,rust-libloading-0.8)
         ("rust-log" ,rust-log-0.4)
         ("rust-metal" ,rust-metal-0.27)
         ("rust-naga" ,rust-naga-0.14)
         ("rust-objc" ,rust-objc-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-profiling" ,rust-profiling-1)
         ("rust-range-alloc" ,rust-range-alloc-0.1)
         ("rust-raw-window-handle"
          ,rust-raw-window-handle-0.5)
         ("rust-renderdoc-sys" ,rust-renderdoc-sys-1)
         ("rust-rustc-hash" ,rust-rustc-hash-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
         ("rust-web-sys" ,rust-web-sys-0.3)
         ("rust-wgpu-types" ,rust-wgpu-types-0.18)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://wgpu.rs/")
    (synopsis "WebGPU hardware abstraction layer")
    (description
      "@code{WebGPU} hardware abstraction layer")
    (license (list license:expat license:asl2.0))))

(define-public rust-wgpu-core-0.18
  (package
    (name "rust-wgpu-core")
    (version "0.18.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wgpu-core" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "09i7653il0aaqh4xxnyb66amrxzdb2i320b0kv3q37hy5pbc34gg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arrayvec" ,rust-arrayvec-0.7)
         ("rust-bit-vec" ,rust-bit-vec-0.6)
         ("rust-bitflags" ,rust-bitflags-2)
         ("rust-codespan-reporting"
          ,rust-codespan-reporting-0.11)
         ("rust-log" ,rust-log-0.4)
         ("rust-naga" ,rust-naga-0.14)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-profiling" ,rust-profiling-1)
         ("rust-raw-window-handle"
          ,rust-raw-window-handle-0.5)
         ("rust-ron" ,rust-ron-0.8)
         ("rust-rustc-hash" ,rust-rustc-hash-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-web-sys" ,rust-web-sys-0.3)
         ("rust-wgpu-hal" ,rust-wgpu-hal-0.18)
         ("rust-wgpu-types" ,rust-wgpu-types-0.18))))
    (home-page "https://wgpu.rs/")
    (synopsis "WebGPU core logic on wgpu-hal")
    (description
      "@code{WebGPU} core logic on wgpu-hal")
    (license (list license:expat license:asl2.0))))

(define-public rust-cc-1
  (package
    (name "rust-cc")
    (version "1.0.83")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "cc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1l643zidlb5iy1dskc5ggqs4wqa29a02f44piczqc8zcnsq4y5zi"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-jobserver" ,rust-jobserver-0.1)
         ("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/rust-lang/cc-rs")
    (synopsis
      "A build-time dependency for Cargo build scripts to assist in invoking the native\nC compiler to compile native C code into a static archive to be linked into Rust\ncode.\n")
    (description
      "This package provides a build-time dependency for Cargo build scripts to assist\nin invoking the native C compiler to compile native C code into a static archive\nto be linked into Rust code.")
    (license (list license:expat license:asl2.0))))

(define-public rust-tracy-client-sys-0.22
  (package
    (name "rust-tracy-client-sys")
    (version "0.22.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tracy-client-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xppip59nk9gminpj6lp1lwqgddc0zyazn80fd2p0ami3g6b3c1x"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cc" ,rust-cc-1))))
    (home-page
      "https://github.com/nagisa/rust_tracy_client")
    (synopsis
      "Low level bindings to the client libraries for the Tracy profiler\n")
    (description
      "Low level bindings to the client libraries for the Tracy profiler")
    (license
      (list license:gpl3 license:gpl3 license:bsd-3))))

(define-public rust-tracy-client-0.16
  (package
    (name "rust-tracy-client")
    (version "0.16.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "tracy-client" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "03yjmdpv2719bd408dcwidyryxyy767i2nqykdhhc4fzv580vnl2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-loom" ,rust-loom-0.5)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-tracy-client-sys"
          ,rust-tracy-client-sys-0.22))))
    (home-page
      "https://github.com/nagisa/rust_tracy_client")
    (synopsis
      "High level bindings to the client libraries for the Tracy profiler\n")
    (description
      "High level bindings to the client libraries for the Tracy profiler")
    (license (list license:expat license:asl2.0))))

(define-public rust-superluminal-perf-sys-0.1
  (package
    (name "rust-superluminal-perf-sys")
    (version "0.1.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "superluminal-perf-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "05pz0yybf4y2iw3rvqf2crk04zv7610jjm3glhi8hlv2rhms0hh3"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/EmbarkStudios/superluminal-perf-rs")
    (synopsis
      "Superluminal Performance C API bindings")
    (description
      "Superluminal Performance C API bindings")
    (license (list license:expat license:asl2.0))))

(define-public rust-superluminal-perf-0.1
  (package
    (name "rust-superluminal-perf")
    (version "0.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "superluminal-perf" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0q0ykfn04i2qg5zfizp75y4dn2klpvhb6xfwlygq8jiabpgqvvc0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-superluminal-perf-sys"
          ,rust-superluminal-perf-sys-0.1))))
    (home-page
      "https://github.com/EmbarkStudios/superluminal-perf-rs")
    (synopsis
      "Superluminal Performance API for adding user events to profiler captures")
    (description
      "Superluminal Performance API for adding user events to profiler captures")
    (license (list license:expat license:asl2.0))))

(define-public rust-profiling-procmacros-1
  (package
    (name "rust-profiling-procmacros")
    (version "1.0.12")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "profiling-procmacros" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "13ddnqfnd207c7pvz61zvcm1csd0s5bwrm9yi5a259r1qvikd3wx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/aclysma/profiling")
    (synopsis
      "This crate provides a very thin abstraction over other profiler crates.")
    (description
      "This crate provides a very thin abstraction over other profiler crates.")
    (license (list license:expat license:asl2.0))))

(define-public rust-optick-1
  (package
    (name "rust-optick")
    (version "1.3.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "optick" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0j35dj8ggfpcc399h1ljm6xfz8kszqc4nrw3vcl9kfndd1hapryp"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/bombomby/optick-rs")
    (synopsis
      "Super Lightweight Performance Profiler")
    (description
      "Super Lightweight Performance Profiler")
    (license license:expat)))

(define-public rust-profiling-1
  (package
    (name "rust-profiling")
    (version "1.0.12")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "profiling" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0g5kvipvp7qw1q5xddniv6g70wccmg0zihmnkzaw58ifrlkrbq0x"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-optick" ,rust-optick-1)
         ("rust-profiling-procmacros"
          ,rust-profiling-procmacros-1)
         ("rust-puffin" ,rust-puffin-0.18)
         ("rust-superluminal-perf"
          ,rust-superluminal-perf-0.1)
         ("rust-tracing" ,rust-tracing-0.1)
         ("rust-tracy-client" ,rust-tracy-client-0.16))))
    (home-page
      "https://github.com/aclysma/profiling")
    (synopsis
      "This crate provides a very thin abstraction over other profiler crates.")
    (description
      "This crate provides a very thin abstraction over other profiler crates.")
    (license (list license:expat license:asl2.0))))

(define-public rust-spirv-0.2
  (package
    (name "rust-spirv")
    (version "0.2.0+1.5.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "spirv" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0c7qjinqpwcfxk00qx0j46z7i31lnzg2qnnar3gz3crxzqwglsr4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-num-traits" ,rust-num-traits-0.2)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/gfx-rs/rspirv")
    (synopsis
      "Rust definition of SPIR-V structs and enums")
    (description
      "Rust definition of SPIR-V structs and enums")
    (license license:asl2.0)))

(define-public rust-pp-rs-0.2
  (package
    (name "rust-pp-rs")
    (version "0.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pp-rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1vkd9lgwf5rxy7qgzl8mka7vnghaq6nnn0nmg7mycl72ysvqnidv"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-unicode-xid" ,rust-unicode-xid-0.2))))
    (home-page "https://github.com/Kangz/glslpp-rs")
    (synopsis "Shader preprocessor")
    (description "Shader preprocessor")
    (license license:bsd-3)))

(define-public rust-hexf-parse-0.2
  (package
    (name "rust-hexf-parse")
    (version "0.2.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "hexf-parse" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1pr3a3sk66ddxdyxdxac7q6qaqjcn28v0njy22ghdpfn78l8d9nz"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/lifthrasiir/hexf")
    (synopsis
      "Parses hexadecimal floats (see also hexf)")
    (description
      "Parses hexadecimal floats (see also hexf)")
    (license license:cc0)))

(define-public rust-naga-0.14
  (package
    (name "rust-naga")
    (version "0.14.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "naga" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17i4j40xq67qkia5p0q44y4pbjgdj94spwf05a2ghk2invs5sn5f"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arbitrary" ,rust-arbitrary-1)
         ("rust-bit-set" ,rust-bit-set-0.5)
         ("rust-bitflags" ,rust-bitflags-2)
         ("rust-codespan-reporting"
          ,rust-codespan-reporting-0.11)
         ("rust-hexf-parse" ,rust-hexf-parse-0.2)
         ("rust-indexmap" ,rust-indexmap-2)
         ("rust-log" ,rust-log-0.4)
         ("rust-num-traits" ,rust-num-traits-0.2)
         ("rust-petgraph" ,rust-petgraph-0.6)
         ("rust-pp-rs" ,rust-pp-rs-0.2)
         ("rust-rustc-hash" ,rust-rustc-hash-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-spirv" ,rust-spirv-0.2)
         ("rust-termcolor" ,rust-termcolor-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-unicode-xid" ,rust-unicode-xid-0.2))))
    (home-page "https://github.com/gfx-rs/naga")
    (synopsis "Shader translation infrastructure")
    (description "Shader translation infrastructure")
    (license (list license:expat license:asl2.0))))

(define-public rust-flume-0.11
  (package
    (name "rust-flume")
    (version "0.11.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "flume" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "10girdbqn77wi802pdh55lwbmymy437k7kklnvj12aaiwaflbb2m"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-sink" ,rust-futures-sink-0.3)
         ("rust-nanorand" ,rust-nanorand-0.7)
         ("rust-spin" ,rust-spin-0.9))))
    (home-page "https://github.com/zesterer/flume")
    (synopsis
      "A blazingly fast multi-producer channel")
    (description
      "This package provides a blazingly fast multi-producer channel")
    (license (list license:asl2.0 license:expat))))

(define-public rust-wgpu-0.18
  (package
    (name "rust-wgpu")
    (version "0.18.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "wgpu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "097gjin9snc32y9x1vanw0vyzw2dpl7wpx163h3g4qgrr4kx5rrh"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-arrayvec" ,rust-arrayvec-0.7)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-flume" ,rust-flume-0.11)
         ("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-naga" ,rust-naga-0.14)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-profiling" ,rust-profiling-1)
         ("rust-raw-window-handle"
          ,rust-raw-window-handle-0.5)
         ("rust-serde" ,rust-serde-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-static-assertions"
          ,rust-static-assertions-1)
         ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
         ("rust-wasm-bindgen-futures"
          ,rust-wasm-bindgen-futures-0.4)
         ("rust-web-sys" ,rust-web-sys-0.3)
         ("rust-wgpu-core" ,rust-wgpu-core-0.18)
         ("rust-wgpu-hal" ,rust-wgpu-hal-0.18)
         ("rust-wgpu-types" ,rust-wgpu-types-0.18))))
    (home-page "https://wgpu.rs/")
    (synopsis "Rusty WebGPU API wrapper")
    (description "Rusty @code{WebGPU} API wrapper")
    (license (list license:expat license:asl2.0))))

(define-public rust-type-map-0.5
  (package
    (name "rust-type-map")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "type-map" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17qaga12nkankr7hi2mv43f4lnc78hg480kz6j9zmy4g0h28ddny"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-rustc-hash" ,rust-rustc-hash-1))))
    (home-page "https://github.com/kardeiz/type-map")
    (synopsis
      "Provides a typemap container with FxHashMap")
    (description
      "This package provides a typemap container with @code{FxHashMap}")
    (license (list license:expat license:asl2.0))))

(define-public rust-egui-wgpu-0.24
  (package
    (name "rust-egui-wgpu")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "egui-wgpu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0lshd739dd94j6qc8446z5k9m3ra18crnb5cbxibwjcn68xsg3id"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-egui" ,rust-egui-0.24)
         ("rust-epaint" ,rust-epaint-0.24)
         ("rust-log" ,rust-log-0.4)
         ("rust-puffin" ,rust-puffin-0.18)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-type-map" ,rust-type-map-0.5)
         ("rust-wgpu" ,rust-wgpu-0.18)
         ("rust-winit" ,rust-winit-0.28))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/egui-wgpu")
    (synopsis
      "Bindings for using egui natively using the wgpu library")
    (description
      "Bindings for using egui natively using the wgpu library")
    (license (list license:expat license:asl2.0))))

(define-public rust-zstd-safe-6
  (package
    (name "rust-zstd-safe")
    (version "6.0.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zstd-safe" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "10cm0v8sw3jz3pi0wlwx9mbb2l25lm28w638a5n5xscfnk8gz67f"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-zstd-sys" ,rust-zstd-sys-2))))
    (home-page "https://github.com/gyscos/zstd-rs")
    (synopsis
      "Safe low-level bindings for the zstd compression library.")
    (description
      "Safe low-level bindings for the zstd compression library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-zstd-0.12
  (package
    (name "rust-zstd")
    (version "0.12.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zstd" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0g654jj8z25rvzli2b1231pcp9y7n6vk44jaqwgifh9n2xg5j9qs"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-zstd-safe" ,rust-zstd-safe-6))))
    (home-page "https://github.com/gyscos/zstd-rs")
    (synopsis
      "Binding for the zstd compression library.")
    (description
      "Binding for the zstd compression library.")
    (license license:expat)))

(define-public rust-web-time-0.2
  (package
    (name "rust-web-time")
    (version "0.2.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "web-time" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1gykl6dlhm1fjqdrl01b5sa7p7124kf2i0iyk4zh9a5k3xq9l2ap"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2))))
    (home-page
      "https://github.com/daxpedda/web-time")
    (synopsis
      "Drop-in replacement for std::time for Wasm in browsers")
    (description
      "Drop-in replacement for std::time for Wasm in browsers")
    (license (list license:expat license:asl2.0))))

(define-public rust-thiserror-core-impl-1
  (package
    (name "rust-thiserror-core-impl")
    (version "1.0.50")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "thiserror-core-impl" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "014xs0ajjzrc7pxafn1ys8i5f9s2iv5vjqvnrivs05b6ydlhvip4"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/FlorianUekermann/thiserror/tree/1.0.50")
    (synopsis
      "Implementation detail of the `thiserror` crate")
    (description
      "Implementation detail of the `thiserror` crate")
    (license (list license:expat license:asl2.0))))

(define-public rust-thiserror-core-1
  (package
    (name "rust-thiserror-core")
    (version "1.0.50")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "thiserror-core" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "16g9j00g7bn8q1wk2i5p5f88vrhr04igxisqpwngdqz5nwcfw0f0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-thiserror-core-impl"
          ,rust-thiserror-core-impl-1))))
    (home-page
      "https://github.com/FlorianUekermann/thiserror/tree/1.0.50")
    (synopsis "derive(Error)")
    (description "derive(Error)")
    (license (list license:expat license:asl2.0))))

(define-public rust-ruzstd-0.4
  (package
    (name "rust-ruzstd")
    (version "0.4.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ruzstd" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1p4ghqzkq36dy1x1ijnk7jmml4wi3v9bkfzlbm2hsnkiz6wglgxc"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-byteorder" ,rust-byteorder-1)
         ("rust-thiserror-core" ,rust-thiserror-core-1)
         ("rust-twox-hash" ,rust-twox-hash-1))))
    (home-page
      "https://github.com/KillingSpark/zstd-rs")
    (synopsis
      "A decoder for the zstd compression format")
    (description
      "This package provides a decoder for the zstd compression format")
    (license license:expat)))

(define-public rust-lz4-flex-0.11
  (package
    (name "rust-lz4-flex")
    (version "0.11.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "lz4_flex" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1n290fjvfi8jg20n6i0q77g8pqi5srnpgg7zhw1ppnlyd5bb5a9y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-twox-hash" ,rust-twox-hash-1))))
    (home-page "https://github.com/pseitz/lz4_flex")
    (synopsis
      "Fastest LZ4 implementation in Rust, no unsafe by default.")
    (description
      "Fastest LZ4 implementation in Rust, no unsafe by default.")
    (license license:expat)))

(define-public rust-puffin-0.18
  (package
    (name "rust-puffin")
    (version "0.18.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "puffin" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ip8dgmqc6sb6kzpfz09qfw17a0aq4j2cx0ga43j1z5abiwhycq2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-anyhow" ,rust-anyhow-1)
         ("rust-bincode" ,rust-bincode-1)
         ("rust-byteorder" ,rust-byteorder-1)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-lz4-flex" ,rust-lz4-flex-0.11)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-ruzstd" ,rust-ruzstd-0.4)
         ("rust-serde" ,rust-serde-1)
         ("rust-web-time" ,rust-web-time-0.2)
         ("rust-zstd" ,rust-zstd-0.12))))
    (home-page
      "https://github.com/EmbarkStudios/puffin")
    (synopsis
      "Simple instrumentation profiler for games")
    (description
      "Simple instrumentation profiler for games")
    (license (list license:expat license:asl2.0))))

(define-public rust-nohash-hasher-0.2
  (package
    (name "rust-nohash-hasher")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "nohash-hasher" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0lf4p6k01w4wm7zn4grnihzj8s7zd5qczjmzng7wviwxawih5x9b"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/paritytech/nohash-hasher")
    (synopsis
      "An implementation of `std::hash::Hasher` which does not hash at all.")
    (description
      "An implementation of `std::hash::Hasher` which does not hash at all.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-emath-0.24
  (package
    (name "rust-emath")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "emath" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1r6caqgn0ral6kxbkk6a4yn82a5l78c9s7pw2f2yjdabnk0ccid0"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-mint" ,rust-mint-0.5)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/emath")
    (synopsis "Minimal 2D math library for GUI work")
    (description
      "Minimal 2D math library for GUI work")
    (license (list license:expat license:asl2.0))))

(define-public rust-color-hex-0.2
  (package
    (name "rust-color-hex")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "color-hex" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1yacshskcjybr727rh6d38lrfrcdivnd184h49j6qsrj7a8zppzc"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/newcomb-luke/color-hex")
    (synopsis
      "Procedural macro for converting hexadecimal strings to an RGB or RGBA byte array at compile time.")
    (description
      "Procedural macro for converting hexadecimal strings to an RGB or RGBA byte array\nat compile time.")
    (license license:expat)))

(define-public rust-cint-0.3
  (package
    (name "rust-cint")
    (version "0.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "cint" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "16l9glvaxshbp3awcga3s8cdfv00gb1n2s7ixzxxjwc5yz6qf3ks"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1))))
    (home-page "https://github.com/termhn/cint")
    (synopsis
      "A lean, minimal, and stable set of types for color interoperation between crates in Rust.")
    (description
      "This package provides a lean, minimal, and stable set of types for color\ninteroperation between crates in Rust.")
    (license
      (list license:expat license:asl2.0 license:zlib))))

(define-public rust-ecolor-0.24
  (package
    (name "rust-ecolor")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ecolor" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0whrk6jxqk7jfai7z76sd9vsqqf09zzr1b0vjd97xlbl5vy3fxjb"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-cint" ,rust-cint-0.3)
         ("rust-color-hex" ,rust-color-hex-0.2)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/emilk/egui")
    (synopsis
      "Color structs and color conversion utilities")
    (description
      "Color structs and color conversion utilities")
    (license (list license:expat license:asl2.0))))

(define-public rust-epaint-0.24
  (package
    (name "rust-epaint")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "epaint" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1f7szv3waqb5jcip4v3zfwzqpqjvfkvzjy6f6nsvkfi11l09w6vx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-ab-glyph" ,rust-ab-glyph-0.2)
         ("rust-ahash" ,rust-ahash-0.8)
         ("rust-backtrace" ,rust-backtrace-0.3)
         ("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-ecolor" ,rust-ecolor-0.24)
         ("rust-emath" ,rust-emath-0.24)
         ("rust-log" ,rust-log-0.4)
         ("rust-nohash-hasher" ,rust-nohash-hasher-0.2)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/epaint")
    (synopsis
      "Minimal 2D graphics library for GUI work")
    (description
      "Minimal 2D graphics library for GUI work")
    (license
      (list license:gpl3
            license:gpl3
            license:silofl1.1
            license:gpl3))))

(define-public rust-zerocopy-derive-0.7
  (package
    (name "rust-zerocopy-derive")
    (version "0.7.31")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zerocopy-derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "06k0zk4x4n9s1blgxmxqb1g81y8q334aayx61gyy6v9y1dajkhdk"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/google/zerocopy")
    (synopsis
      "Custom derive for traits from the zerocopy crate")
    (description
      "Custom derive for traits from the zerocopy crate")
    (license
      (list license:bsd-2 license:asl2.0 license:expat))))

(define-public rust-zerocopy-0.7
  (package
    (name "rust-zerocopy")
    (version "0.7.31")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "zerocopy" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0gcfyrmlrhmsz16qxjp2qzr6vixyaw1p04zl28f08lxkvfz62h0w"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-byteorder" ,rust-byteorder-1)
         ("rust-zerocopy-derive"
          ,rust-zerocopy-derive-0.7))))
    (home-page "https://github.com/google/zerocopy")
    (synopsis
      "Utilities for zero-copy parsing and serialization")
    (description
      "Utilities for zero-copy parsing and serialization")
    (license
      (list license:bsd-2 license:asl2.0 license:expat))))

(define-public rust-ahash-0.8
  (package
    (name "rust-ahash")
    (version "0.8.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "ahash" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0yn9i8nc6mmv28ig9w3dga571q09vg9f1f650mi5z8phx42r6hli"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-atomic-polyfill" ,rust-atomic-polyfill-1)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-const-random" ,rust-const-random-0.1)
         ("rust-getrandom" ,rust-getrandom-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-serde" ,rust-serde-1)
         ("rust-version-check" ,rust-version-check-0.9)
         ("rust-zerocopy" ,rust-zerocopy-0.7))))
    (home-page "https://github.com/tkaitchuck/ahash")
    (synopsis
      "A non-cryptographic hash function using AES-NI for high performance")
    (description
      "This package provides a non-cryptographic hash function using AES-NI for high\nperformance")
    (license (list license:expat license:asl2.0))))

(define-public rust-enumn-0.1
  (package
    (name "rust-enumn")
    (version "0.1.12")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "enumn" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ard4yslzvax82k3gi38i7jcii7a605rz4fqpy34c6l03ppqrbf2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/dtolnay/enumn")
    (synopsis "Convert number to enum")
    (description "Convert number to enum")
    (license (list license:expat license:asl2.0))))

(define-public rust-accesskit-0.12
  (package
    (name "rust-accesskit")
    (version "0.12.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "accesskit" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1clpb5j1vqhayj7s3ybchz6bvrykfid3zvg9l721fnnqgrs1116a"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-enumn" ,rust-enumn-0.1)
         ("rust-pyo3" ,rust-pyo3-0.19)
         ("rust-schemars" ,rust-schemars-0.8)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/AccessKit/accesskit")
    (synopsis
      "UI accessibility infrastructure across platforms")
    (description
      "UI accessibility infrastructure across platforms")
    (license (list license:expat license:asl2.0))))

(define-public rust-egui-0.24
  (package
    (name "rust-egui")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "egui" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0szfj7r2vvipcq91bb9q0wjplrap8y9bhf2sa64vhkkn9f3cnny5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-accesskit" ,rust-accesskit-0.12)
         ("rust-ahash" ,rust-ahash-0.8)
         ("rust-backtrace" ,rust-backtrace-0.3)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-epaint" ,rust-epaint-0.24)
         ("rust-log" ,rust-log-0.4)
         ("rust-nohash-hasher" ,rust-nohash-hasher-0.2)
         ("rust-puffin" ,rust-puffin-0.18)
         ("rust-ron" ,rust-ron-0.8)
         ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/emilk/egui")
    (synopsis
      "An easy-to-use immediate mode GUI that runs on both web and native")
    (description
      "An easy-to-use immediate mode GUI that runs on both web and native")
    (license (list license:expat license:asl2.0))))

(define-public rust-cocoa-0.24
  (package
    (name "rust-cocoa")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "cocoa" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0flg2cwpqxyvsr1v3f54vi3d3qmbr1sn7gf3mr6nhb056xwxn9gl"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-block" ,rust-block-0.1)
         ("rust-cocoa-foundation"
          ,rust-cocoa-foundation-0.1)
         ("rust-core-foundation"
          ,rust-core-foundation-0.9)
         ("rust-core-graphics" ,rust-core-graphics-0.22)
         ("rust-foreign-types" ,rust-foreign-types-0.3)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-objc" ,rust-objc-0.2))))
    (home-page
      "https://github.com/servo/core-foundation-rs")
    (synopsis "Bindings to Cocoa for macOS")
    (description
      "Bindings to Cocoa for @code{macOS}")
    (license (list license:expat license:asl2.0))))

(define-public rust-eframe-0.24
  (package
    (name "rust-eframe")
    (version "0.24.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "eframe" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ynw7nq1gj91ynaysy4ib3ybzx1xjzm8hwadzdz5mhr8m0c3kmyd"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bytemuck" ,rust-bytemuck-1)
         ("rust-cocoa" ,rust-cocoa-0.24)
         ("rust-directories-next"
          ,rust-directories-next-2)
         ("rust-document-features"
          ,rust-document-features-0.2)
         ("rust-egui" ,rust-egui-0.24)
         ("rust-egui-wgpu" ,rust-egui-wgpu-0.24)
         ("rust-egui-winit" ,rust-egui-winit-0.24)
         ("rust-egui-glow" ,rust-egui-glow-0.24)
         ("rust-glow" ,rust-glow-0.12)
         ("rust-glutin" ,rust-glutin-0.30)
         ("rust-glutin-winit" ,rust-glutin-winit-0.3)
         ("rust-image" ,rust-image-0.24)
         ("rust-js-sys" ,rust-js-sys-0.3)
         ("rust-log" ,rust-log-0.4)
         ("rust-objc" ,rust-objc-0.2)
         ("rust-parking-lot" ,rust-parking-lot-0.12)
         ("rust-percent-encoding"
          ,rust-percent-encoding-2)
         ("rust-pollster" ,rust-pollster-0.3)
         ("rust-puffin" ,rust-puffin-0.18)
         ("rust-raw-window-handle"
          ,rust-raw-window-handle-0.5)
         ("rust-ron" ,rust-ron-0.8)
         ("rust-serde" ,rust-serde-1)
         ("rust-static-assertions"
          ,rust-static-assertions-1)
         ("rust-thiserror" ,rust-thiserror-1)
         ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2)
         ("rust-wasm-bindgen-futures"
          ,rust-wasm-bindgen-futures-0.4)
         ("rust-web-sys" ,rust-web-sys-0.3)
         ("rust-wgpu" ,rust-wgpu-0.18)
         ("rust-winapi" ,rust-winapi-0.3)
         ("rust-winit" ,rust-winit-0.28))))
    (home-page
      "https://github.com/emilk/egui/tree/master/crates/eframe")
    (synopsis
      "egui framework - write GUI apps that compiles to web and/or natively")
    (description
      "egui framework - write GUI apps that compiles to web and/or natively")
    (license (list license:expat license:asl2.0))))

(define-public rust-amdgpu-top-gui-0.5
  (package
    (name "rust-amdgpu-top-gui")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "amdgpu_top_gui" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0v8cik8avpmkqm56idf1syaq5jdgfr3dbfrnjf0qck30gng9bn70"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-eframe" ,rust-eframe-0.24)
         ("rust-egui-plot" ,rust-egui-plot-0.24)
         ("rust-i18n-embed" ,rust-i18n-embed-0.14)
         ("rust-i18n-embed-fl" ,rust-i18n-embed-fl-0.7)
         ("rust-libamdgpu-top" ,rust-libamdgpu-top-0.5)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-rust-embed" ,rust-rust-embed-8))))
    (home-page
      "https://github.com/Umio-Yasuno/amdgpu_top")
    (synopsis "GUI Library for amdgpu_top")
    (description "GUI Library for amdgpu_top")
    (license license:expat)))

(define-public amdgpu-top
  (package
    (name "amdgpu-top")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "amdgpu_top" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0qrcbwrv4g462nzlgid8dbvka4py7xa859yg30pkin2h984m2w9d"))))
    (build-system cargo-build-system)
    (inputs (list libdrm))
    (arguments
      `(#:cargo-inputs
        (("rust-amdgpu-top-gui" ,rust-amdgpu-top-gui-0.5)
         ("rust-amdgpu-top-json"
          ,rust-amdgpu-top-json-0.5)
         ("rust-amdgpu-top-tui" ,rust-amdgpu-top-tui-0.5)
         ("rust-gix" ,rust-gix-0.55)
         ("rust-libamdgpu-top" ,rust-libamdgpu-top-0.5))))
    (home-page
      "https://github.com/Umio-Yasuno/amdgpu_top")
    (synopsis
      "Tool to displays AMDGPU usage.\nThe tool displays information gathered from performance counters (GRBM, GRBM2), sensors, fdinfo, gpu_metrics and AMDGPU driver.\n")
    (description
      "Tool to displays AMDGPU usage.  The tool displays information gathered from\nperformance counters (GRBM, GRBM2), sensors, fdinfo, gpu_metrics and AMDGPU\ndriver.")
    (license license:expat)))

(define-public fceux
  (package
    (name "fceux")
    (version "2.6.6")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/TASEmulators/fceux")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "02s5qmxdxpsa71977z9bs5vfhnszn5nr5hk05wns8cm9nshbg7as"))))
    (build-system cmake-build-system)
    (arguments `(#:tests? #f))
    (inputs (list qtbase-5 zlib minizip sdl2))
    (native-inputs (list pkg-config))
    (synopsis "FCEUX, a NES Emulator")
    (description
      "An open source NES Emulator for Windows and Unix that features solid emulation accuracy and state of the art tools for power users. For some reason casual gamers use it too.")
    (home-page "https://fceux.com")
    (license license:gpl2)))

(define-public distrobox-bumped
  (package
    (inherit distrobox)
    (version "1.6.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/89luca89/distrobox")
             (commit version)))
       (sha256
        (base32 "0kj02phzikz9rddcx2apq3a8zwwfaawc3sfkd4q7f85lpnjxfsji"))
       (file-name (git-file-name (package-name distrobox) version))))))
