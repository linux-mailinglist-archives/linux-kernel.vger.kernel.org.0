Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08CD1593AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 16:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgBKPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 10:49:50 -0500
Received: from foss.arm.com ([217.140.110.172]:48632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbgBKPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:49:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 236ED113E;
        Tue, 11 Feb 2020 07:49:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BFE13F68E;
        Tue, 11 Feb 2020 07:49:40 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:49:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, Etienne Carriere <etienne.carriere@st.com>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: spdifrx: manage error when getting reset controller" to the asoc tree
In-Reply-To: <20200203100814.22944-3-olivier.moysan@st.com>
Message-Id: <applied-20200203100814.22944-3-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: spdifrx: manage error when getting reset controller

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 7889c0082e6400ae5d07345e5573548d0999b840 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 3 Feb 2020 11:08:10 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: manage error when getting reset
 controller

Return an error when the SPDIFRX driver fails to get a reset controller.
Also add an error trace, except on probe defer status.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200203100814.22944-3-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 3769d9ce5dbe..9f80ddf34443 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -978,12 +978,16 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (!IS_ERR(rst)) {
-		reset_control_assert(rst);
-		udelay(2);
-		reset_control_deassert(rst);
+	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rst)) {
+		if (PTR_ERR(rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Reset controller error %ld\n",
+				PTR_ERR(rst));
+		return PTR_ERR(rst);
 	}
+	reset_control_assert(rst);
+	udelay(2);
+	reset_control_deassert(rst);
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &stm32_spdifrx_component,
-- 
2.20.1

