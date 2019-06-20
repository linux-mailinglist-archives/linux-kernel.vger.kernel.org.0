Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0964D965
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 20:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfFTSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 14:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfFTSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:35:57 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C4E20B1F;
        Thu, 20 Jun 2019 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561055756;
        bh=pWNqjq23LV4OCadPPMnSFJ7l4+RDhwdpKiMigfnoDsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArKD+osVVUCx1Xg8iO5/g16dCnO+81fwD3iXgV5xMciGAZHjEz8i4uk9wdv62Ckwg
         HANuTP62Sc3teFIBNuyld5YCiqXcKdPAB68NQb55PEtL8Ch52VCczKMt8B9vNoh7Zm
         WmT3OABtGqxmVCeVR6DpMsirhfXuSmx25kMApBgI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, notify@kernel.org,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 4/6] ARM: dts: exynos: Disable unused buck10 regulator on Odroid HC1 board
Date:   Thu, 20 Jun 2019 20:35:28 +0200
Message-Id: <20190620183530.5386-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620183530.5386-1-krzk@kernel.org>
References: <20190620183530.5386-1-krzk@kernel.org>
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

