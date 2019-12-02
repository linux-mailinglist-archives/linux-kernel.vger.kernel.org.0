Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3010EC91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 16:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfLBPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 10:41:46 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40736 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLBPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575301296; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsu8btJZj2fyl7PzBZMzpf5zydLm0yevNz9rkKTMgk8=;
        b=D/3RqVEaQZA1jrix+fzbJ6s9davLxy+oJAZHT52DagrWjdIrA90czYOKKCZ/EdvHRN8tXt
        yTXMJRe8UbjFc6ZqUiCY6BuSed6xoYtO0YlC5ZeeAt2BF+TNiU9afgqtz+YTbFwwxJ55eQ
        KbsVwashSaYHn9dtinwGw2T/d8AKWXQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] dt-bindings: panel: Document Frida FRD350H54004 LCD panel
Date:   Mon,  2 Dec 2019 16:41:22 +0100
Message-Id: <20191202154123.64139-2-paul@crapouillou.net>
In-Reply-To: <20191202154123.64139-1-paul@crapouillou.net>
References: <20191202154123.64139-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for the Frida 3.5" (320x240 pixels) 24-bit
TFT LCD panel.

v2: Switch documentation from plain text to YAML

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../display/panel/frida,frd350h54004.yaml     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml
new file mode 100644
index 000000000000..a29c3daf0c78
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/frida,frd350h54004.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Frida 3.5" (320x240 pixels) 24-bit TFT LCD panel
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: frida,frd350h54004
+
+  power-supply: true
+  backlight: true
+  enable-gpios: true
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - power-supply
+
+...
-- 
2.24.0

