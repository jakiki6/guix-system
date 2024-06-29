(include "src/common.scm")

(define my-os
  (operating-system
    (inherit base-os)
    (host-name "linux-server")
    (bootloader
      (bootloader-configuration
        (bootloader grub-bootloader)
        (targets (list "/dev/sda"))
        (keyboard-layout
          (keyboard-layout "us" "altgr-intl"))))
    (mapped-devices (list))
    (file-systems
      (cons* (file-system
               (mount-point "/")
               (device (file-system-label "guix_root"))
               (type "btrfs"))
             %base-file-systems))))

my-os
