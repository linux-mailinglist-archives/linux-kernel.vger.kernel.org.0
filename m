Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99DFD8AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391630AbfJPI1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:27:08 -0400
Received: from smtp2.goneo.de ([85.220.129.33]:55104 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfJPI1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:27:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 6F2A823F823;
        Wed, 16 Oct 2019 10:27:05 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.082
X-Spam-Level: 
X-Spam-Status: No, score=-3.082 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.182, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w3S4VUh7oJUr; Wed, 16 Oct 2019 10:27:04 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 17AFD23FF79;
        Wed, 16 Oct 2019 10:27:04 +0200 (CEST)
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "GitAuthor: Lars Poeschel" <poeschel@lemonage.de>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] auxdisplay: lcd2s DT binding doc
Date:   Wed, 16 Oct 2019 10:26:47 +0200
Message-Id: <20191016082654.6173-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016082430.5955-1-poeschel@lemonage.de>
References: <20191016082430.5955-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding doc for the modtronix lcd2s auxdisplay driver. It also
adds modtronix to the list of known vendor-prefixes.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 .../bindings/auxdisplay/modtronix,lcd2s.txt   | 24 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.txt

diff --git a/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.txt b/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.txt
new file mode 100644
index 000000000000..2d4235482658
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.txt
@@ -0,0 +1,24 @@
+DT bindings for the LCD2S Character LCD Display
+
+The LCD2S is a Character LCD Display manufactured by Modtronix Engineering.
+The display supports a serial I2C and SPI interface. The driver currently
+only supports the I2C interface.
+
+Required properties:
+  - compatible: Must contain "modtronix,lcd2s",
+  - reg: I2C bus address of the display,
+  - display-height-chars: Height of the display, in character cells,
+  - display-width-chars: Width of the display, in character cells.
+
+Example:
+
+i2c1: i2c@0 {
+	compatible = "ti,omap3-i2c";
+
+	lcd2s: auxdisplay@28 {
+		reg = <0x28>;
+		compatible = "modtronix,lcd2s";
+		display-height-chars = <4>;
+		display-width-chars = <20>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..b853974956f1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -603,6 +603,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^modtronix,.*":
+    description: Modtronix Engineering
   "^mosaixtech,.*":
     description: Mosaix Technologies, Inc.
   "^motorola,.*":
-- 
2.23.0

