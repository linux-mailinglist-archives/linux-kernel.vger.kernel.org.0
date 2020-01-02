Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E312E786
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgABOzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 09:55:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32892 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgABOzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:55:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13so17912465pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Z+ykCApUKr71c1VGBorDn77jB+/PZ2ewvhrIdMZeSk=;
        b=G/LyjidH8NkuVHiVaHJuqgBE5y1B2/jUnddxNK4+lhp+GjTc0/4/OlsYWo4WSl3Ph6
         yebGYik3KMTttXXOFD/sJ4jTdGI4t7yiaRf5U6vfjoQ8dpN5wHidHZtOmYOxKC89wO54
         kSEs/+yK7RVrBg/DKFaEh6YMIq5dft40zWPoVWoa2PFAIVdFDuv8s8gW0gtWj4lnca7T
         Mty9pqKJ2xbOx8bQQ8TnbZ0LE5+PWAFmqCKMYdkfAdyDuew8ShuESOPxuJ8c9ul0fjIc
         exHbeTcfoBDR+RMgEqJtwQ4Un92Fn3kqqWW4mffzDG2ZVOdy37SzjAksQh7wIqwjdEFr
         PC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Z+ykCApUKr71c1VGBorDn77jB+/PZ2ewvhrIdMZeSk=;
        b=rbm/Moox4MF5xdFWoON274K/wrUqcTQIKPf3H+GoyLFy18X/yP48P79WUc0ZTuZhwR
         +Q5jIk6FS/eqBoh0uUvC8CyltGpBECnJQvabU2R1jMAOjWQC3lEpOSXT7tUPs05HTVgH
         g+dLQxZL24rnSOS4X/eA4GT7j35toMA/XNgdMfTrSmR2F3LbfwOEnN1QqxLSqulhRYQr
         tYEo4axpaPpyvTisYbIuGHVpuBxWmNKZBo2xoa5ieR59NJGLotPJreUlgB8j29qTCBaC
         lKKwigHmb0XPXKrHmIaOnYCEVNMGM2xDCw0bxa6SZipbib8X2d04kchc0bVw98sC12OA
         oxpw==
X-Gm-Message-State: APjAAAXeIWnofUMCEPQlfjQPNDfCCSQdFocf9tlBlmCiGdo1UathP7eu
        78l61ztObSV/ahrC7GhxkLhtbFdZWrh/yg==
X-Google-Smtp-Source: APXvYqyIE5FHCwGSphUYUhngzGV6pJlqz1dPd1JHr+XJsTNJ8hqHmAOs+o2Wfcc8YSziVGX3lle0Gw==
X-Received: by 2002:a17:902:247:: with SMTP id 65mr35582927plc.108.1577976908282;
        Thu, 02 Jan 2020 06:55:08 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id f9sm62504237pfd.141.2020.01.02.06.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:55:07 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v3 8/9] arm64: dts: msm8996: thermal: Add critical interrupt support
Date:   Thu,  2 Jan 2020 20:24:33 +0530
Message-Id: <05acb189abeedbd57018814ebbe92751e955c539.1577976221.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577976221.git.amit.kucheria@linaro.org>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register critical interrupts for each of the two tsens controllers

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4ca2e7b44559..fec0e50fe4fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -591,8 +591,9 @@
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
-			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -601,8 +602,9 @@
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.20.1

