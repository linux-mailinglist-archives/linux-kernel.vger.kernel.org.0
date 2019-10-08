Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0FCFE79
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 18:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfJHQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 12:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbfJHQDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:03:51 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C7220815;
        Tue,  8 Oct 2019 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570550630;
        bh=xp63xfZYYr/4fmyY0e7gVnsIupMIVgJn/wfEy+/uzo0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=srdp3UkqTynIKaJp97COCjhIllE2c/LfCKPCvMFPbsuk5oBalWqnBaGIobfVakVVO
         5YyZlg8mSQOxAvWueGwIZZCC10o3SjXBpfo7gwrhSPQvkISbc0WQlcpjcIekzSB6Re
         /rQXg9uOaxo0UKx+vu4azK9JwFnUZbjqxcjgoyos=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: Enable Exynos bus and memory frequency scaling (devfreq)
Date:   Tue,  8 Oct 2019 18:02:34 +0200
Message-Id: <20191008160234.3106-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008160234.3106-1-krzk@kernel.org>
References: <20191008160234.3106-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable devfreq events along with drivers for scaling frequency and
voltages of Exynos buses and Dynamic Memory Controller (DMC).  This
usually brings energy saving benefits.

So far devfreq was disabled because it was causing hangs during system
reboot (voltage not matching reset frequency). This was already fixed.

Occasionally, devfreq might negatively impact performance of certain SoC
blocks, e.g. when a bus is scaled down but some block (like Mixer with
two Full HD windows) wants to perform high-throughput DMA operations.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
None
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d576845acd6f..55fcc53a677a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -978,11 +978,14 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
+CONFIG_ARM_EXYNOS_BUS_DEVFREQ=m
 CONFIG_ARM_TEGRA_DEVFREQ=m
+CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=m
 CONFIG_EXTCON_MAX14577=m
 CONFIG_EXTCON_MAX77693=m
 CONFIG_EXTCON_MAX8997=m
 CONFIG_TI_AEMIF=y
+CONFIG_EXYNOS5422_DMC=m
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
 CONFIG_ASPEED_ADC=m
-- 
2.17.1

