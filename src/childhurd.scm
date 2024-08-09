(define childhurd-os
  (operating-system
    (inherit %hurd-vm-operating-system)
    (timezone "Europe/Berlin")
    (users (cons (user-account
                   (name "laura")
                   (comment "")
                   (group "users")
                   (supplementary-groups '("wheel")))
                 %base-user-accounts))
    (packages
      (append
        (list)
        (operating-system-packages
          %hurd-vm-operating-system)))
    (sudoers-file
      (plain-file
        "sudoers"
        (string-append
          (plain-file-content %sudoers-specification)
          (format #f "~a ALL = NOPASSWD: ALL~%" "laura"))))
    (services
      (modify-services
        (operating-system-user-services
          %hurd-vm-operating-system)
        (openssh-service-type
          config
          =>
          (openssh-configuration
            (inherit config)
            (authorized-keys
              `(("root"
                 ,(local-file "/home/laura/.ssh/id_ed25519.pub"))
                ("laura"
                 ,(local-file "/home/laura/.ssh/id_ed25519.pub"))))))))))
