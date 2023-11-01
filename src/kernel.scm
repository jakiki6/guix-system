(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define linux-zen
  (package
    (inherit linux)
    (name "linux-zen")
    (version "6.6-zen1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0rda54h5lg2llbwkj2h4mqfshjyha1dzlcwhx099is7g2lfzksxx"))))))
