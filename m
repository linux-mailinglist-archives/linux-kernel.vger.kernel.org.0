Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8C135072
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 01:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgAIAaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 19:30:19 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42952 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAIAaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578529817; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=NHhHx7ZlRF7eivXl3/VLwz7qgS0NV8FmX8RqxK46cCo=;
        b=pyTObPhS2panfCUwZeh7TMkP5NeDmK0j6O7a4knVlSYsQ+W4IE7vgiMVmfs8ratrnVHNQ8
        azPFgtapRx/ZtkTyaZZPWiLbqLM+4I7duxshzMlUiD3PNsJTfGaeuwn3zkM5x7N7kmGX/e
        m/uImfSjxz7ikrsJtAYdM8xNIOVM2Pw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: panel-simple: Add compatible for GiantPlus GPM940B0
Date:   Wed,  8 Jan 2020 21:29:59 -0300
Message-Id: <20200109003000.119516-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the GiantPlus GPM740B0 3" QVGA TFT LCD
panel, and remove the old giantplus,gpm740b0.txt documentation which is
now obsolete.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/display/panel/giantplus,gpm940b0.txt    | 12 ------------
 .../bindings/display/panel/panel-simple.yaml         |  2 ++
 2 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt

diff --git a/Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt b/Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
deleted file mode 100644
index 3dab52f92c26..000000000000
--- a/Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-GiantPlus 3.0" (320x240 pixels) 24-bit TFT LCD panel
-
-Required properties:
-- compatible: should be "giantplus,gpm940b0"
-- power-supply: as specified in the base binding
-
-Optional properties:
-- backlight: as specified in the base binding
-- enable-gpios: as specified in the base binding
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 090866260f4f..c1a77d9105a2 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -33,6 +33,8 @@ properties:
       - ampire,am-480272h3tmqw-t01h
         # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
       - ampire,am800480r3tmqwa1h
+        # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
+      - giantplus,gpm940b0
 
   backlight: true
   enable-gpios: true
-- 
2.24.1

