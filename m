Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8A12D546
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 01:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfLaAau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 19:30:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46332 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfLaAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LRE6H5xMkMRjNG5YNwa1v2sVNQG2SVX63QXvygSTW9c=; b=fgPLWU3nbm3w
        O5mCDFnLa84A5No8g7NFFYXdgxQ0OkzXL8D9vkEgjS8nW70mHbnsztkVsMmqLvwZ2aJQdh5oCcQZO
        yeKewhyx0q4k+v7pHpXsgZikwPpEQs03zUw2WgLddDqP8WhUBhHaXEqcdpPlKQDqg+yACXQLQwmHh
        UV5XE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1im5Qg-0002nU-47; Tue, 31 Dec 2019 00:30:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 86CEAD01A54; Tue, 31 Dec 2019 00:30:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, "Cc:"@sirena.org.uk, "Cc:"@sirena.org.uk,
        Colin@sirena.org.uk, djkurtz@google.com,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam@sirena.org.uk, Mark Brown <broonie@kernel.org>,
        moderated@sirena.org.uk, "list:SOUND"@sirena.org.uk,
        -@sirena.org.uk, open list <linux-kernel@vger.kernel.org>,
        Takashi@sirena.org.uk, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Applied "ASoC: amd: Handle ACP3x I2S-SP Interrupts." to the asoc tree
In-Reply-To: <1577540460-21438-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Message-Id: <applied-1577540460-21438-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Patchwork-Hint: ignore
Date:   Tue, 31 Dec 2019 00:30:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Handle ACP3x I2S-SP Interrupts.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From cea5f40d4e7ae711622ba7ee3caa60c315f101c0 Mon Sep 17 00:00:00 2001
From: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Date: Sat, 28 Dec 2019 19:10:58 +0530
Subject: [PATCH] ASoC: amd: Handle ACP3x I2S-SP Interrupts.

Enabled support for I2S-SP interrupt handling.
Previous to this implementation, driver supports only interrupts
on BT instance.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Link: https://lore.kernel.org/r/1577540460-21438-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 040a8be593f0..c5d7f3558867 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -176,6 +176,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 		snd_pcm_period_elapsed(rv_i2s_data->play_stream);
 		play_flag = 1;
 	}
+	if ((val & BIT(I2S_TX_THRESHOLD)) &&
+				rv_i2s_data->i2ssp_play_stream) {
+		rv_writel(BIT(I2S_TX_THRESHOLD),
+			rv_i2s_data->acp3x_base	+ mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->i2ssp_play_stream);
+		play_flag = 1;
+	}
 
 	if ((val & BIT(BT_RX_THRESHOLD)) && rv_i2s_data->capture_stream) {
 		rv_writel(BIT(BT_RX_THRESHOLD), rv_i2s_data->acp3x_base +
@@ -183,6 +190,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 		snd_pcm_period_elapsed(rv_i2s_data->capture_stream);
 		cap_flag = 1;
 	}
+	if ((val & BIT(I2S_RX_THRESHOLD)) &&
+				rv_i2s_data->i2ssp_capture_stream) {
+		rv_writel(BIT(I2S_RX_THRESHOLD),
+			 rv_i2s_data->acp3x_base + mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->i2ssp_capture_stream);
+		cap_flag = 1;
+	}
 
 	if (play_flag | cap_flag)
 		return IRQ_HANDLED;
-- 
2.20.1

