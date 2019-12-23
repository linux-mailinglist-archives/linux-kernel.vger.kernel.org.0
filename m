Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF212952A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 12:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfLWLeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 06:34:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38212 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLWLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:34:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so12379637lfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 03:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sRlbBOojW7v2VRLaDWPeR8d17hgWrl9wNZOspFmUuFU=;
        b=d4l5DT24Y38W5mGuPJIynJ4QPy5y2AWXpfgy1NN3L/MYUmQX19hnKTTiPzFkalQ9Mn
         PgyRbz56ibJ1HYrr7UfrDjkHeXb40tsZdYSFwRRS3BuRxDe2BsmwolxenveHq6hPUruv
         Xy7PCG415Tej4ov7zYhfhSmb9vQHj05DFGuUWvmLwEwJZm+V7KN5LN9XDXsaK4AOPICJ
         D4waAR3nseEIP22O3paOsc50esLW1/Ln3N51JGKwiw4/BLhSltqxp1dirTucsmhovzk9
         UwU5u7lk3FKJaQ119nGK3AsNrPL7AummJd/0hqvuOagRfVuePG5e3XMUyBIPvyBSh8CM
         X8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sRlbBOojW7v2VRLaDWPeR8d17hgWrl9wNZOspFmUuFU=;
        b=Jg3xWhjmrJ70k5GIcUuKKkc5Rvr5hpgjqwn6+cwOuPMIuJiAo1fUCqSIuah0XAM3pd
         HHLN/7/kUmrevi6d7zX9zwB4go26KJLMzq817uMt8M6QnjhYGzwfOi+HwWHFecPKXaaO
         gH7DnyegND5vuL4WOJauJkAWh46nfmKdZu7C9hL4MEs5Et/k5dLI+CImyUCnP8Wwkh0Q
         ckHzIs3bi85poD1fs744dzcpZz6cTOdhWPmXfIl72sm+cVHt+l7S9xTMTQHdbYW35MZ9
         QxKT2xC5zC2Am6uHTik6ntxWIYLPbvgNEy4dXOJb5nECwXUOwaii4D1CQm1oFSqpjx3J
         xszQ==
X-Gm-Message-State: APjAAAUty4CS/pazPPcI360bcAYWOYvdzVa87cvPs885UdcT6j58rJzE
        /QrqQd9BD2/47DInICpbVItaBg==
X-Google-Smtp-Source: APXvYqxF0S28L1/Zi6H0Gem2KPIrjcbUfKLbJmevhwSHRFRhcsmkmzWRZmEGRfdJYYuWSay6RfkSyg==
X-Received: by 2002:a19:888:: with SMTP id 130mr16914253lfi.167.1577100842992;
        Mon, 23 Dec 2019 03:34:02 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id g15sm8381500ljk.8.2019.12.23.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 03:34:02 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 11/12] arm64: dts: sdm845: follow venus-sdm845v2 DT binding
Date:   Mon, 23 Dec 2019 13:33:10 +0200
Message-Id: <20191223113311.20602-12-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
References: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all pmdomain and clock resources to Venus DT node. And make
possible to support dynamic core assignment on v4.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23c936f..c5784951d408 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2568,32 +2568,33 @@
 		};
 
 		video-codec@aa00000 {
-			compatible = "qcom,sdm845-venus";
+			compatible = "qcom,sdm845-venus-v2";
 			reg = <0 0x0aa00000 0 0xff000>;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&videocc VENUS_GDSC>;
+			power-domains = <&videocc VENUS_GDSC>,
+					<&videocc VCODEC0_GDSC>,
+					<&videocc VCODEC1_GDSC>;
+			power-domain-names = "venus", "vcodec0", "vcodec1";
 			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
 				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
-				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
-			clock-names = "core", "iface", "bus";
+				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>,
+				 <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+				 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+			clock-names = "core", "iface", "bus",
+				      "vcodec0_core", "vcodec0_bus",
+				      "vcodec1_core", "vcodec1_bus";
 			iommus = <&apps_smmu 0x10a0 0x8>,
 				 <&apps_smmu 0x10b0 0x0>;
 			memory-region = <&venus_mem>;
 
 			video-core0 {
 				compatible = "venus-decoder";
-				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
-					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
-				clock-names = "core", "bus";
-				power-domains = <&videocc VCODEC0_GDSC>;
 			};
 
 			video-core1 {
 				compatible = "venus-encoder";
-				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
-					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
-				clock-names = "core", "bus";
-				power-domains = <&videocc VCODEC1_GDSC>;
 			};
 		};
 
-- 
2.17.1

