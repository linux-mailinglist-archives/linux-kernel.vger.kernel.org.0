Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC590E22D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 20:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404535AbfJWS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 14:56:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59580 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404472AbfJWS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=j/8yayfqMY0ZyCUC8zjVt9apU8LafgXQ0fDRwU+6/iQ=; b=L4TmW74BoYDt
        J9IEPYU9uFs7yHt4LFK7+xRfFBHFlm30/Dqz3JDPHWDoFirnv5GUmrMP8cnCqU3fwSQliUlAkblVe
        vjwQWzrLXRB4mpsqp7cTWweAYNZGRwalCZ7X11Ni7TT5+AXPjxSqpvCv6opPFOfYI8byw5k1/bQta
        A6A9I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNLnj-0001B9-4v; Wed, 23 Oct 2019 18:56:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 98437274326D; Wed, 23 Oct 2019 19:56:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     alsa-devel@alsa-project.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: Applied "ASoC: rsnd: dma: set bus width to data width for monaural data" to the asoc tree
In-Reply-To: <20191022185518.12838-1-erosca@de.adit-jv.com>
X-Patchwork-Hint: ignore
Message-Id: <20191023185606.98437274326D@ypsilon.sirena.org.uk>
Date:   Wed, 23 Oct 2019 19:56:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rsnd: dma: set bus width to data width for monaural data

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

From d4d9360bf702890b5d3b1b62d8619a2690dd3278 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Tue, 22 Oct 2019 20:55:18 +0200
Subject: [PATCH] ASoC: rsnd: dma: set bus width to data width for monaural
 data

According to R-Car3 HW manual 40.3.3 (Data Format on Audio Local Bus),
in case of monaural data writing or reading through Audio-DMAC,
it's always in Left Justified format, so both src and dst
DMA Bus width should be equal to physical data width.

Therefore set src and dst's DMA bus width to:
 - [monaural case] data width
 - [non-monaural case] 32bits (as prior applying the patch)

Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Link: https://lore.kernel.org/r/20191022185518.12838-1-erosca@de.adit-jv.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 0324a5c39619..bcb6d5960661 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -165,14 +165,40 @@ static int rsnd_dmaen_start(struct rsnd_mod *mod,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_async_tx_descriptor *desc;
 	struct dma_slave_config cfg = {};
+	enum dma_slave_buswidth buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	int is_play = rsnd_io_is_play(io);
 	int ret;
 
+	/*
+	 * in case of monaural data writing or reading through Audio-DMAC
+	 * data is always in Left Justified format, so both src and dst
+	 * DMA Bus width need to be set equal to physical data width.
+	 */
+	if (rsnd_runtime_channel_original(io) == 1) {
+		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+		int bits = snd_pcm_format_physical_width(runtime->format);
+
+		switch (bits) {
+		case 8:
+			buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+			break;
+		case 16:
+			buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+			break;
+		case 32:
+			buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			break;
+		default:
+			dev_err(dev, "invalid format width %d\n", bits);
+			return -EINVAL;
+		}
+	}
+
 	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 	cfg.src_addr	= dma->src_addr;
 	cfg.dst_addr	= dma->dst_addr;
-	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_addr_width = buswidth;
+	cfg.dst_addr_width = buswidth;
 
 	dev_dbg(dev, "%s %pad -> %pad\n",
 		rsnd_mod_name(mod),
-- 
2.20.1

