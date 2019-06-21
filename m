Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF3B4ECB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFUP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 11:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUP64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:58:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7C8206B7;
        Fri, 21 Jun 2019 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561132735;
        bh=7XFF/9p+dYOYssFeDHiKPhmpzkHKkQfC0rOFxlDqZKo=;
        h=From:To:Subject:Date:From;
        b=nCCbG66mlF9/FT/MMmVUwArOmDcJsgQD3NUalhRzU6LxSnJ7YwPx68wR2F9R9MIOZ
         r4jxw8/eJorPcIPjui3P8gwvKh5KnB+1v9g/BU5EgwmlFy0d82jayxaA76RvEtSmo4
         xygb5w2udm6p89vzImMBvuVqJgBas2sli9wHNXmY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: exynos: Disable unused buck10 regulator on Odroid HC1 board
Date:   Fri, 21 Jun 2019 17:58:42 +0200
Message-Id: <20190621155845.7079-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eMMC memory on Odroid XU3/XU4 boards is supplied by two regulators
LDO18 and buck10 (and LDO13 for the host interface).

However the Odroid HC1 board does not have eMMC connector so this
regulator does not have to be always on.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 2 --
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 25d95de15c9b..0f967259ad29 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -490,8 +490,6 @@
 				regulator-name = "vdd_vmem";
 				regulator-min-microvolt = <2850000>;
 				regulator-max-microvolt = <2850000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 93a48f2dda49..838872037493 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -360,6 +360,12 @@
 	};
 };
 
+&buck10_reg {
+	/* Supplies vmmc-supply of mmc_0 */
+	regulator-always-on;
+	regulator-boot-on;
+};
+
 &hdmi {
 	status = "okay";
 	ddc = <&i2c_2>;
-- 
2.17.1

