Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA0103C57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbfKTNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfKTNm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:56 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081AB224FC;
        Wed, 20 Nov 2019 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257376;
        bh=mcshde1DXfPlrTcso7HevGxkj/tsZLZId92qk1mAbV4=;
        h=From:To:Cc:Subject:Date:From;
        b=rXRH0AUI5l8YdAs6ip+DUnHABA3BVOMvgunFz7rPz6Hac9d+khiyYIlWhNpo/5M1J
         lz73qXW4lMGc+juwkL5kN1riPG27w5/7My/xiIny7wL5bNRz1WVmU0mEnDgaGG/sf9
         cUOvg4T+R6dNo2vpTSWw4VG1uC8SNkmQlEtBKQZ4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:52 +0800
Message-Id: <20191120134252.16129-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/block/Kconfig          | 28 ++++++++++++++--------------
 drivers/block/mtip32xx/Kconfig |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..fa0cd072f5a1 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -142,10 +142,10 @@ config BLK_DEV_UBD
 	bool "Virtual block device"
 	depends on UML
 	---help---
-          The User-Mode Linux port includes a driver called UBD which will let
-          you access arbitrary files on the host computer as block devices.
-          Unless you know that you do not need such virtual block devices say
-          Y here.
+	  The User-Mode Linux port includes a driver called UBD which will let
+	  you access arbitrary files on the host computer as block devices.
+	  Unless you know that you do not need such virtual block devices say
+	  Y here.
 
 config BLK_DEV_UBD_SYNC
 	bool "Always do synchronous disk IO for UBD"
@@ -156,16 +156,16 @@ config BLK_DEV_UBD_SYNC
 	  Linux 'Virtual Machine' uses a journalling filesystem and the host
 	  computer crashes.
 
-          Synchronous operation (i.e. always writing data to the host's disk
-          immediately) is configurable on a per-UBD basis by using a special
-          kernel command line option.  Alternatively, you can say Y here to
-          turn on synchronous operation by default for all block devices.
+	  Synchronous operation (i.e. always writing data to the host's disk
+	  immediately) is configurable on a per-UBD basis by using a special
+	  kernel command line option.  Alternatively, you can say Y here to
+	  turn on synchronous operation by default for all block devices.
 
-          If you're running a journalling file system (like reiserfs, for
-          example) in your virtual machine, you will want to say Y here.  If
-          you care for the safety of the data in your virtual machine, Y is a
-          wise choice too.  In all other cases (for example, if you're just
-          playing around with User-Mode Linux) you can choose N.
+	  If you're running a journalling file system (like reiserfs, for
+	  example) in your virtual machine, you will want to say Y here.  If
+	  you care for the safety of the data in your virtual machine, Y is a
+	  wise choice too.  In all other cases (for example, if you're just
+	  playing around with User-Mode Linux) you can choose N.
 
 config BLK_DEV_COW_COMMON
 	bool
@@ -430,7 +430,7 @@ config VIRTIO_BLK
 	depends on VIRTIO
 	---help---
 	  This is the virtual block driver for virtio.  It can be used with
-          QEMU based VMMs (like KVM or Xen).  Say Y or M.
+	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 config VIRTIO_BLK_SCSI
 	bool "SCSI passthrough request for the Virtio block driver"
diff --git a/drivers/block/mtip32xx/Kconfig b/drivers/block/mtip32xx/Kconfig
index bf221358567e..a469dc72e67a 100644
--- a/drivers/block/mtip32xx/Kconfig
+++ b/drivers/block/mtip32xx/Kconfig
@@ -7,4 +7,4 @@ config BLK_DEV_PCIESSD_MTIP32XX
 	tristate "Block Device Driver for Micron PCIe SSDs"
 	depends on PCI
 	help
-          This enables the block driver for Micron PCIe SSDs.
+	  This enables the block driver for Micron PCIe SSDs.
-- 
2.17.1

