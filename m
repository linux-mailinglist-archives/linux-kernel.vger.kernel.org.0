Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26ABF15475
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 21:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfEFTbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 15:31:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40240 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEFTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:31:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id d15so12131288ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzqt154DTH5ImHOjvijUWjXzMNwVv74MLXkB9lgKrrw=;
        b=nNjHFpzz2vKI+badclYzMfOso23Nvg4F0z3eEjQbGkckMUxF028F3XqkKl/++V119q
         rmijiMxVjktUYfhRDo+EilRRHAeKGukmRxE8T9sjzgWaXZRFMY7e09yL3qFe55WFI9AZ
         wqbVg0bjGylSD2CSjKPBYzkvCehm17FK+pFyWWHkFPCpf5nNR5P6dJbc5ALmkWPSbaew
         pDzKzELKkim55dy96hCNNH0k+6PMagrKQHF3cOw3CK8MTFdPOc/2GHg/8uwzzao6MrlA
         RX5rEyrn/eJu877EpH28W6WpdxyOPHkkTOBbPfYpj8moqhZr1HlkgaJpNGwKmva9zmhU
         CNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzqt154DTH5ImHOjvijUWjXzMNwVv74MLXkB9lgKrrw=;
        b=UHViupDUueHx3ZfZAMit+pgqffrg5sQ7TpsxCR0EOBeAFy9Ak3Jn5qJejxvfLPmH9p
         gb0GPJlsiT5+V093eZhVj0fo9zKRFERfkFvPtFtVJBejKU9i3P39Q31o7GK4/tF82jB0
         g3UXDg4506bDXA7pL0KFIM5NmAHbf5FoZng1b29MjE1XojZ3LWCGSPyUuXe2ry+cFbV7
         /ht43G7V1T5/s3MFlEiKvNkQztqDeTCMMZXUasO4038VUppDfqT//5dNMQAi2iJBhrEE
         6+Dt+Yz21aYUnB293SWRMjkMdn13DwyeZQ33GBHi+X4ErClA/pZR1HdyvzZLidjU1B98
         FrvQ==
X-Gm-Message-State: APjAAAXEgR5nwHNhafMioD29F75IzzcOhd4SvHBBWJfH0Z+9bHX2IwBJ
        /BLcT30mNkeIVNnSxb+ctPONFg==
X-Google-Smtp-Source: APXvYqy8ZbmneS+bhGFlFzRN4Lj7M6HDD7Mh2kRpXYNfAJfEhMqOyD3kfORTGIB7aXwSQnnwZTAtJg==
X-Received: by 2002:a2e:8141:: with SMTP id t1mr14742420ljg.122.1557171099519;
        Mon, 06 May 2019 12:31:39 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-72.NA.cust.bahnhof.se. [158.174.22.72])
        by smtp.gmail.com with ESMTPSA id r136sm2660779lff.50.2019.05.06.12.31.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 12:31:38 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     amit.kucheria@linaro.org, jorge.ramirez-ortiz@linaro.org,
        lina.iyer@linaro.org, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404: Add PSCI cpuidle support
Date:   Mon,  6 May 2019 21:31:15 +0200
Message-Id: <20190506193115.20909-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device bindings for CPUs to suspend using PSCI as the enable-method.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ffedf9640af7..f9db9f3ee10c 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -31,6 +31,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&CPU_PC>;
 		};
 
 		CPU1: cpu@101 {
@@ -39,6 +40,7 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&CPU_PC>;
 		};
 
 		CPU2: cpu@102 {
@@ -47,6 +49,7 @@
 			reg = <0x102>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&CPU_PC>;
 		};
 
 		CPU3: cpu@103 {
@@ -55,12 +58,24 @@
 			reg = <0x103>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&CPU_PC>;
 		};
 
 		L2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 		};
+
+		idle-states {
+			CPU_PC: pc {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <125>;
+				exit-latency-us = <180>;
+				min-residency-us = <595>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	firmware {
-- 
2.21.0

