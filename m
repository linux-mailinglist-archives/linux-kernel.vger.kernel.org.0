Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9212E093
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 22:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgAAVmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 16:42:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56504 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAAVmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 16:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1GJeXqBZgwVZGjKHCG8CUrT1zbGnow5SWLDAyMEOoqA=; b=rrfujMrMQDqx
        694ngqHc4672jevij1CmPFnBhzJy+5Fvxpv2Nv3EaaEgSD470jKdcT627rGJ+Bp/FQwery4QDsWNA
        c+jHgtzNwwFSM6iJIHZNUeTXsZPtqT2WVjkyg2kXY16D9R/+KofPO0ceLc64VAqhh16uGS92Kv53Z
        4Xu4k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1imlke-0002aP-75; Wed, 01 Jan 2020 21:42:00 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 78EFFD057C6; Wed,  1 Jan 2020 21:41:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: qdsp6: q6asm-dai: constify copied structure" to the asoc tree
In-Reply-To:  <1577864614-5543-11-git-send-email-Julia.Lawall@inria.fr>
Message-Id:  <applied-1577864614-5543-11-git-send-email-Julia.Lawall@inria.fr>
X-Patchwork-Hint: ignore
Date:   Wed,  1 Jan 2020 21:41:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6asm-dai: constify copied structure

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 0da390ba86d841b1f9770c0a67bdebb4d8dc8be5 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@inria.fr>
Date: Wed, 1 Jan 2020 08:43:28 +0100
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: constify copied structure

The q6asm_dai_hardware_capture structure is only copied into another
structure, so make it const.

The opportunity for this change was found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Link: https://lore.kernel.org/r/1577864614-5543-11-git-send-email-Julia.Lawall@inria.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 5e2327708772..c0d422d0ab94 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -72,7 +72,7 @@ struct q6asm_dai_data {
 	long long int sid;
 };
 
-static struct snd_pcm_hardware q6asm_dai_hardware_capture = {
+static const struct snd_pcm_hardware q6asm_dai_hardware_capture = {
 	.info =                 (SNDRV_PCM_INFO_MMAP |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				SNDRV_PCM_INFO_MMAP_VALID |
-- 
2.20.1

