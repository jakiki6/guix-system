(define vim-as-vi
  (package
    (name "vim-as-vi")
    (version (package-version vim))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (vim (assoc-ref %build-inputs "vim")))
            (mkdir out)
            (mkdir (string-append out "/bin"))
            (chdir (string-append out "/bin"))
            (symlink (string-append vim "/bin/vim") "vi")))))
    (inputs (list vim))
    (synopsis "Symlink vi to vim")
    (description
      "Make vi a symlink to vim. This collides with nvi.")
    (home-page (package-home-page vim))
    (license (package-license vim))))

(define python3-as-python
  (package
    (name "python3-as-python")
    (version (package-version python-3))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (python (assoc-ref %build-inputs "python")))
            (mkdir out)
            (mkdir (string-append out "/bin"))
            (chdir (string-append out "/bin"))
            (symlink
              (string-append python "/bin/python3")
              "python")))))
    (inputs (list python-3))
    (synopsis "Python 3 + symlink to python")
    (description "Make python a symlink to python3.")
    (home-page (package-home-page python-3))
    (license (package-license python-3))))

(define shutdown-as-poweroff
  (package
    (name "shutdown-as-poweroff")
    (version (package-version shepherd))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (shepherd (assoc-ref %build-inputs "shepherd")))
            (mkdir out)
            (mkdir (string-append out "/sbin"))
            (chdir (string-append out "/sbin"))
            (symlink
              (string-append shepherd "/sbin/shutdown")
              "poweroff")))))
    (inputs (list shepherd))
    (synopsis "Symlink poweroff to shutdown")
    (description
      "Make poweroff a symlink to shutdown.")
    (home-page (package-home-page shepherd))
    (license (package-license shepherd))))

(define gcc-as-cc
  (package
    (name "gcc-as-cc")
    (version (package-version gcc-toolchain))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (gcc (assoc-ref %build-inputs "gcc-toolchain")))
            (mkdir out)
            (mkdir (string-append out "/bin"))
            (chdir (string-append out "/bin"))
            (symlink (string-append gcc "/bin/gcc") "cc")))))
    (propagated-inputs (list gcc-toolchain))
    (synopsis "Symlink cc to gcc")
    (description "Make cc a symlink to gcc.")
    (home-page (package-home-page gcc-toolchain))
    (license (package-license gcc-toolchain))))

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
                  "patches/shepherd-reboot-kexec.patch")))))))
