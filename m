Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B73D4C57
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 05:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfJLDH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 23:07:58 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:53907 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbfJLDH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:07:56 -0400
X-UUID: 1546340fb04a4756af28f25751b60902-20191012
X-UUID: 1546340fb04a4756af28f25751b60902-20191012
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 805684718; Sat, 12 Oct 2019 11:07:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Oct
 2019 11:07:42 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sat, 12 Oct 2019 11:07:41 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 3/8] dt-bindings: display: panel: add auo kd101n80-45na panel bindings
Date:   Sat, 12 Oct 2019 11:07:15 +0800
Message-ID: <20191012030720.27127-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012030720.27127-1-jitao.shi@mediatek.com>
References: <20191012030720.27127-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: B1703BEAAF6946DE1CA55BF37AA78AB710073CC6D9653C91AAC35A86A128B1CD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for auo kd101n80-45na panel.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/auo,kd101n80-45na.yaml      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.yaml b/Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.yaml
new file mode 100644
index 000000000000..46ba7e8a3896
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/auo,kd101n80-45na.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AUO KD101N80-45NA DSI Display Panel
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Sam Ravnborg <sam@ravnborg.org>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  compatible:
+        const: auo,kd101n80-45na
+
+  reg:
+    description: the virtual channel number of a DSI peripheral
+
+  enable-gpios:
+    description: a GPIO spec for the enable pin
+
+  pp1800-supply:
+    description: core voltage supply
+
+  avdd-supply:
+    description: phandle of the regulator that provides positive voltage
+
+  avee-supply:
+    description: phandle of the regulator that provides negative voltage
+
+  backlight:
+    description: phandle of the backlight device attached to the panel
+
+required:
+ - compatible
+ - reg
+ - enable-gpios
+ - pp1800-supply
+ - avdd-supply
+ - avee-supply
+ - backlight
+
+additionalProperties: false
+
+examples:
+  - |
+    &dsi {
+        panel@0 {
+            compatible = "auo,kd101n80-45na";
+            reg = <0>;
+            enable-gpios = <&pio 45 0>;
+            avdd-supply = <&ppvarn_lcd>;
+            avee-supply = <&ppvarp_lcd>;
+            pp1800-supply = <&pp1800_lcd>;
+            backlight = <&backlight_lcd0>;
+            status = "okay";
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.21.0

