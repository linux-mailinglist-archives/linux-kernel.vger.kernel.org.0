Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3D13A1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 08:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgANHZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 02:25:01 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6479 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgANHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:24:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1d6ca80000>; Mon, 13 Jan 2020 23:24:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 23:24:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 23:24:44 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 07:24:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 14 Jan 2020 07:24:44 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.242]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1d6cbb0001>; Mon, 13 Jan 2020 23:24:44 -0800
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
Subject: [PATCH v8 19/22] ASoC: tegra: Enable audio mclk during tegra_asoc_utils_init
Date:   Mon, 13 Jan 2020 23:24:24 -0800
Message-ID: <1578986667-16041-20-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578986664; bh=XTOW+HfFsgaE5pdHn8ya63ic1oBZbrtP91w4Baxf3+4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bUebdhrFjGxFR+mbT3X3uVpJT10+0BFsFlspKFC1rVvDGlX+cEOvIxqS+GPEY2xxM
         gWknhxYkj69q1LxW5DvLqBiymWW92PefTddii49snt3RtNOkDafD+Ga38UMipaRIgL
         EVF6sj4OlD41iPucNAQ4MFHlN+oTacGeltZwnkUoCDITXWuvOtScTzyxth3LXtmArZ
         YL7w3MFbwPefd1QFNcBnMaHCKPehhpzWZFuJOs/iVP23tL6smoPcHWkhwCBd/YhqWq
         Nr3Ct3MmPBeN/gkJKkxkDNLX4BgkwWknpGJCBhBdZ0n7fE/f0ZpEQYBq8fFwuACpga
         gJFJ76xy9OzNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
through Tegra210 and currently Tegra clock driver keeps the audio
mclk enabled.

With the move of PMC clocks from clock driver into pmc driver,
audio mclk enable from clock driver is removed and this should be
taken care by the audio driver.

tegra_asoc_utils_init calls tegra_asoc_utils_set_rate and audio mclk
rate configuration is not needed during init and set_rate is actually
done during hw_params callback.

So, this patch removes tegra_asoc_utils_set_rate call and just leaves
the audio mclk enabled.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index 1dce5ad6e665..99584970f5f4 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -216,9 +216,16 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 		data->clk_cdev1 = clk_out_1;
 	}
 
-	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
-	if (ret)
+	/*
+	 * FIXME: There is some unknown dependency between audio mclk disable
+	 * and suspend-resume functionality on Tegra30, although audio mclk is
+	 * only needed for audio.
+	 */
+	ret = clk_prepare_enable(data->clk_cdev1);
+	if (ret) {
+		dev_err(data->dev, "Can't enable cdev1: %d\n", ret);
 		return ret;
+	}
 
 	return 0;
 }
-- 
2.7.4

