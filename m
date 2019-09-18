Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A53B5F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfIRI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:28:19 -0400
Received: from mail.thundersoft.com ([114.242.213.61]:46640 "EHLO
        mail2.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfIRI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:28:19 -0400
Received: from localhost (unknown [192.168.122.240])
        by mail2.thundersoft.com (Postfix) with ESMTPA id 5F07D15208D2;
        Wed, 18 Sep 2019 16:28:16 +0800 (CST)
From:   shifu0704@thundersoft.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     dmurphy@ti.com, navada@ti.com,
        Frank Shi <shifu0704@thundersoft.com>
Subject: [PATCH v6] dt-bindings: ASoC: Add tas2770 smart PA dt bindings
Date:   Wed, 18 Sep 2019 16:28:12 +0800
Message-Id: <1568795293-19697-1-git-send-email-shifu0704@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Shi <shifu0704@thundersoft.com>

Add tas2770 smart PA dt bindings

Signed-off-by: Frank Shi <shifu0704@thundersoft.com>
---
 .../devicetree/bindings/sound/tas2770.txt          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2770.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2770.txt b/Documentation/devicetree/bindings/sound/tas2770.txt
new file mode 100644
index 0000000..ede6bb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2770.txt
@@ -0,0 +1,37 @@
+Texas Instruments TAS2770 Smart PA
+
+The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
+efficiently driving high peak power into small loudspeakers.
+Integrated speaker voltage and current sense provides for
+real time monitoring of loudspeaker behavior.
+
+Required properties:
+
+ - compatible:	   - Should contain "ti,tas2770".
+ - reg:		       - The i2c address. Should contain <0x4c>, <0x4d>,<0x4e>, or <0x4f>.
+ - #address-cells  - Should be <1>.
+ - #size-cells     - Should be <0>.
+ - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+ - ti,vmon-slot-no:- TDM TX voltage sense time slot.
+
+Optional properties:
+
+- interrupt-parent: the phandle to the interrupt controller which provides
+                     the interrupt.
+- interrupts: interrupt specification for data-ready.
+
+Examples:
+
+    tas2770@4c {
+                compatible = "ti,tas2770";
+                reg = <0x4c>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                interrupt-parent = <&msm_gpio>;
+                interrupts = <97 0>;
+                ti,asi-format = <0>;
+                ti,imon-slot-no = <0>;
+                ti,vmon-slot-no = <2>;
+        };
+
-- 
2.7.4

