Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18ECC15D820
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 14:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgBNNOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 08:14:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38155 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgBNNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:14:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so10565524wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5hDX2fKXXUqTN4gPhmTaSqEJNj3ED130xdKjaE+HMU=;
        b=crz6YhDtrV4g8O0/zuiDTYuG8zBCm32KRjK1pD7VSdJPhUVaoAYvLpqkt3v7PIzjH3
         obkCAkhtBFnXK0ExU10NKjBrPtLnGlHTsfOGNOgSjcQhRYEOeRtAg1kX/YRO+Cpa9CLE
         SyXdc2npbGM93qpvkjgJrD/mv/tT2utWUvKQKBvK9rmNbTqeXFFI5Ah27zYZyLJdsPlH
         abrWcUMYrrH+AJtI+u6RxalK5ymeul/ch5gXVOK15AQlgMEAY5XYjtclqy18QKxpgTHN
         EzYMvc6y+368tLzlLAASePwT+nXO3iliU+BhwY4QgFIoei+DzzeE7FcVSYd8tUstN+zy
         snGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5hDX2fKXXUqTN4gPhmTaSqEJNj3ED130xdKjaE+HMU=;
        b=IuOEXTKN5SNsHWWKDmwnjCM2YwR4k3xmyGlnEAyKPkc9G0166F1pZzt8YG6nP6acoQ
         wbHtLjAE+0+lyasZT17pUCzKyA4mlYqH0uqrgF4gGXBi1jPU5ti5T4ePsk2TKTWyOibn
         ep7ynWycJ6m1mfSZh+EnPvudXYvDgzh7T4O/QcSvK1Aw3SNoUPZLmbN2jJ6FUjVxDnA9
         u4wqxSBUsWt4hyomaxV34j09vLek10hTwDrLa3ovWvA4uEzJi2VJjz8TRo3SmEUCJdNM
         pHJuoZi/3mASAKhyxjFN/Mt8NPyo+En9UV2xHKjpF0kc8sECwuURd0P0rQfGnDiDKqYA
         PprA==
X-Gm-Message-State: APjAAAULxcBL2Pku6CVkZ24x3nGkyoJitHGlNm90D1lBawp0AK6aAOsc
        4QhcC7WA+1l0zPU9N0TsPh8R4Q==
X-Google-Smtp-Source: APXvYqwgaIoCglawV5EQ+iFySvSsaN3OWiu9vP82DWE/KGYV9dscwOSz5sA+BE7GOlaYfgmLrE+ljA==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr4579049wmf.75.1581686038936;
        Fri, 14 Feb 2020 05:13:58 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w7sm6760792wmi.9.2020.02.14.05.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:13:58 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4/5] ASoC: meson: aiu: fix acodec dai input name init
Date:   Fri, 14 Feb 2020 14:13:49 +0100
Message-Id: <20200214131350.337968-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214131350.337968-1-jbrunet@baylibre.com>
References: <20200214131350.337968-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the double initialization of the dai input name as reported by
sparse.

Fixes: 65816025d461 ("ASoC: meson: aiu: add internal dac codec control support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/aiu-acodec-ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/meson/aiu-acodec-ctrl.c b/sound/soc/meson/aiu-acodec-ctrl.c
index 12d8a4d351a1..b8e88b1a4fc8 100644
--- a/sound/soc/meson/aiu-acodec-ctrl.c
+++ b/sound/soc/meson/aiu-acodec-ctrl.c
@@ -128,7 +128,6 @@ static const struct snd_soc_dai_ops aiu_acodec_ctrl_output_ops = {
 
 #define AIU_ACODEC_INPUT(xname) {				\
 	.name = "ACODEC CTRL " xname,				\
-	.name = xname,						\
 	.playback = AIU_ACODEC_STREAM(xname, "Playback", 8),	\
 	.ops = &aiu_acodec_ctrl_input_ops,			\
 	.probe = meson_codec_glue_input_dai_probe,		\
-- 
2.24.1

