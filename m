Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370D1118B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 15:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfLJOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 09:42:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:49932 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575988918; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=BK+1F7xIRj68d46F1jAvtX4kN3AW/YIFawXHe73bc8E=;
        b=Hx8wSZppBKSt8143F9zfmJP9ElZmC2/0tqtsGIjIMxQLmZA8wnhmHHQb85jz+DRlegKvJa
        biomE7dSZZ8vp4BVfQzKmG3oEgoq2J6CZ80mTZVsAHuNxbcl+ZmSnC3Ofx+ABUj5YrlsJD
        M9Pyd8G5fdBPpgr4SR0h9wqN2pQSjEE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: display/ingenic: Add compatible string for JZ4770
Date:   Tue, 10 Dec 2019 15:41:37 +0100
Message-Id: <20191210144142.33143-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the LCD controller found in the JZ4770 SoC.

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/ingenic,lcd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.txt b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
index 7b536c8c6dde..01e3261defb6 100644
--- a/Documentation/devicetree/bindings/display/ingenic,lcd.txt
+++ b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: one of:
   * ingenic,jz4740-lcd
   * ingenic,jz4725b-lcd
+  * ingenic,jz4770-lcd
 - reg: LCD registers location and length
 - clocks: LCD pixclock and device clock specifiers.
 	   The device clock is only required on the JZ4740.
-- 
2.24.0

