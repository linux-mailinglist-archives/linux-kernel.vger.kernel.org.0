Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3F170DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 02:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgB0B1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 20:27:11 -0500
Received: from vps.xff.cz ([195.181.215.36]:44750 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgB0B1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582766829; bh=cU/73/qZHZaqIsGpwSHvOs00pwlBavlxFL23j/MD9Cg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bbjPgN0xwRTQTP5l3OYbcP00l+0I4tu0GBk03D9C7B9MNjC6Q88OviNcpMXBtwtcy
         +EtRs0O2new93qUHyVJY+5jwfiswHtttoZkXkv0yaaNInEcXslNZVByFsejxdccwPL
         ckuFSQY4yZRk17WduhAfa63BCSe60HzChHdV0uAk=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: sunxi: Add PinePhone 1.0 and 1.1 bindings
Date:   Thu, 27 Feb 2020 02:26:49 +0100
Message-Id: <20200227012650.1179151-3-megous@megous.com>
In-Reply-To: <20200227012650.1179151-1-megous@megous.com>
References: <20200227012650.1179151-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Pine64 PinePhone:

- 1.0 - Developer variant
- 1.1 - Braveheart variant

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 5b22b77e4bb73..abf2d97fb7ae3 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -642,6 +642,16 @@ properties:
           - const: pine64,pinebook
           - const: allwinner,sun50i-a64
 
+      - description: Pine64 PinePhone Developer Batch (1.0)
+        items:
+          - const: pine64,pinephone-1.0
+          - const: allwinner,sun50i-a64
+
+      - description: Pine64 PinePhone Braveheart (1.1)
+        items:
+          - const: pine64,pinephone-1.1
+          - const: allwinner,sun50i-a64
+
       - description: Pine64 PineTab
         items:
           - const: pine64,pinetab
-- 
2.25.1

