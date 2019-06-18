Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22174977A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfFRCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 22:24:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36580 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfFRCYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:24:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so4044928plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yw03RFVQcw38KaDua5lfZL2d94vDmgCgBzJoqXkOo3o=;
        b=LVk29ML2Mk7TxhTiFLm8J7/YvF/o+CR7DzBBXQPGajlXfqUxXGXJ4EhHkqq5u4Lc16
         YugCinbdUozD6ADaCMon/inXwIx77+du+fQc6e0aD5WwA6cZJQYREkJdz1/MUIWPda3y
         pJkmCgvOHdNqJt9VZoHIq6UaUIKh9IBP8aybQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yw03RFVQcw38KaDua5lfZL2d94vDmgCgBzJoqXkOo3o=;
        b=ZTKoBrH/YISH7YQGlM3/BrjwCbIg5ZP2QZ7JgMsOz5xRROp8sMAzHsQh6Z2v93eF2q
         1/2/4ghw65gj2QsOrOvksFJO8q34T+F5QOQOywNW6T+YbP9RepEzFYntDXwsKkZ62VKi
         h6yoC06RFy8eLOI6NerTpDKV3nzW4D/l1YyhVPu2bOG2Ret05OMSTrwF5OZIHK8mdnYi
         awFWY5B7qkzJZGT013+ypS6Gxiv/9uEzxgip6Uuvglf5fyJaaunELdWH4I2T5/1dgzgC
         ySiS1/m08Gqq/nvnOAlhSuXpkA02w7leWa0+40NPQ5V47tUh5pkzjM3qVqvfRgE9KeBK
         9ruA==
X-Gm-Message-State: APjAAAU9AFQ6AsVnOnXZ/Vx+D84mLQq6+i1rwMhoC9o2lqF2fUE+9O7O
        GHGuMPnF58+Gat3rz5dYVTh5y+qzLSE=
X-Google-Smtp-Source: APXvYqw2i5AMM/87XCpRxxTyAuhe6pnkw8RyEuhbtxI/wc3tynKJvEOPZRHYiDLNxEM4jR0p2mVDxA==
X-Received: by 2002:a17:902:1566:: with SMTP id b35mr113961401plh.147.1560824660939;
        Mon, 17 Jun 2019 19:24:20 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id y185sm13173222pfy.110.2019.06.17.19.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 19:24:20 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, dgreid@chromium.org,
        cychiang@chromium.org
Subject: [PATCH v6] ASoC: max98090: remove 24-bit format support if RJ is 0
Date:   Tue, 18 Jun 2019 10:24:11 +0800
Message-Id: <20190618022411.208156-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported formats are S16_LE and S24_LE now. However, S24_LE is
not supported when TDM is 0 and it is not in the right justified mode.
We should remove 24-bit format in that situation to avoid triggering
error.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
Changed the order of the conditional.
Remove the snd_pcm_hw_constraint_msbits function.
Use removing 24 bits format instead of fixing at 16 bits format.
 sound/soc/codecs/max98090.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7619ea31ab50..9fbb4c31bcf1 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1909,6 +1909,24 @@ static int max98090_configure_dmic(struct max98090_priv *max98090,
 	return 0;
 }
 
+static int max98090_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
+	unsigned int fmt = max98090->dai_fmt;
+
+	/*
+	 * When TDM = 0, remove 24-bit format support if it is not in right
+	 * justified mode.
+	 */
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J &&
+			!max98090->tdm_slots)
+		substream->runtime->hw.formats &= ~SNDRV_PCM_FMTBIT_S24_LE;
+
+	return 0;
+}
+
 static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -2316,6 +2334,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops max98090_dai_ops = {
+	.startup = max98090_dai_startup,
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
-- 
2.22.0.410.gd8fdbe21b5-goog

