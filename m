Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9558610F70B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 06:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLCFYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 00:24:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45602 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfLCFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:24:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id w7so1199588plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uC4Bl0qQMP+1vSYZwhrmDHQhbcFrxWT9l8fOqCUV/2M=;
        b=CsBQbbk33gwSnGTheESyeysKYf5sXnfg5mZVFnO0DaOw2FrrxXsCZTUBhUS/MrDmrP
         xVJsth6AadZWqmV4Cn4jnVRF5YTOi8prYKzDcQQXIq11NQhRCeNijr9gQhIzk8Q5YrjC
         aqHhpgAtaZFym1+lC7ZBR+uSsLZH+/MjroeeuZi9MkRiNabtAHU6GSl6otUCcOYnDShf
         A8TGRHlbu8P5X4OrSmpaOVuFrxhQkejScB+1zzLtgUvQGe1JLdaBKW+f/cLcMGV0HG/5
         sfcHMxgnT4oDpY80QZ6aWaJyWYFiHRnZmHyef0Kg3WDmMDxBCtCQFFIQsvjcpm2Dbb2S
         yBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=uC4Bl0qQMP+1vSYZwhrmDHQhbcFrxWT9l8fOqCUV/2M=;
        b=npB+TsgXSD16SE13kWTghPs6hCyVJ2A+xaxCZhgOUZ2WgP0lpOZu7RNOQpXgkvIdps
         A9P9CpoN6qu6TkYTYUk34qbgVDfwodjScmbgUkQ9u0MCs+c/jUE4YQ697J6bzJgnK/wO
         KWgqFDCbxkVTFGYua2lcCDE49cDsmlkTXBIVXuemPQmD37vbIL2bAsDDFO+m6pqVbkyZ
         1s/YToKmVtwlUI8Z/iOLPFsUXzI5WQC/pD8YJzhYhO55oTCo02tUJf6NEJNb3Eup4THt
         yNvIB+8DpK5Hxc3hY+hfSFiB7E1M71tLMdrLzrPvSzQGE5HmnEW4NWDXUElmjINvJy6+
         EETQ==
X-Gm-Message-State: APjAAAUCG7Z9xLGqBa/hcgXooC/lnmH5XGGvByNOGRJcrYv42M63MSzG
        QiYNdkzXvR3hng7ahRvfMLiZJRcn0rmIkA==
X-Google-Smtp-Source: APXvYqzAkPb+58kmN+jZ+GoeV3AgIBAOA1Hp2v7nvCCOaOjQLYETIKHjGrMPFYLkgjefi6AmYAf02A==
X-Received: by 2002:a17:902:126:: with SMTP id 35mr3273197plb.105.1575350643416;
        Mon, 02 Dec 2019 21:24:03 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id l18sm1415986pff.79.2019.12.02.21.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:24:02 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 7/9] arm64: dts: sdm845: thermal: Add critical interrupt support
Date:   Tue,  3 Dec 2019 10:53:28 +0530
Message-Id: <2e01f6891b5cbdc5dec754e7e3afc737ecbaa87a.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register critical interrupts for each of the two tsens controllers

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Message-Id: <3686bd40c99692feb955e936b608b080e2cb1826.1568624011.git.amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ddb1f23c936fe..8986553cf2eb6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2950,8 +2950,9 @@
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 			      <0 0x0c222000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <13>;
-			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -2960,8 +2961,9 @@
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 			      <0 0x0c223000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <8>;
-			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

