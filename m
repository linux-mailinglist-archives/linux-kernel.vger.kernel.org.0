Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E944C416E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfJAT5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 15:57:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJAT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:57:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8354E611BE; Tue,  1 Oct 2019 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569959856;
        bh=lacpV8pZ+TtmtbTg9XL6lXQiYbefzaqvqpcn/G+ReUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRasfR3unzZlBHZObkqI/SOOcEDE3pr/9tflSHr6ZEGVaFMvmy9vMIk2lDrsLnUtd
         a73xeRl3/oGcrTm6fIIxpvUXkS8ky1RW7DczmuFPhKXEo+QfL6SR05yQAPf73KcrGy
         6DBD+DfY24NrIVuRNerNKt3pKesUUAJ0+NX7Igeo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B20C611CE;
        Tue,  1 Oct 2019 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569959853;
        bh=lacpV8pZ+TtmtbTg9XL6lXQiYbefzaqvqpcn/G+ReUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEPq2/GDu8OmGqAPtYURwYvngVlOF7/tg2axZ//lby/SeK/PRDsCinL7wp923F0hC
         zbWwSOVcgFeiD+qiMHAN1kdNrVk8n2M8uTxnGOupph/V7I7OzqZKjZre0uBAe8UOCB
         Cx1PUQ26DR9V1bfyrNMjKM4NuqGt241fDrY/hjTE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B20C611CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sboyd@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v6 4/6] dt-bindings: clock: Add support for the MSM8998 mmcc
Date:   Tue,  1 Oct 2019 13:57:22 -0600
Message-Id: <1569959842-8399-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569959656-5202-1-git-send-email-jhugo@codeaurora.org>
References: <1569959656-5202-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the multimedia clock controller found on MSM8998.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/clock/qcom,mmcc.txt   |  21 ++
 include/dt-bindings/clock/qcom,mmcc-msm8998.h | 210 ++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-msm8998.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
index 8b0f7841af8d..a92f3cbc9736 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
@@ -10,11 +10,32 @@ Required properties :
 			"qcom,mmcc-msm8960"
 			"qcom,mmcc-msm8974"
 			"qcom,mmcc-msm8996"
+			"qcom,mmcc-msm8998"
 
 - reg : shall contain base register location and length
 - #clock-cells : shall contain 1
 - #reset-cells : shall contain 1
 
+For MSM8998 only:
+	- clocks: a list of phandles and clock-specifier pairs,
+		  one for each entry in clock-names.
+	- clock-names: "xo" for the xo clock.
+		       "gpll0" for the global pll 0 clock.
+		       "dsi0dsi" for the dsi0 pll dsi clock (required if dsi is
+				enabled, optional otherwise).
+		       "dsi0byte" for the dsi0 pll byte clock (required if dsi
+				is enabled, optional otherwise).
+		       "dsi1dsi" for the dsi1 pll dsi clock (required if dsi is
+				enabled, optional otherwise).
+		       "dsi1byte" for the dsi1 pll byte clock (required if dsi
+				is enabled, optional otherwise).
+		       "hdmipll" for the hdmi pll clock (required if hdmi is
+				enabled, optional otherwise).
+		       "dpvco" for the displayport pll vco clock (required if
+				dp is enabled, optional otherwise).
+		       "dplink" for the displayport pll link clock (required if
+				dp is enabled, optional otherwise).
+
 Optional properties :
 - #power-domain-cells : shall contain 1
 
diff --git a/include/dt-bindings/clock/qcom,mmcc-msm8998.h b/include/dt-bindings/clock/qcom,mmcc-msm8998.h
new file mode 100644
index 000000000000..ecbafdb930aa
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,mmcc-msm8998.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_MMCC_8998_H
+#define _DT_BINDINGS_CLK_MSM_MMCC_8998_H
+
+#define MMPLL0						0
+#define MMPLL0_OUT_EVEN					1
+#define MMPLL1						2
+#define MMPLL1_OUT_EVEN					3
+#define MMPLL3						4
+#define MMPLL3_OUT_EVEN					5
+#define MMPLL4						6
+#define MMPLL4_OUT_EVEN					7
+#define MMPLL5						8
+#define MMPLL5_OUT_EVEN					9
+#define MMPLL6						10
+#define MMPLL6_OUT_EVEN					11
+#define MMPLL7						12
+#define MMPLL7_OUT_EVEN					13
+#define MMPLL10						14
+#define MMPLL10_OUT_EVEN				15
+#define BYTE0_CLK_SRC					16
+#define BYTE1_CLK_SRC					17
+#define CCI_CLK_SRC					18
+#define CPP_CLK_SRC					19
+#define CSI0_CLK_SRC					20
+#define CSI1_CLK_SRC					21
+#define CSI2_CLK_SRC					22
+#define CSI3_CLK_SRC					23
+#define CSIPHY_CLK_SRC					24
+#define CSI0PHYTIMER_CLK_SRC				25
+#define CSI1PHYTIMER_CLK_SRC				26
+#define CSI2PHYTIMER_CLK_SRC				27
+#define DP_AUX_CLK_SRC					28
+#define DP_CRYPTO_CLK_SRC				29
+#define DP_LINK_CLK_SRC					30
+#define DP_PIXEL_CLK_SRC				31
+#define ESC0_CLK_SRC					32
+#define ESC1_CLK_SRC					33
+#define EXTPCLK_CLK_SRC					34
+#define FD_CORE_CLK_SRC					35
+#define HDMI_CLK_SRC					36
+#define JPEG0_CLK_SRC					37
+#define MAXI_CLK_SRC					38
+#define MCLK0_CLK_SRC					39
+#define MCLK1_CLK_SRC					40
+#define MCLK2_CLK_SRC					41
+#define MCLK3_CLK_SRC					42
+#define MDP_CLK_SRC					43
+#define VSYNC_CLK_SRC					44
+#define AHB_CLK_SRC					45
+#define AXI_CLK_SRC					46
+#define PCLK0_CLK_SRC					47
+#define PCLK1_CLK_SRC					48
+#define ROT_CLK_SRC					49
+#define VIDEO_CORE_CLK_SRC				50
+#define VIDEO_SUBCORE0_CLK_SRC				51
+#define VIDEO_SUBCORE1_CLK_SRC				52
+#define VFE0_CLK_SRC					53
+#define VFE1_CLK_SRC					54
+#define MISC_AHB_CLK					55
+#define VIDEO_CORE_CLK					56
+#define VIDEO_AHB_CLK					57
+#define VIDEO_AXI_CLK					58
+#define VIDEO_MAXI_CLK					59
+#define VIDEO_SUBCORE0_CLK				60
+#define VIDEO_SUBCORE1_CLK				61
+#define MDSS_AHB_CLK					62
+#define MDSS_HDMI_DP_AHB_CLK				63
+#define MDSS_AXI_CLK					64
+#define MDSS_PCLK0_CLK					65
+#define MDSS_PCLK1_CLK					66
+#define MDSS_MDP_CLK					67
+#define MDSS_MDP_LUT_CLK				68
+#define MDSS_EXTPCLK_CLK				69
+#define MDSS_VSYNC_CLK					70
+#define MDSS_HDMI_CLK					71
+#define MDSS_BYTE0_CLK					72
+#define MDSS_BYTE1_CLK					73
+#define MDSS_ESC0_CLK					74
+#define MDSS_ESC1_CLK					75
+#define MDSS_ROT_CLK					76
+#define MDSS_DP_LINK_CLK				77
+#define MDSS_DP_LINK_INTF_CLK				78
+#define MDSS_DP_CRYPTO_CLK				79
+#define MDSS_DP_PIXEL_CLK				80
+#define MDSS_DP_AUX_CLK					81
+#define MDSS_BYTE0_INTF_CLK				82
+#define MDSS_BYTE1_INTF_CLK				83
+#define CAMSS_CSI0PHYTIMER_CLK				84
+#define CAMSS_CSI1PHYTIMER_CLK				85
+#define CAMSS_CSI2PHYTIMER_CLK				86
+#define CAMSS_CSI0_CLK					87
+#define CAMSS_CSI0_AHB_CLK				88
+#define CAMSS_CSI0RDI_CLK				89
+#define CAMSS_CSI0PIX_CLK				90
+#define CAMSS_CSI1_CLK					91
+#define CAMSS_CSI1_AHB_CLK				92
+#define CAMSS_CSI1RDI_CLK				93
+#define CAMSS_CSI1PIX_CLK				94
+#define CAMSS_CSI2_CLK					95
+#define CAMSS_CSI2_AHB_CLK				96
+#define CAMSS_CSI2RDI_CLK				97
+#define CAMSS_CSI2PIX_CLK				98
+#define CAMSS_CSI3_CLK					99
+#define CAMSS_CSI3_AHB_CLK				100
+#define CAMSS_CSI3RDI_CLK				101
+#define CAMSS_CSI3PIX_CLK				102
+#define CAMSS_ISPIF_AHB_CLK				103
+#define CAMSS_CCI_CLK					104
+#define CAMSS_CCI_AHB_CLK				105
+#define CAMSS_MCLK0_CLK					106
+#define CAMSS_MCLK1_CLK					107
+#define CAMSS_MCLK2_CLK					108
+#define CAMSS_MCLK3_CLK					109
+#define CAMSS_TOP_AHB_CLK				110
+#define CAMSS_AHB_CLK					111
+#define CAMSS_MICRO_AHB_CLK				112
+#define CAMSS_JPEG0_CLK					113
+#define CAMSS_JPEG_AHB_CLK				114
+#define CAMSS_JPEG_AXI_CLK				115
+#define CAMSS_VFE0_AHB_CLK				116
+#define CAMSS_VFE1_AHB_CLK				117
+#define CAMSS_VFE0_CLK					118
+#define CAMSS_VFE1_CLK					119
+#define CAMSS_CPP_CLK					120
+#define CAMSS_CPP_AHB_CLK				121
+#define CAMSS_VFE_VBIF_AHB_CLK				122
+#define CAMSS_VFE_VBIF_AXI_CLK				123
+#define CAMSS_CPP_AXI_CLK				124
+#define CAMSS_CPP_VBIF_AHB_CLK				125
+#define CAMSS_CSI_VFE0_CLK				126
+#define CAMSS_CSI_VFE1_CLK				127
+#define CAMSS_VFE0_STREAM_CLK				128
+#define CAMSS_VFE1_STREAM_CLK				129
+#define CAMSS_CPHY_CSID0_CLK				130
+#define CAMSS_CPHY_CSID1_CLK				131
+#define CAMSS_CPHY_CSID2_CLK				132
+#define CAMSS_CPHY_CSID3_CLK				133
+#define CAMSS_CSIPHY0_CLK				134
+#define CAMSS_CSIPHY1_CLK				135
+#define CAMSS_CSIPHY2_CLK				136
+#define FD_CORE_CLK					137
+#define FD_CORE_UAR_CLK					138
+#define FD_AHB_CLK					139
+#define MNOC_AHB_CLK					140
+#define BIMC_SMMU_AHB_CLK				141
+#define BIMC_SMMU_AXI_CLK				142
+#define MNOC_MAXI_CLK					143
+#define VMEM_MAXI_CLK					144
+#define VMEM_AHB_CLK					145
+
+#define SPDM_BCR					0
+#define SPDM_RM_BCR					1
+#define MISC_BCR					2
+#define VIDEO_TOP_BCR					3
+#define THROTTLE_VIDEO_BCR				4
+#define MDSS_BCR					5
+#define THROTTLE_MDSS_BCR				6
+#define CAMSS_PHY0_BCR					7
+#define CAMSS_PHY1_BCR					8
+#define CAMSS_PHY2_BCR					9
+#define CAMSS_CSI0_BCR					10
+#define CAMSS_CSI0RDI_BCR				11
+#define CAMSS_CSI0PIX_BCR				12
+#define CAMSS_CSI1_BCR					13
+#define CAMSS_CSI1RDI_BCR				14
+#define CAMSS_CSI1PIX_BCR				15
+#define CAMSS_CSI2_BCR					16
+#define CAMSS_CSI2RDI_BCR				17
+#define CAMSS_CSI2PIX_BCR				18
+#define CAMSS_CSI3_BCR					19
+#define CAMSS_CSI3RDI_BCR				20
+#define CAMSS_CSI3PIX_BCR				21
+#define CAMSS_ISPIF_BCR					22
+#define CAMSS_CCI_BCR					23
+#define CAMSS_TOP_BCR					24
+#define CAMSS_AHB_BCR					25
+#define CAMSS_MICRO_BCR					26
+#define CAMSS_JPEG_BCR					27
+#define CAMSS_VFE0_BCR					28
+#define CAMSS_VFE1_BCR					29
+#define CAMSS_VFE_VBIF_BCR				30
+#define CAMSS_CPP_TOP_BCR				31
+#define CAMSS_CPP_BCR					32
+#define CAMSS_CSI_VFE0_BCR				33
+#define CAMSS_CSI_VFE1_BCR				34
+#define CAMSS_FD_BCR					35
+#define THROTTLE_CAMSS_BCR				36
+#define MNOCAHB_BCR					37
+#define MNOCAXI_BCR					38
+#define BMIC_SMMU_BCR					39
+#define MNOC_MAXI_BCR					40
+#define VMEM_BCR					41
+#define BTO_BCR						42
+
+#define VIDEO_TOP_GDSC		1
+#define VIDEO_SUBCORE0_GDSC	2
+#define VIDEO_SUBCORE1_GDSC	3
+#define MDSS_GDSC		4
+#define CAMSS_TOP_GDSC		5
+#define CAMSS_VFE0_GDSC		6
+#define CAMSS_VFE1_GDSC		7
+#define CAMSS_CPP_GDSC		8
+#define BIMC_SMMU_GDSC		9
+
+#endif
-- 
2.17.1

