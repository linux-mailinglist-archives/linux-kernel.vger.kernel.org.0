Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC71E3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 15:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfD2N3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 09:29:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32851 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfD2N3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:29:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so16140521wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5gkjIo0jKHz5nMirUsgx+T49vpY9J+GcHz2XWc4FKc=;
        b=pFUVGdlRPrcuUqW2/0hELTzPbKKNEYhqDI3CkoHGbZm5Yq65C2D4IF8ZEXBAdCGtm8
         6y06tr2gg4sOArlY8cGKjM3ebjdz0ngMoptkgu46RzVGo5BR9g2+DFM/wOEPtp9o8wT4
         Rwoc0G8zd17SAbTmHP7FagKPPu93ZXMX/8yb+MbH4oV242MLkVQFh4kWT4loQuxdmu0x
         tYoULFW6Gm/RlFujGK8PtsjODesDRrDXCUEXXxbX1fOWnMy/BdnVREtQkCQeYj8X50nr
         ymiJSVYd7oFu6C++IEeQyMRAe+AFq2Wdm4m2vv7Zk3zP031MG5rTwCecm4QiH1gEyYXu
         Hx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5gkjIo0jKHz5nMirUsgx+T49vpY9J+GcHz2XWc4FKc=;
        b=M/tC5zWnXfxzrceQwZHC1nzukuJTutaiA5SuJjjpQFkcNArycXWD25ALDQRQ15w4Qk
         mlQMjIjPRobEveOcZgj4XB3cQXnLIMN/CDPMTKXvR39FQUv4xptWrKOhz7zbF/bQd5i9
         QUxEwpkZ2og7GIvfogPYb6muSPAzTuW8VSKSsiRj4p2WuPZfAVWtkOwB+MzWhMoC34eJ
         ePuVzoNBnpltbuN58jy+EqEq0PhZ9xDJ1GRgMYdlzYxYJbJUZJoeN1gpgZMUUSmURl6I
         D58Eb9YkP/SVvSKlG6rM77WXlTZO7jGI8upj1Uu7oX/SlaT2gwXZvQJC3I9fdfdXPREe
         B8fw==
X-Gm-Message-State: APjAAAU8JnPhFoFrkTTzejpsrEqZfOkAPkpRIdv8h0Qe+EexY9lyAHHB
        OAoL9HClZpDPa3JAU/xLgCvpvA==
X-Google-Smtp-Source: APXvYqwQRjw0fpniFRPWZPbufXRuMFumxyoEfAbrckJdhgOSUuRSLDn24hIGZQuswECs2edXbWvhNQ==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr10153524wrq.239.1556544589439;
        Mon, 29 Apr 2019 06:29:49 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s17sm2857593wra.94.2019.04.29.06.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 06:29:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 1/6] ASoC: hdmi-codec: remove function name debug traces
Date:   Mon, 29 Apr 2019 15:29:38 +0200
Message-Id: <20190429132943.16269-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429132943.16269-1-jbrunet@baylibre.com>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the debug traces only showing the function name on entry.
The same can be obtained using ftrace.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index e5b6769b9797..9dca24732069 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -416,8 +416,6 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret = hdmi_codec_new_stream(substream, dai);
 	if (ret)
 		return ret;
@@ -453,8 +451,6 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	WARN_ON(hcp->current_stream != substream);
 
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
@@ -531,8 +527,6 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 	struct hdmi_codec_daifmt cf = { 0 };
 	int ret = 0;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (dai->id == DAI_ID_SPDIF) {
 		cf.fmt = HDMI_SPDIF;
 	} else {
@@ -602,8 +596,6 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	if (hcp->hcd.ops->digital_mute)
 		return hcp->hcd.ops->digital_mute(dai->dev->parent,
 						  hcp->hcd.data, mute);
@@ -661,8 +653,6 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	};
 	int ret;
 
-	dev_dbg(dai->dev, "%s()\n", __func__);
-
 	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				      NULL, drv->playback.channels_max, 0,
 				      &hcp->chmap_info);
@@ -759,8 +749,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	int dai_count, i = 0;
 	int ret;
 
-	dev_dbg(dev, "%s()\n", __func__);
-
 	if (!hcd) {
 		dev_err(dev, "%s: No plalform data\n", __func__);
 		return -EINVAL;
-- 
2.20.1

