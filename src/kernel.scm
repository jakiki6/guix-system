(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define linux-zen
  (package
    (inherit linux)
    (name "linux-zen")
    (version "6.6.8-zen1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "1b7ji0zb0wbpl92zrjrqh69cm8n7vyq7a7smsww01agvr1nd8djc"))))))
