(include "../src/common.scm")

(define my-os
  (operating-system
    (inherit
      (personalize
        (prepare-base
          (operating-system
            (host-name "s-laura")
            (services %desktop-services)
            (bootloader
              (bootloader-configuration
                (bootloader grub-bootloader)
                (targets (list "/dev/sda"))
                (keyboard-layout
                  (keyboard-layout "us" "altgr-intl"))
                (theme (grub-theme
                         (image (local-file "../files/background.png"))))))
            (file-systems
              (cons* (file-system
                       (mount-point "/")
                       (device "/dev/sda1")
                       (type "btrfs"))
                     (file-system
                       (mount-point "/smb")
                       (device "//192.168.69.11/jakob")
                       (type "cifs")
                       (mount-may-fail? #t)
                       (options
                         (string-append
                           "username=jakob,password="
                           secret-smb-password
                           ",_netdev"))
                       (mount? #f))
                     %base-file-systems))))))
    (firmware %base-firmware)))

my-os
