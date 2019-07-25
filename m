Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291D2754DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbfGYRAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 13:00:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40457 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390569AbfGYRAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:00:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so45402459wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lbYdutAm45vnNpTOgncZbQOVHMX6IrCJM1Bp1BbX570=;
        b=JHL5b6yjq498WqGFuxUL/3bR4AEmuQubYpax4UgNdWtxexCUwcLOEgfLEK6IEeOV9j
         ZEQ/VPp/zAPPlSOpJ2P7cK/l0jbzfN93PS9DUEChu69bt2XEmoBULnR82eIPbgYt71dv
         9MVzSFF95J4xkl9e4ZrDs5TF6h1wxTdijRA/El6uPPOXG5PtDW22GgkqXaHKN7nmpWiy
         tNTYcx0HpmJWfDM8WY1uIfBpx6ANJt4h3QXSAJBMv6qu87JdtXBVvA7dgq0liy7XTGVc
         b6TRBWvAHXzIz76zWg5hhAg3zQ3fo6818Qrn6vkqSuW5T89PJJP3JH46GsppTjysOvBD
         b4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbYdutAm45vnNpTOgncZbQOVHMX6IrCJM1Bp1BbX570=;
        b=eRUQNYI68E+9FNlosQi3mpdEdie7lCDaw6oIai4K8mqN4MAHgYMXnzOVGF6FI0wzJG
         8+gNXFSsQZGEgLrzHoMP6O574DSXBJdaCu51nb2CSVhvN/pSGv4AAOq13Pcy6+nGnsIc
         qZvazGG5IoxFd12lOzvDmqlvZIcqIpJPeiv4sDv4OyEYqArmFBye6VePdKYPPM/Psl89
         ougE8bIjQmdiiGItoiINafZT1LD9dxUBEX7Hedzbw14+gqmBbZF8DllaPX2gQdcJF4PG
         jX/dE99TJpp4JnHYGit8XkvzgDMztn0K17jkBVmtGTLgP+c/6HHf9BjH8xNqM+T+VCtH
         tXvg==
X-Gm-Message-State: APjAAAVoXFZqsoDbC8QCzXVi+e4fhtE58I6EsKSD6rLMvqJoVXGbKjuN
        Ps7I2e+aHnnAfIiMQVtOXuwliQ==
X-Google-Smtp-Source: APXvYqyoB5DTPbPo8blqtf5tmVRdEJqQhC7XQYxzoSLPmCRuk3ksWFESivbnEbmeeLuvKYeRRNAl7g==
X-Received: by 2002:a1c:988a:: with SMTP id a132mr78758639wme.165.1564073998535;
        Thu, 25 Jul 2019 09:59:58 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q10sm53627199wrf.32.2019.07.25.09.59.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 09:59:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 6/6] ASoC: codec2codec: fill some of the runtime stream parameters
Date:   Thu, 25 Jul 2019 18:59:49 +0200
Message-Id: <20190725165949.29699-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725165949.29699-1-jbrunet@baylibre.com>
References: <20190725165949.29699-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the information provided struct snd_soc_pcm_stream in the
struct snd_pcm_runtime of the codec to codec link.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3e3b81ae87dd..fadc804be89c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3872,6 +3872,11 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 		dapm_update_dai_unlocked(substream, params, sink);
 	}
 
+	runtime->format = params_format(params);
+	runtime->subformat = params_subformat(params);
+	runtime->channels = params_channels(params);
+	runtime->rate = params_rate(params);
+
 out:
 	if (ret < 0)
 		kfree(runtime);
-- 
2.21.0

