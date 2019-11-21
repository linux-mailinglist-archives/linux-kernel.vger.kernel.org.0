Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCECF1049CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 06:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKUFCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 00:02:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:36490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfKUFCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:02:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0F52B183;
        Thu, 21 Nov 2019 05:02:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 9/9] arm64: dts: realtek: rtd139x: Add irq muxes and UART interrupts
Date:   Thu, 21 Nov 2019 06:02:08 +0100
Message-Id: <20191121050208.11324-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121050208.11324-1-afaerber@suse.de>
References: <20191121050208.11324-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iso and misc IRQ mux DT nodes for Realtek RTD1395 SoC.

Update the UART DT nodes with interrupts from these muxes,
so that UART0 can be used without earlycon.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4 -> v5: Unchanged
 
 v4: New
 
 arch/arm64/boot/dts/realtek/rtd139x.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd139x.dtsi b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
index 706da12f9ea3..f53cb8a5083b 100644
--- a/arch/arm64/boot/dts/realtek/rtd139x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
@@ -84,6 +84,14 @@
 				#reset-cells = <1>;
 			};
 
+			iso_irq_mux: interrupt-controller@7000 {
+				compatible = "realtek,rtd1395-iso-irq-mux";
+				reg = <0x7000 0x100>;
+				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
 			iso_reset: reset-controller@7088 {
 				compatible = "snps,dw-low-reset";
 				reg = <0x7088 0x4>;
@@ -103,6 +111,8 @@
 				reg-io-width = <4>;
 				clock-frequency = <27000000>;
 				resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
+				interrupt-parent = <&iso_irq_mux>;
+				interrupts = <2>;
 				status = "disabled";
 			};
 
@@ -111,6 +121,14 @@
 				reg = <0x1a200 0x8>;
 			};
 
+			misc_irq_mux: interrupt-controller@1b000 {
+				compatible = "realtek,rtd1395-misc-irq-mux";
+				reg = <0x1b000 0x100>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
 			uart1: serial@1b200 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0x1b200 0x100>;
@@ -118,6 +136,8 @@
 				reg-io-width = <4>;
 				clock-frequency = <432000000>;
 				resets = <&reset2 RTD1295_RSTN_UR1>;
+				interrupt-parent = <&misc_irq_mux>;
+				interrupts = <3>;
 				status = "disabled";
 			};
 
@@ -128,6 +148,8 @@
 				reg-io-width = <4>;
 				clock-frequency = <432000000>;
 				resets = <&reset2 RTD1295_RSTN_UR2>;
+				interrupt-parent = <&misc_irq_mux>;
+				interrupts = <8>;
 				status = "disabled";
 			};
 		};
-- 
2.16.4

