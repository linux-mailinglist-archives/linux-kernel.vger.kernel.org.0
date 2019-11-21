Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E6E104927
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 04:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKUDUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 22:20:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfKUDUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:48 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5B8208A3;
        Thu, 21 Nov 2019 03:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306447;
        bh=NjVI8odmttsECwSZARjFEDrBXK5my+3emM678PTtG94=;
        h=From:To:Cc:Subject:Date:From;
        b=WQZK6cMtaWkIJOSMao3ywIh41eaZr/u5Q+zJRP2Ygdiih7Vut5cuyF2oorTeQxGlh
         8UhcwkSQ7REj+BI1zv0UYiC6enciol0rMqllbx5yAPsRoQCYcITn7fO/0tfEWxY6z2
         pnake7TWOhdy79laqUJpRXpKzt7Hkz/srqWieYx8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:44 +0100
Message-Id: <1574306444-30831-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/ata/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a6beb2c5a692..c9132177faee 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -32,7 +32,7 @@ menuconfig ATA
 if ATA
 
 config ATA_NONSTANDARD
-       bool
+	bool
 
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
@@ -695,7 +695,7 @@ config PATA_IMX
 	depends on ARCH_MXC
 	help
 	  This option enables support for the PATA host available on Freescale
-          iMX SoCs.
+	  iMX SoCs.
 
 	  If unsure, say N.
 
@@ -704,7 +704,7 @@ config PATA_IT8213
 	depends on PCI
 	help
 	  This option enables support for the ITE 821 PATA
-          controllers via the new ATA layer.
+	  controllers via the new ATA layer.
 
 	  If unsure, say N.
 
@@ -732,9 +732,9 @@ config PATA_MACIO
 	depends on PPC_PMAC
 	help
 	  Most IDE capable PowerMacs have IDE busses driven by a variant
-          of this controller which is part of the Apple chipset used on
-          most PowerMac models. Some models have multiple busses using
-          different chipsets, though generally, MacIO is one of them.
+	  of this controller which is part of the Apple chipset used on
+	  most PowerMac models. Some models have multiple busses using
+	  different chipsets, though generally, MacIO is one of them.
 
 config PATA_MARVELL
 	tristate "Marvell PATA support via legacy mode"
@@ -915,7 +915,7 @@ config PATA_PXA
 	  This option enables support for harddrive attached to PXA CPU's bus.
 
 	  NOTE: This driver utilizes PXA DMA controller, in case your hardware
-	        is not capable of doing MWDMA, use pata_platform instead.
+	  is not capable of doing MWDMA, use pata_platform instead.
 
 	  If unsure, say N.
 
-- 
2.7.4

