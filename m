Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1493C790EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfG2Qd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:33:28 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37466 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfG2Qd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:33:26 -0400
Received: by mail-vk1-f196.google.com with SMTP id 9so12131759vkw.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/t4nyA1Q5Ire67bzt1cmZdzjlm5dY9UznxFZlUXgxs=;
        b=cJ+QBiHtj4joLDdWo3ko8KyT7anFWu3nS4m2R2ggcQLExoCvgemhSOm4R3MGuuAS+R
         UUhc3FfMLQFaMQgUK+4pz2vGHUcoT733fpPJWC4x4SfKh57m73DCBNz2hmcx9rBziXUg
         edFE+J9YCSGbq4oUZUl4T7C5YbRj+6BQ+d2hMJVE07S1s642wHolqPQPivrxotpNlkus
         9nDE/wQb2YGhOMUK6aHNATji2FQZfwxOlPW6lRM+E0eAE0vN9vED3F6wfKgQCXumybj+
         ekk40r5L0I1F6AfGNmDiOJAI3mU/o4QQJQrdGoQkswdjtUNiQzqdTvk3PkHCozetl/C9
         ka/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/t4nyA1Q5Ire67bzt1cmZdzjlm5dY9UznxFZlUXgxs=;
        b=s/OQuJnQCbBm7+fwfgh+Tm/jgq0OlBnVAYolKxJ0p7FYj/V6z0RatLYGpGkpmUWedB
         vcPsT5WrwTk1u3yjFqRGlBqnzcmws0VtFvi/34gODshvaqJHcYHmBjftbv4xjtNtZiNn
         9i0z/MtHer4dVvJ+i1MMyhL/a2tdKi4QjrxXC96jziifHeaN21VNSn//+4rJfn/sOwRx
         nMk9MRyJWJJP33rx8Cx07abJeP8a4Pjbbe1I7tFUWTIb204tehVJZ8g2ZUFhQnZp0C13
         +rJ4FuH1/3z6eWqmNFwtWd0VAokYJ9qoPaGrVruBNRkoi7bQITfAAL2FRir1Xdc1fhbb
         QtMA==
X-Gm-Message-State: APjAAAWyrJpLQSxHNVbTuAnpoVhL+d0wNrEIuZCny3489s8wdzJDuBBU
        5uRb9AiVHeZ3hs5Hyk38z63MmA==
X-Google-Smtp-Source: APXvYqxruim+XfgMG1TgZXYZ4llcXHm+qO2F5Xfw42zvdX1iAL6Pruu/xnt08WS99QNb5hXXF7Tcpg==
X-Received: by 2002:a1f:b552:: with SMTP id e79mr26613652vkf.90.1564418005133;
        Mon, 29 Jul 2019 09:33:25 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o9sm39762738vkd.27.2019.07.29.09.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jul 2019 09:33:24 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: Extend AOSS QMP node
Date:   Mon, 29 Jul 2019 12:33:21 -0400
Message-Id: <1564418001-24940-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1564418001-24940-1-git-send-email-thara.gopinath@linaro.org>
References: <1564418001-24940-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AOSS hosts resources that can be used to warm up the SoC.
Add nodes for these resources.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 4babff5..d0c0d4f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2411,6 +2411,14 @@
 
 			#clock-cells = <0>;
 			#power-domain-cells = <1>;
+
+			cx_cdev: cx {
+				#cooling-cells = <2>;
+			};
+
+			ebi_cdev: ebi {
+				#cooling-cells = <2>;
+			};
 		};
 
 		spmi_bus: spmi@c440000 {
-- 
2.1.4

