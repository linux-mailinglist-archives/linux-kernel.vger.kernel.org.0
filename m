Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943B51B5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfEMMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 08:30:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfEMMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yA1X7HgkSnP2Au2Kn2fvnU9tH9YznOnzDuipdGr7QC8=; b=E2KaLt+Bej4Y
        a8mddpGY3pMt36iTt36v6QvarXjGpxHbUQTLIrJAXIJk8p5gXISBxe5xvboOJeuRdJgeFuyneVGwY
        NK6A0IxU8sXkNHcRHzDV29nijSs4TDDJzbXikMwUihC86Lkb3uKJI32zwCRygDiDyumr7zdjbXkFz
        zToC0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQA6B-0006Wf-TN; Mon, 13 May 2019 12:30:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3B9B71129235; Mon, 13 May 2019 13:30:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: wcd9335: Fix missing regmap requirement" to the asoc tree
In-Reply-To: <8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190513123031.3B9B71129235@debutante.sirena.org.uk>
Date:   Mon, 13 May 2019 13:30:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd9335: Fix missing regmap requirement

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

From 741bfce676b765f01396e148862740caec91338c Mon Sep 17 00:00:00 2001
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Date: Wed, 10 Apr 2019 16:23:38 +0200
Subject: [PATCH] ASoC: wcd9335: Fix missing regmap requirement

wcd9335.c: undefined reference to 'devm_regmap_add_irq_chip'

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 419114edfd57..667fc1d59e18 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1151,6 +1151,7 @@ config SND_SOC_WCD9335
 	tristate "WCD9335 Codec"
 	depends on SLIMBUS
 	select REGMAP_SLIMBUS
+	select REGMAP_IRQ
 	help
 	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
 	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
-- 
2.20.1

