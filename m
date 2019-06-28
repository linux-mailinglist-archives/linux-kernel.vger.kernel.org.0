Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8559AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF1MYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:24:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfF1MUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4cWjMp5PaXweLfT1aRxtKRWZepkzB8FeW0x9RJN+xzA=; b=aEjnO659FFI6XQP0TkAY0HWE5x
        wTgw4FLrcyZWEuDdS415q6pSleIRidnvguWRrRCfDQbqfblxPUAs7ep4Z7U/4FdBDdunv9xjzka9z
        0pAiBzASw3HVlSWCRg27zuTsu/TMuOse+676BwDkYrLBDmHAhG4mUvCeuBmo41KsxIj2dg/bKzIhN
        KsoH3h48lHCtxbfIirg1N2uzWdWf/3luXXgEGVx/ILEO2T6tHi+iJUPRl2uMWPVUfvkoF4YCXy9M8
        bBUrhPV3JREMazdMLQ0bYULX01nrdd63/51BHOoXWTg13qNrMwuFomiAOxMpWjLEw8ySNfcMAS+vU
        Qpt9BEfA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-0000A1-BS; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00057z-ES; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 15/43] docs: memory-devices: convert ti-emif.txt to ReST
Date:   Fri, 28 Jun 2019 09:20:11 -0300
Message-Id: <481fb7e84e78cfd12f960dbab9f562200191fff3.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare this file to be moved to a kernel book by converting
it to ReST format and renaming it to ti-emif.rst.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{ti-emif.txt => ti-emif.rst}              | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)
 rename Documentation/memory-devices/{ti-emif.txt => ti-emif.rst} (81%)

diff --git a/Documentation/memory-devices/ti-emif.txt b/Documentation/memory-devices/ti-emif.rst
similarity index 81%
rename from Documentation/memory-devices/ti-emif.txt
rename to Documentation/memory-devices/ti-emif.rst
index f4ad9a7d0f4b..c9242294e63c 100644
--- a/Documentation/memory-devices/ti-emif.txt
+++ b/Documentation/memory-devices/ti-emif.rst
@@ -1,20 +1,24 @@
-TI EMIF SDRAM Controller Driver:
+:orphan:
+
+===============================
+TI EMIF SDRAM Controller Driver
+===============================
 
 Author
-========
+======
 Aneesh V <aneesh@ti.com>
 
 Location
-============
+========
 driver/memory/emif.c
 
 Supported SoCs:
-===================
+===============
 TI OMAP44xx
 TI OMAP54xx
 
 Menuconfig option:
-==========================
+==================
 Device Drivers
 	Memory devices
 		Texas Instruments EMIF driver
@@ -29,10 +33,11 @@ functions of the driver includes re-configuring AC timing
 parameters and other settings during frequency, voltage and
 temperature changes
 
-Platform Data (see include/linux/platform_data/emif_plat.h):
-=====================================================================
+Platform Data (see include/linux/platform_data/emif_plat.h)
+===========================================================
 DDR device details and other board dependent and SoC dependent
 information can be passed through platform data (struct emif_platform_data)
+
 - DDR device details: 'struct ddr_device_info'
 - Device AC timings: 'struct lpddr2_timings' and 'struct lpddr2_min_tck'
 - Custom configurations: customizable policy options through
@@ -40,17 +45,19 @@ information can be passed through platform data (struct emif_platform_data)
 - IP revision
 - PHY type
 
-Interface to the external world:
-================================
+Interface to the external world
+===============================
 EMIF driver registers notifiers for voltage and frequency changes
 affecting EMIF and takes appropriate actions when these are invoked.
+
 - freq_pre_notify_handling()
 - freq_post_notify_handling()
 - volt_notify_handling()
 
 Debugfs
-========
+=======
 The driver creates two debugfs entries per device.
+
 - regcache_dump : dump of register values calculated and saved for all
   frequencies used so far.
 - mr4 : last polled value of MR4 register in the LPDDR2 device. MR4
-- 
2.21.0

