Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7574E1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfFUI07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 04:26:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40790 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfFUI06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:26:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E5B571A09A7;
        Fri, 21 Jun 2019 10:26:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 138531A0206;
        Fri, 21 Jun 2019 10:26:48 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2B70C402F1;
        Fri, 21 Jun 2019 16:26:37 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, ccaione@baylibre.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] arm64: dts: imx8mq: Add system counter node
Date:   Fri, 21 Jun 2019 16:28:38 +0800
Message-Id: <20190621082838.12630-3-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621082838.12630-1-Anson.Huang@nxp.com>
References: <20190621082838.12630-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MQ system counter node to enable timer-imx-sysctr
broadcast timer driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808..9d99191 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -635,6 +635,14 @@
 				#pwm-cells = <2>;
 				status = "disabled";
 			};
+
+			system_counter: timer@306a0000 {
+				compatible = "nxp,sysctr-timer";
+				reg = <0x306a0000 0x30000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency = <8333333>;
+			};
 		};
 
 		bus@30800000 { /* AIPS3 */
-- 
2.7.4

