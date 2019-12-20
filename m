Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BBF128277
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 19:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfLTSxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 13:53:01 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54932 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727390AbfLTSxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:53:00 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B05A52003C1;
        Fri, 20 Dec 2019 19:52:58 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0C142013CC;
        Fri, 20 Dec 2019 19:52:54 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A7FBB402A5;
        Sat, 21 Dec 2019 02:52:49 +0800 (SGT)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] arm64: dts: ls208xa: Update qspi node properties for LS2088ARDB
Date:   Sat, 21 Dec 2019 00:22:34 +0530
Message-Id: <1576867954-17756-1-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS2088ADB has one spansion flash s25fs512s of size 64M.

Add qspi dts entry for the board using compatibles as "jedec,spi-nor" to
probe flash successfully. Also, align properties with other board dts
properties.

Use dt-bindings constants in interrupts instead of using numbers.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 10 +++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 6fd7f63085c9..d0d670227ae2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -108,7 +108,15 @@
 };
 
 &qspi {
-	status = "disabled";
+	status = "okay";
+
+	s25fs512s0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+	};
 };
 
 &sata0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 8b2fd278844b..f96d06da96be 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -618,16 +618,16 @@
 		};
 
 		qspi: spi@20c0000 {
-			status = "disabled";
 			compatible = "fsl,ls2080a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x20c0000 0x0 0x10000>,
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "QuadSPI", "QuadSPI-memory";
-			interrupts = <0 25 0x4>; /* Level high type */
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
 			clock-names = "qspi_en", "qspi";
+			status = "disabled";
 		};
 
 		pcie1: pcie@3400000 {
-- 
2.17.1

