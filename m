Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5BFEAE69B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbfIJJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 05:19:36 -0400
Received: from smtp3.goneo.de ([85.220.129.37]:33404 "EHLO smtp3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbfIJJTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:19:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 0247F23FDF8;
        Tue, 10 Sep 2019 11:19:32 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.035
X-Spam-Level: 
X-Spam-Status: No, score=-3.035 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.135, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dffO01LN1ocM; Tue, 10 Sep 2019 11:19:31 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 671F923FA02;
        Tue, 10 Sep 2019 11:19:31 +0200 (CEST)
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "GitAuthor: Lars Poeschel" <poeschel@lemonage.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     Johan Hovold <johan@kernel.org>
Subject: [PATCH v7 2/7] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Date:   Tue, 10 Sep 2019 11:32:53 +0200
Message-Id: <20190910093256.1920-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple binding doc for the pn532.

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v6:
- Rebased the patch series on v5.3-rc5
- Picked up Rob's Reviewed-By

Changes in v4:
- Add documentation about reg property in case of i2c

Changes in v3:
- seperate binding doc instead of entry in trivial-devices.txt

 .../devicetree/bindings/nfc/pn532.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nfc/pn532.txt

diff --git a/Documentation/devicetree/bindings/nfc/pn532.txt b/Documentation/devicetree/bindings/nfc/pn532.txt
new file mode 100644
index 000000000000..d5aaa588073d
--- /dev/null
+++ b/Documentation/devicetree/bindings/nfc/pn532.txt
@@ -0,0 +1,33 @@
+NXP PN532 NFC Chip
+
+Required properties:
+- compatible: Should be
+    - "nxp,pn532" Place a node with this inside the devicetree node of the bus
+                  where the NFC chip is connected to.
+                  Currently the kernel has phy bindings for uart and i2c.
+    - "nxp,pn532-i2c" (DEPRECATED) only works for the i2c binding.
+    - "nxp,pn533-i2c" (DEPRECATED) only works for the i2c binding.
+
+Required properties if connected on i2c:
+- reg: for the i2c bus address. This is fixed at 0x48 for the PN532.
+
+Example uart:
+
+uart4: serial@49042000 {
+        compatible = "ti,omap3-uart";
+
+        pn532: nfc {
+                compatible = "nxp,pn532";
+        };
+};
+
+Example i2c:
+
+i2c1: i2c@0 {
+        compatible = "ti,omap3-i2c";
+
+        pn532: nfc {
+                compatible = "nxp,pn532";
+                reg = <0x48>;
+        };
+};
-- 
2.23.0

