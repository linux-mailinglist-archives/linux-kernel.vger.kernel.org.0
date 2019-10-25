Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B860EE4843
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409127AbfJYKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 06:12:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409011AbfJYKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=UIHdbuehA4W5cQC/qzKEDI4VtUGGKof8itjs+eOyx+E=; b=JF2doRefoXnQ
        lWBOkJj9/uB6Rh/B2njgORKwRLWda76rcCGjW5aM/TE7Pb8uf+ma1bvwawEJiBBbk4x8pN4jUK+7n
        05AiVkU+lfk5wAB/2Auucd0ZxvxZUApFlrhkCcfc1x5y7o/iZYpShdZ5K0dZPqiZ132ufI1RuPzZ0
        6iw98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNwZp-0006eG-Ph; Fri, 25 Oct 2019 10:12:13 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3AA502743273; Fri, 25 Oct 2019 11:12:13 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt5677: Add missing null check for failed allocation of rt5677_dsp" to the asoc tree
In-Reply-To: <20191024124610.18182-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20191025101213.3AA502743273@ypsilon.sirena.org.uk>
Date:   Fri, 25 Oct 2019 11:12:13 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5677: Add missing null check for failed allocation of rt5677_dsp

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From f8a60435703bdde8f8a0ceb1aa8dad59df821583 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 24 Oct 2019 13:46:10 +0100
Subject: [PATCH] ASoC: rt5677: Add missing null check for failed allocation of
 rt5677_dsp

The allocation of rt5677_dsp can potentially fail and return null, so add
a null check and return -ENOMEM on a memory allocation failure.

Addresses-Coverity: ("Dereference null return")
Fixes: a0e0d135427c ("ASoC: rt5677: Add a PCM device for streaming hotword via SPI")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20191024124610.18182-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 36c02d200cfc..3a17643fcd9f 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -376,6 +376,8 @@ static int rt5677_spi_pcm_probe(struct snd_soc_component *component)
 
 	rt5677_dsp = devm_kzalloc(component->dev, sizeof(*rt5677_dsp),
 			GFP_KERNEL);
+	if (!rt5677_dsp)
+		return -ENOMEM;
 	rt5677_dsp->dev = &g_spi->dev;
 	mutex_init(&rt5677_dsp->dma_lock);
 	INIT_DELAYED_WORK(&rt5677_dsp->copy_work, rt5677_spi_copy_work);
-- 
2.20.1

