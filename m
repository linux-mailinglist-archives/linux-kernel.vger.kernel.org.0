Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3E61041C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 18:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfKTRKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 12:10:39 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:54468 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfKTRKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574269834; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=/xS8wWdZbwsK04N14PWTSsZY6F81o/i8NADVFiFMWpY=;
        b=GgCoreU47Z1orXM9eQjTD5auYk05YUsF9vw01cpJ7dCo7QC7n+QMwhWCS0ZNIcvw1u5d++
        MpxFhVZNclAXgo9az569U5nY0Xb1VTd5jIC0SYSEuWMYuIoXhOm9ySo68XpDKawiKQR/wF
        TDoHsdlcfuWCAXmg01jUCpXIdBL3OTY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Shenzhen Frida LCD Co., Ltd.
Date:   Wed, 20 Nov 2019 18:10:25 +0100
Message-Id: <20191120171027.1102250-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Shenzhen Frida LCD Co., Ltd.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..9c6e1b42435b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -337,6 +337,8 @@ patternProperties:
     description: Firefly
   "^focaltech,.*":
     description: FocalTech Systems Co.,Ltd
+  "^frida,.*":
+    description: Shenzhen Frida LCD Co., Ltd.
   "^friendlyarm,.*":
     description: Guangzhou FriendlyARM Computer Tech Co., Ltd
   "^fsl,.*":
-- 
2.24.0

