Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263E1156802
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBHWev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 17:34:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBHWeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:34:50 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j0YgV-0001jM-Q3; Sat, 08 Feb 2020 22:34:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ali5451: remove redundant variable capture_flag
Date:   Sat,  8 Feb 2020 22:34:43 +0000
Message-Id: <20200208223443.38047-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable capture_flag is only ever assigned values, it is never read
and hence it is redundant. Remove it.

Addresses-Coverity ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/ali5451/ali5451.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 4f524a9dbbca..4462375d2d82 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1070,7 +1070,7 @@ static int snd_ali_trigger(struct snd_pcm_substream *substream,
 {
 	struct snd_ali *codec = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *s;
-	unsigned int what, whati, capture_flag;
+	unsigned int what, whati;
 	struct snd_ali_voice *pvoice, *evoice;
 	unsigned int val;
 	int do_start;
@@ -1088,7 +1088,7 @@ static int snd_ali_trigger(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	what = whati = capture_flag = 0;
+	what = whati = 0;
 	snd_pcm_group_for_each_entry(s, substream) {
 		if ((struct snd_ali *) snd_pcm_substream_chip(s) == codec) {
 			pvoice = s->runtime->private_data;
@@ -1110,8 +1110,6 @@ static int snd_ali_trigger(struct snd_pcm_substream *substream,
 					evoice->running = 0;
 			}
 			snd_pcm_trigger_done(s, substream);
-			if (pvoice->mode)
-				capture_flag = 1;
 		}
 	}
 	spin_lock(&codec->reg_lock);
-- 
2.25.0

