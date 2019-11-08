Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354F5F5BBA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfKHXR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 18:17:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHXR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:17:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B48C66130A; Fri,  8 Nov 2019 23:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573255046;
        bh=HAIEAB/0z5LSdKmtLEEK40eFMVSuSI3HP9POVYE8JS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDRzujUUE/zGgdHh/gUbMDpeHN1xAdYe0XDpFJK8oPxGbh2kTdCyz74TurYcuUF29
         /Msvg+/kyILUKouVi4/J8IuZhvWKmNIaxRC7c3AXBpHYRYSOe/oI4kVXTjW2elM+I4
         aEU4qv3D4OCrTo9HWYCw/8IXR4jSpwmsIIQh4iu0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60A78612C4;
        Fri,  8 Nov 2019 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573255046;
        bh=HAIEAB/0z5LSdKmtLEEK40eFMVSuSI3HP9POVYE8JS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDRzujUUE/zGgdHh/gUbMDpeHN1xAdYe0XDpFJK8oPxGbh2kTdCyz74TurYcuUF29
         /Msvg+/kyILUKouVi4/J8IuZhvWKmNIaxRC7c3AXBpHYRYSOe/oI4kVXTjW2elM+I4
         aEU4qv3D4OCrTo9HWYCw/8IXR4jSpwmsIIQh4iu0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60A78612C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v8 1/4] dt-bindings: clock: Document external clocks for MSM8998 gcc
Date:   Fri,  8 Nov 2019 16:17:16 -0700
Message-Id: <1573255036-10302-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573254987-10241-1-git-send-email-jhugo@codeaurora.org>
References: <1573254987-10241-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global clock controller on MSM8998 can consume a number of external
clocks.  Document them.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gcc.yaml        | 47 +++++++++++++++-------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index e73a56f..2f3512b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -40,20 +40,38 @@ properties:
        - qcom,gcc-sm8150
 
   clocks:
-    minItems: 1
-    maxItems: 3
-    items:
-      - description: Board XO source
-      - description: Board active XO source
-      - description: Sleep clock source
+    oneOf:
+      #qcom,gcc-sm8150
+      #qcom,gcc-sc7180
+      - items:
+        - description: Board XO source
+        - description: Board active XO source
+        - description: Sleep clock source
+      #qcom,gcc-msm8998
+      - items:
+        - description: Board XO source
+        - description: USB 3.0 phy pipe clock
+        - description: UFS phy rx symbol clock for pipe 0
+        - description: UFS phy rx symbol clock for pipe 1
+        - description: UFS phy tx symbol clock
+        - description: PCIE phy pipe clock
 
   clock-names:
-    minItems: 1
-    maxItems: 3
-    items:
-      - const: bi_tcxo
-      - const: bi_tcxo_ao
-      - const: sleep_clk
+    oneOf:
+      #qcom,gcc-sm8150
+      #qcom,gcc-sc7180
+      - items:
+        - const: bi_tcxo
+        - const: bi_tcxo_ao
+        - const: sleep_clk
+      #qcom,gcc-msm8998
+      - items:
+        - const: xo
+        - const: usb3_pipe
+        - const: ufs_rx_symbol0
+        - const: ufs_rx_symbol1
+        - const: ufs_tx_symbol0
+        - const: pcie0_pipe
 
   '#clock-cells':
     const: 1
@@ -118,6 +136,7 @@ else:
       compatible:
         contains:
           enum:
+            - qcom,gcc-msm8998
             - qcom,gcc-sm8150
             - qcom,gcc-sc7180
   then:
@@ -179,8 +198,8 @@ examples:
     clock-controller@100000 {
       compatible = "qcom,gcc-sc7180";
       reg = <0x100000 0x1f0000>;
-      clocks = <&rpmhcc 0>, <&rpmhcc 1>;
-      clock-names = "bi_tcxo", "bi_tcxo_ao";
+      clocks = <&rpmhcc 0>, <&rpmhcc 1>, <0>;
+      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
       #clock-cells = <1>;
       #reset-cells = <1>;
       #power-domain-cells = <1>;
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

