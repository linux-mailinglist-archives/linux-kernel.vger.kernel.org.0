Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18ECE14FEE3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 20:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBBTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 14:30:21 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36278 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBBTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 14:30:21 -0500
Received: from trochilidae.toradex.int (unknown [IPv6:2a02:169:3df5::edf])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2E2FE5C3E95;
        Sun,  2 Feb 2020 20:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580671819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=c10NgeLMXY9PyKT9RGI6/m1O339YHY744+DezUz8wuY=;
        b=sROThqjmpJlX3D+RgZWB1NdsiLEgGKpFD7QGlZo8kG1+mLGcDiVNlpILZPbzrCGggfyFBh
        p1wR5g9SXC8k8tKuBvXJQKvDjt9nzsHLdxqsHhxPwuZqUIZp8+KXEXxIf/EBt4YAn98b0m
        Yga4sndTjDh4k2H0bG9U/eREBotbbDg=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     stefan@agner.ch, linux@armlinux.org.uk, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, arnd@arndb.de,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] ARM: imx: limit errata selection to Cortex-A9 based designs
Date:   Sun,  2 Feb 2020 20:30:14 +0100
Message-Id: <20200202193014.107003-1-stefan@agner.ch>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

The two erratas 754322 and 775420 are Cortex-A9 specific. Only
select the erratas for SoC which use a Cortex-A9.

Signed-off-by: Stefan Agner <stefan@agner.ch>
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

