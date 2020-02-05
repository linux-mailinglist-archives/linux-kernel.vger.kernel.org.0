Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E06153B30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgBEWmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:42:20 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57700 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBEWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:42:20 -0500
Received: from trochilidae.toradex.int (unknown [IPv6:2a02:169:3df5::edf])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 44ED15C406B;
        Wed,  5 Feb 2020 23:42:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580942538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=IMLaqe+3/cNGrP9F0fpJ/nD3jwSko8goV2jkxITs1to=;
        b=H6Qv++Ghmk/dESi8x9UO2WFr4rza3Yso7vUCNFheHj5STpl/S0T2OYVoRfQZS+fc4fv98A
        7aG59rxGn3PZflJrTH4raYUSMHTRsi51ozcDlnXqb5htaCD3NkJ2iGEGnVX8piA1+4N7qR
        xEOIrnn56ZR/z/NfC86Nsx83QnTdtjs=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     stefan@agner.ch, linux@armlinux.org.uk, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, arnd@arndb.de,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v2] ARM: imx: limit errata selection to Cortex-A9 based designs
Date:   Wed,  5 Feb 2020 23:42:14 +0100
Message-Id: <20200205224214.253098-1-stefan@agner.ch>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

The two erratas 754322 and 775420 are Cortex-A9 specific. The i.MX 6UL
SoCs include a Cortex-A7 CPU and hence do not need this erratas enabeld.
This patch moves the errata selection from the family Kconfig symbol to
the SoC specifc Kconfig symbols where a Cortex-A9 is used.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/mach-imx/Kconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 95584ee02b55..e7d7b90e2cf8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -471,8 +471,6 @@ config	SOC_IMX53
 config SOC_IMX6
 	bool
 	select ARM_CPU_SUSPEND if (PM || CPU_IDLE)
-	select ARM_ERRATA_754322
-	select ARM_ERRATA_775420
 	select ARM_GIC
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_GPC
@@ -484,6 +482,8 @@ config SOC_IMX6
 config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
 	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD
 	select PINCTRL_IMX6Q
@@ -494,6 +494,8 @@ config SOC_IMX6Q
 
 config SOC_IMX6SL
 	bool "i.MX6 SoloLite support"
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
 	select PINCTRL_IMX6SL
 	select SOC_IMX6
 
@@ -502,6 +504,8 @@ config SOC_IMX6SL
 
 config SOC_IMX6SLL
 	bool "i.MX6 SoloLiteLite support"
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
 	select PINCTRL_IMX6SLL
 	select SOC_IMX6
 
@@ -510,6 +514,8 @@ config SOC_IMX6SLL
 
 config SOC_IMX6SX
 	bool "i.MX6 SoloX support"
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
 	select PINCTRL_IMX6SX
 	select SOC_IMX6
 
-- 
2.25.0

