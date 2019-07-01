Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD057D20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF0HZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 03:25:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfF0HZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:25:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6BE8860A97; Thu, 27 Jun 2019 07:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561620349;
        bh=oxE09IRTVjrsXuVc2uWxgCxvtlioYxx0Cz0iqmRMrVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoCpgEl7RgBDKlkSU6qizO/NjsHEcTagWp+vedgBNeVuI4/sPd0lKUablK6rRIewT
         vDe3yEPOo2oDU4FnPtTGFzUWJRIw8x3URsuhu86LGCjgqD3tvvk1ODlN/FfUIwXSRN
         9YaQknCX5UiV7XpvvaGbbGzeMpY4CFlIg0gq/gFQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from amasule-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: amasule@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7071860909;
        Thu, 27 Jun 2019 07:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561620348;
        bh=oxE09IRTVjrsXuVc2uWxgCxvtlioYxx0Cz0iqmRMrVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PltXJ6n/s/LQBIi6fEzJYTCeIZfOVoOB0X24Mj3b008yDZIGfoCfM0Ytgg+R/6WeU
         qrhkh+i6BDnwAgTV41Sp7vtvqNpdDbtNeTRuQQeGUfowkpRGYPXy9PQCXEaHhTbDjA
         QpEPBuwZCOOmb/LeDVCxEF8Bob80bhTzGCHAPLmU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7071860909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=amasule@codeaurora.org
From:   Aniket Masule <amasule@codeaurora.org>
To:     david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Subject: [PATCH v2] arm64: dts: sdm845: Add video nodes
Date:   Thu, 27 Jun 2019 12:55:34 +0530
Message-Id: <1561620334-17642-2-git-send-email-amasule@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561620334-17642-1-git-send-email-amasule@codeaurora.org>
References: <1561620334-17642-1-git-send-email-amasule@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malathi Gottam <mgottam@codeaurora.org>

This adds video nodes to sdm845 based on the examples
in the bindings.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
Co-developed-by: Aniket Masule <amasule@codeaurora.org>
Signed-off-by: Aniket Masule <amasule@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fcb9330..94813a9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1893,6 +1893,36 @@
 			};
 		};
 
+		video-codec@aa00000 {
+			compatible = "qcom,sdm845-venus";
+			reg = <0x0aa00000 0xff000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&videocc VENUS_GDSC>;
+			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
+			clock-names = "core", "iface", "bus";
+			iommus = <&apps_smmu 0x10a0 0x8>,
+				 <&apps_smmu 0x10b0 0x0>;
+			memory-region = <&venus_region>;
+
+			video-core0 {
+				compatible = "venus-decoder";
+				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
+				clock-names = "core", "bus";
+				power-domains = <&videocc VCODEC0_GDSC>;
+			};
+
+			video-core1 {
+				compatible = "venus-encoder";
+				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+				clock-names = "core", "bus";
+				power-domains = <&videocc VCODEC1_GDSC>;
+			};
+		};
+
 		videocc: clock-controller@ab00000 {
 			compatible = "qcom,sdm845-videocc";
 			reg = <0 0x0ab00000 0 0x10000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

