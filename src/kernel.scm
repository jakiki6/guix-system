(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define linux-zen
  (package
    (inherit linux)
    (name "linux-zen")
    (version "6.5.9-lqx1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0z5mfcblwqzsw2d98npv1aa32bni46xmsvwc1ijad1c54iimsk9a"))))))
