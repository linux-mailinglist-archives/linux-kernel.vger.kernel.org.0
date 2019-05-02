Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A21111D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 04:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfEBCSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 22:18:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfEBCSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w52+WD1FRjYJTS1b/QlKeFRTLrKcf/MWXa48o0J7BR8=; b=wv38btT2KChe
        tdM3DnV0rSaLva6jN2TxBVg/+98h0I8EJ2FIeE5zY1bVDogbV2Aq6ATypOhlNptyymuVa2tIDI4Gt
        HrtPVICwFbw7gviM1+P2BfckKhaUMryzzhJXX8/G6Ui14drVEt5ai+kMSUD8TW8+43UuuNmZz7X42
        0qDQ8=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1IT-0005pm-8v; Thu, 02 May 2019 02:18:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 515C4441D3D; Thu,  2 May 2019 03:18:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Keyon Jie <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: SOF: Intel: fix spelling mistake "incompatble" -> "incompatible"" to the asoc tree
In-Reply-To: <20190501102308.30390-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021801.515C4441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: Intel: fix spelling mistake "incompatble" -> "incompatible"

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From 07f80454369e5a8141dbbf4ae0a535230f223f2b Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 1 May 2019 11:23:08 +0100
Subject: [PATCH] ASoC: SOF: Intel: fix spelling mistake "incompatble" ->
 "incompatible"

There is a spelling mistake in a hda_dsp_rom_msg message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index b8fc19790f3b..84baf275b467 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -54,7 +54,7 @@ static const struct hda_dsp_msg_code hda_dsp_rom_msg[] = {
 	{HDA_DSP_ROM_L2_CACHE_ERROR, "error: L2 cache error"},
 	{HDA_DSP_ROM_LOAD_OFFSET_TO_SMALL, "error: load offset too small"},
 	{HDA_DSP_ROM_API_PTR_INVALID, "error: API ptr invalid"},
-	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatble"},
+	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatible"},
 	{HDA_DSP_ROM_UNHANDLED_INTERRUPT, "error: unhandled interrupt"},
 	{HDA_DSP_ROM_MEMORY_HOLE_ECC, "error: ECC memory hole"},
 	{HDA_DSP_ROM_KERNEL_EXCEPTION, "error: kernel exception"},
-- 
2.20.1

