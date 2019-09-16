Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2878BB3847
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 12:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbfIPKgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 06:36:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47304 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfIPKgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:36:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 01D781A0207;
        Mon, 16 Sep 2019 12:36:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B3FD41A0049;
        Mon, 16 Sep 2019 12:36:17 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 89A4C402CA;
        Mon, 16 Sep 2019 18:36:12 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [2/3] arm: dts: ls1021a: fix that FlexTimer cannot wakeup system in deep sleep
Date:   Mon, 16 Sep 2019 18:25:55 +0800
Message-Id: <20190916102556.16655-2-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190916102556.16655-1-biwen.li@nxp.com>
References: <20190916102556.16655-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fix a bug that FlexTimer cannot
wakeup system in deep sleep.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index e3973b611c3a..377bb4717584 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -1000,12 +1000,13 @@
 			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x8>;
 			#fsl,rcpm-wakeup-cells = <2>;
+			fsl,rcpm-scfg = <&scfg 0x0 0x51c>; /* SCFG_SPARECR8 */
 		};
 
 		ftm_alarm0: timer0@29d0000 {
 			compatible = "fsl,ls1021a-ftm-alarm";
 			reg = <0x0 0x29d0000 0x0 0x10000>;
-			fsl,rcpm-wakeup = <&rcpm 0x0 0x20000000>;
+			fsl,rcpm-wakeup = <&rcpm 0x0 0x30000000>; /* FlexTimer1 and OCRAM1 are not powerdown during LPM20(sleep) */
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			big-endian;
 		};
-- 
2.17.1

