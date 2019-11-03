Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABDED15F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 02:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfKCBhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 21:37:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:59462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfKCBg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DFD7B300;
        Sun,  3 Nov 2019 01:36:56 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 09/11] dt-bindings: soc: realtek: rtd1195-chip: Extend reg node again
Date:   Sun,  3 Nov 2019 02:36:43 +0100
Message-Id: <20191103013645.9856-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103013645.9856-1-afaerber@suse.de>
References: <20191103013645.9856-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to optionally specify a third register to identify the chip.
Whether needed and which register to specify depends on the family;
RTD1295 family will want an efuse register.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 I don't like specifying an efuse register here, which seems its own IP block.
 
 .../devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml    | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
index e431cf559b66..249737e116d7 100644
--- a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
+++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
@@ -19,7 +19,7 @@ properties:
 
   reg:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
 required:
   - compatible
@@ -37,4 +37,11 @@ examples:
         reg = <0x9801a200 0x8>,
               <0x98007028 0x4>;
     };
+  - |
+    chip-info@9801a200 {
+        compatible = "realtek,rtd1195-chip";
+        reg = <0x9801a200 0x8>,
+              <0x98007028 0x4>,
+              <0x980171d8 0x4>;
+    };
 ...
-- 
2.16.4

