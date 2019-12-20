Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4991284C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLTW16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 17:27:58 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13460 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfLTW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:27:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfd4abf0001>; Fri, 20 Dec 2019 14:27:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 20 Dec 2019 14:27:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Dec 2019 14:27:21 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec
 2019 22:27:21 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 20 Dec 2019 22:27:21 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.197]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dfd4ac80001>; Fri, 20 Dec 2019 14:27:21 -0800
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
Subject: [PATCH v5 13/19] ASoC: tegra: Add fallback implementation for audio mclk
Date:   Fri, 20 Dec 2019 14:26:59 -0800
Message-ID: <1576880825-15010-14-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576880831; bh=z7SsrqcLkMI91+hk9rh2Uy0osUWCnias+wy7iFK2u6A=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LrOsa1dXKRw2rYhSzoJKvNBgVo2xEByPFU7HYwL3nitpWFJyBIHjpXL5d+UU8HUFP
         vmglugAguTCm0O7bgmIUDt6hYlQTfrz/BTSsnmRCm5GOv1DkTqO4WSa9X+Yp8TsX9M
         oCcIDPuvj8w1toeyOB4E+stIsJaLrKcKMq9aFgG5EzIa2q4TK0qkpqGxBkBA45xQeP
         ZxjE28cCLRJgrS5TcGxsjFGclaBBa/01cH6BNs4Af99q/keuXL4tAiAoHgx+HKtC/F
         WbQhtcNL4trMm4s7lc57FL0jleHe17NsZIHAXnc5utawtiwkJcEtVbUT16XeTXj7xC
         UC9O3yo9PZJSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
are moved to Tegra PMC driver with pmc as clock provider and using pmc
clock ids.

New device tree uses clk_out_1 from pmc clock provider.

So, this patch adds implementation for mclk fallback to extern1 when
retrieving mclk returns -ENOENT to be backward compatible of new device
tree with older kernels.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index fc3135c08f43..46ff70c16b74 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -166,7 +166,16 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 	data->clk_cdev1 = devm_clk_get(dev, "mclk");
 	if (IS_ERR(data->clk_cdev1)) {
 		dev_err(data->dev, "Can't retrieve clk cdev1\n");
-		return PTR_ERR(data->clk_cdev1);
+		if (PTR_ERR(data->clk_cdev1) != -ENOENT)
+			return PTR_ERR(data->clk_cdev1);
+		/* Fall back to extern1 */
+		data->clk_cdev1 = devm_clk_get(dev, "extern1");
+		if (IS_ERR(data->clk_cdev1)) {
+			dev_err(data->dev, "Can't retrieve clk extern1\n");
+			return PTR_ERR(data->clk_cdev1);
+		}
+
+		dev_err(data->dev, "Falling back to extern1\n");
 	}
 
 	/*
-- 
2.7.4

