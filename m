Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88D1775A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 13:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgCCMIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 07:08:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:44776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgCCMIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:08:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D37C7AEE7;
        Tue,  3 Mar 2020 12:08:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     phil@raspberrypi.org, florian.fainelli@broadcom.com,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] DTS: bcm2711: Move emmc2 into its own bus
Date:   Tue,  3 Mar 2020 13:08:20 +0100
Message-Id: <20200303120820.4377-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on bcm2711's revision its emmc2 controller might have
different DMA constraints. Raspberry Pi 4's firmware will take care of
updating those, but only if a certain alias is found in the device tree.
So, move emmc2 into its own bus, so as not to pollute other devices with
dma-ranges changes and create the emmc2bus alias.

Based in Phil ELwell's downstream implementation.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts |  1 +
 arch/arm/boot/dts/bcm2711.dtsi        | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 1d4b589fe233..e26ea9006378 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -20,6 +20,7 @@ memory@0 {
 	};
 
 	aliases {
+		emmc2bus = &emmc2bus;
 		ethernet0 = &genet;
 		pcie0 = &pcie0;
 	};
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index d1e684d0acfd..61ea8b44c51e 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -241,17 +241,26 @@ pwm1: pwm@7e20c800 {
 			status = "disabled";
 		};
 
+		hvs@7e400000 {
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	emmc2bus: emmc2bus {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = <0x0 0x7e000000  0x0 0xfe000000  0x01800000>;
+		dma-ranges = <0x0 0xc0000000  0x0 0x00000000  0x40000000>;
+
 		emmc2: emmc2@7e340000 {
 			compatible = "brcm,bcm2711-emmc2";
-			reg = <0x7e340000 0x100>;
+			reg = <0x0 0x7e340000 0x100>;
 			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clocks BCM2711_CLOCK_EMMC2>;
 			status = "disabled";
 		};
-
-		hvs@7e400000 {
-			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-		};
 	};
 
 	arm-pmu {
-- 
2.25.1

