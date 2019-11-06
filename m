Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B9F192C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfKFOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 09:54:17 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:44065 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727312AbfKFOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:54:16 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xA6ErXWN026782;
        Wed, 6 Nov 2019 16:53:33 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id CAE1460329; Wed,  6 Nov 2019 16:53:33 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: reset: add NPCM reset controller documentation
Date:   Wed,  6 Nov 2019 16:53:29 +0200
Message-Id: <20191106145331.25740-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191106145331.25740-1-tmaimon77@gmail.com>
References: <20191106145331.25740-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM reset controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/reset/nuvoton,npcm-reset.txt     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
new file mode 100644
index 000000000000..6e802703af60
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
@@ -0,0 +1,32 @@
+Nuvoton NPCM Reset controller
+
+Required properties:
+- compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
+- reg : specifies physical base address and size of the register.
+- #reset-cells: must be set to 2
+
+Optional property:
+- nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
+  NPCM7xx contain four software reset that represent numbers 1 to 4.
+
+  If 'nuvoton,sw-reset-number' is not specfied software reset is disabled.
+
+Example:
+	rstc: rstc@f0801000 {
+		compatible = "nuvoton,npcm750-reset";
+		reg = <0xf0801000 0x70>;
+		#reset-cells = <2>;
+		nuvoton,sw-reset-number = <2>;
+	};
+
+Specifying reset lines connected to IP NPCM7XX modules
+======================================================
+example:
+
+        spi0: spi@..... {
+                ...
+                resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_PSPI1>;
+                ...
+        };
+
+The index could be found in <dt-bindings/reset/nuvoton,npcm7xx-reset.h>.
-- 
2.22.0

