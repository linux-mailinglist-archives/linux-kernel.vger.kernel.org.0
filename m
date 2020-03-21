Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3DE18DE95
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 08:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgCUH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 03:58:22 -0400
Received: from olimex.com ([184.105.72.32]:49174 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgCUH6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 03:58:20 -0400
Received: from localhost.localdomain ([89.25.85.162])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 00:58:17 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com
Subject: [PATCH 2/2] dt-bindings: arm: sunxi: Add compatible for A20-OLinuXino-LIME-eMMC
Date:   Sat, 21 Mar 2020 09:57:57 +0200
Message-Id: <20200321075757.15853-3-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200321075757.15853-1-stefan@olimex.com>
References: <20200321075757.15853-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for A20-OLinuXino-LIME2-eMMC to the
bindings documentation.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 327ce6730823..25c09a121b63 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -555,6 +555,11 @@ properties:
           - const: olimex,a20-olinuxino-lime
           - const: allwinner,sun7i-a20
 
+      - description: Olimex A20-OlinuXino LIME (with eMMC)
+        items:
+          - const: olimex,a20-olinuxino-lime-emmc
+          - const: allwinner,sun7i-a20
+
       - description: Olimex A20-OlinuXino LIME2
         items:
           - const: olimex,a20-olinuxino-lime2
-- 
2.17.1

