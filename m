Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380C0EFFE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbfKEOej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:34:39 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:47049 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbfKEOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:34:38 -0500
IronPort-SDR: rzk1viUqN4GVDfhcJ0yZrxetNnR/Bym/vqmsxg5Rok9rHPpQ7sK37kPmHeyileBS9HYTJ+jr+/
 YCM488a4c4NcRYLJVIaghIgWY1iDbeW10QUjeroEpqPN1962LNz0mAa6R7eEdcNoO6qW4DURt/
 hPbLxUe2WN1aQo4vMz+uAiJDK5HmZlwAfQomunY3DXJUx0Te1UGQGdldCgXILKBc820LVZzNBs
 W5cjSCd9BW4mmT/Q8Nwds4uxdZKQRnnxg3svvrkoq4gewAIUJKZMABeLOhgmuCpZxPNJNhI5YQ
 vT4=
X-IronPort-AV: E=Sophos;i="5.68,271,1569312000"; 
   d="scan'208";a="42819840"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 05 Nov 2019 06:34:05 -0800
IronPort-SDR: C+x4olymjgc2C+OpQIjlrJCdlRcsjL5Qltv+InIzFQSDaGcSotgp+iVYPcOBybqZL4SVUUohGU
 sp9etVIgA2GjOchVZi4pNLZ0XAP2R6thP0bMa03hbxXuTdVrar3MFlnM3YjZmGhvN5TAjq7/YP
 xd0Resb3aRxSy0fUeWF6XFRkxw7RhHNNqdqKlfPJOf5l+crB3yJ/pm2auDZUdakosmpAx3G1fr
 hUvIJKtdH3kUJ1ZAThKUEko4W5fJMRrBUOjJeoFh5JjlSaJ3pooZ5BgxqwLiU7BGaSzkVPh50f
 wag=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v2 2/8] ALSA: aloop: loopback_timer_start: Support return of error code
Date:   Tue, 5 Nov 2019 08:32:12 -0600
Message-ID: <20191105143218.5948-3-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105143218.5948-2-andrew_gabbasov@mentor.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
 <20191105143218.5948-2-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

This is required for additional timer implementations which could detect
errors and want to throw them.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 1f5982e09025..b9ee5b72a996 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -155,7 +155,7 @@ static inline unsigned int get_rate_shift(struct loopback_pcm *dpcm)
 }
 
 /* call in cable->lock */
-static void loopback_timer_start(struct loopback_pcm *dpcm)
+static int loopback_timer_start(struct loopback_pcm *dpcm)
 {
 	unsigned long tick;
 	unsigned int rate_shift = get_rate_shift(dpcm);
@@ -171,6 +171,8 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
 	tick = dpcm->period_size_frac - dpcm->irq_pos;
 	tick = (tick + dpcm->pcm_bps - 1) / dpcm->pcm_bps;
 	mod_timer(&dpcm->timer, jiffies + tick);
+
+	return 0;
 }
 
 /* call in cable->lock */
@@ -251,7 +253,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
-	int err, stream = 1 << substream->stream;
+	int err = 0, stream = 1 << substream->stream;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -264,7 +266,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);	
 		cable->running |= stream;
 		cable->pause &= ~stream;
-		loopback_timer_start(dpcm);
+		err = loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -292,7 +294,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);
 		dpcm->last_jiffies = jiffies;
 		cable->pause &= ~stream;
-		loopback_timer_start(dpcm);
+		err = loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -300,7 +302,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	return 0;
+	return err;
 }
 
 static void params_change(struct snd_pcm_substream *substream)
-- 
2.21.0

