Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602CFED709
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 02:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfKDBkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 20:40:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:55830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbfKDBk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:40:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56B4BB22E;
        Mon,  4 Nov 2019 01:40:27 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 5/7] ARM: dts: rtd1195: Add Mali node
Date:   Mon,  4 Nov 2019 02:39:30 +0100
Message-Id: <20191104013932.22505-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104013932.22505-1-afaerber@suse.de>
References: <20191104013932.22505-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for the Mali GPU.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/rtd1195.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index 774f95d544a3..ae8843782cfa 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -292,6 +292,25 @@
 			status = "disabled";
 		};
 
+		/* TODO 0x18030000 0x10000 or 0x18003000 0x1000? */
+		mali: gpu@18030000 {
+			compatible = "realtek,rtd1195-mali", "arm,mali-400";
+			reg = <0x18030000 0x10000>;
+			/* TODO which bus clk to pass? */
+			clocks = <&clkc RTD1195_CLK_EN_GPU>, <&osc27M>;
+			clock-names = "core", "bus";
+			resets = <&reset1 RTD1195_RSTN_GPU>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",  "gpmmu",
+					  "pp0", "ppmmu0",
+					  "pp1", "ppmmu1";
+		};
+
 		gic: interrupt-controller@ff011000 {
 			compatible = "arm,cortex-a7-gic";
 			reg = <0xff011000 0x1000>,
-- 
2.16.4

