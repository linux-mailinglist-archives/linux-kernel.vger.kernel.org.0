Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA07F478DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 05:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFQDzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 23:55:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43785 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfFQDze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:55:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so4880174pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 20:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqJC7xd4cP2xpAKX8G95YoEsmqVNCEblRXgdAkHCapM=;
        b=QNNfyl42w6byYynB7rie9EzAzYFuxbsJrA50fJY8WM5bonPLS23f4e7cxoAkvfq/lX
         0nZrdjylhTEbzuFVWupwnQVBibKxgttbTeD2/H9tbj/p4yGeWUdQhXYG7Zy8us880YD9
         0TseLImsZsc9wISY/IKOoeeZUBRgekmFvLRCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqJC7xd4cP2xpAKX8G95YoEsmqVNCEblRXgdAkHCapM=;
        b=M1mceWbhAmn7y3D3TfUalNZNe0puyNd2pYbn2HmaVfHG3c/OvfOrFPfiXXzXjtu4sx
         R10tDlnPxK5CeFQy0+GVgVP7SyzwnGa3gkIXbCu49MbHk4uv857H6RNC+EJ+mHgyV3az
         a57gsQ8b4OEIAF5/Ba4rle9UlDu1pwT3Van8LVrGUoOxtARflm5lbCYX/2bmjiFK69Pj
         cdowqrKKesZh5ZnKcU+XO0OfKP5UPtTr+DqnEU3+9aPG4LqbxiFRpPFzJ1HC51J1gppi
         ADCrWiar9QZsTuWpiVE82zxNXVEjb0UdNOp6/NIfwyVjuKC5KUvQP6IDXdfLThYX1Tbx
         gakQ==
X-Gm-Message-State: APjAAAX5waLRPk2HRmdMvKlvyU+JxOrkRCLV+qzWoiQYFtRka6Ls/jJ9
        1Q3LPgj6kaxeWnlAoxrVMtPHaKMIw5Q=
X-Google-Smtp-Source: APXvYqzMcJGvPCzd3KYYEdzBOyrQBsmuYJagogI+c0tD6CSvNL8goYmfenj4fCeIdCvv3A9NE5ZTDg==
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr24710251pjb.132.1560743733942;
        Sun, 16 Jun 2019 20:55:33 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:845f:e35d:e30c:4b47])
        by smtp.gmail.com with ESMTPSA id a3sm9720214pfo.49.2019.06.16.20.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 20:55:33 -0700 (PDT)
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, dgreid@chromium.org,
        cychiang@chromium.org
Subject: [PATCH v5] ASoC: max98090: remove 24-bit format support if RJ is 0
Date:   Mon, 17 Jun 2019 11:55:26 +0800
Message-Id: <20190617035526.85310-1-yuhsuan@chromium.org>
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
The datasheet said that when TDM=0 and RJ=0, S24_LE is not supported.
So I added a constraint to check TDM. Please take a look. Thanks!

 sound/soc/codecs/max98090.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 7619ea31ab50..d118cf80b6b2 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1909,6 +1909,26 @@ static int max98090_configure_dmic(struct max98090_priv *max98090,
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
+	if (!max98090->tdm_slots &&
+		(fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
+		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
+	}
+
+	return 0;
+}
+
 static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
@@ -2316,6 +2336,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 static const struct snd_soc_dai_ops max98090_dai_ops = {
+	.startup = max98090_dai_startup,
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
-- 
2.22.0.410.gd8fdbe21b5-goog

