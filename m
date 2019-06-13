Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7709844665
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393014AbfFMQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:51:27 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57788 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfFMDdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:33:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F2DA1A030B;
        Thu, 13 Jun 2019 05:33:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2000D1A030E;
        Thu, 13 Jun 2019 05:33:38 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3C725402A0;
        Thu, 13 Jun 2019 11:33:32 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/6] ARM: dts: imx6sx: Enable SNVS power key according to board design
Date:   Thu, 13 Jun 2019 11:35:23 +0800
Message-Id: <20190613033527.40555-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613033527.40555-1-Anson.Huang@nxp.com>
References: <20190613033527.40555-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

The SNVS power key depends on board design, by default it should
be disabled in SoC DT and ONLY be enabled on board DT if it is
wired up.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts | 4 ++++
 arch/arm/boot/dts/imx6sx-sdb.dts      | 4 ++++
 arch/arm/boot/dts/imx6sx.dtsi         | 1 +
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index 5b3d6c10..f1830ed 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -166,3 +166,7 @@
 &reg_vdd2p5 {
 	vin-supply = <&vgen6_reg>;
 };
+
+&snvs_pwrkey {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 10f6da8..a8ee708 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -153,3 +153,7 @@
 	/* Transceiver EN/STBY is active low on RevB board */
 	gpio = <&gpio4 27 GPIO_ACTIVE_LOW>;
 };
+
+&snvs_pwrkey {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index bbdfdd8..bb25add 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -738,6 +738,7 @@
 					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 					linux,keycode = <KEY_POWER>;
 					wakeup-source;
+					status = "disabled";
 				};
 			};
 
-- 
2.7.4

