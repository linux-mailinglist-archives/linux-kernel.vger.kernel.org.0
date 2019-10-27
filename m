Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63DE6505
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 20:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfJ0TMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 15:12:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36453 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfJ0TMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 15:12:20 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so8066706ioc.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FuOLoqKuBv55/BgOb7/WblKZiW3GWx52B3jkkZBZ3Zs=;
        b=nTJ9eeMnKQvuN/UQW8tRL0yhN3rANkRe5hNsbWMqNk9nIG9WaWhKLLMyoYYLV0BAtP
         Ve/D0M93iqhs4/+YjKesD+qfSNRQfOBA9BPuRVXYGOukMnmuZdgL7X81PQFsjSbbFlDA
         ITK/Z/3VHDF4l+c96mIXAJLkfgQwcbet32M1HP6kJjtJDpdmOnt+ajOrE/nGF0qGPg5k
         MkZBDj1Fx54Eu9Ww6CqZyTFnYvNBCRtRN/v6hNId2IsKJBiAhYzRmcmEs/IVbCBNJwZj
         SXk9/XI8hF00fY9BY5B3SP9hkIVEIQLuAFiaNMqjX/yjAlC17yyo62Bgd5Ke1v+i7ydy
         Ll6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FuOLoqKuBv55/BgOb7/WblKZiW3GWx52B3jkkZBZ3Zs=;
        b=L67iYBVQKldCIgJr5dsFkxopOm1z3PvGRJIdm2pEAdL/0SYFuXswj4piiTlEMWnvQL
         J0egZVkA8/19KAJIg8ZUwhvs3kJYMHjd1+QWH887ZZUYcE20xe2RuMFdjREGJLpOYX+3
         NxR7qK5fc+hwlQrD7tnlSplF8o2qBvIiTvoFBYWDKgvQFeGP2MWfqBUIE2KpdkRZqlzG
         1JWEvns4emSagHzenJk6Ugt6QfpHNqeTUhfuqvx0BqIaHmZkN8u0E9XKXQNMsgbegeww
         bF1iDKrXSdlRRNjkcFyFXzWpdz4YnAhzViZJPLHLA30c+Af/VxBIgU5/NrZPhqwRuSjl
         BDhA==
X-Gm-Message-State: APjAAAWoh6EL+rKKq2IVeF+C12s8axxptI8yw7Yb73chFIGnqJJJEFiu
        F49X6C5jJcDg+yfEPUJYx5E=
X-Google-Smtp-Source: APXvYqwJazqg1e7f41IHEhAXNxGf0z9vaXl6FfV1BoS/lcf+kRJXX3wQR5O5boZMMgc9oIxNrE3pdA==
X-Received: by 2002:a5e:d90c:: with SMTP id n12mr6934565iop.140.1572203539173;
        Sun, 27 Oct 2019 12:12:19 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id v14sm745920iob.59.2019.10.27.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 12:12:18 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pci: Fix memory leak in snd_korg1212_create
Date:   Sun, 27 Oct 2019 14:12:04 -0500
Message-Id: <20191027191206.30820-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of snd_korg1212_create() the allocated memory for
korg1212 is leaked in cases of error. Release korg1212 via
snd_korg1212_free() if either of these calls fail:
snd_korg1212_downloadDSPCode(), snd_pcm_new(), or snd_ctl_add().

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/pci/korg1212/korg1212.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 0d81eac0a478..e976e857d915 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2367,8 +2367,10 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 
 	mdelay(CARD_BOOT_DELAY_IN_MS);
 
-        if (snd_korg1212_downloadDSPCode(korg1212))
+	if (snd_korg1212_downloadDSPCode(korg1212)) {
+		snd_korg1212_free(korg1212);
         	return -EBUSY;
+	}
 
         K1212_DEBUG_PRINTK("korg1212: dspMemPhy = %08x U[%08x], "
                "PlayDataPhy = %08x L[%08x]\n"
@@ -2383,8 +2385,11 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
                korg1212->RoutingTablePhy, LowerWordSwap(korg1212->RoutingTablePhy),
                korg1212->AdatTimeCodePhy, LowerWordSwap(korg1212->AdatTimeCodePhy));
 
-        if ((err = snd_pcm_new(korg1212->card, "korg1212", 0, 1, 1, &korg1212->pcm)) < 0)
+	err = snd_pcm_new(korg1212->card, "korg1212", 0, 1, 1, &korg1212->pcm);
+	if (err < 0) {
+		snd_korg1212_free(korg1212);
                 return err;
+	}
 
 	korg1212->pcm->private_data = korg1212;
         korg1212->pcm->private_free = snd_korg1212_free_pcm;
@@ -2398,8 +2403,10 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 
         for (i = 0; i < ARRAY_SIZE(snd_korg1212_controls); i++) {
                 err = snd_ctl_add(korg1212->card, snd_ctl_new1(&snd_korg1212_controls[i], korg1212));
-                if (err < 0)
+		if (err < 0) {
+			snd_korg1212_free(korg1212);
                         return err;
+		}
         }
 
         snd_korg1212_proc_init(korg1212);
-- 
2.17.1

