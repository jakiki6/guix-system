(define cross-mach
  (package-cross-derivation
    (open-connection)
    gnumach
    "i586-pc-gnu"))

(define (config->string options)
  (string-join
    (map (match-lambda
           ((option quote m) (string-append option "=m"))
           ((option . #t) (string-append option "=y"))
           ((option . #f) (string-append option "=n"))
           ((option . string)
            (string-append option "=\"" string "\"")))
         options)
    "\n"))

(define %default-extra-linux-options
  `(("CONFIG_IKCONFIG" . #t)
    ("CONFIG_IKCONFIG_PROC" . #t)
    ("CONFIG_SECURITY_DMESG_RESTRICT" . #t)
    ("CONFIG_STRICT_DEVMEM" . #f)
    ("CONFIG_IO_STRICT_DEVMEM" . #f)
    ("CONFIG_IKHEADERS" . #t)
    ("CONFIG_NAMESPACES" . #t)
    ("CONFIG_UTS_NS" . #t)
    ("CONFIG_IPC_NS" . #t)
    ("CONFIG_USER_NS" . #t)
    ("CONFIG_PID_NS" . #t)
    ("CONFIG_NET_NS" . #t)
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
    ("CONFIG_DM_CRYPT" . m)
    ("CONFIG_ZSWAP" . #t)
    ("CONFIG_ZSMALLOC" . #t)
    ("CONFIG_ZRAM" . m)
    ("CONFIG_ACCESSIBILITY" . #t)
    ("CONFIG_A11Y_BRAILLE_CONSOLE" . #t)
    ("CONFIG_SPEAKUP" . m)
    ("CONFIG_SPEAKUP_SYNTH_SOFT" . m)
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
    (version "6.11.5-zen1")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://github.com/zen-kernel/zen-kernel")
               (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (patches
          (list (local-file
                  "../patches/linux-max-cipher-blocksize.patch")))
        (sha256
          (base32
            "1w342k54ns6rwkk13l9f7h0qzikn6hbnb2ydxyqalrmll8n2g237"))))
    (native-inputs
      (modify-inputs
        (package-native-inputs linux)
        (prepend clang-18 lld-18 python-3 cpio)))
    (arguments
      (substitute-keyword-arguments
        (package-arguments linux)
        ((#:phases phases)
         (gexp (modify-phases
                 (ungexp phases)
                 (add-after
                   'configure
                   'my-patches
                   (lambda _
                     (setenv "LLVM" "1")
                     (setenv "LLVM_IAS" "1")
                     (let ((port (open-file ".config" "a"))
                           (extra-configuration
                             (ungexp
                               (config->string
                                 (append
                                   '(("CONFIG_LTO" . #t)
                                     ("CONFIG_LTO_CLANG" . #t)
                                     ("CONFIG_ARCH_SUPPORTS_LTO_CLANG" . #t)
                                     ("CONFIG_HAS_LTO_CLANG" . #t)
                                     ("CONFIG_LTO_CLANG_FULL" . #t))
                                   %default-extra-linux-options)))))
                       (display extra-configuration port)
                       (close-port port))
                     (invoke "make" "oldconfig"))))))))))
