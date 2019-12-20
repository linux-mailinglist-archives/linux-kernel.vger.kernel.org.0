Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C0128498
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 23:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLTW1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 17:27:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7294 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfLTW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:27:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfd4aaa0000>; Fri, 20 Dec 2019 14:26:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Dec 2019 14:27:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Dec 2019 14:27:20 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec
 2019 22:27:20 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 20 Dec 2019 22:27:20 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.197]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dfd4ac70001>; Fri, 20 Dec 2019 14:27:20 -0800
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
Subject: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration for audio mclk
Date:   Fri, 20 Dec 2019 14:26:58 -0800
Message-ID: <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576880810; bh=QdOc3YnjVu/XgzWmSUXmDjziKb9PvXaQKhX3Ck5gCQQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=D5ugB35j57lGioe9GAzJ0Ff7guuRW2UvKteHKPQVs0C6VmxXOBELAHMrsFMAUMCGK
         H+gn9byE92Dl5VgiokGGMAck77JZN/l09YnUWtQyQ2ljwaUpjvP5AH6OHimFegr05U
         TF96G79AktJrQtFiORF0h8d/88cm5mongBf1IzfrZmQZ7TO4BBQ3B1DI/pSpg4jkMQ
         TYlP69uZsMCEZk71t62L9B5uUSFOLmO4kzCFYVuXLVgXT9Zqw1DizUQvxUS0Rm99NM
         zgsaEPmBPx3VBm/zEA/lL7naMbPc/2PHWlsIMk1nckDstmogH1mPRdGP/D3KMuFx5a
         QvQjmZE6anPmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
through Tegra210 and currently Tegra clock driver does initial parent
configuration for audio mclk "clk_out_1" and enables them by default.

With the move of Tera PMC clocks from clock driver to Tegra PMC
driver, initial parent configuration for audio clocks are through
the device tree using assigned-clock-parents property.

Default clock parents can be specified in device tree using
assigned-clocks and assigned-clock-parents and there is no need
to have clock driver do parent configuration and enable audio related
clocks.

This patch has implementation for initial parent configuration in
audio driver when default parent configuration is not specified in the
device tree using assigned-clock properties and enables audio clocks
during the clock rate change.

This patch configures PLLA_OUT0 as parent to extern1 and extern1
as parent to clk_out_1 and uses clk_out_1 as cdev1 clock to allow
mclk control from this driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c | 71 ++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index 38535962029c..fc3135c08f43 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -59,9 +60,8 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 	data->set_baseclock = 0;
 	data->set_mclk = 0;
 
-	clk_disable_unprepare(data->clk_cdev1);
-	clk_disable_unprepare(data->clk_pll_a_out0);
-	clk_disable_unprepare(data->clk_pll_a);
+	if (__clk_is_enabled(data->clk_cdev1))
+		clk_disable_unprepare(data->clk_cdev1);
 
 	err = clk_set_rate(data->clk_pll_a, new_baseclock);
 	if (err) {
@@ -77,18 +77,6 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
 
 	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
 
-	err = clk_prepare_enable(data->clk_pll_a);
-	if (err) {
-		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
-		return err;
-	}
-
-	err = clk_prepare_enable(data->clk_pll_a_out0);
-	if (err) {
-		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
-		return err;
-	}
-
 	err = clk_prepare_enable(data->clk_cdev1);
 	if (err) {
 		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
@@ -108,9 +96,8 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
 	const int ac97_rate = 24576000;
 	int err;
 
-	clk_disable_unprepare(data->clk_cdev1);
-	clk_disable_unprepare(data->clk_pll_a_out0);
-	clk_disable_unprepare(data->clk_pll_a);
+	if (__clk_is_enabled(data->clk_cdev1))
+		clk_disable_unprepare(data->clk_cdev1);
 
 	/*
 	 * AC97 rate is fixed at 24.576MHz and is used for both the host
@@ -130,18 +117,6 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
 
 	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
 
-	err = clk_prepare_enable(data->clk_pll_a);
-	if (err) {
-		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
-		return err;
-	}
-
-	err = clk_prepare_enable(data->clk_pll_a_out0);
-	if (err) {
-		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
-		return err;
-	}
-
 	err = clk_prepare_enable(data->clk_cdev1);
 	if (err) {
 		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
@@ -158,6 +133,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 			  struct device *dev)
 {
+	struct clk *clk_out_1, *clk_extern1;
 	int ret;
 
 	data->dev = dev;
@@ -193,6 +169,41 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 		return PTR_ERR(data->clk_cdev1);
 	}
 
+	/*
+	 * If clock parents are not set in DT, configure here to use clk_out_1
+	 * as mclk and extern1 as parent for Tegra30 and higher.
+	 */
+	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
+	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
+		clk_extern1 = devm_clk_get(dev, "extern1");
+		if (IS_ERR(clk_extern1)) {
+			dev_err(data->dev, "Can't retrieve clk extern1\n");
+			return PTR_ERR(clk_extern1);
+		}
+
+		ret = clk_set_parent(clk_extern1, data->clk_pll_a_out0);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"Set parent failed for clk extern1\n");
+			return ret;
+		}
+
+		clk_out_1 = devm_clk_get(dev, "clk_out_1");
+		if (IS_ERR(clk_out_1)) {
+			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
+			return PTR_ERR(clk_out_1);
+		}
+
+		ret = clk_set_parent(clk_out_1, clk_extern1);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"Set parent failed for clk_out_1\n");
+			return ret;
+		}
+
+		data->clk_cdev1 = clk_out_1;
+	}
+
 	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
 
 	return ret;
-- 
2.7.4

