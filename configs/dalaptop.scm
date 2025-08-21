(include "../src/common.scm")

(define my-os
  (personalize
    (prepare-desktop
      (operating-system
        (host-name "dalaptop")
        (bootloader
          (bootloader-configuration
            (bootloader
              (bootloader
                (inherit grub-efi-removable-bootloader)
                (package grub-efi-fixed)))
            (targets (list "/boot"))
            (keyboard-layout
              (keyboard-layout "us" "altgr-intl"))
            (theme (grub-theme
                     (image (local-file "../files/background.png"))))
            (menu-entries
              (list (menu-entry
                      (label "Memtest86+")
                      (multiboot-kernel
                        (file-append
                          memtest86+
                          "/lib/memtest86+/memtest.bin")))
                    (menu-entry
                      (label "GNU Mach")
                      (multiboot-kernel
                        (file-append cross-mach "/boot/gnumach")))))))
        (services
          (append
            (list (service tlp-service-type
                    (tlp-configuration
                    (cpu-scaling-governor-on-ac (list "performance"))
                    (sched-powersave-on-bat? #t)
                    (cpu-boost-on-ac? #t)
                    (stop-charge-thresh-bat0 80)
                    (start-charge-thresh-bat0 70)))
                  (service thermald-service-type)
                  (service
                    openssh-service-type
                    (openssh-configuration
                      (x11-forwarding? #t)
                      (permit-root-login 'prohibit-password)
                      (authorized-keys
                        `(("root" ,(local-file "../keys/s-laura.pub")))))))
            %desktop-services))
        (mapped-devices
          (list (mapped-device
                  (source (uuid "227bf599-01bc-48a4-97f0-9496ce7224cb"))
                  (target "guix_root")
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
                   (type "vfat"))
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
