Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD5BE483E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409079AbfJYKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 06:12:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37652 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409011AbfJYKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Mfwi8AbI+njv6OXBWSEU3ESst6lzCiQazpD9WrFtGOs=; b=PejzMVlZbUqx
        fSWESryCFXJJPU17sFwlk8S7+h3cO3184RFLTHRDblukpGYd9k6aH+GZ92FC7DUHc/FverGf3dyhE
        11xAB+QcwD6u3+XkSgQ+ZsuE7z8ez8yPINS6cItdVxMHrr29OdjzG9Ncm+6mzIx6ULE8NaXmNJWy9
        2yxTc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNwZo-0006dx-NU; Fri, 25 Oct 2019 10:12:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 251942743267; Fri, 25 Oct 2019 11:12:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiri Kosina <trivial@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: pxa: poodle: Spelling s/enpoints/endpoints/, s/connetion/connection/" to the asoc tree
In-Reply-To: <20191024153130.31082-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20191025101212.251942743267@ypsilon.sirena.org.uk>
Date:   Fri, 25 Oct 2019 11:12:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pxa: poodle: Spelling s/enpoints/endpoints/, s/connetion/connection/

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

From 16c33235321d5ce3463ebefc205d7cf11929d59f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 24 Oct 2019 17:31:30 +0200
Subject: [PATCH] ASoC: pxa: poodle: Spelling s/enpoints/endpoints/,
 s/connetion/connection/

Fix misspelling of "endpoints" and "connection".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20191024153130.31082-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/poodle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 48d5c2252b10..59ef04d0467a 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -56,7 +56,7 @@ static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	}
 
-	/* set the enpoints to their new connetion states */
+	/* set the endpoints to their new connection states */
 	if (poodle_spk_func == POODLE_SPK_ON)
 		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
-- 
2.20.1

