Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1F171671
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgB0Lza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 06:55:30 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:44832 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgB0Lza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:55:30 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 48F8815EF6; Thu, 27 Feb 2020 11:55:28 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: sunxi: h3/h5: add r_pwm node
Date:   Thu, 27 Feb 2020 11:55:26 +0000
Message-Id: <20200227115526.28075-1-mans@mansr.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a second PWM unit available in the PL I/O block.
Add a node and pinmux definition for it.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changed in v2:
- use singular name (pin vs pins) for pinmux group
- set pinmux in device node as there is only one choice
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 107eeafad20a..54b32537d6ae 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -871,6 +871,21 @@
 				pins = "PL0", "PL1";
 				function = "s_i2c";
 			};
+
+			r_pwm_pin: r-pwm-pin {
+				pins = "PL10";
+				function = "s_pwm";
+			};
+		};
+
+		r_pwm: pwm@1f03800 {
+			compatible = "allwinner,sun8i-h3-pwm";
+			reg = <0x01f03800 0x8>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_pwm_pin>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
 		};
 	};
 };
-- 
2.25.0

