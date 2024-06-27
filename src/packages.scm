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
