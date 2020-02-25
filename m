Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69216C053
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgBYMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 07:08:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37959 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbgBYMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:08:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id p7so1037251pli.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+p6H2ZNLGX3Lb58Cw5KgycQ+ehTxEdhQmQiKBPEVO+U=;
        b=kRtX+kgwVQA0xe9sRwmpzh2Hui+5ZOMUT7TdrKqB2mMpSLgZ86Fqj8SOCnZs3muWGF
         6vT48SozMlKzlGQ2X8jhOJQC1Z2rxPt0ypBryt23mAIGx+ZD6ZCFvbhqHOa4MSIw/2E2
         0M0giWjJz5nUIDSxGjUcMyhOt770JuOtcAQwhNnNdxYYn4Of5WIkZ3UZS0mnB+J/oorL
         8FiX6ksmz+xxIvyrDzA9G/stTptlif7VZhicvZfl1kg5Zk9APlhlSy1JZdmc5LjGEPx1
         DgC8Gs1hixUADJ/AQBk2r/8GmiJvyTn2Z2QVk60hgQLVo120Ep473xU9hm7EADhF6/R1
         5ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+p6H2ZNLGX3Lb58Cw5KgycQ+ehTxEdhQmQiKBPEVO+U=;
        b=tzTZX7y/PmYhxtD12VdYYwvqvkwPuZ1mAMO4t/4lcznhq7aYHIeebQldyxwUx8ZrFL
         Jx/IWkIz1Odqg/gSnZtFPPj+TmS6KJvFNoN6YcDDoIiI9PvgsODRPki3MWW6BW85M5nV
         wkljlrhjEUQhmJxnKc0vhhVqdJXSQKQfqPW5u0snXnOeieEpWBbiJEj+tjalt9Mf3Tki
         GlGEaFO7o+TZps3WZ7ERUw+UtZhT6XekOfz2zACf3vbhUW2TRA1o1CyxeKHtYxFcAp0q
         FoGc88/gYQVo4b9tod6TJ1o6QQOewR49xnt2bPPQLMwQspVfkHW4TJh75SM1pZTdtc5Z
         KuHg==
X-Gm-Message-State: APjAAAVvlyeKtAYqFwIipxn9iXg8wt4y4G40OR5NGgiBZuqk0uQzX1JG
        UYVZEpL2rkgWPz2DR7J7f6yDYnoryZY=
X-Google-Smtp-Source: APXvYqzxEigKbggFpsVzsSSJ3ezBZ/GPuFc6AHh6gYbU7LdMoKJBXbkvk3VtA9xf3T2FIbWdCZu2bA==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr53776336plb.309.1582632526707;
        Tue, 25 Feb 2020 04:08:46 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id d3sm3353314pjx.10.2020.02.25.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 04:08:45 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: thermal: tsens: Make dtbs_check pass for msm8996 tsens
Date:   Tue, 25 Feb 2020 17:38:29 +0530
Message-Id: <80eaa4d88a7d9951fed4bd37d42bbae51e926be8.1582632110.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582632110.git.amit.kucheria@linaro.org>
References: <cover.1582632110.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom-tsens binding requires a SoC-specific and a TSENS
family-specific binding to be specified in the compatible string.

Since them family-specific binding is not listed in the .dtsi file, we
see the following warnings in 'make dtbs_check'. Fix them.

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 7ae082ea14ea..f157cd4f53b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -446,7 +446,7 @@
 		};
 
 		tsens0: thermal-sensor@4a9000 {
-			compatible = "qcom,msm8996-tsens";
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
 			reg = <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
@@ -457,7 +457,7 @@
 		};
 
 		tsens1: thermal-sensor@4ad000 {
-			compatible = "qcom,msm8996-tsens";
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
 			reg = <0x004ad000 0x1000>, /* TM */
 			      <0x004ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-- 
2.20.1

