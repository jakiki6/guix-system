(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define linux-zen
  (package
    (inherit linux)
    (name "linux-zen")
    (version "6.6.2-zen1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0l97szqyr2i5kfl38hz1bnyd51s3zk4vf4c4xc860gy2fcxaprkl"))))))
