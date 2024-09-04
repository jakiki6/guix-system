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
            "0k40n9qm5r5rqf94isa1857ghd4329zc5rjf3ll2572gpiw3ij4x"))
        (patches
          (list (local-file
                  "../patches/shepherd-reboot-kexec.patch")))))))

(define-public fwupd-patched
  (package
    (name "fwupd")
    (version "1.8.14")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/fwupd/fwupd")
               (commit version)))
        (file-name (git-file-name name version))
        (patches
          (list (local-file "../patches/fwupd-polkit.patch")))
        (sha256
          (base32
            "179yc0nbbyrdya5q16ncf7lkslrhr3i90rgb9vdmv751ikilkby6"))))
    (build-system meson-build-system)
    (arguments
      (list #:configure-flags
            (gexp (list "--wrap-mode=nofallback"
                        "-Dsystemd=false"
                        (string-append
                          "-Defi_os_dir="
                          (ungexp gnu-efi)
                          "/lib")
                        "-Defi_binary=false"
                        (string-append
                          "-Dudevdir="
                          (ungexp output)
                          "/lib/udev")
                        "--localstatedir=/var"
                        (string-append
                          "--libexecdir="
                          (ungexp output)
                          "/libexec")
                        "-Dsupported_build=true"
                        "-Dlvfs=true"))
            #:glib-or-gtk?
            #t
            #:phases
            (gexp (modify-phases
                    %standard-phases
                    (add-after
                      'unpack
                      'make-source-writable
                      (lambda _
                        (for-each make-file-writable (find-files "."))
                        (substitute*
                          "src/fu-self-test.c"
                          (("/bin/sh") (which "sh")))))
                    (add-after
                      'unpack
                      'newer-timestamps-for-python-zip
                      (lambda _
                        (let ((circa-1980 (* 10 366 24 60 60)))
                          (for-each
                            (lambda (file)
                              (make-file-writable file)
                              (utime file circa-1980 circa-1980))
                            '("./libfwupdplugin/tests/colorhug/firmware.bin"
                              "./libfwupdplugin/tests/colorhug/firmware.bin.asc")))))
                    (add-before
                      'build
                      'setup-home
                      (lambda _ (setenv "HOME" "/tmp")))
                    (add-before
                      'install
                      'no-polkit-magic
                      (lambda _ (setenv "PKEXEC_UID" "something")))
                    (add-after
                      'install
                      'ensure-all-remotes-are-enabled
                      (lambda _
                        (substitute*
                          (find-files
                            (string-append (ungexp output) "/etc")
                            "\\.conf$")
                          (("Enabled=false") "Enabled=true"))))))))
    (native-inputs
      (list gobject-introspection
            python-pygobject
            python-pillow
            python-pycairo
            python
            pkg-config
            vala
            gtk-doc
            which
            umockdev
            `(,glib "bin")
            help2man
            gettext-minimal))
    (inputs
      (append
        (list bash-completion
              libgudev
              libxmlb
              sqlite
              polkit
              eudev
              libelf
              tpm2-tss
              cairo
              efivar
              pango
              protobuf-c
              mingw-w64-tools
              gnu-efi)
        (if (supported-package?
              libsmbios
              (or (and=> (%current-target-system)
                         platform-target->system)
                  (%current-system)))
          (list libsmbios)
          '())))
    (propagated-inputs
      (list curl
            gcab
            glib
            gnutls
            gusb
            json-glib
            libarchive
            libjcat))
    (home-page "https://fwupd.org/")
    (synopsis
      "Daemon to allow session software to update firmware")
    (description
      "This package aims to make updating firmware on GNU/Linux\nautomatic, safe and reliable.  It is used by tools such as GNOME Software.")
    (license license:lgpl2.1+)))
