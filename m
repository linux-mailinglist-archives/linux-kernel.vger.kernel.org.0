Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B7A4AF2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfIARo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 13:44:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42258 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfIARo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 13:44:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C73376090F; Sun,  1 Sep 2019 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567359866;
        bh=a9PUoE6TAyvPF1jlYJf1pYU/4OGq1P6lUpBn+tl/vZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWq+z7HBKtogEYJFsPStFVPAnuiwEzUkCJrG/YQ3xArFNbG0TkLidgroi+KggSKdN
         rcTPdTNI47ULZ6Jq6fzU1LuCtgetI1a21LbpuvUNL4s7ql4nxvDDxP1t8d/IdZ8zZX
         LXc1FgfvB1PPcokeMNjcYuvOifKgHsF8CyITbPxg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 487CB60592;
        Sun,  1 Sep 2019 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567359865;
        bh=a9PUoE6TAyvPF1jlYJf1pYU/4OGq1P6lUpBn+tl/vZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDWtYzrrTumTs3nej0zdAs0hCPsApeKSnCRVPxskSktf/luuNEblfQbFxHh8wuGBY
         XDEKYBFSASinZ5wYFrnwt6tzo9J0nQjy569U14dW05z8Q6a0VvEwN9rfDOY408r42f
         fyCDL7W+3jjYzZeYxhyc9CyiAt6JPLXNtMhUWM+k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 487CB60592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 1/2] dt-bindings: reset: aoss: Convert AOSS reset bindings to yaml
Date:   Sun,  1 Sep 2019 23:14:06 +0530
Message-Id: <20190901174407.30756-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190901174407.30756-1-sibis@codeaurora.org>
References: <20190901174407.30756-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert AOSS reset bindings to yaml and add SC7180 AOSS reset to the list
of possible bindings.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../bindings/reset/qcom,aoss-reset.txt        | 52 -------------------
 .../bindings/reset/qcom,aoss-reset.yaml       | 47 +++++++++++++++++
 2 files changed, 47 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
deleted file mode 100644
index 510c748656ec5..0000000000000
--- a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-Qualcomm AOSS Reset Controller
-======================================
-
-This binding describes a reset-controller found on AOSS-CC (always on subsystem)
-for Qualcomm SDM845 SoCs.
-
-Required properties:
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be:
-		    "qcom,sdm845-aoss-cc"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must specify the base address and size of the register
-	            space.
-
-- #reset-cells:
-	Usage: required
-	Value type: <uint>
-	Definition: must be 1; cell entry represents the reset index.
-
-Example:
-
-aoss_reset: reset-controller@c2a0000 {
-	compatible = "qcom,sdm845-aoss-cc";
-	reg = <0xc2a0000 0x31000>;
-	#reset-cells = <1>;
-};
-
-Specifying reset lines connected to IP modules
-==============================================
-
-Device nodes that need access to reset lines should
-specify them as a reset phandle in their corresponding node as
-specified in reset.txt.
-
-For list of all valid reset indicies see
-<dt-bindings/reset/qcom,sdm845-aoss.h>
-
-Example:
-
-modem-pil@4080000 {
-	...
-
-	resets = <&aoss_reset AOSS_CC_MSS_RESTART>;
-	reset-names = "mss_restart";
-
-	...
-};
diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml
new file mode 100644
index 0000000000000..e2d85a1e1d637
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/qcom,aoss-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm AOSS Reset Controller
+
+maintainers:
+  - Sibi Sankar <sibis@codeaurora.org>
+
+description:
+  The bindings describe the reset-controller found on AOSS-CC (always on
+  subsystem) for Qualcomm Technologies Inc SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - description: on SC7180 SoCs the following compatibles must be specified
+        items:
+          - const: "qcom,sc7180-aoss-cc"
+          - const: "qcom,sdm845-aoss-cc"
+
+      - description: on SDM845 SoCs the following compatibles must be specified
+        items:
+          - const: "qcom,sdm845-aoss-cc"
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    aoss_reset: reset-controller@c2a0000 {
+      compatible = "qcom,sdm845-aoss-cc";
+      reg = <0xc2a0000 0x31000>;
+      #reset-cells = <1>;
+    };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

