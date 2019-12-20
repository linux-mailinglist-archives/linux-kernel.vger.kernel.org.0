Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98101284D2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 23:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfLTW2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 17:28:08 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7259 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfLTW1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:27:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfd4aa50001>; Fri, 20 Dec 2019 14:26:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Dec 2019 14:27:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Dec 2019 14:27:16 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec
 2019 22:27:16 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 20 Dec 2019 22:27:16 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.197]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dfd4ac30001>; Fri, 20 Dec 2019 14:27:15 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 07/19] dt-bindings: soc: tegra-pmc: Add id for Tegra PMC 32KHz blink clock
Date:   Fri, 20 Dec 2019 14:26:53 -0800
Message-ID: <1576880825-15010-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576880805; bh=x4itCOEFQTqr4Po2PuDtX3OJlZkcnEkwJ110zILFSac=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=AOAnADD428auSvjKep2wFPS6/9q4vC6geK2dV+g22ei2ptUaXESuia8CnsbRBgdoJ
         xIHCIEkxbS3Cj3WmEyeV5eWiCCFg7Xxwy9v5I9JY/zaqLF84W9dMynKS7wycGNveIm
         7c1t0s125Odvr0FT5YnpdoJAkB+fN7y52vFv9pYchOOqHvKHw4NEhuWX/FIpe5yI4o
         PAgtYrbCq+tI9mouY6n5NxS95JT1+bq0nnvx9I4IT9mEDK9nsgEEXeK0//c/V41Hbo
         2O9Tac05jiCd+PJSpWppm/U1jqwrczVsxsH5DW36QSyjiDOK9C1KrkKXSII0WkIL8k
         y3haKS6sSI3pw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has blink functionality that allows 32KHz clock out to
blink pin of the Tegra.

This patch adds id for this blink clock to use for enabling or
disabling blink output through device tree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/soc/tegra-pmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
index f7c866404456..a99a457471ee 100644
--- a/include/dt-bindings/soc/tegra-pmc.h
+++ b/include/dt-bindings/soc/tegra-pmc.h
@@ -9,7 +9,8 @@
 #define TEGRA_PMC_CLK_OUT_1		0
 #define TEGRA_PMC_CLK_OUT_2		1
 #define TEGRA_PMC_CLK_OUT_3		2
+#define TEGRA_PMC_CLK_BLINK		3
 
-#define TEGRA_PMC_CLK_MAX		3
+#define TEGRA_PMC_CLK_MAX		4
 
 #endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
-- 
2.7.4

