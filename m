Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EEDDC46
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 06:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJTEI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 00:08:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfJTEI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 00:08:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A90FCAC2C;
        Sun, 20 Oct 2019 04:08:26 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] dt-bindings: arm: realtek: Tidy up conversion to json-schema
Date:   Sun, 20 Oct 2019 06:08:12 +0200
Message-Id: <20191020040817.16882-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191020040817.16882-1-afaerber@suse.de>
References: <20191020040817.16882-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the device names for compatible strings as comments.
Prepare for adding more SoCs by inserting oneOf.

Fixes: 693af5f3eeaa ("dt-bindings: arm: Convert Realtek board/soc bindings to json-schema")
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 Documentation/devicetree/bindings/arm/realtek.yaml | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
index 3528b61963b4..66458a3f422d 100644
--- a/Documentation/devicetree/bindings/arm/realtek.yaml
+++ b/Documentation/devicetree/bindings/arm/realtek.yaml
@@ -13,11 +13,12 @@ properties:
   $nodename:
     const: '/'
   compatible:
-    # RTD1295 SoC based boards
-    items:
-      - enum:
-          - mele,v9
-          - probox2,ava
-          - zidoo,x9s
-      - const: realtek,rtd1295
+    oneOf:
+      # RTD1295 SoC based boards
+      - items:
+          - enum:
+              - mele,v9 # MeLE V9
+              - probox2,ava # ProBox2 AVA
+              - zidoo,x9s # Zidoo X9S
+          - const: realtek,rtd1295
 ...
-- 
2.16.4

