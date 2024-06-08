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
            "0206r2l914qjahzd1qill57r1qcg1x8faj0f6qv3x42wqx6x28ky"))
        (patches
          (list (local-file
                  "../patches/shepherd-reboot-kexec.patch")))))))
