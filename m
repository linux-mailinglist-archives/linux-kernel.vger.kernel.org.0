Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678EC10113D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 03:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKSCTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 21:19:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfKSCT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:19:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 359A4B330;
        Tue, 19 Nov 2019 02:19:24 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 5/8] ARM: dts: rtd1195: Add irq muxes and UART interrupts
Date:   Tue, 19 Nov 2019 03:19:14 +0100
Message-Id: <20191119021917.15917-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191119021917.15917-1-afaerber@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iso and misc IRQ mux DT nodes for the Realtek RTD1195 SoC.

Update the UART DT nodes with interrupts from those muxes,
so that UART0 can be used without earlycon.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4: New
 
 arch/arm/boot/dts/rtd1195.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index db1171c5adfa..ee7761ae4ee0 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -118,6 +118,14 @@
 				#reset-cells = <1>;
 			};
 
+			iso_irq_mux: interrupt-controller@7000 {
+				compatible = "realtek,rtd1195-iso-irq-mux";
+				reg = <0x7000 0x100>;
+				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
 			iso_reset: reset-controller@7088 {
 				compatible = "snps,dw-low-reset";
 				reg = <0x7088 0x4>;
@@ -137,6 +145,8 @@
 				reg-io-width = <4>;
 				resets = <&iso_reset RTD1195_ISO_RSTN_UR0>;
 				clock-frequency = <27000000>;
+				interrupt-parent = <&iso_irq_mux>;
+				interrupts = <2>;
 				status = "disabled";
 			};
 
@@ -145,6 +155,14 @@
 				reg = <0x1a200 0x8>;
 			};
 
+			misc_irq_mux: interrupt-controller@1b000 {
+				compatible = "realtek,rtd1195-misc-irq-mux";
+				reg = <0x1b000 0x100>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
 			uart1: serial@1b200 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x1b200 0x100>;
@@ -152,6 +170,8 @@
 				reg-io-width = <4>;
 				resets = <&reset2 RTD1195_RSTN_UR1>;
 				clock-frequency = <27000000>;
+				interrupt-parent = <&misc_irq_mux>;
+				interrupts = <3>;
 				status = "disabled";
 			};
 		};
-- 
2.16.4

