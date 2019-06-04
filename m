Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19296342A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfFDJGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 05:06:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46856 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFDJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:06:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so9954839pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfFtTOSVe4GXuDzP0da8mgJsCVGqfo1O1ofIicvNlPw=;
        b=cGz20g9tu97nNM3OpJWcrJM++3f2oaf5mAfdN4TQLbuqDjwgzW9jcVJXuvnTmSlyn+
         xnh073pF5HgUHFAcBzdnb9SMgXe/JTvrtkzkj5SwJq2K0oMZ0MTXEIOuxlyu9DedN7VP
         hdizIYIU8uxumJWUNtGF3HWEBVSLTDB9E4N9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfFtTOSVe4GXuDzP0da8mgJsCVGqfo1O1ofIicvNlPw=;
        b=hi00NC3I6dftxSNc2XynVlhgg7yfHt9kd8fPu9iB6s0Kj56d8JnKwaoCLr/BTPReZj
         ToNOH4DZnegX82cFSN8kQxZaQ0Z+xKGw6iPMKpam4d4ng1hU4J6FKspkxycTEkQ916J8
         Ne/XuhpqW42XCfwgxSZInpJD/UH1Z93o2q51dckORQQHoRl+sjSLTAu3tCWzDBGuZpWt
         OWzGhwPjlHfQ/UwB3HuE6Ck0ayYiyvunvYON1s+7LWxQHmTU7Awl/Hs+wN+qc58FXt+q
         tqprdipHyF/2IL39JKnro7cNdVt1kRA1HDmAJPkxrcWFGROSYimNtDy+8c0z7SvLvcCI
         OmBw==
X-Gm-Message-State: APjAAAUNJ03dnsfnMBI904XOkFZO+XwMdWn7MHCSh9JIPvBypJ6/MBko
        LOKNnQqPolK/lBF+swf9MKwk7vD/GCc=
X-Google-Smtp-Source: APXvYqw0MrZPhbHOIZ5oCl8sVuLhD95RjKVOtq7qegsufs09L3nAESMfj4hjD6C55317hrMQIYi4bw==
X-Received: by 2002:a63:6b08:: with SMTP id g8mr35261104pgc.106.1559639203881;
        Tue, 04 Jun 2019 02:06:43 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id s4sm4238038pgg.55.2019.06.04.02.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 02:06:43 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, dgreid@chromium.org,
        cychiang@chromium.org
Subject: [PATCH] ASoC: max98090: remove 24-bit format support if RJ is 0
Date:   Tue,  4 Jun 2019 17:06:30 +0800
Message-Id: <20190604090630.151610-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The supported formats are S16_LE and S24_LE now. However, by datasheet
of max98090, S24_LE is only supported when it is in the right justified
mode. We should remove 24-bit format if it is not in that mode to avoid
triggering error.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/max98090.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7619ea31ab50..4cbfb0b95404 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1909,6 +1909,21 @@ static int max98090_configure_dmic(struct max98090_priv *max98090,
 	return 0;
 }
 
+static int max98090_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
+	unsigned int fmt = max98090->dai_fmt;
+
+	/* Remove 24-bit format support if RJ is 1. */
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
+	}
+	return 0;
+}
+
 static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -2316,6 +2331,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops max98090_dai_ops = {
+	.startup = max98090_dai_startup,
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
-- 
2.22.0.rc1.311.g5d7573a151-goog

