Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4238014D58B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 05:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgA3ETT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 23:19:19 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:37962 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbgA3ETT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:19:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580357958; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FyekpXztweTBbXUHaIsv0VJPtRbAjYA8mKBWve8q7gc=; b=oJCehbg7iApaprSlF+lD0U6ZxhxCELeDwTqWEg89YwELWh/zCDY//L4HfyJDz2jhn+I2TM9j
 2rHFVoeKjRaivJ8k38AHYlqZHDXmHwI2Kqo3NOt6w6EkXmPXXaocPajLZ1RFhxhk/e7VRvbH
 Len+SDU+OvO5gjBT+iaA2LtzUsA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e32593f.7f9935175810-smtp-out-n01;
 Thu, 30 Jan 2020 04:19:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7FD5EC4479C; Thu, 30 Jan 2020 04:19:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC8C2C433CB;
        Thu, 30 Jan 2020 04:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC8C2C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v3 1/3] dt-bindings: clock: Add YAML schemas for the QCOM MSS clock bindings
Date:   Thu, 30 Jan 2020 09:48:41 +0530
Message-Id: <1580357923-19783-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580357923-19783-1-git-send-email-tdas@codeaurora.org>
References: <1580357923-19783-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Modem Subsystem clock provider have a bunch of generic properties
that are needed in a device tree. Add a YAML schemas for those.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,mss.yaml        | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,mss.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,mss.yaml b/Documentation/devicetree/bindings/clock/qcom,mss.yaml
new file mode 100644
index 0000000..ebb04e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,mss.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/qcom,mss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Modem Clock Controller Binding
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm modem clock control module which supports the clocks.
+
+properties:
+  compatible:
+    enum:
+       - qcom,sc7180-mss
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+    items:
+      - description: gcc_mss_mfab_axi clock from GCC
+      - description: gcc_mss_nav_axi clock from GCC
+      - description: gcc_mss_cfg_ahb clock from GCC
+
+  clock-names:
+    items:
+      - const: gcc_mss_mfab_axis_clk
+      - const: gcc_mss_nav_axi_clk
+      - const: cfg_clk
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Example of MSS with clock nodes properties for SC7180:
+  - |
+    clock-controller@41a8000 {
+      compatible = "qcom,sc7180-mss";
+      reg = <0x041a8000 0x8000>;
+      clocks = <&gcc 126>, <&gcc 127>, <&gcc 125>;
+      clock-names = "gcc_mss_mfab_axis_clk", "gcc_mss_nav_axi_clk", "cfg_clk";
+      #clock-cells = <1>;
+    };
+...
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
