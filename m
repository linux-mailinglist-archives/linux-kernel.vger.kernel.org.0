Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BD10264E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 15:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfKSORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 09:17:49 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:49804 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfKSORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574173064; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=GwQs/I34Gsxl3SkZJ9TndJzpKGHdtrRU8KhsXh5z6T4=;
        b=mrT2mpYFDmFwKTDD8Mwz02JbRJsC+rlA44Wx0jWx/ZCxD8LzKabuLh4MZBcahZ6u36KNDr
        4D8N75NLGhtHVfWL5A5y1HSHCs5e9xDnwNA5dc3fPzVd9ik5qVydB7ZlnN2fHX0NDF8rOJ
        fs9NcFPmUx1lWMwqSdeTyViKojNa8Lc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/6] dt-bindings: display/ingenic: Add compatible string for JZ4770
Date:   Tue, 19 Nov 2019 15:17:31 +0100
Message-Id: <20191119141736.74607-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the LCD controller found in the JZ4770 SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
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

