Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FDC9020
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfJBRoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 13:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJBRoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:44:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA15221D81;
        Wed,  2 Oct 2019 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570038253;
        bh=MZYQ5QLRxsH5Lm/zp4Xs3ZdRx+OF3lS8A4Qr/ENHFmY=;
        h=From:To:Subject:Date:From;
        b=B6EQLsiyV2WDt8tyVi5J3ORL9Qfx9JZa0Vniop0dnsfyqz4zo0SEzy7rAOTqu3E+h
         vEGELl6rkQy2Vb5oNtHGMWmp213uVAdOmqAed0SL/6IUulw+ufw8irmG3PKg5dq/rw
         9ltiv4qOVeqc9733aEdZuhclwmwyTNJNUQwOf3sY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: memory-controllers: exynos5422-dmc: Correct example syntax and memory region
Date:   Wed,  2 Oct 2019 19:44:01 +0200
Message-Id: <20191002174401.17590-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding the interrupt properties to Exynos5422 DMC bindings
example, the mapped memory region must be big enough to access
performance counters registers.

Fix also syntax errors (semicolons) and adjust indentation.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Rebased on top of my for-next branch as exynos5422-dmc.txt bindings were
applied by me.
---
 .../bindings/memory-controllers/exynos5422-dmc.txt        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
index e2434cac4858..02e4a1f862f1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
@@ -55,7 +55,7 @@ Example:
 
 	dmc: memory-controller@10c20000 {
 		compatible = "samsung,exynos5422-dmc";
-		reg = <0x10c20000 0x100>, <0x10c30000 0x100>,
+		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>;
 		clocks = <&clock CLK_FOUT_SPLL>,
 			 <&clock CLK_MOUT_SCLK_SPLL>,
 			 <&clock CLK_FF_DOUT_SPLL2>,
@@ -63,7 +63,7 @@ Example:
 			 <&clock CLK_MOUT_BPLL>,
 			 <&clock CLK_SCLK_BPLL>,
 			 <&clock CLK_MOUT_MX_MSPLL_CCORE>,
-			 <&clock CLK_MOUT_MCLK_CDREX>,
+			 <&clock CLK_MOUT_MCLK_CDREX>;
 		clock-names = "fout_spll",
 			      "mout_sclk_spll",
 			      "ff_dout_spll2",
@@ -71,10 +71,10 @@ Example:
 			      "mout_bpll",
 			      "sclk_bpll",
 			      "mout_mx_mspll_ccore",
-			      "mout_mclk_cdrex",
+			      "mout_mclk_cdrex";
 		operating-points-v2 = <&dmc_opp_table>;
 		devfreq-events = <&ppmu_event3_dmc0_0>,	<&ppmu_event3_dmc0_1>,
-				<&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
+				 <&ppmu_event3_dmc1_0>, <&ppmu_event3_dmc1_1>;
 		device-handle = <&samsung_K3QF2F20DB>;
 		vdd-supply = <&buck1_reg>;
 		samsung,syscon-clk = <&clock>;
-- 
2.17.1

