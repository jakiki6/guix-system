(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define linux-hardened
  (package
    (inherit linux)
    (name "linux-hardened")
    (version "6.5.13-hardened2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/anthraxx/linux-hardened")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "0z7qmmwzf5lvcv1dgbymz337df1z0gfybd5421wfk3z3wb2rzjxv"))))))
