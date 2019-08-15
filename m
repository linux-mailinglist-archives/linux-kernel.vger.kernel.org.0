Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9018F1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 19:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbfHOROe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 13:14:34 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:45479 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfHORO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:29 -0400
Received: by mail-wr1-f99.google.com with SMTP id q12so2831236wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=YPeSnlp85BSgqZ8FUqvf/b5hI6uRVke7m+e+NVbbr4w=;
        b=hGukWCOcwzySSmP8nSfR1+66LG0hu1LU8Y1tyRzIlQgJ0X/aNLDHH0eJdOhR9nCURa
         J0BfwvBIbvqZVphIdeBPjPxhTS+mWfCHEG5A9REVVwu3V1Q+dTsBEFmOznb+x5rAKiub
         H0tL9bukUiDZ6XMFV6Va/7FvGdfLcqmbU1cT0Xj5X3OyP7euHngolXS/ZL7XsBpXMdtr
         0Ojl4APrBH4VlTifDUlWH6zWoNaRxy7gI/0lIwOJBfgRaWD8Tz/kspcKb5tUsRAdmQCa
         gHWKx6dNsaHt1q4mWWv4r85hTQPJi/RlmYuKTs4NfT1inpFmnVk1vgRGW0vZtw0C13UE
         5udw==
X-Gm-Message-State: APjAAAUOS1jbIHgMzyN7/Amnmva6rrAdyzI22tvDRvO7rXWok7d8SbGS
        jJ+3/VI/R36M0HVQE7YFUWmxXboT2r05ElofKDuemZd26b9P+gJkF66JONIJe7lrOQ==
X-Google-Smtp-Source: APXvYqwzCFxnd7Tnrw+VcKoRu5IrfLOdJxhmvb9tC1g2WmdJI+J7y+97oDUNU/8wBnVKOLWS0o9WgLgcpwBa
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr6963937wrp.42.1565889267066;
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id o9sm58910wrg.25.2019.08.15.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKU-00052B-Ld; Thu, 15 Aug 2019 17:14:26 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 173082742BC7; Thu, 15 Aug 2019 18:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.c, tiwai@suse.com
Subject: Applied "ASoC: mt2701: remove unused variables" to the asoc tree
In-Reply-To: <20190813143811.31456-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171426.173082742BC7@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mt2701: remove unused variables

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

From a9e792d006edbd33724f2eb858887d3b591d82c5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 13 Aug 2019 22:38:11 +0800
Subject: [PATCH] ASoC: mt2701: remove unused variables

sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:799:38: warning:
 mt2701_afe_o23_mix defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:803:38: warning:
 mt2701_afe_o24_mix defined but not used [-Wunused-const-variable=]
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:835:38: warning:
 mt2701_afe_multi_ch_out_i2s4 defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190813143811.31456-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 9af76ae315a5..d7f5defa50c2 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -796,14 +796,6 @@ static const struct snd_kcontrol_new mt2701_afe_o22_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I19 Switch", AFE_CONN22, 19, 1, 0),
 };
 
-static const struct snd_kcontrol_new mt2701_afe_o23_mix[] = {
-	SOC_DAPM_SINGLE_AUTODISABLE("I20 Switch", AFE_CONN23, 20, 1, 0),
-};
-
-static const struct snd_kcontrol_new mt2701_afe_o24_mix[] = {
-	SOC_DAPM_SINGLE_AUTODISABLE("I21 Switch", AFE_CONN24, 21, 1, 0),
-};
-
 static const struct snd_kcontrol_new mt2701_afe_o31_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I35 Switch", AFE_CONN41, 9, 1, 0),
 };
@@ -832,11 +824,6 @@ static const struct snd_kcontrol_new mt2701_afe_multi_ch_out_i2s3[] = {
 				    PWR2_TOP_CON, 18, 1, 0),
 };
 
-static const struct snd_kcontrol_new mt2701_afe_multi_ch_out_i2s4[] = {
-	SOC_DAPM_SINGLE_AUTODISABLE("Multich I2S4 Out Switch",
-				    PWR2_TOP_CON, 19, 1, 0),
-};
-
 static const struct snd_soc_dapm_widget mt2701_afe_pcm_widgets[] = {
 	/* inter-connections */
 	SND_SOC_DAPM_MIXER("I00", SND_SOC_NOPM, 0, 0, NULL, 0),
-- 
2.20.1

