Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2560EE6513
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfJ0TYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 15:24:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36881 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfJ0TYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 15:24:33 -0400
Received: by mail-io1-f65.google.com with SMTP id 1so8082328iou.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4ofksQ7AcOmTu9H2NgEjkUZ7Z46uH3mw4srj1dXfSSs=;
        b=faXS+qqeDe638CZeqsshIVZhWuSZTrK2yiAsn9fDoQ0Q/sibPkrm78pc6vUC6HQgAU
         LNDbTOCIpw4BdC3vKaP3/3iwt55G0iAge2g2TFSSpPTdZqxe3y4XSPSjcsupx3teh+XV
         Do0nMYDHXPXh2NXH3JMUEatk0KuRo7RHCs7sQZJDBss7aNFDB1FGMbeOP9+TR5GWwOlA
         O4FnvjHrc3mmAkeKVCZWjQ1m0roQQ4kAT4MSSFWGKo6GPKbFVR0szViTvNDzpbBf63ll
         Ey6VYZg8t+/MI7WNUerX2acpc6tx6yI7EFhECU788PS4Ajed+2OIY/TW/8U2jpo8AZmb
         6hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4ofksQ7AcOmTu9H2NgEjkUZ7Z46uH3mw4srj1dXfSSs=;
        b=AVhujOqHnXaB0mz5JRzwJf4gBDpyDiTWnD0lquNWdOuT6e5W+DiqdXiTkp+umZdSIu
         NKRAm6CRSXxUSjk38FvyafK++KNtcDHVg4URhWolklRT3weFwXaWf+++FIDMc/VTsz/R
         CCNrZ1UsnN+BzBfAPtf8PAP26+iNfKXyFFRqo3kP82NdcsHclqmXm6dBzEQc55wbwBVS
         iTmrQ5MAwBsw+G8uEI4jY3KUJc0QDDN71PfDFQLSDk9X2XE0OTitKGgOmDY9IzkIOoK0
         nUeKnTarO0n5BksX7F/6sIXI/BvW9sghWetazsdEpHy1prmGvE/U1V7IC/uMvk07aa84
         jfDw==
X-Gm-Message-State: APjAAAXKuN9LEWaw1JWTsq/5DAqONJWeKotyTFijipKFYlKcNIE6mD3b
        7qQJ5UOEH5qwXZgeHpr72g0=
X-Google-Smtp-Source: APXvYqzzOQqltc5n2sD1ambBu/V7rbpCeqXdQqBw8B8OavUNbezXePdT4X4kwQUm7qT5h6NQbGglHw==
X-Received: by 2002:a6b:7942:: with SMTP id j2mr14638510iop.161.1572204271276;
        Sun, 27 Oct 2019 12:24:31 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id a6sm1212642ill.87.2019.10.27.12.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 12:24:30 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Tim Blechmann <tim@klingt.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: lx6464es: Fix memory leaks in snd_lx6464es_create
Date:   Sun, 27 Oct 2019 14:24:13 -0500
Message-Id: <20191027192415.32743-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of snd_lx6464es_create() it there are memory leaks
when error happens. Go to error path if any of these calls fail:
lx_init_dsp(), lx_pcm_create(), lx_proc_create(), snd_ctl_add().

Fixes: 02bec4904508 ("ALSA: lx6464es - driver for the digigram lx6464es interface")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/pci/lx6464es/lx6464es.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index fe10714380f2..7c6e8f4ef826 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1020,25 +1020,26 @@ static int snd_lx6464es_create(struct snd_card *card,
 	err = lx_init_dsp(chip);
 	if (err < 0) {
 		dev_err(card->dev, "error during DSP initialization\n");
-		return err;
+		goto cleanup;
 	}
 
 	err = lx_pcm_create(chip);
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	err = lx_proc_create(card, chip);
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	err = snd_ctl_add(card, snd_ctl_new1(&lx_control_playback_switch,
 					     chip));
 	if (err < 0)
-		return err;
+		goto cleanup;
 
 	*rchip = chip;
 	return 0;
 
+cleanup:
 device_new_failed:
 	free_irq(pci->irq, chip);
 
-- 
2.17.1

