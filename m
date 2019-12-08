Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F31163A1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 20:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfLHTrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 14:47:10 -0500
Received: from mout01.posteo.de ([185.67.36.65]:47478 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfLHTrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:47:10 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 59E2B160061
        for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2019 20:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1575834427; bh=7v8h57nbuElqsj5jB948wzc4FlIs7ExKcvJcrr350IA=;
        h=From:To:Cc:Subject:Date:From;
        b=VaWCuzubSCL8aiFo256pQRLTa51PaGnDfi+QmhK/RDsGes0z3xyVL9z9u2eLG6U5x
         gRJNuZVb1voZnCThMX13T4GLZFGcJ1zLXeHlpkWWqZDLivDEOjPRX+lgM5WBIEVpYh
         TRNGM5pw2PwZh0RSSq7UPZRQOwfmRkeskXdZFmZs/JCviR/KFcRqGihQIqU8h6thko
         r0eceEGX4gHZQDfwE1P2uZav0Hng+kJQG8E8xeAq7wmVkkbiPbF7piBH1MTCEGJ+YG
         gELQWS7MtohVzchyjOKuBY7yo5U3I4ZnzNHRh1MsfZSCnNODGds69U+vODUlvnEOYr
         sT3BSwWKx4kmQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47WH0B3N8Qz6tmG;
        Sun,  8 Dec 2019 20:47:06 +0100 (CET)
From:   =?UTF-8?q?Moritz=20M=C3=BCller?= <moritzm.mueller@posteo.de>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Cc:     =?UTF-8?q?Moritz=20M=C3=BCller?= <moritzm.mueller@posteo.de>,
        "Philip K ." <philip@warpmail.net>
Subject: [PATCH] floppy: hide invalid floppy disk types
Date:   Sun,  8 Dec 2019 20:45:35 +0100
Message-Id: <20191208194534.32270-1-moritzm.mueller@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases floppy disks are being indexed, even though no actual
device exists. In our case this was caused by the CMOS-RAM having a few
peculiar bits. This caused a non-existent floppy disk of the type 13 to
be registered as an possibly mountable device, even though it could not
be mounted by any user.

We believe this to be an instance of this bug, as we had similar logs
and issues:

 https://bugzilla.kernel.org/show_bug.cgi?id=13486
 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/384579

This patch adds the option FLOPPY_ALLOW_UNKNOWN_TYPES to prevent the
additional check that fixed the issue on our reference system, and
increases the startup time of affected systems by over a minute.

Co-developed-by: Philip K. <philip@warpmail.net>
Signed-off-by: Philip K. <philip@warpmail.net>
Signed-off-by: Moritz Müller <moritzm.mueller@posteo.de>
---
 drivers/block/Kconfig  | 10 ++++++++++
 drivers/block/floppy.c |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..9e6b32c50b67 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -72,6 +72,16 @@ config AMIGA_Z2RAM
 	  To compile this driver as a module, choose M here: the
 	  module will be called z2ram.
 
+config FLOPPY_ALLOW_UNKNOWN_TYPES
+	bool "Allow floppy disks of unknown type to be registered."
+	default n
+	help
+	  Select this option if you want the Kernel to register floppy
+	  disks of an unknown type.
+
+	  This should usually not be enabled, because of cases where the
+	  system falsely recognizes a non-existent floppy disk as mountable.
+
 config CDROM
 	tristate
 	select BLK_SCSI_REQUEST
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 485865fd0412..9439444d46d0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3949,7 +3949,9 @@ static void __init config_types(void)
 			} else
 				allowed_drive_mask &= ~(1 << drive);
 		} else {
+#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
 			params = &default_drive_params[0].params;
+#endif
 			snprintf(temparea, sizeof(temparea),
 				 "unknown type %d (usb?)", type);
 			name = temparea;
@@ -4518,6 +4520,10 @@ static bool floppy_available(int drive)
 		return false;
 	if (fdc_state[FDC(drive)].version == FDC_NONE)
 		return false;
+#ifndef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
+	if (type >= ARRAY_SIZE(default_drive_params))
+		return false;
+#endif
 	return true;
 }
 
-- 
2.20.1

