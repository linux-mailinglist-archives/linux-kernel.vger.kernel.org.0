Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6993814DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 11:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfHEJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 05:12:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14294 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728068AbfHEJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:12:20 -0400
X-UUID: 204a8b5a59f940babf202b28ed013dac-20190805
X-UUID: 204a8b5a59f940babf202b28ed013dac-20190805
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1911217896; Mon, 05 Aug 2019 17:12:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 5 Aug 2019 17:12:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Aug 2019 17:12:06 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>
Subject: [PATCH 08/11] dt-bindings: mediatek: bindings for MT6779 clk
Date:   Mon, 5 Aug 2019 17:11:57 +0800
Message-ID: <1564996320-10897-9-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com>
References: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7FA339A3E9B92709963665FA152CA49D9B53064AD81A5ED5C6C5DC72EEE0401D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wendell Lin <wendell.lin@mediatek.com>

This patch adds the binding documentation for
apmixedsys, audiosys, camsys, imgsys, ipesys,
infracfg, mfgcfg, mmsys, topckgen, vdecsys,
and vencsys for Mediatek MT6779.

Signed-off-by: Wendell Lin <wendell.lin@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,ipesys.txt      |   22 ++++++++++++++++++++
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |    1 +
 11 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index 161e63a..ff000cc 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt2712-apmixedsys", "syscon"
+	- "mediatek,mt6779-apmixedsys", "syscon"
 	- "mediatek,mt6797-apmixedsys"
 	- "mediatek,mt7622-apmixedsys"
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 07c9d81..e4ca7b7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2701-audsys", "syscon"
+	- "mediatek,mt6779-audio", "syscon"
 	- "mediatek,mt7622-audsys", "syscon"
 	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
 	- "mediatek,mt8183-audiosys", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
index d8930f6..1f4aaa1 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
@@ -6,6 +6,7 @@ The MediaTek camsys controller provides various clocks to the system.
 Required Properties:
 
 - compatible: Should be one of:
+	- "mediatek,mt6779-camsys", "syscon"
 	- "mediatek,mt8183-camsys", "syscon"
 - #clock-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index e3bc4a1..2b693e3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-imgsys", "syscon"
 	- "mediatek,mt2712-imgsys", "syscon"
+	- "mediatek,mt6779-imgsys", "syscon"
 	- "mediatek,mt6797-imgsys", "syscon"
 	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index a909139..db2f4fd 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -9,6 +9,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt2712-infracfg", "syscon"
+	- "mediatek,mt6779-infracfg_ao", "syscon"
 	- "mediatek,mt6797-infracfg", "syscon"
 	- "mediatek,mt7622-infracfg", "syscon"
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
new file mode 100644
index 0000000..2ce889b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
@@ -0,0 +1,22 @@
+Mediatek ipesys controller
+============================
+
+The Mediatek ipesys controller provides various clocks to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt6779-ipesys", "syscon"
+- #clock-cells: Must be 1
+
+The ipesys controller uses the common clk binding from
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+
+Example:
+
+ipesys: clock-controller@1b000000 {
+	compatible = "mediatek,mt6779-ipesys", "syscon";
+	reg = <0 0x1b000000 0 0x1000>;
+	#clock-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
index 72787e7..ad5f9d2 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2712-mfgcfg", "syscon"
+	- "mediatek,mt6779-mfgcfg", "syscon"
 	- "mediatek,mt8183-mfgcfg", "syscon"
 - #clock-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 545eab7..301eefb 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-mmsys", "syscon"
 	- "mediatek,mt2712-mmsys", "syscon"
+	- "mediatek,mt6779-mmsys", "syscon"
 	- "mediatek,mt6797-mmsys", "syscon"
 	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index a023b83..0293d69 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-topckgen"
 	- "mediatek,mt2712-topckgen", "syscon"
+	- "mediatek,mt6779-topckgen", "syscon"
 	- "mediatek,mt6797-topckgen"
 	- "mediatek,mt7622-topckgen"
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index 57176bb..7894558 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-vdecsys", "syscon"
 	- "mediatek,mt2712-vdecsys", "syscon"
+	- "mediatek,mt6779-vdecsys", "syscon"
 	- "mediatek,mt6797-vdecsys", "syscon"
 	- "mediatek,mt7623-vdecsys", "mediatek,mt2701-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
index c9faa62..6a6a14e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: Should be one of:
 	- "mediatek,mt2712-vencsys", "syscon"
+	- "mediatek,mt6779-vencsys", "syscon"
 	- "mediatek,mt6797-vencsys", "syscon"
 	- "mediatek,mt8173-vencsys", "syscon"
 	- "mediatek,mt8183-vencsys", "syscon"
-- 
1.7.9.5

