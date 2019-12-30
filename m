Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D812CBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 02:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfL3Bot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 20:44:49 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44304 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfL3Bor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 20:44:47 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79FD620119A;
        Mon, 30 Dec 2019 02:44:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C414200470;
        Mon, 30 Dec 2019 02:44:41 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5E5A1402DA;
        Mon, 30 Dec 2019 09:44:30 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        andreas@kemnade.info, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 5/5] ARM: dts: imx6sl-tolino-shine3: Remove incorrect power supply assignment
Date:   Mon, 30 Dec 2019 09:41:11 +0800
Message-Id: <1577670071-1322-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
References: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdd3p0's input should be from external USB VBUS directly, NOT
PMIC's dcdc2, so remove the power supply assignment for vdd3p0.

Fixes: 0b47f9201075 ("ARM: dts: add devicetree entry for Tolino Shine 3")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
index 0ee4925..27143ea 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
@@ -290,10 +290,6 @@
 	vin-supply = <&dcdc2_reg>;
 };
 
-&reg_vdd3p0 {
-	vin-supply = <&dcdc2_reg>;
-};
-
 &ricoh619 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ricoh_gpio>;
-- 
2.7.4

