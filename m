Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF417CE89
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 22:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfGaUae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 16:30:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38087 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbfGaU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:29:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so39639181wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOocsbJSeEFZluDhuzPE1zAAorjfBXrmhgRxid6+uG4=;
        b=fbHyeQffSQKLyJZweT+WJ4+v6XLbm73VRmJtKif+8DkHNYy3c9TYTD2MYwCZOHUcUr
         QJ+vr34pV4wi2sUxPS6fRLR0yLGRbeUDIZFRi5yetwxKdN1qQ8heUZvrxUwtBJP7Vthp
         VlkwzSdOiLVviHfnmXUJvONySuBWzlgMYw85+NZgGvgNNJ+IzBK7FE08NVPFkrFZHZiY
         98InzBB2uz5dK7VvdIFyKPNsSu1/1ae2NMb6JwLDDLB4m9K0PuCmkUzlmQBPu2/lr9IG
         cfe6YpP2wTjzhuv2QouZ/Jy4zJx1+WmxjetGIQcELpeKyUQLsiyLszwnRdnaJtBFA+q6
         FzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOocsbJSeEFZluDhuzPE1zAAorjfBXrmhgRxid6+uG4=;
        b=Wpsfm5idqM1S5xm6GaEEsdvp9wTQj5hQTMHprFJa2Kb9JA94vXMpM51n16n4Orsj6h
         QwewBMUOQSvNI1Ei8H0Qvp6t5GJLt4xiG9/1ch6xEpNi8iRoMez1/KiUAauOYCUHp5oE
         +zgvAtE5eBA1EoIPHujTOPimwWh7++oJNrTFJ20ttdEDYmzCYK4uT3hjJIT9HP9LYaQc
         kUxfOkMIcOtHyBueROdSn5YTHtJyBcwZH7JLnnZclbie74qhfXZJPAsIO3I/E7p+uF40
         UjKNr44v06+vPSQkAp1UC1QLy6I/dprv8M+CVpJNFq57OC9DTIzjOPW1Z0jfYawYxTc/
         IDkg==
X-Gm-Message-State: APjAAAV9CUyaoDVPQ5GCz6KVPEzuqX6bHnINl8LzklXp5F1s3Dq0+4af
        G36gag+Tu3iOkRN+8udEM6qb9Q==
X-Google-Smtp-Source: APXvYqzXIxgckZrkrnAp9ds5RzMoiAUwWdZwbhnFGifcbNCZHENWdnEhg2gML/kMDfxfHu1Tmc21pw==
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr51418847wme.173.1564604981865;
        Wed, 31 Jul 2019 13:29:41 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:41 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v4 04/13] dt-bindings: mailbox: qcom: Add clock-name optional property
Date:   Wed, 31 Jul 2019 22:29:20 +0200
Message-Id: <20190731202929.16443-5-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the APCS clock is registered (platform dependent), it retrieves
its parent names from hardcoded values in the driver.

The following commit allows the DT node to provide such clock names to
the platform data based clock driver therefore avoiding having to
explicitly embed those names in the clock driver source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../mailbox/qcom,apcs-kpss-global.txt         | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
index 1232fc9fc709..b69310322b09 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
@@ -18,10 +18,11 @@ platforms.
 	Usage: required
 	Value type: <prop-encoded-array>
 	Definition: must specify the base address and size of the global block
+
 - clocks:
-	Usage: required if #clocks-cells property is present
-	Value type: <phandle>
-	Definition: phandle to the input PLL, which feeds the APCS mux/divider
+	Usage: required if #clock-names property is present
+	Value type: <phandle array>
+	Definition: phandles to the two parent clocks of the clock driver.
 
 - #mbox-cells:
 	Usage: required
@@ -33,6 +34,12 @@ platforms.
 	Value type: <u32>
 	Definition: as described in clock.txt, must be 0
 
+- clock-names:
+	Usage: required if the platform data based clock driver needs to
+	retrieve the parent clock names from device tree.
+	This will requires two mandatory clocks to be defined.
+	Value type: <string-array>
+	Definition: must be "aux" and "pll"
 
 = EXAMPLE
 The following example describes the APCS HMSS found in MSM8996 and part of the
@@ -65,3 +72,14 @@ Below is another example of the APCS binding on MSM8916 platforms:
 		clocks = <&a53pll>;
 		#clock-cells = <0>;
 	};
+
+Below is another example of the APCS binding on QCS404 platforms:
+
+	apcs_glb: mailbox@b011000 {
+		compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+		reg = <0x0b011000 0x1000>;
+		#mbox-cells = <1>;
+		clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+		clock-names = "aux", "pll";
+		#clock-cells = <0>;
+	};
-- 
2.22.0

