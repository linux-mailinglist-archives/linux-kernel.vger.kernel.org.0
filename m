Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80A719CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 13:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEJLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 07:30:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47045 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfEJLaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:30:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so3068084pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JVo/NvEDRX1QVQbcjE8Yetg8X4Rda/MV9JSZ7Qo1pjU=;
        b=s7jn7hlrXaSulZyC00By0r91cNEiJ4SQmpC82v3lVdN6t5HlkoTF5vWlBltkS/3M5D
         6lNJ1AlB23X0DJ7A92bi7ijQ7QT/pDm4SlcAv4GWOMue0yksI3pxr4Tgt+IDcVRUQ2hJ
         11Rj7TX8mo66oXANkYVxmfvvYkFNOrWm010WN2S1rU5iqLLXfOzzmr3Ni7FTIRDCZ+fu
         RW6s7S1Oe2mHLWyuwso/IDKyeKzur/Q/EKDBUxCHMtPhOcONfeFX/s3lgWzVIK56oIyw
         xaSGWvjXzxOnrR7BhhZh3IgQWSNoifY0fHaZKwPGfJ33VhleHf1gPRFPNGvzuvI77hGG
         xETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JVo/NvEDRX1QVQbcjE8Yetg8X4Rda/MV9JSZ7Qo1pjU=;
        b=cwXt0sCiCWczgAoVQ+qhhKHOvETmMcKeCSeexbXwaaj7gV5+BxqIfwxWh6lysT9Jlp
         sYbf95VQIcNya11hugpaJe4PGr35Im1f7/eaenMg0M193dd4u797pXiMNtzPLfdLa3Xj
         gxkD9M7Y4KmWwpNhG0nS3YiuOSPSlr9pTdpU63zOWD9w0ovm89/Bf29QhaA6On59LjjL
         IApcJ4VJjzFBoEzUmnC6mNdpe2FVoSslDKCqI2ZdKqCnCBGosBOKZm1Rnj6EtqcCncnQ
         4R7rtYNTnVsmFNfiIDrmt6RW2dEuGwy0+9mjF0Y+Dj5B6rON8tyR8uom2mdI4VIqYmjl
         F9YQ==
X-Gm-Message-State: APjAAAV3RxsfUoVek0Dj2Ve/BJYASA67GauOkSGjJWEwhr5EI6lQ4U5S
        zo1jr81P1mBPybJWS1lb8Za/8lVJus4=
X-Google-Smtp-Source: APXvYqwEbvNp0PS8j3TrnVgJ43uU+ruCMJVabRwUeDoOmcXa/KEOgwodv32L5LHlsWbl5aCE7MmN4Q==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr13008017pfm.191.1557487817121;
        Fri, 10 May 2019 04:30:17 -0700 (PDT)
Received: from localhost ([103.8.150.7])
        by smtp.gmail.com with ESMTPSA id g32sm5295248pgl.16.2019.05.10.04.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:30:16 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCHv1 6/8] arm64: dts: qcom: msm8996: Add PSCI cpuidle low power states
Date:   Fri, 10 May 2019 16:59:44 +0530
Message-Id: <8648ba97d49a9f731001e4b36611be9650e37f37.1557486950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device bindings for cpuidle states for cpu devices.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c761269caf80..b615bcb9e351 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -95,6 +95,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_PD>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -107,6 +108,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_PD>;
 			next-level-cache = <&L2_0>;
 		};
 
@@ -115,6 +117,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&BIG_CPU_PD>;
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 			      compatible = "cache";
@@ -127,6 +130,7 @@
 			compatible = "qcom,kryo";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&BIG_CPU_PD>;
 			next-level-cache = <&L2_1>;
 		};
 
@@ -151,6 +155,30 @@
 				};
 			};
 		};
+
+		idle-states {
+			entry-method="psci";
+
+			LITTLE_CPU_PD: little-power-down {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <40>;
+				exit-latency-us = <40>;
+				min-residency-us = <300>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_PD: big-power-down {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <40>;
+				exit-latency-us = <40>;
+				min-residency-us = <300>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	thermal-zones {
-- 
2.17.1

