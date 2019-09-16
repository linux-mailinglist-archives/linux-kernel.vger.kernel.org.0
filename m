Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A59B3362
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 04:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfIPCaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 22:30:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:10228 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbfIPCaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:30:16 -0400
X-UUID: ff25d7aa78504ef8a644a12692a2bd2f-20190916
X-UUID: ff25d7aa78504ef8a644a12692a2bd2f-20190916
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 250707718; Mon, 16 Sep 2019 10:30:07 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Sep
 2019 10:30:06 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 16 Sep 2019 10:30:05 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v5 5/8] dt-bindings: display: panel: add boe tv101wum-n53 panel documentation
Date:   Mon, 16 Sep 2019 10:29:38 +0800
Message-ID: <20190916022941.15404-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916022941.15404-1-jitao.shi@mediatek.com>
References: <20190916022941.15404-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: A3F385A883601703994C308500DFF60BDF8FF3405BD9EFA91D5E213D386999F82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dcumentation for boe,tv101wum-n53, which is mipi dsi video panel
and resolution is 1200x1920.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../display/panel/boe,tv101wum-n53.txt        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.txt

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.txt b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.txt
new file mode 100644
index 000000000000..145a0b2a80a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.txt
@@ -0,0 +1,34 @@
+BOE Corporation 10.1" WUXGA TFT LCD panel
+
+Required properties:
+- compatible: should be "boe,tv101wum-n53"
+- reg: the virtual channel number of a DSI peripheral
+- enable-gpios: a GPIO spec for the enable pin
+- pp1800-supply: core voltage supply
+- avdd-supply: phandle of the regulator that provides positive voltage
+- avee-supply: phandle of the regulator that provides negative voltage
+- backlight: phandle of the backlight device attached to the panel
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in
+media/video-interfaces.txt. This node should describe panel's video bus.
+
+Example:
+&dsi {
+	...
+	panel@0 {
+		compatible = "boe,tv101wum-n53";
+		reg = <0>;
+		enable-gpios = <&pio 45 0>;
+		avdd-supply = <&ppvarn_lcd>;
+		avee-supply = <&ppvarp_lcd>;
+		pp1800-supply = <&pp1800_lcd>;
+		backlight = <&backlight_lcd0>;
+		status = "okay";
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
-- 
2.21.0

