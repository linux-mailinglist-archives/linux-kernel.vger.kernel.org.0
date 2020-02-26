Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011E21707C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgBZSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 13:33:28 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:39338 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgBZSd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:33:28 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 3C5FB15EF6; Wed, 26 Feb 2020 18:33:26 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sunxi: h3/h5: add r_pwm node
Date:   Wed, 26 Feb 2020 18:33:16 +0000
Message-Id: <20200226183316.26159-1-mans@mansr.com>
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
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 107eeafad20a..1842c9f12c36 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -871,6 +871,19 @@
 				pins = "PL0", "PL1";
 				function = "s_i2c";
 			};
+
+			r_pwm_pins: r-pwm-pins {
+				pins = "PL10";
+				function = "s_pwm";
+			};
+		};
+
+		r_pwm: pwm@1f03800 {
+			compatible = "allwinner,sun8i-h3-pwm";
+			reg = <0x01f03800 0x8>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
 		};
 	};
 };
-- 
2.25.0

