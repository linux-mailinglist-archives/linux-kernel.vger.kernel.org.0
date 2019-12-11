Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6511A255
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 03:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfLKC4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 21:56:13 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57980 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfLKC4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:56:09 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECDBA1A0599;
        Wed, 11 Dec 2019 03:56:07 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E0FF1A057A;
        Wed, 11 Dec 2019 03:56:03 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9C68F402AE;
        Wed, 11 Dec 2019 10:55:57 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D
Date:   Wed, 11 Dec 2019 10:53:36 +0800
Message-Id: <1576032816-23373-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM_ERRATA_814220 has below description:

The v7 ARM states that all cache and branch predictor maintenance
operations that do not specify an address execute, relative to
each other, in program order.
However, because of this erratum, an L2 set/way cache maintenance
operation can overtake an L1 set/way cache maintenance operation.
This ERRATA only affected the Cortex-A7 and present in r0p2, r0p3,
r0p4, r0p5.

i.MX6UL and i.MX7D have Cortex-A7 r0p5 inside, need to enable
ARM_ERRATA_814220 for proper workaround.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- Add errata description and ARM core version in commit message.
---
 arch/arm/mach-imx/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 593bf15..4326c8f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -520,6 +520,7 @@ config SOC_IMX6UL
 	bool "i.MX6 UltraLite support"
 	select PINCTRL_IMX6UL
 	select SOC_IMX6
+	select ARM_ERRATA_814220
 
 	help
 	  This enables support for Freescale i.MX6 UltraLite processor.
@@ -556,6 +557,7 @@ config SOC_IMX7D
 	select PINCTRL_IMX7D
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
+	select ARM_ERRATA_814220
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
-- 
2.7.4

