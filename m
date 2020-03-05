Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4674417A6F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 08:59:48 -0500
Received: from inva021.nxp.com ([92.121.34.21]:49482 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCEN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:59:45 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBAAE200713;
        Thu,  5 Mar 2020 14:59:43 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF47520070F;
        Thu,  5 Mar 2020 14:59:43 +0100 (CET)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FCB42059D;
        Thu,  5 Mar 2020 14:59:43 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: imx8mn: align name for crypto child nodes
Date:   Thu,  5 Mar 2020 15:59:09 +0200
Message-Id: <20200305135909.8180-6-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305135909.8180-1-horia.geanta@nxp.com>
References: <20200305135909.8180-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Silvano di Ninno <silvano.dininno@nxp.com>

crypto child nodes should use the "jr" name (without an index),
as indicated in the DT binding.

Signed-off-by: Silvano di Ninno <silvano.dininno@nxp.com>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index f2775724377f..ff9c1ea38130 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -554,19 +554,19 @@
 					 <&clk IMX8MN_CLK_IPG_ROOT>;
 				clock-names = "aclk", "ipg";
 
-				sec_jr0: jr0@1000 {
+				sec_jr0: jr@1000 {
 					 compatible = "fsl,sec-v4.0-job-ring";
 					 reg = <0x1000 0x1000>;
 					 interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				sec_jr1: jr1@2000 {
+				sec_jr1: jr@2000 {
 					 compatible = "fsl,sec-v4.0-job-ring";
 					 reg = <0x2000 0x1000>;
 					 interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
-				sec_jr2: jr2@3000 {
+				sec_jr2: jr@3000 {
 					 compatible = "fsl,sec-v4.0-job-ring";
 					 reg = <0x3000 0x1000>;
 					 interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

