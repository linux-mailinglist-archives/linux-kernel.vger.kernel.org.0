Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA571698F9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 18:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBWR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 12:29:28 -0500
Received: from vps.xff.cz ([195.181.215.36]:44496 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgBWR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582478966; bh=xWvIq2K8vFLnETTDs7Gq4WrOOk7m+WA+aN0LYzNvStA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QDN6KAniOV+RdBqj3rt/ejmUhdo5aZhXStUvI1yDle2O9TE9uWeWy2cNRxQCc5P6a
         2OBa0J9QjN4SH4q/DUTIMTX6+xoK+OhfSQcemVVjYsqNNEhoNmlmGaGZHyo8LTWuxV
         5Crw9lAlkDdgsg+2sKpv5sFEFp0uOqkaJC2dngGs=
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
Subject: [PATCH 2/3] dt-bindings: arm: sunxi: Add PinePhone 1.0 and 1.1 bindings
Date:   Sun, 23 Feb 2020 18:29:15 +0100
Message-Id: <20200223172916.843379-3-megous@megous.com>
In-Reply-To: <20200223172916.843379-1-megous@megous.com>
References: <20200223172916.843379-1-megous@megous.com>
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
index 327ce67308237..e24e0fac58f04 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -636,6 +636,16 @@ properties:
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
       - description: Pine64 SoPine Baseboard
         items:
           - const: pine64,sopine-baseboard
-- 
2.25.1

