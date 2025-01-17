(define (kubo-shepherd-service config)
  (list (shepherd-service
          (provision '(kubo))
          (requirement '(loopback))
          (documentation "Connect to the IPFS network")
          (start (gexp (make-forkexec-constructor
                         (list (string-append (ungexp kubo) "/bin/ipfs")
                               "daemon"
                               "--mount")
                         #:log-file
                         "/var/log/ipfs.log"
                         #:user
                         "laura"
                         #:group
                         "users"
                         #:environment-variables
                         (list "IPFS_PATH=/ipfs_data"
                               (string-append
                                 "PATH=/run/setuid-programs:"
                                 (ungexp fuse-2)
                                 "/bin")))))
          (stop (gexp (make-kill-destructor))))))

(define %kubo-log-rotation
  (list "/var/log/ipfs.log"))

(define (%kubo-activation config)
  (gexp (begin
          (let ((pid (primitive-fork)))
            (if (zero? pid)
              (dynamic-wind
                (const #t)
                (lambda ()
                  (let ((pw (getpwnam "laura")))
                    (umask 63)
                    (setenv "IPFS_PATH" "/ipfs_data")
                    (setgroups '#())
                    (setgid (passwd:gid pw))
                    (setuid (passwd:uid pw)))
                  (system "ipfs init"))
                (lambda () (primitive-exit 127)))
              (waitpid pid))))))

(define kubo-service-type
  (service-type
    (name 'kubo)
    (extensions
      (list (service-extension
              activation-service-type
              %kubo-activation)
            (service-extension
              shepherd-root-service-type
              kubo-shepherd-service)
            (service-extension
              log-rotation-service-type
              (const %kubo-log-rotation))))
    (default-value #f)
    (description
      "Run @command{ipfs daemon}, the reference implementation of the IPFS peer-to-peer storage network.")))
