(include "../src/common.scm")

(define my-os
  (personalize
    (prepare-laptop
      (operating-system
        (host-name "dalaptop")
        (services %desktop-services)
        (bootloader
          (bootloader-configuration
            (bootloader
              (inherit grub-efi-removable-bootloader)
              (package grub-efi-fixed))
            (targets (list "/dev/sda"))
            (keyboard-layout
              (keyboard-layout "us" "altgr-intl"))
            (theme (grub-theme
                     (image (local-file "../files/background.png"))))))
        (mapped-devices
          (list (mapped-device
                  (source "/dev/sda2")
                  (target "root1")
                  (type luks-device-mapping))))
        (file-systems
          (cons* (file-system
                   (mount-point "/")
                   (device (file-system-label "guix_root"))
                   (type "btrfs")
                   (dependencies mapped-devices))
                 (file-system
                   (mount-point "/boot")
                   (device (file-system-label "guix_boot"))
                   (type "ext4"))
                 (file-system
                   (mount-point "/smb")
                   (device "//10.10.20.111/jakob")
                   (type "cifs")
                   (mount-may-fail? #t)
                   (options
                     (string-append
                       "username=jakob,password="
                       secret-smb-password
                       ",_netdev"))
                   (mount? #f))
                 %base-file-systems))))))

my-os
