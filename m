Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3CA6AE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 20:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbfGPSSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 14:18:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbfGPSSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cRKuEDJ/FB9J2ll+d0oSNxmNcsGoBayeoTn6TOmXgto=; b=w60j8A2KGH0T
        Ds7zrZ9yrRUsMsg8UMoJSEn1vs9Pbaldjn2X2+GqKwu0VDOnRH6p6xtq/VZ8u8k2MAvqYEHCK0mir
        Js2D52tFq7M4tt9zfwn3CoN/Sjz6tHZCe/d4EdiHgWjBV0YCtpqA+Jd3uWMogtlmirRwBj0IZ6haf
        F7H7o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hnS1h-0005ye-K1; Tue, 16 Jul 2019 18:18:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6D85F2742BE5; Tue, 16 Jul 2019 19:18:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cheng.shengyu@zte.com.cn, Jaroslav Kysela <perex@perex.cz>,
        krzk@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        lgirdwood@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, Sangbeom Kim <sbkim73@samsung.com>,
        sbkim73@samsung.com, s.nawrocki@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>, tiwai@suse.com,
        wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
Subject: Applied "ASoC: samsung: odroid: fix an use-after-free issue for codec" to the asoc tree
In-Reply-To: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
X-Patchwork-Hint: ignore
Message-Id: <20190716181808.6D85F2742BE5@ypsilon.sirena.org.uk>
Date:   Tue, 16 Jul 2019 19:18:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: odroid: fix an use-after-free issue for codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 9b6d104a6b150bd4d3e5b039340e1f6b20c2e3c1 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Sat, 13 Jul 2019 11:46:14 +0800
Subject: [PATCH] ASoC: samsung: odroid: fix an use-after-free issue for codec

The codec variable is still being used after the of_node_put() call,
which may result in use-after-free.

Fixes: bc3cf17b575a ("ASoC: samsung: odroid: Add support for secondary CPU DAI")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index dfb6e460e7eb..64ebe895cdd7 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -284,9 +284,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	}
 
 	of_node_put(cpu);
-	of_node_put(codec);
 	if (ret < 0)
-		return ret;
+		goto err_put_node;
 
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
@@ -317,6 +316,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		goto err_put_clk_i2s;
 	}
 
+	of_node_put(codec);
 	return 0;
 
 err_put_clk_i2s:
@@ -326,6 +326,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 err_put_cpu_dai:
 	of_node_put(cpu_dai);
 	snd_soc_of_put_dai_link_codecs(codec_link);
+err_put_node:
+	of_node_put(codec);
 	return ret;
 }
 
-- 
2.20.1

