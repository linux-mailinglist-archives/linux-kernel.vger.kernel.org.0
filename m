Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E37139599
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 17:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgAMQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 11:17:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50200 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAMQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578932272; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=cZANvumXw1YT4vM678LgsjuFp42QFxALr28U8EYagH8=;
        b=lh05AnIjWW42LDs3svB2tecp31KTGyzzZ1BA4UG9jfRRj1rq7XjL1Zx1IjS+tSoMN3a/FO
        JzMKgVgQPWK4FGErORtOOT3dxW+eDtMvFLh/MVvKeaxQCG9YphR+Sq5rYZQfeomObhmgVg
        lf8ocXtIzkiEBj//6iN1CO6RShrLb4A=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Shenzhen Frida LCD Co., Ltd.
Date:   Mon, 13 Jan 2020 13:17:39 -0300
Message-Id: <20200113161741.32061-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Shenzhen Frida LCD Co., Ltd.

v2: No change
v3: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 835579edc971..76069bb51ea4 100644
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
2.24.1

