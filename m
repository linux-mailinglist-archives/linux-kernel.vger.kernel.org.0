Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1187317BB03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 11:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 05:58:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:60704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgCFK66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:58:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5273AC50;
        Fri,  6 Mar 2020 10:58:56 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: sgio2audio: Remove usage of dropped hw_params/hw_free functions
Date:   Fri,  6 Mar 2020 11:58:37 +0100
Message-Id: <20200306105837.31523-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ee88f4ebe575 ("ALSA: mips: Use managed buffer allocation") removed
superfluous hw_params/hw_free callbacks, but forgot to remove them where
they were used.

Fixes: ee88f4ebe575 ("ALSA: mips: Use managed buffer allocation")
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 sound/mips/sgio2audio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 9f60a5037f8b..5bf1ea150f26 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -649,8 +649,6 @@ snd_sgio2audio_pcm_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_sgio2audio_playback1_ops = {
 	.open =        snd_sgio2audio_playback1_open,
 	.close =       snd_sgio2audio_pcm_close,
-	.hw_params =   snd_sgio2audio_pcm_hw_params,
-	.hw_free =     snd_sgio2audio_pcm_hw_free,
 	.prepare =     snd_sgio2audio_pcm_prepare,
 	.trigger =     snd_sgio2audio_pcm_trigger,
 	.pointer =     snd_sgio2audio_pcm_pointer,
@@ -659,8 +657,6 @@ static const struct snd_pcm_ops snd_sgio2audio_playback1_ops = {
 static const struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
 	.open =        snd_sgio2audio_playback2_open,
 	.close =       snd_sgio2audio_pcm_close,
-	.hw_params =   snd_sgio2audio_pcm_hw_params,
-	.hw_free =     snd_sgio2audio_pcm_hw_free,
 	.prepare =     snd_sgio2audio_pcm_prepare,
 	.trigger =     snd_sgio2audio_pcm_trigger,
 	.pointer =     snd_sgio2audio_pcm_pointer,
@@ -669,8 +665,6 @@ static const struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
 static const struct snd_pcm_ops snd_sgio2audio_capture_ops = {
 	.open =        snd_sgio2audio_capture_open,
 	.close =       snd_sgio2audio_pcm_close,
-	.hw_params =   snd_sgio2audio_pcm_hw_params,
-	.hw_free =     snd_sgio2audio_pcm_hw_free,
 	.prepare =     snd_sgio2audio_pcm_prepare,
 	.trigger =     snd_sgio2audio_pcm_trigger,
 	.pointer =     snd_sgio2audio_pcm_pointer,
-- 
2.25.0

