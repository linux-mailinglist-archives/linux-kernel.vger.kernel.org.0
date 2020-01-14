Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC14139EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 02:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgANBaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 20:30:30 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46112 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgANBaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:30:20 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 981E91A07BA;
        Tue, 14 Jan 2020 02:30:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EB4D1A01BD;
        Tue, 14 Jan 2020 02:30:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0DD0B402DF;
        Tue, 14 Jan 2020 09:30:06 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/3] dt-bindings: clock: Refine i.MX8MN clock binding
Date:   Tue, 14 Jan 2020 09:26:07 +0800
Message-Id: <1578965167-31588-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
References: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine i.MX8MN clock binding by removing useless content and
updating the example, it makes all i.MX8M SoCs' clock binding
aligned.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 .../devicetree/bindings/clock/imx8mn-clock.yaml    | 48 +---------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
index 622f365..da2103d 100644
--- a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
@@ -40,7 +40,7 @@ properties:
 
   '#clock-cells':
     const: 1
-    description: |
+    description:
       The clock consumer should specify the desired clock by having the clock
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8mn-clock.h
       for the full list of i.MX8M Nano clock IDs.
@@ -57,7 +57,7 @@ examples:
   - |
     clk: clock-controller@30380000 {
         compatible = "fsl,imx8mn-ccm";
-        reg = <0x0 0x30380000 0x0 0x10000>;
+        reg = <0x30380000 0x10000>;
         #clock-cells = <1>;
         clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>,
                  <&clk_ext2>, <&clk_ext3>, <&clk_ext4>;
@@ -65,48 +65,4 @@ examples:
                       "clk_ext2", "clk_ext3", "clk_ext4";
     };
 
-  # Required external clocks for Clock Control Module node:
-  - |
-    osc_32k: clock-osc-32k {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency = <32768>;
-        clock-output-names = "osc_32k";
-    };
-
-    osc_24m: clock-osc-24m {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency = <24000000>;
-        clock-output-names = "osc_24m";
-    };
-
-    clk_ext1: clock-ext1 {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency = <133000000>;
-        clock-output-names = "clk_ext1";
-    };
-
-    clk_ext2: clock-ext2 {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency = <133000000>;
-        clock-output-names = "clk_ext2";
-    };
-
-    clk_ext3: clock-ext3 {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency = <133000000>;
-        clock-output-names = "clk_ext3";
-    };
-
-    clk_ext4: clock-ext4 {
-        compatible = "fixed-clock";
-        #clock-cells = <0>;
-        clock-frequency= <133000000>;
-        clock-output-names = "clk_ext4";
-    };
-
 ...
-- 
2.7.4

