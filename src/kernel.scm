(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define linux-zen
  (package
    (inherit linux)
    (name "linux-zen")
    (version "6.6.3-zen1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0hjn4qq8dppa0cn4rx7n98cxvzhkbn30hlm3bgcv97fwyvglsdwc"))))))
