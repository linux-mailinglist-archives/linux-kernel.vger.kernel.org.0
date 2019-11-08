Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87580F516D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfKHQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:45:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:40448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbfKHQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:45:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23A9DAC59;
        Fri,  8 Nov 2019 16:45:37 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: Convert to the common vmalloc memalloc
Date:   Fri,  8 Nov 2019 17:45:28 +0100
Message-Id: <20191108164528.998-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change (*) in the ALSA memalloc core allows us to drop the
special vmalloc-specific allocation and page handling.  This patch
coverts to the common code.
(*) 1fe7f397cfe2: ALSA: memalloc: Add vmalloc buffer allocation
                  support
    7e8edae39fd1: ALSA: pcm: Handle special page mapping in the
                  default mmap handler

Signed-off-by: Takashi Iwai <tiwai@suse.de>

---

Since the prerequisite commits above are found only on for-next branch
of sound git tree, please give ACK if the patch is OK; then I'll apply
it on top of my branch.  Thanks!


 drivers/staging/most/sound/sound.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 79817061fcfa..add16997f129 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -344,8 +344,7 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
 		pr_err("Requested number of channels not supported.\n");
 		return -EINVAL;
 	}
-	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
-						params_buffer_bytes(hw_params));
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 }
 
 /**
@@ -359,7 +358,7 @@ static int pcm_hw_params(struct snd_pcm_substream *substream,
  */
 static int pcm_hw_free(struct snd_pcm_substream *substream)
 {
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
+	return snd_pcm_lib_free_pages(substream);
 }
 
 /**
@@ -469,7 +468,6 @@ static const struct snd_pcm_ops pcm_ops = {
 	.prepare    = pcm_prepare,
 	.trigger    = pcm_trigger,
 	.pointer    = pcm_pointer,
-	.page       = snd_pcm_lib_get_vmalloc_page,
 };
 
 static int split_arg_list(char *buf, u16 *ch_num, char **sample_res)
@@ -663,6 +661,8 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
 	pcm->private_data = channel;
 	strscpy(pcm->name, device_name, sizeof(pcm->name));
 	snd_pcm_set_ops(pcm, direction, &pcm_ops);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_VMALLOC,
+					      NULL, 0, 0);
 
 	return 0;
 
-- 
2.16.4

