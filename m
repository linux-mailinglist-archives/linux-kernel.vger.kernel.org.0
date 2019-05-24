Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0BF28ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 03:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbfEXBaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 21:30:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34382 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388141AbfEXBaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:30:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 545011A0345;
        Fri, 24 May 2019 03:30:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 946971A0342;
        Fri, 24 May 2019 03:30:04 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9D0824029F;
        Fri, 24 May 2019 09:29:59 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: Add temperature sensor node
Date:   Fri, 24 May 2019 09:21:51 +0800
Message-Id: <20190524012151.31840-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nxp sa56004 chip node for temperature monitor.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 5 +++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index b359068d9605..31fd626dd344 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -131,6 +131,11 @@
 				compatible = "atmel,24c512";
 				reg = <0x57>;
 			};
+
+			temp@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+			};
 		};
 
 		i2c@5 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index f9c272fb0738..012b3f8696b7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -119,6 +119,11 @@
 				compatible = "nxp,pcf2129";
 				reg = <0x51>;
 			};
+
+			temp@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+			};
 		};
 	};
 };
-- 
2.17.1

