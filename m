Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3164BE6F65
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbfJ1Jwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 05:52:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33311 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfJ1Jwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:52:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so6593563pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00GH+7MY7gv6VeGZTXVYIreq96BqJ0QE/x20tMZ+6ks=;
        b=Z2BgNGzJ7q4FPtJU4fW2x3DMrNZlTDM5dHyQ8Hf5kSrB3beK/s9ztKON5ojRLhAuMU
         Nyza/b0Moh08dmhqk8Sbj4HZo5KxZBPDr9IKjplFa2wWNOjsepMPXWzF68Gq1+GogWj3
         F5uKtCRH9q/B9Y/z0A5OS6pkzkgTaPndd1a/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=00GH+7MY7gv6VeGZTXVYIreq96BqJ0QE/x20tMZ+6ks=;
        b=qcYRQelekG+55uk8va4z8FDHCbOMWryXo+YF/ImViNbFsphrVYFUWMpk4jyFOFk9cy
         dd4VTOXtCUiP1UGLMG4/tqsJtEpMGwUwZtxoyx0NEn+/SeiRm4FplQRYWFRAMLvmjrUO
         o4L4jPjF2pv6xwue/S9Ubs0fyHBUQ+RLlmJiOs+vS/acF0xC6+Nwz+LFAdsB/Mui65Wv
         8e9+A3LLZBnDpc1rr+vadrrZtXQmE1CGqh1bUTRKoJWPB4Dnqw5fqCx8wT5o7GqSTPg3
         wW9ocXDxgZ6sT5stEPbHSQp1y9iVghEwJy16uXqdyDdqsPk8+/oA3m3NjMWDwv9d7VCz
         OBDg==
X-Gm-Message-State: APjAAAW7FjS6hNJ14x6NQtebtdHmLppzwQ1SuqQc6aDSv+Y0/bWtPI0w
        J2h7sYbl9yMzUrlyTU+q5oyCTwVhgiS45Q==
X-Google-Smtp-Source: APXvYqzdMK0gStf/HLg07oXhPJn5lFdaQhPuDeCWUTAcDq3Av+TyeUSuRXkSsM7OLCc3qJH164huew==
X-Received: by 2002:a63:6901:: with SMTP id e1mr19755671pgc.373.1572256360802;
        Mon, 28 Oct 2019 02:52:40 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id p3sm9897517pgp.41.2019.10.28.02.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 02:52:40 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, enric.balletbo@collabora.com,
        dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: rockchip: rockchip_max98090: Enable SHDN to fix headset detection
Date:   Mon, 28 Oct 2019 17:52:29 +0800
Message-Id: <20191028095229.99438-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max98090 spec states that chip needs to be in turned-on state to supply
mic bias. Enable SHDN dapm widget along with MICBIAS widget to
actually turn on mic bias for proper headset button detection.
This is similar to cht_ti_jack_event in
sound/soc/intel/boards/cht_bsw_max98090_ti.c.

Note that due to ts3a227e reports the jack event right away before the
notifier is registered, if headset is plugged on boot, headset button
will not get detected until headset is unplugged and plugged. This is
still an issue to be fixed.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 0097df1fae66..e80b09143b63 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -66,10 +66,13 @@ static int rk_jack_event(struct notifier_block *nb, unsigned long event,
 	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
 	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
 
-	if (event & SND_JACK_MICROPHONE)
+	if (event & SND_JACK_MICROPHONE) {
 		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
-	else
+		snd_soc_dapm_force_enable_pin(dapm, "SHDN");
+	} else {
 		snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+		snd_soc_dapm_disable_pin(dapm, "SHDN");
+	}
 
 	snd_soc_dapm_sync(dapm);
 
-- 
2.24.0.rc0.303.g954a862665-goog

