Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1EF72C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 12:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKKLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 06:09:33 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:65317 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:09:32 -0500
IronPort-SDR: ylDSoGPThEd4Pr+EW6LM+NkIq2h7EEy9Z9zrOl5QXWeckfQ1u9vr5D1yHz6k0yv0OuqsXVBPmj
 ZwBWrs9DdXmMM3P7Ne8iAY9sA6962ZZcbTzSQw9PLBypZTN2Y9liWQsgCoqOiiBTuBVfWqgQ20
 scKImK0foS/YYbTahMncuGpGsY+xkkAGVSw8xjLDHcO1YTGPqcCLvcuJ/QMowai9gVmXfxxcjO
 /UQEp5M8PJTrxVFCOGiRTf83vwAX9lkTgrxTgMYJBF3M73nNb/+iC3WjoucjR22HcGH9WSkTD4
 I7o=
X-IronPort-AV: E=Sophos;i="5.68,292,1569312000"; 
   d="scan'208";a="43051110"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 11 Nov 2019 03:09:31 -0800
IronPort-SDR: 5idUWUzRCps92YlOKu+Y9QijUPKmgHKOAVjG/lH9VUeOQo0pfyDuZHKlHpeenr1oU/hXSvlCBj
 rWFLPGUUoJ29Us2ZvxftSLFlatpqQffvENakmC0c0p163000xpMfX9Jx05YU1qTI55xB8f4yY5
 Q9MN1NvTkEoHhYkwnQfSr07Nv/0t3V2o/0LuXiL+twlRGwN7D0cO66EIN3N0kpzOz/wMacyuvB
 lQ8dqVjaFsw92TrlItlCxyfDxcxndtDT1DIBShNsOgUiNWiH+FFvb2+uAls96LylWC7Fu3QKyI
 pzk=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v3 2/7] ALSA: aloop: Support return of error code for timer start and stop
Date:   Mon, 11 Nov 2019 05:08:41 -0600
Message-ID: <20191111110846.18223-3-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111110846.18223-2-andrew_gabbasov@mentor.com>
References: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
 <20191111110846.18223-2-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
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
 sound/drivers/aloop.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 1f5982e09025..dc9154662d5b 100644
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
@@ -171,18 +171,24 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
 	tick = dpcm->period_size_frac - dpcm->irq_pos;
 	tick = (tick + dpcm->pcm_bps - 1) / dpcm->pcm_bps;
 	mod_timer(&dpcm->timer, jiffies + tick);
+
+	return 0;
 }
 
 /* call in cable->lock */
-static inline void loopback_timer_stop(struct loopback_pcm *dpcm)
+static inline int loopback_timer_stop(struct loopback_pcm *dpcm)
 {
 	del_timer(&dpcm->timer);
 	dpcm->timer.expires = 0;
+
+	return 0;
 }
 
-static inline void loopback_timer_stop_sync(struct loopback_pcm *dpcm)
+static inline int loopback_timer_stop_sync(struct loopback_pcm *dpcm)
 {
 	del_timer_sync(&dpcm->timer);
+
+	return 0;
 }
 
 #define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
@@ -251,7 +257,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
-	int err, stream = 1 << substream->stream;
+	int err = 0, stream = 1 << substream->stream;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -264,7 +270,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);	
 		cable->running |= stream;
 		cable->pause &= ~stream;
-		loopback_timer_start(dpcm);
+		err = loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -273,7 +279,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);	
 		cable->running &= ~stream;
 		cable->pause &= ~stream;
-		loopback_timer_stop(dpcm);
+		err = loopback_timer_stop(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -282,7 +288,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		spin_lock(&cable->lock);	
 		cable->pause |= stream;
-		loopback_timer_stop(dpcm);
+		err = loopback_timer_stop(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -292,7 +298,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);
 		dpcm->last_jiffies = jiffies;
 		cable->pause &= ~stream;
-		loopback_timer_start(dpcm);
+		err = loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -300,7 +306,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	return 0;
+	return err;
 }
 
 static void params_change(struct snd_pcm_substream *substream)
@@ -321,9 +327,11 @@ static int loopback_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
-	int bps, salign;
+	int err, bps, salign;
 
-	loopback_timer_stop_sync(dpcm);
+	err = loopback_timer_stop_sync(dpcm);
+	if (err < 0)
+		return err;
 
 	salign = (snd_pcm_format_physical_width(runtime->format) *
 						runtime->channels) / 8;
-- 
2.21.0

