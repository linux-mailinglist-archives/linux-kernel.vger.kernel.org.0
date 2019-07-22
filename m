Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB96FF71
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 14:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfGVMW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 08:22:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58652 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfGVMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kFFhP1m/SJsYy3wFd8EeoLTWfc7nLb+MzjoAq1XU1bM=; b=uz9pO8Z/7NtG
        lu1qjUtfzRiNE343/nvMj2YiSSy6zYZ9lGxUygPB/XEgYeQ1W+jNARZiQ9L1/O4s7zYu7tvvKgZuR
        Jz2sa/epXyN7tE90GSdB8tSB/cQOZarY/Xc84VAiYBmSK/Rx9es3E/ivT+9LuXUal6XTd5jDLmQi4
        bNoXg=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKT-0007d4-2y; Mon, 22 Jul 2019 12:22:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 514A1274046A; Mon, 22 Jul 2019 13:22:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "sound: soc: bcm: cygnus-pcm: Unneeded variable: "ret"." to the asoc tree
In-Reply-To: <20190709184236.GA7873@hari-Inspiron-1545>
X-Patchwork-Hint: ignore
Message-Id: <20190722122208.514A1274046A@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   sound: soc: bcm: cygnus-pcm: Unneeded variable: "ret".

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From a08c1037c2c04bd0ba691c109e3af51817707fe0 Mon Sep 17 00:00:00 2001
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Date: Wed, 10 Jul 2019 00:12:37 +0530
Subject: [PATCH] sound: soc: bcm: cygnus-pcm: Unneeded variable: "ret".

This patch fixes below issues reported by coccicheck

sound/soc/bcm/cygnus-pcm.c:642:5-8: Unneeded variable: "ret". Return "0"
on line 650
sound/soc/bcm/cygnus-pcm.c:671:5-8: Unneeded variable: "ret". Return "0"
on line 696

We cannot change return type of these functions as they are callback
functions of snd_pcm_ops

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Link: https://lore.kernel.org/r/20190709184236.GA7873@hari-Inspiron-1545
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-pcm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/bcm/cygnus-pcm.c b/sound/soc/bcm/cygnus-pcm.c
index 123ecf5479d7..8966b02844dc 100644
--- a/sound/soc/bcm/cygnus-pcm.c
+++ b/sound/soc/bcm/cygnus-pcm.c
@@ -639,7 +639,6 @@ static int cygnus_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct cygnus_aio_port *aio;
-	int ret = 0;
 
 	aio = cygnus_dai_get_dma_data(substream);
 	dev_dbg(rtd->cpu_dai->dev, "%s  port %d\n", __func__, aio->portnum);
@@ -647,7 +646,7 @@ static int cygnus_pcm_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = params_buffer_bytes(params);
 
-	return ret;
+	return 0;
 }
 
 static int cygnus_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -668,7 +667,6 @@ static int cygnus_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct cygnus_aio_port *aio;
 	unsigned long bufsize, periodsize;
-	int ret = 0;
 	bool is_play;
 	u32 start;
 	struct ringbuf_regs *p_rbuf = NULL;
@@ -693,7 +691,7 @@ static int cygnus_pcm_prepare(struct snd_pcm_substream *substream)
 	ringbuf_set_initial(aio->cygaud->audio, p_rbuf, is_play, start,
 				periodsize, bufsize);
 
-	return ret;
+	return 0;
 }
 
 static snd_pcm_uframes_t cygnus_pcm_pointer(struct snd_pcm_substream *substream)
-- 
2.20.1

