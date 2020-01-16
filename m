Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F813D2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 04:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgAPDhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 22:37:41 -0500
Received: from hermes.aosc.io ([199.195.250.187]:57191 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbgAPDhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:37:40 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id DA90247720;
        Thu, 16 Jan 2020 03:37:35 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: arm: sunxi: add binding for PineTab tablet
Date:   Thu, 16 Jan 2020 11:36:35 +0800
Message-Id: <20200116033636.512461-5-icenowy@aosc.io>
In-Reply-To: <20200116033636.512461-1-icenowy@aosc.io>
References: <20200116033636.512461-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1579145860;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
        bh=KnPZmUA4jMX9XqFMlF8ay3G6LudBy8KgPlNFXGrlc9w=;
        b=PoIT64PBkL2Z6UNlTLLS1C05GhzhO1FXxM/KQstcC4awHMNLUwSzrIvGU+I7z66KHmVgQw
        fraDLntQAF1dQHsHiQj0PXSGbaPl81pRRAUyGP9FpuiUHf3e3fdU70wK0O+zNwHIU1W0nv
        8ZP7MAiBEiQuexqoQeWQWWP406RsBxg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree binding for Pine64's PineTab tablet, which uses
Allwinner A64 SoC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Added Review tag by Rob.

 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 327ce6730823..159060b65c5d 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -636,6 +636,11 @@ properties:
           - const: pine64,pinebook
           - const: allwinner,sun50i-a64
 
+      - description: Pine64 PineTab
+        items:
+          - const: pine64,pinetab
+          - const: allwinner,sun50i-a64
+
       - description: Pine64 SoPine Baseboard
         items:
           - const: pine64,sopine-baseboard
-- 
2.23.0

