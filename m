Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79998192CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgCYPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 11:39:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52840 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgCYPj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:39:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F8751A057C;
        Wed, 25 Mar 2020 16:39:25 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9097A1A0557;
        Wed, 25 Mar 2020 16:39:25 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DBD94203CE;
        Wed, 25 Mar 2020 16:39:24 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 03/13] arm64: dts: imx8mp: Add AIPS 4 and 5
Date:   Wed, 25 Mar 2020 17:38:41 +0200
Message-Id: <1585150731-3354-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 5 AIPS maps in total, according to the RM. Add the missing
ones here.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b1616e..c08156f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -318,7 +318,7 @@
 
 		aips2: bus@30400000 {
 			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x305f0000 0x400000>;
+			reg = <0x305f0000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -378,7 +378,7 @@
 
 		aips3: bus@30800000 {
 			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x309f0000 0x400000>;
+			reg = <0x309f0000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -641,6 +641,22 @@
 			};
 		};
 
+		aips4: bus@32c00000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x32c00000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
+		aips5: bus@30c00000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			reg = <0x30c00000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.7.4

