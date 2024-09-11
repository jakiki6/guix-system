(cons* (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix")
         (introduction
           (make-channel-introduction
             "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
             (openpgp-fingerprint
               "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
         (name 'rosenthal)
         (url "https://codeberg.org/hako/rosenthal.git")
         (branch "trunk")
         (introduction
           (make-channel-introduction
             "7677db76330121a901604dfbad19077893865f35"
             (openpgp-fingerprint
               "13E7 6CD6 E649 C28C 3385  4DF5 5E5A A665 6149 17F7"))))
       (channel
         (name 'lauras-channel)
         (url "https://github.com/jakiki6/lauras-channel"))
       (channel
         (name 'guix-hpc)
         (url "https://gitlab.inria.fr/guix-hpc/guix-hpc.git")
         (branch "master"))
       (channel
         (name 'guix-science)
         (url "https://github.com/guix-science/guix-science.git")
         (introduction
           (make-channel-introduction
             "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
             (openpgp-fingerprint
               "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))
       %default-channels)
