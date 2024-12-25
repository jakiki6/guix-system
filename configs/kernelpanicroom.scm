(include "../src/common.scm")

(define my-os
  (personalize
    (prepare-desktop
      (operating-system
        (host-name "kernelpanicroom")
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
        (mapped-devices
          (list (mapped-device
                  (source
                    (uuid "9ed7fd2f-f4ec-485a-a816-11be07e84d10"))
                  (target "root1")
                  (type luks-device-mapping))
                (mapped-device
                  (source
                    (uuid "81aa6264-1607-439c-8ea6-b5ef981777ab"))
                  (target "root2")
                  (type luks-device-mapping))))
        (services
          (append
            (list (service
                    openssh-service-type
                    (openssh-configuration
                      (x11-forwarding? #t)
                      (permit-root-login 'prohibit-password)
                      (authorized-keys
                        `(("root" ,(local-file "../keys/s-laura.pub")))))))
            %desktop-services))
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
                   (mount-point "/data")
                   (device
                     (uuid "d883b77a-1f15-48ea-94e1-af4e64be9951"
                           'xfs))
                   (type "xfs")
                   (mount-may-fail? #t)
                   (mount? #f))
                 (file-system
                   (mount-point "/smb")
                   (device "//192.168.69.11/jakob")
                   (type "cifs")
                   (mount-may-fail? #t)
                   (options
                     (string-append
                       "username=jakob,password="
                       secret-smb-password
                       ",_netdev")))
                 %base-file-systems))))))

my-os
