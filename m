Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BF12A51D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 01:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfLYAJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 19:09:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLYAJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bEZvX6CrllH0JlHEqZn5tWeyLbTXuuTkTNuWN7wm62Q=; b=PZktTYDu3E3y
        x1C1fcnOVPvjuJcW0KWfuKhwpnfEqBi5T1FkLy5PUYaty5bTUxz4BLFDfOmy2hOZvj1H3OOQwXpAo
        iyexXvFcsE9U8PWC5aK2t91qTdWPoXoSzhzCzTSwOQklGEG5Mx1QdAY+j6U08rXwy5Q3Q0cH6AdhW
        JXgVg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuEj-0007Mf-Qr; Wed, 25 Dec 2019 00:09:13 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 58ABCD01957; Wed, 25 Dec 2019 00:09:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: SOF: imx8: fix memory allocation failure check on priv->pd_dev" to the asoc tree
In-Reply-To:  <20191204124816.1415359-1-colin.king@canonical.com>
Message-Id:  <applied-20191204124816.1415359-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:09:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: imx8: fix memory allocation failure check on priv->pd_dev

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

From 98910e1d61384430a080b4bcf986c3b0cf3fdf46 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 4 Dec 2019 12:48:16 +0000
Subject: [PATCH] ASoC: SOF: imx8: fix memory allocation failure check on
 priv->pd_dev

The memory allocation failure check for priv->pd_dev is incorrectly
pointer checking priv instead of priv->pd_dev. Fix this.

Addresses-Coverity: ("Logically dead code")
Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191204124816.1415359-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/imx/imx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index cfefcfd92798..9d926b1df0d7 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -209,7 +209,7 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 
 	priv->pd_dev = devm_kmalloc_array(&pdev->dev, priv->num_domains,
 					  sizeof(*priv->pd_dev), GFP_KERNEL);
-	if (!priv)
+	if (!priv->pd_dev)
 		return -ENOMEM;
 
 	priv->link = devm_kmalloc_array(&pdev->dev, priv->num_domains,
-- 
2.20.1

