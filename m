Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693AF17318
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfEHIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 04:04:10 -0400
Received: from HC210-202-87-179.vdslpro.static.apol.com.tw ([210.202.87.179]:47246
        "EHLO ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725842AbfEHIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:04:10 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 04:04:09 EDT
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 08 May 2019 15:54:20 +0800
Received: from csbcas.internal.ite.com.tw (csbcas1.internal.ite.com.tw [192.168.65.46])
        by mse.ite.com.tw with ESMTP id x487sFOA075568;
        Wed, 8 May 2019 15:54:15 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas1.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 8 May 2019 15:54:15 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: Add binding for IT6505.
Date:   Wed, 8 May 2019 15:48:40 +0800
Message-ID: <1557301722-20827-2-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557301722-20827-1-git-send-email-allen.chen@ite.com.tw>
References: <1557301722-20827-1-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw x487sFOA075568
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Chen <allen.chen@ite.com.tw>

Add a DT binding documentation for IT6505.

Signed-off-by: Allen Chen <allen.chen@ite.com.tw>

---
 .../bindings/display/bridge/ite,it6505.txt         | 30 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
new file mode 100644
index 0000000..c3506ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
@@ -0,0 +1,30 @@
+iTE it6505 DP bridge bindings
+
+Required properties:
+        - compatible: "ite,it6505"
+        - reg: i2c address of the bridge
+        - ovdd-supply: I/O voltage
+        - pwr18-supply: Core voltage
+        - interrupts: interrupt specifier of INT pin
+        - reset-gpios: gpio specifier of RESET pin
+
+Example:
+	it6505dptx: it6505dptx@5c {
+                compatible = "ite,it6505";
+                status = "okay";
+                interrupt-parent = <&pio>;
+                interrupts = <152 IRQ_TYPE_EDGE_RISING 152 0>;
+                reg = <0x5c>;
+                pinctrl-names = "default";
+                pinctrl-0 = <&it6505_pins>;
+                ovdd-supply = <&mt6358_vsim1_reg>;
+                pwr18-supply = <&it6505_pp18_reg>;
+                reset-gpios = <&pio 179 1>;
+                hpd-gpios = <&pio 9 0>;
+                extcon = <&usbc_extcon>;
+                port {
+                        it6505_in: endpoint {
+                                remote-endpoint = <&dpi_out>;
+                        };
+                };
+        };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc51..c088646 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -184,6 +184,7 @@ iom	Iomega Corporation
 isee	ISEE 2007 S.L.
 isil	Intersil
 issi	Integrated Silicon Solutions Inc.
+ite	iTE Tech. Inc.
 itead	ITEAD Intelligent Systems Co.Ltd
 iwave  iWave Systems Technologies Pvt. Ltd.
 jdi	Japan Display Inc.
-- 
1.9.1

