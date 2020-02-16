Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52440160389
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 11:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgBPK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 05:29:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgBPK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 05:29:10 -0500
Received: from localhost.localdomain (unknown [122.178.194.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052B420857;
        Sun, 16 Feb 2020 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581848949;
        bh=iE998DlgK+Rv2cwgd4BqV+PzsCLkWpad9ocwW8pQa6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWVTZJRIarr+Hm+1r+Ul2bnWuEbNur3OfHf5IRI8q2SpfMh55VrxcfOLTYHaid70P
         1gXI/zVSW2y4SN5eVdSh/K5dCUBSl2DFRfKgspndxl+wfmpvCCNAc0GrT0Ag1AMTeF
         t6vYojsVNPZ5gDduS2WDz5hR3W+eNDmH/qkvdDKU=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, vnkgutta@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 4/5] dt-bindings: clock: Add SM8250 GCC clock bindings
Date:   Sun, 16 Feb 2020 15:57:24 +0530
Message-Id: <20200216102725.2629155-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200216102725.2629155-1-vkoul@kernel.org>
References: <20200216102725.2629155-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

Add device tree bindings for global clock controller on SM8250 SoCs.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/clock/qcom,gcc-sm8250.yaml       |  72 +++++
 include/dt-bindings/clock/qcom,gcc-sm8250.h   | 271 ++++++++++++++++++
 2 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8250.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
new file mode 100644
index 000000000000..d48fb25b0d44
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-sm8250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for SM8250
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on SM8250.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-sm8250.h
+
+properties:
+  compatible:
+    const: qcom,gcc-sm8250
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: sleep_clk
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  protected-clocks:
+    description:
+      Protected clock specifier list as per common clock binding.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,gcc-sm8250";
+      reg = <0 0x00100000 0 0x1f0000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>;
+      clock-names = "bi_tcxo", "sleep_clk";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,gcc-sm8250.h b/include/dt-bindings/clock/qcom,gcc-sm8250.h
new file mode 100644
index 000000000000..7b7abe327e37
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sm8250.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM8250_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM8250_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_EVEN						1
+#define GPLL4							2
+#define GPLL9							3
+#define GCC_AGGRE_NOC_PCIE_TBU_CLK				4
+#define GCC_AGGRE_UFS_CARD_AXI_CLK				5
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				6
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				7
+#define GCC_AGGRE_USB3_SEC_AXI_CLK				8
+#define GCC_BOOT_ROM_AHB_CLK					9
+#define GCC_CAMERA_AHB_CLK					10
+#define GCC_CAMERA_HF_AXI_CLK					11
+#define GCC_CAMERA_SF_AXI_CLK					12
+#define GCC_CAMERA_XO_CLK					13
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				14
+#define GCC_CFG_NOC_USB3_SEC_AXI_CLK				15
+#define GCC_CPUSS_AHB_CLK					16
+#define GCC_CPUSS_AHB_CLK_SRC					17
+#define GCC_CPUSS_AHB_POSTDIV_CLK_SRC				18
+#define GCC_CPUSS_DVM_BUS_CLK					19
+#define GCC_CPUSS_RBCPR_CLK					20
+#define GCC_DDRSS_GPU_AXI_CLK					21
+#define GCC_DDRSS_PCIE_SF_TBU_CLK				22
+#define GCC_DISP_AHB_CLK					23
+#define GCC_DISP_HF_AXI_CLK					24
+#define GCC_DISP_SF_AXI_CLK					25
+#define GCC_DISP_XO_CLK						26
+#define GCC_GP1_CLK						27
+#define GCC_GP1_CLK_SRC						28
+#define GCC_GP2_CLK						29
+#define GCC_GP2_CLK_SRC						30
+#define GCC_GP3_CLK						31
+#define GCC_GP3_CLK_SRC						32
+#define GCC_GPU_CFG_AHB_CLK					33
+#define GCC_GPU_GPLL0_CLK_SRC					34
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				35
+#define GCC_GPU_IREF_EN						36
+#define GCC_GPU_MEMNOC_GFX_CLK					37
+#define GCC_GPU_SNOC_DVM_GFX_CLK				38
+#define GCC_NPU_AXI_CLK						39
+#define GCC_NPU_BWMON_AXI_CLK					40
+#define GCC_NPU_BWMON_CFG_AHB_CLK				41
+#define GCC_NPU_CFG_AHB_CLK					42
+#define GCC_NPU_DMA_CLK						43
+#define GCC_NPU_GPLL0_CLK_SRC					44
+#define GCC_NPU_GPLL0_DIV_CLK_SRC				45
+#define GCC_PCIE0_PHY_REFGEN_CLK				46
+#define GCC_PCIE1_PHY_REFGEN_CLK				47
+#define GCC_PCIE2_PHY_REFGEN_CLK				48
+#define GCC_PCIE_0_AUX_CLK					49
+#define GCC_PCIE_0_AUX_CLK_SRC					50
+#define GCC_PCIE_0_CFG_AHB_CLK					51
+#define GCC_PCIE_0_MSTR_AXI_CLK					52
+#define GCC_PCIE_0_PIPE_CLK					53
+#define GCC_PCIE_0_SLV_AXI_CLK					54
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				55
+#define GCC_PCIE_1_AUX_CLK					56
+#define GCC_PCIE_1_AUX_CLK_SRC					57
+#define GCC_PCIE_1_CFG_AHB_CLK					58
+#define GCC_PCIE_1_MSTR_AXI_CLK					59
+#define GCC_PCIE_1_PIPE_CLK					60
+#define GCC_PCIE_1_SLV_AXI_CLK					61
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				62
+#define GCC_PCIE_2_AUX_CLK					63
+#define GCC_PCIE_2_AUX_CLK_SRC					64
+#define GCC_PCIE_2_CFG_AHB_CLK					65
+#define GCC_PCIE_2_MSTR_AXI_CLK					66
+#define GCC_PCIE_2_PIPE_CLK					67
+#define GCC_PCIE_2_SLV_AXI_CLK					68
+#define GCC_PCIE_2_SLV_Q2A_AXI_CLK				69
+#define GCC_PCIE_MDM_CLKREF_EN					70
+#define GCC_PCIE_PHY_AUX_CLK					71
+#define GCC_PCIE_PHY_REFGEN_CLK_SRC				72
+#define GCC_PCIE_WIFI_CLKREF_EN					73
+#define GCC_PCIE_WIGIG_CLKREF_EN				74
+#define GCC_PDM2_CLK						75
+#define GCC_PDM2_CLK_SRC					76
+#define GCC_PDM_AHB_CLK						77
+#define GCC_PDM_XO4_CLK						78
+#define GCC_PRNG_AHB_CLK					79
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				80
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				81
+#define GCC_QMIP_DISP_AHB_CLK					82
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				83
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				84
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				85
+#define GCC_QUPV3_WRAP0_CORE_CLK				86
+#define GCC_QUPV3_WRAP0_S0_CLK					87
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				88
+#define GCC_QUPV3_WRAP0_S1_CLK					89
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				90
+#define GCC_QUPV3_WRAP0_S2_CLK					91
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				92
+#define GCC_QUPV3_WRAP0_S3_CLK					93
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				94
+#define GCC_QUPV3_WRAP0_S4_CLK					95
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				96
+#define GCC_QUPV3_WRAP0_S5_CLK					97
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				98
+#define GCC_QUPV3_WRAP0_S6_CLK					99
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC				100
+#define GCC_QUPV3_WRAP0_S7_CLK					101
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC				102
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				103
+#define GCC_QUPV3_WRAP1_CORE_CLK				104
+#define GCC_QUPV3_WRAP1_S0_CLK					105
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				106
+#define GCC_QUPV3_WRAP1_S1_CLK					107
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				108
+#define GCC_QUPV3_WRAP1_S2_CLK					109
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				110
+#define GCC_QUPV3_WRAP1_S3_CLK					111
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				112
+#define GCC_QUPV3_WRAP1_S4_CLK					113
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				114
+#define GCC_QUPV3_WRAP1_S5_CLK					115
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				116
+#define GCC_QUPV3_WRAP2_CORE_2X_CLK				117
+#define GCC_QUPV3_WRAP2_CORE_CLK				118
+#define GCC_QUPV3_WRAP2_S0_CLK					119
+#define GCC_QUPV3_WRAP2_S0_CLK_SRC				120
+#define GCC_QUPV3_WRAP2_S1_CLK					121
+#define GCC_QUPV3_WRAP2_S1_CLK_SRC				122
+#define GCC_QUPV3_WRAP2_S2_CLK					123
+#define GCC_QUPV3_WRAP2_S2_CLK_SRC				124
+#define GCC_QUPV3_WRAP2_S3_CLK					125
+#define GCC_QUPV3_WRAP2_S3_CLK_SRC				126
+#define GCC_QUPV3_WRAP2_S4_CLK					127
+#define GCC_QUPV3_WRAP2_S4_CLK_SRC				128
+#define GCC_QUPV3_WRAP2_S5_CLK					129
+#define GCC_QUPV3_WRAP2_S5_CLK_SRC				130
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				131
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				132
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				133
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				134
+#define GCC_QUPV3_WRAP_2_M_AHB_CLK				135
+#define GCC_QUPV3_WRAP_2_S_AHB_CLK				136
+#define GCC_SDCC2_AHB_CLK					137
+#define GCC_SDCC2_APPS_CLK					138
+#define GCC_SDCC2_APPS_CLK_SRC					139
+#define GCC_SDCC4_AHB_CLK					140
+#define GCC_SDCC4_APPS_CLK					141
+#define GCC_SDCC4_APPS_CLK_SRC					142
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				143
+#define GCC_TSIF_AHB_CLK					144
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK				145
+#define GCC_TSIF_REF_CLK					146
+#define GCC_TSIF_REF_CLK_SRC					147
+#define GCC_UFS_1X_CLKREF_EN					148
+#define GCC_UFS_CARD_AHB_CLK					149
+#define GCC_UFS_CARD_AXI_CLK					150
+#define GCC_UFS_CARD_AXI_CLK_SRC				151
+#define GCC_UFS_CARD_ICE_CORE_CLK				152
+#define GCC_UFS_CARD_ICE_CORE_CLK_SRC				153
+#define GCC_UFS_CARD_PHY_AUX_CLK				154
+#define GCC_UFS_CARD_PHY_AUX_CLK_SRC				155
+#define GCC_UFS_CARD_RX_SYMBOL_0_CLK				156
+#define GCC_UFS_CARD_RX_SYMBOL_1_CLK				157
+#define GCC_UFS_CARD_TX_SYMBOL_0_CLK				158
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK				159
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC			160
+#define GCC_UFS_PHY_AHB_CLK					161
+#define GCC_UFS_PHY_AXI_CLK					162
+#define GCC_UFS_PHY_AXI_CLK_SRC					163
+#define GCC_UFS_PHY_ICE_CORE_CLK				164
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				165
+#define GCC_UFS_PHY_PHY_AUX_CLK					166
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				167
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				168
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				169
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				170
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				171
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				172
+#define GCC_USB30_PRIM_MASTER_CLK				173
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				174
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				175
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			176
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		177
+#define GCC_USB30_PRIM_SLEEP_CLK				178
+#define GCC_USB30_SEC_MASTER_CLK				179
+#define GCC_USB30_SEC_MASTER_CLK_SRC				180
+#define GCC_USB30_SEC_MOCK_UTMI_CLK				181
+#define GCC_USB30_SEC_MOCK_UTMI_CLK_SRC				182
+#define GCC_USB30_SEC_MOCK_UTMI_POSTDIV_CLK_SRC			183
+#define GCC_USB30_SEC_SLEEP_CLK					184
+#define GCC_USB3_PRIM_PHY_AUX_CLK				185
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				186
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				187
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				188
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				189
+#define GCC_USB3_SEC_CLKREF_EN					190
+#define GCC_USB3_SEC_PHY_AUX_CLK				191
+#define GCC_USB3_SEC_PHY_AUX_CLK_SRC				192
+#define GCC_USB3_SEC_PHY_COM_AUX_CLK				193
+#define GCC_USB3_SEC_PHY_PIPE_CLK				194
+#define GCC_USB3_SEC_PHY_PIPE_CLK_SRC				195
+#define GCC_VIDEO_AHB_CLK					196
+#define GCC_VIDEO_AXI0_CLK					197
+#define GCC_VIDEO_AXI1_CLK					198
+#define GCC_VIDEO_XO_CLK					199
+
+/* GCC resets */
+#define GCC_GPU_BCR						0
+#define GCC_MMSS_BCR						1
+#define GCC_NPU_BWMON_BCR					2
+#define GCC_NPU_BCR						3
+#define GCC_PCIE_0_BCR						4
+#define GCC_PCIE_0_LINK_DOWN_BCR				5
+#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				6
+#define GCC_PCIE_0_PHY_BCR					7
+#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			8
+#define GCC_PCIE_1_BCR						9
+#define GCC_PCIE_1_LINK_DOWN_BCR				10
+#define GCC_PCIE_1_NOCSR_COM_PHY_BCR				11
+#define GCC_PCIE_1_PHY_BCR					12
+#define GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR			13
+#define GCC_PCIE_2_BCR						14
+#define GCC_PCIE_2_LINK_DOWN_BCR				15
+#define GCC_PCIE_2_NOCSR_COM_PHY_BCR				16
+#define GCC_PCIE_2_PHY_BCR					17
+#define GCC_PCIE_2_PHY_NOCSR_COM_PHY_BCR			18
+#define GCC_PCIE_PHY_BCR					19
+#define GCC_PCIE_PHY_CFG_AHB_BCR				20
+#define GCC_PCIE_PHY_COM_BCR					21
+#define GCC_PDM_BCR						22
+#define GCC_PRNG_BCR						23
+#define GCC_QUPV3_WRAPPER_0_BCR					24
+#define GCC_QUPV3_WRAPPER_1_BCR					25
+#define GCC_QUPV3_WRAPPER_2_BCR					26
+#define GCC_QUSB2PHY_PRIM_BCR					27
+#define GCC_QUSB2PHY_SEC_BCR					28
+#define GCC_SDCC2_BCR						29
+#define GCC_SDCC4_BCR						30
+#define GCC_TSIF_BCR						31
+#define GCC_UFS_CARD_BCR					32
+#define GCC_UFS_PHY_BCR						33
+#define GCC_USB30_PRIM_BCR					34
+#define GCC_USB30_SEC_BCR					35
+#define GCC_USB3_DP_PHY_PRIM_BCR				36
+#define GCC_USB3_DP_PHY_SEC_BCR					37
+#define GCC_USB3_PHY_PRIM_BCR					38
+#define GCC_USB3_PHY_SEC_BCR					39
+#define GCC_USB3PHY_PHY_PRIM_BCR				40
+#define GCC_USB3PHY_PHY_SEC_BCR					41
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				42
+#define GCC_VIDEO_AXI0_CLK_ARES					43
+#define GCC_VIDEO_AXI1_CLK_ARES					44
+
+/* GCC power domains */
+#define PCIE_0_GDSC						0
+#define PCIE_1_GDSC						1
+#define PCIE_2_GDSC						2
+#define UFS_CARD_GDSC						3
+#define UFS_PHY_GDSC						4
+#define USB30_PRIM_GDSC						5
+#define USB30_SEC_GDSC						6
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC			7
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC			8
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC			9
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF1_GDSC			10
+
+#endif
-- 
2.24.1

