Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B47460AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfFNO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 10:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbfFNO0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:26:46 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4538520866;
        Fri, 14 Jun 2019 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560522405;
        bh=gLPYiKNlVZyeJBqzSMBS8jUdMgiD9fjJjnKZnvHHlSY=;
        h=From:To:Cc:Subject:Date:From;
        b=WxzwwUJ1i+vWCIZdcZ/gu57471NyDP1ca6EcHwkZl8/HurL+wOodywTy8m55QIPRV
         CaGZX7vye3cjmdPiW5xgeQNcW1aJmbZi8hNhIyzbMm3N5KPD327TCAEr2jB23WQ0xO
         8DkWqrIUw1MUR2cFJc8R1ss18CbkAsyW7Buw2bJA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, notify@kernel.org
Subject: [PATCH] ARM: dts: exynos: Add PMU interrupt affinity to Exynos4 boards
Date:   Fri, 14 Jun 2019 16:26:40 +0200
Message-Id: <1560522400-31086-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SoC-specific PMU properties from exynos4.dtsi to respective SoC
(4210 or 4412) so common DTSI would have only common properties.

Define there also interrupt affinity to remove the boot warning message:

    hw perfevents: no interrupt-affinity property for /pmu, guessing.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi    | 2 +-
 arch/arm/boot/dts/exynos4210.dtsi | 6 ++++++
 arch/arm/boot/dts/exynos4412.dtsi | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 36ccf227434d..dde27451faa8 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -54,7 +54,7 @@
 	pmu: pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&combiner>;
-		interrupts = <2 2>, <3 2>;
+		status = "disabled";
 	};
 
 	soc: soc {
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b491c345b2e8..ce29e026e226 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -461,6 +461,12 @@
 		 <&clock CLK_MOUT_MIXER>, <&clock CLK_SCLK_MIXER>;
 };
 
+&pmu {
+	interrupts = <2 2>, <3 2>;
+	interrupt-affinity = <&cpu0>, <&cpu1>;
+	status = "okay";
+};
+
 &pmu_system_controller {
 	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 			"clkout4", "clkout8", "clkout9";
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e5c041ec0756..4a58b70df125 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -737,6 +737,8 @@
 
 &pmu {
 	interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
+	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	status = "okay";
 };
 
 &pmu_system_controller {
-- 
2.7.4

