Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32AD156FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 08:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBJHlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 02:41:23 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:18580 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgBJHlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:41:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581320481; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=yCDeCdgKA3IXNoyqrtgJmGy4KgKCgByY8yGLh4PgpZg=; b=eJVDeVhDwrV4dp5jY+r+8uVQ4MlxkO0+Oh5/OjcSfX1EjCXn9uxO6dv816nnX6qf4Jd4rgcC
 Zq1TyB0Sz68kGNi+yad0IsUDouEvDj0bmDZnIIMI/d3szMOmn4wigjJ7vDyhGZkcZmiBM4xF
 7NbJbBaox1LMRQMCGKSj2Sbzsuw=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e410920.7fbbe469ee30-smtp-out-n01;
 Mon, 10 Feb 2020 07:41:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90120C433A2; Mon, 10 Feb 2020 07:41:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2044C447A3;
        Mon, 10 Feb 2020 07:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2044C447A3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH v6] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
Date:   Mon, 10 Feb 2020 13:11:05 +0530
Message-Id: <1581320465-15854-2-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1581320465-15854-1-git-send-email-smasetty@codeaurora.org>
References: <1581320465-15854-1-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the required dt nodes and properties
to enabled A618 GPU.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 102 +++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f3fcc5c..63fff15 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1043,6 +1043,108 @@
 			};
 		};
 
+		gpu: gpu@5000000 {
+			compatible = "qcom,adreno-618.0", "qcom,adreno";
+			#stream-id-cells = <16>;
+			reg = <0 0x05000000 0 0x40000>, <0 0x0509e000 0 0x1000>,
+				<0 0x05061000 0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory", "cx_mem", "cx_dbgc";
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&adreno_smmu 0>;
+			operating-points-v2 = <&gpu_opp_table>;
+			qcom,gmu = <&gmu>;
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-800000000 {
+					opp-hz = /bits/ 64 <800000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+				};
+
+				opp-650000000 {
+					opp-hz = /bits/ 64 <650000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+				};
+
+				opp-565000000 {
+					opp-hz = /bits/ 64 <565000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+
+				opp-430000000 {
+					opp-hz = /bits/ 64 <430000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-355000000 {
+					opp-hz = /bits/ 64 <355000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-267000000 {
+					opp-hz = /bits/ 64 <267000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+
+				opp-180000000 {
+					opp-hz = /bits/ 64 <180000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
+		adreno_smmu: iommu@5040000 {
+			compatible = "qcom,sc7180-smmu-v2", "qcom,smmu-v2";
+			reg = <0 0x05040000 0 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				<&gcc GCC_GPU_CFG_AHB_CLK>,
+				<&gcc GCC_DDRSS_GPU_AXI_CLK>;
+
+			clock-names = "bus", "iface", "mem_iface_clk";
+			power-domains = <&gpucc CX_GDSC>;
+		};
+
+		gmu: gmu@506a000 {
+			compatible="qcom,adreno-gmu-618.0", "qcom,adreno-gmu";
+			reg = <0 0x0506a000 0 0x31000>, <0 0x0b290000 0 0x10000>,
+				<0 0x0b490000 0 0x10000>;
+			reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+			       <&gpucc GPU_CC_CXO_CLK>,
+			       <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+			       <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names = "gmu", "cxo", "axi", "memnoc";
+			power-domains = <&gpucc CX_GDSC>, <&gpucc GX_GDSC>;
+			power-domain-names = "cx", "gx";
+			iommus = <&adreno_smmu 5>;
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sc7180-gpucc";
 			reg = <0 0x05090000 0 0x9000>;
-- 
1.9.1
