Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136BB182395
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 21:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgCKU6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 16:58:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39709 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCKU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:58:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id a9so3656262otl.6;
        Wed, 11 Mar 2020 13:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhg/0FAO3q/vHDALs56YJQeY3t0IUDUvD5cc2QPb2XM=;
        b=KsYXVLQRf7/eboG8pK12yn3G6DKlj6g9mgA273x2UI0jjCeZNt191jSz+a/CK8dTwQ
         30IVBMKU7hKf0iPmJudTX1xAlJYeAtVRrUrpjYcqz3G7moDbqNAf1/F9Axa9zIVOZ5L3
         vIOgK4BOZ1rpl8ei8zbHOHqg7tofUwKeO5fEu+xZFoHyTSKYmwzvm7luzqTar9Ekq8Fr
         s5nFuYxxs1+lz3bqelERtGnHBO1INxE6bPLvYigHvFP4QTc6x/VAx3Ei1a7p9t2EGQPk
         zQZ7tHFfvvfk7kZq+fkvuYd7kkM+O+3mPk4Ip69ZVP/du7aTSPYvzN2sm77vGdBzq1gJ
         v/lQ==
X-Gm-Message-State: ANhLgQ2W3bhmXu4762S/DrIXzzxXh7+w8tykIEpo4TVel6qnv1k/q2JA
        pUVZm+uVNj+anFftaWvsdg==
X-Google-Smtp-Source: ADFU+vuv4liSgXNM9hk0LvRLrjr4VQeYNuyIQ2YCdJkyrlgfjAXq5rTb3WuF0vh5KOZNuIaLo8UO8Q==
X-Received: by 2002:a9d:3d65:: with SMTP id a92mr3565544otc.326.1583960323590;
        Wed, 11 Mar 2020 13:58:43 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c24sm638848oov.43.2020.03.11.13.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 13:58:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: dt-bindings: google,cros-ec-codec: Fix dtc warnings in example
Date:   Wed, 11 Mar 2020 15:58:41 -0500
Message-Id: <20200311205841.2710-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extra dtc warnings (roughly what W=1 enables) are now enabled by default
when building the binding examples. These were fixed treewide in
5.6-rc5, but the newly added google,cros-ec-codec schema adds some new
warnings:

Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:17.28-21.11:
Warning (unit_address_vs_reg): /example-0/reserved_mem: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:22.19-32.11:
Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg property
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.37-31.15:
Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name

Fixing the above, then results in:

Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.13-23:
Warning (reg_format): /example-0/cros-ec@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:27.37-32.15:
Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name

Fixes: eadd54c75f1e ("dt-bindings: Convert the binding file google, cros-ec-codec.txt to yaml format.")
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/google,cros-ec-codec.yaml  | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index 94a85d0cbf43..c84e656afb0a 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -44,19 +44,24 @@ additionalProperties: false
 
 examples:
   - |
-    reserved_mem: reserved_mem {
+    reserved_mem: reserved-mem@52800000 {
         compatible = "shared-dma-pool";
-        reg = <0 0x52800000 0 0x100000>;
+        reg = <0x52800000 0x100000>;
         no-map;
     };
-    cros-ec@0 {
-        compatible = "google,cros-ec-spi";
-        #address-cells = <2>;
-        #size-cells = <1>;
-        cros_ec_codec: ec-codec {
-            compatible = "google,cros-ec-codec";
-            #sound-dai-cells = <1>;
-            reg = <0x0 0x10500000 0x80000>;
-            memory-region = <&reserved_mem>;
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            #address-cells = <2>;
+            #size-cells = <1>;
+            reg = <0>;
+            cros_ec_codec: ec-codec@10500000 {
+                compatible = "google,cros-ec-codec";
+                #sound-dai-cells = <1>;
+                reg = <0x0 0x10500000 0x80000>;
+                memory-region = <&reserved_mem>;
+            };
         };
     };
-- 
2.20.1

