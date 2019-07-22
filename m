Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE77270B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfGVVQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:16:00 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:55634 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbfGVVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:15:59 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d78 with ME
        id fxFr2000D4n7eLC03xFs2c; Mon, 22 Jul 2019 23:15:57 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Jul 2019 23:15:57 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, peter.ujfalusi@ti.com,
        gregkh@linuxfoundation.org, wang@mentor.com, tglx@linutronix.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: pcm3168a: Fix a typo in the name of a constant
Date:   Mon, 22 Jul 2019 23:15:28 +0200
Message-Id: <20190722211528.26600-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in PCM1368A_MAX_SYSCLK, it should be PCM3168A_MAX_SYSCLK
(1 and 3 switched in 3168)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/pcm3168a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index ed0b4317c9ae..844602710eee 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -263,7 +263,7 @@ static unsigned int pcm3168a_scki_ratios[] = {
 #define PCM3168A_NUM_SCKI_RATIOS_DAC	ARRAY_SIZE(pcm3168a_scki_ratios)
 #define PCM3168A_NUM_SCKI_RATIOS_ADC	(ARRAY_SIZE(pcm3168a_scki_ratios) - 2)
 
-#define PCM1368A_MAX_SYSCLK		36864000
+#define PCM3168A_MAX_SYSCLK		36864000
 
 static int pcm3168a_reset(struct pcm3168a_priv *pcm3168a)
 {
@@ -296,7 +296,7 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(dai->component);
 	int ret;
 
-	if (freq > PCM1368A_MAX_SYSCLK)
+	if (freq > PCM3168A_MAX_SYSCLK)
 		return -EINVAL;
 
 	ret = clk_set_rate(pcm3168a->scki, freq);
-- 
2.20.1

