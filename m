Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE7164B50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBSRBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:01:17 -0500
Received: from muru.com ([72.249.23.125]:56052 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgBSRBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:01:16 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id F0C2C80F3;
        Wed, 19 Feb 2020 17:02:00 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: mfd: motmdm: Add binding for motorola-mdm
Date:   Wed, 19 Feb 2020 09:01:05 -0800
Message-Id: <20200219170106.38543-4-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200219170106.38543-1-tony@atomide.com>
References: <20200219170106.38543-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding document for Motorola modems controllable by
TS 27.010 UART line discipline using serdev drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../mfd/motorola,mapphone-mdm6600.yaml        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml

diff --git a/Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml b/Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/motorola,mapphone-mdm6600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola Mapphone MDM6600 Modem
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+allOf:
+  - $ref: "motorola,mapphone-mdm6600.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: motorola,mapphone-mdm6600-serial
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: usb
+
+required:
+  - compatible
+  - phys
+  - phy-names
+
+examples:
+  - |
+    modem {
+        compatible = "motorola,mapphone-mdm6600-serial";
+        phys = <&fsusb1_phy>;
+        phy-names = "usb";
+    };
-- 
2.25.1
