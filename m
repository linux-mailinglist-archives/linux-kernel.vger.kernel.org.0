Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911B35F2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 08:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGDGXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 02:23:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53956 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDGXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:23:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7F1A20022D;
        Thu,  4 Jul 2019 08:23:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0156F20054A;
        Thu,  4 Jul 2019 08:23:08 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 12DF8402C3;
        Thu,  4 Jul 2019 14:22:56 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] arm64: dts: imx8mq: Assign highest opp as suspend opp
Date:   Thu,  4 Jul 2019 14:14:02 +0800
Message-Id: <20190704061403.8249-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Assign highest OPP as suspend OPP to reduce suspend/resume
latency on i.MX8MQ.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
This patch is based on https://patchwork.kernel.org/patch/11023815/
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 3187428..c61e968 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -171,6 +171,7 @@
 			opp-microvolt = <1000000>;
 			opp-supported-hw = <0xc>, <0x4>;
 			clock-latency-ns = <150000>;
+			opp-suspend;
 		};
 
 		opp-1500000000 {
@@ -178,6 +179,7 @@
 			opp-microvolt = <1000000>;
 			opp-supported-hw = <0x8>, <0x3>;
 			clock-latency-ns = <150000>;
+			opp-suspend;
 		};
 	};
 
-- 
2.7.4

