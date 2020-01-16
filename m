Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831A913D2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAPDhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 22:37:17 -0500
Received: from hermes.aosc.io ([199.195.250.187]:57128 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgAPDhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:37:16 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 720E54771C;
        Thu, 16 Jan 2020 03:37:12 +0000 (UTC)
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
Subject: [PATCH v2 1/5] dt-bindings: vendor-prefix: add Shenzhen Feixin Photoelectics Co., Ltd
Date:   Thu, 16 Jan 2020 11:36:32 +0800
Message-Id: <20200116033636.512461-2-icenowy@aosc.io>
In-Reply-To: <20200116033636.512461-1-icenowy@aosc.io>
References: <20200116033636.512461-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1579145836;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
        bh=Cots55u7oBo6HLbJ0veZrEhronIaQRrC5wB8giopCdI=;
        b=QAUu2xvkaL12iJS8vAzQbXn0507Pmq8B1zgmbKFcsN5+qK3hciu2EUylZQwvbQXGrYJ1wS
        LcONX8u3wZFUIPbD6ArJJoJtpvBAihun13iASAlmsRRuQwGkMKdo1d15hxlqA6p3rv7ybu
        /2CJCPtur/az2eMoK3aiEF0FUTLotEw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Feixin Photoelectics Co., Ltd is a company to provide LCD
modules.

Add its vendor prefix.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Added ACKs from Sam and Rob.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 97c0a06b35cd..07d52254427b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -337,6 +337,8 @@ patternProperties:
     description: Fastrax Oy
   "^fcs,.*":
     description: Fairchild Semiconductor
+  "^feixin,.*":
+    description: Shenzhen Feixin Photoelectic Co., Ltd
   "^feiyang,.*":
     description: Shenzhen Fly Young Technology Co.,LTD.
   "^firefly,.*":
-- 
2.23.0

