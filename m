Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD2F52DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfKHRtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 12:49:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37838 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfKHRs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:48:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8CB4F29134C
Received: by jupiter.universe (Postfix, from userid 1000)
        id 018E14800A4; Fri,  8 Nov 2019 18:48:53 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 4/5] ASoC: da7213: move set_pll to codec level
Date:   Fri,  8 Nov 2019 18:48:42 +0100
Message-Id: <20191108174843.11227-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108174843.11227-1-sebastian.reichel@collabora.com>
References: <20191108174843.11227-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move set_pll function to component level, so that it can be used at
both component and DAI level.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 sound/soc/codecs/da7213.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index c7734876e4f0..197609691525 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1399,10 +1399,10 @@ static int da7213_set_component_sysclk(struct snd_soc_component *component,
 }
 
 /* Supported PLL input frequencies are 32KHz, 5MHz - 54MHz. */
-static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
-			      int source, unsigned int fref, unsigned int fout)
+static int da7213_set_component_pll(struct snd_soc_component *component,
+				    int pll_id, int source,
+				    unsigned int fref, unsigned int fout)
 {
-	struct snd_soc_component *component = codec_dai->component;
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 
 	u8 pll_ctrl, indiv_bits, indiv;
@@ -1514,7 +1514,6 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 static const struct snd_soc_dai_ops da7213_dai_ops = {
 	.hw_params	= da7213_hw_params,
 	.set_fmt	= da7213_set_dai_fmt,
-	.set_pll	= da7213_set_dai_pll,
 	.digital_mute	= da7213_mute,
 };
 
@@ -1852,6 +1851,7 @@ static const struct snd_soc_component_driver soc_component_dev_da7213 = {
 	.dapm_routes		= da7213_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(da7213_audio_map),
 	.set_sysclk		= da7213_set_component_sysclk,
+	.set_pll		= da7213_set_component_pll,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.24.0.rc1

