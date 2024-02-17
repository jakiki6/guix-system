(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define (config->string options)
  (string-join (map (match-lambda
                      ((option . 'm) 
                       (string-append option "=m"))
                      ((option . #t) 
                       (string-append option "=y"))
                      ((option . #f) 
                       (string-append option "=n"))
                      ((option . string)
                       (string-append option "=\"" string "\"")))
                    options)
               "\n"))

(define %default-extra-linux-options
  `(;; Make the kernel config available at /proc/config.gz
    ("CONFIG_IKCONFIG" . #t) 
    ("CONFIG_IKCONFIG_PROC" . #t) 
    ;; Some very mild hardening.
    ("CONFIG_SECURITY_DMESG_RESTRICT" . #t) 
    ;; Custom
    ("CONFIG_STRICT_DEVMEM" . #f)
    ("CONFIG_IO_STRICT_DEVMEM" . #f)
    ;; All kernels should have NAMESPACES options enabled
    ("CONFIG_NAMESPACES" . #t) 
    ("CONFIG_UTS_NS" . #t) 
    ("CONFIG_IPC_NS" . #t) 
    ("CONFIG_USER_NS" . #t) 
    ("CONFIG_PID_NS" . #t) 
    ("CONFIG_NET_NS" . #t) 
    ;; Various options needed for elogind service:
    ;; https://issues.guix.gnu.org/43078
    ("CONFIG_CGROUP_FREEZER" . #t) 
    ("CONFIG_BLK_CGROUP" . #t) 
    ("CONFIG_CGROUP_WRITEBACK" . #t) 
    ("CONFIG_CGROUP_SCHED" . #t) 
    ("CONFIG_CGROUP_PIDS" . #t) 
    ("CONFIG_CGROUP_FREEZER" . #t) 
    ("CONFIG_CGROUP_DEVICE" . #t) 
    ("CONFIG_CGROUP_CPUACCT" . #t) 
    ("CONFIG_CGROUP_PERF" . #t) 
    ("CONFIG_SOCK_CGROUP_DATA" . #t) 
    ("CONFIG_BLK_CGROUP_IOCOST" . #t) 
    ("CONFIG_CGROUP_NET_PRIO" . #t) 
    ("CONFIG_CGROUP_NET_CLASSID" . #t) 
    ("CONFIG_MEMCG" . #t) 
    ("CONFIG_MEMCG_SWAP" . #t) 
    ("CONFIG_MEMCG_KMEM" . #t) 
    ("CONFIG_CPUSETS" . #t) 
    ("CONFIG_PROC_PID_CPUSET" . #t) 
    ;; Allow disk encryption by default
    ("CONFIG_DM_CRYPT" . m)
    ;; Support zram on all kernel configs
    ("CONFIG_ZSWAP" . #t) 
    ("CONFIG_ZSMALLOC" . #t) 
    ("CONFIG_ZRAM" . m)
    ;; Accessibility support.
    ("CONFIG_ACCESSIBILITY" . #t)
    ("CONFIG_A11Y_BRAILLE_CONSOLE" . #t)
    ("CONFIG_SPEAKUP" . m)
    ("CONFIG_SPEAKUP_SYNTH_SOFT" . m)
    ;; Modules required for initrd:
    ("CONFIG_NET_9P" . m)
    ("CONFIG_NET_9P_VIRTIO" . m)
    ("CONFIG_VIRTIO_BLK" . m)
    ("CONFIG_VIRTIO_NET" . m)
    ("CONFIG_VIRTIO_PCI" . m)
    ("CONFIG_VIRTIO_BALLOON" . m)
    ("CONFIG_VIRTIO_MMIO" . m)
    ("CONFIG_FUSE_FS" . m)
    ("CONFIG_CIFS" . m)
    ("CONFIG_9P_FS" . m)))

(define linux-zen
  (package
    (inherit linux)
    (name "linux-zen")
    (version "6.7.5-zen1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256
          (base32
            "1f7czivsmqzhcbckcyi058lqwa4qds03fmylqa1wa4sybrq4diri"))))
    (native-inputs (modify-inputs (package-native-inputs linux) (prepend clang-17 lld-17 python-3)))
    (arguments
      (substitute-keyword-arguments (package-arguments linux)
        ((#:phases phases)
          #~(modify-phases #$phases
            (add-after 'configure 'my-patches
              (lambda _
                (setenv "LLVM" "1")
                (setenv "LLVM_IAS" "1")
                (setenv "KCFLAGS" "-O2 -march=skylake -pipe")
                (let ((port (open-file ".config" "a"))
                  (extra-configuration
                    #$(config->string
                      (append '(("CONFIG_LTO" . #t)
                                ("CONFIG_LTO_CLANG" . #t) 
                                ("CONFIG_ARCH_SUPPORTS_LTO_CLANG" . #t)
                                ("CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN" . #t)
                                ("CONFIG_HAS_LTO_CLANG" . #t)
                                ("CONFIG_LTO_CLANG_FULL" . #t))
                                %default-extra-linux-options))))
                    (display extra-configuration port)
                    (close-port port))
                (invoke "make" "oldconfig")))))))))
