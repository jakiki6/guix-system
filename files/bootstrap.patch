From 36462095039632348ed5fbd5763426f74f48049f Mon Sep 17 00:00:00 2001
Message-ID: <36462095039632348ed5fbd5763426f74f48049f.1742224546.git.jakob.kirsch@web.de>
From: Jakob Kirsch <jakob.kirsch@web.de>
Date: Mon, 17 Mar 2025 14:53:07 +0100
Subject: [PATCH v1] channels: add transformer field

Change-Id: I46c065eb096d9fccefde7a791e4373a614deac33
---
 guix/channels.scm | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/guix/channels.scm b/guix/channels.scm
index 4700f7a45d..091a5c2f16 100644
--- a/guix/channels.scm
+++ b/guix/channels.scm
@@ -135,6 +135,7 @@ (define-record-type* <channel> channel make-channel
   (branch    channel-branch (default "master"))
   (commit    channel-commit (default #f))
   (introduction channel-introduction (default #f))
+  (transformer channel-transformer (default (lambda checkout #t)))
   (location  channel-location
              (default (current-source-location)) (innate)))

@@ -456,6 +457,8 @@ (define* (latest-channel-instance store channel
 thus potentially malicious code.")))))))))
         (warning (G_ "channel authentication disabled~%")))

+    (apply (channel-transformer channel) (list checkout))
+
     (when (guix-channel? channel)
       ;; Apply the relevant subset of PATCHES directly in CHECKOUT.  This is
       ;; safe to do because 'switch-to-ref' eventually does a hard reset.

base-commit: 98be320183579b3d09cf4059e86a9781485628b4
--
2.48.1