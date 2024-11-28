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

(define grub-efi-fixed
  (package
    (name "grub-efi-fixed")
    (version (package-version grub-efi))
    (source #f)
    (build-system trivial-build-system)
    (arguments
      `(#:modules
        ((guix build utils))
        #:builder
        (begin
          (use-modules (guix build utils))
          (let* ((out (assoc-ref %outputs "out"))
                 (grub (assoc-ref %build-inputs "grub-efi"))
                 (bash (assoc-ref %build-inputs "bash")))
            (copy-recursively grub out)
            (chdir (string-append out "/sbin"))
            (copy-file "grub-install" ".grub-install")
            (make-file-writable "grub-install")
            (define port (open-output-file "grub-install"))
            (display
              (string-append
                "#!"
                bash
                "/bin/sh\nexec "
                out
                "/sbin/.grub-install --target=x86_64-efi $@\n")
              port)
            (close port)
            (chmod "grub-install" 493)))))
    (inputs (list grub-efi bash))
    (synopsis "")
    (description "")
    (home-page "")
    (license (package-license grub-efi))))

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
    (inputs
      (list (specification->package "shepherd")))
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
