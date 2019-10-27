Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8DBE69DD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 23:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfJ0WKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 18:10:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45330 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfJ0WKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:10:19 -0400
Received: by mail-io1-f67.google.com with SMTP id s17so1386728iol.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YHYEhw/ttN3qGticAt8C8vlSjAHhRkI7ojzgrjl+O1c=;
        b=XFvb1jxXsR8xNwzocagsc6QD5/10VL8qUpDjn9qaOcCPjwHyrLVh2Tw4igPb4hCruf
         JGwBLO3cVyHDVto9HokGvbQXd87ikFC1qdkfJT2UMf4Gmu7kOWenk5Ezfl3SHRk2vt7E
         NzPMN4MLrZC6hdD/ru1PRltpmJ2CBgLziW2eptgX+Fk+R5cElH0xpUksUSdp2sRQJWXn
         rRGVL+hDTSFlnK43ysIw06nf4T6ZgAJgJCnxDN8eE7ys4ZlI/oS8zbFmwxryCSooWUd/
         31WeP6Q62+wF2skWxbiPbDynZLUaAVpmCKGAx+7cUbETULbuJHnG9RUserl2I+pHpthi
         GMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YHYEhw/ttN3qGticAt8C8vlSjAHhRkI7ojzgrjl+O1c=;
        b=bRabHCLOogB9e/Tu/NfHqEBMKXOE99wvVieB80XAJGyL3iyrpH4nni86pMT+WM5GEd
         ztff2HBVzlp1Pr750a+GqHYN2TzVrirYvdUoX89dgVg+G0aBMR3QDC+D6Xahz6NTLB7r
         jSeCAQ/eIOoyrI93fz20d9OhSclivE5JenDBxSYtN6JGsZ9lgR7nITSMMkWf0EjZo5Zt
         IPNjcgezqrgMvn64fl2x13RnEFBMbV/fut831PEvUzfs47WERTdByy+VWQkwucy0sxez
         OFfdCuLV7S5nTWDkNgMU7VZexdtSDmMXYQeUKbq/vlw2fN/F2QfTL3zxixHii54B844M
         4djg==
X-Gm-Message-State: APjAAAVP4YLiWT4/wZWOr4LHQ17WtDPeqsOtcmWyUeFPgqUSFvbVtfIN
        xVO+DGLAIh64E24eHsAKjrE=
X-Google-Smtp-Source: APXvYqxVal8/QSSOGAOQGI6ESdTsFK21tbUAO7G+MMjgHbysGbrpcB7CYixkcNCEjev+WbgF+1+NFQ==
X-Received: by 2002:a5d:9b13:: with SMTP id y19mr7913063ion.38.1572214216847;
        Sun, 27 Oct 2019 15:10:16 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r1sm1290319ilq.7.2019.10.27.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 15:10:16 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix memory leak in __snd_usbmidi_create
Date:   Sun, 27 Oct 2019 17:10:06 -0500
Message-Id: <20191027221007.14317-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of __snd_usbmidi_create() there is a memory leak
caused by incorrect goto destination. Go to free_midi if
snd_usbmidi_create_endpoints_midiman() or snd_usbmidi_create_endpoints()
fail.

Fixes: 731209cc0417 ("ALSA: usb-midi: Use common error handling code in __snd_usbmidi_create()")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/usb/midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index b737f0ec77d0..22db37fbfbbd 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2476,7 +2476,7 @@ int __snd_usbmidi_create(struct snd_card *card,
 	else
 		err = snd_usbmidi_create_endpoints(umidi, endpoints);
 	if (err < 0)
-		goto exit;
+		goto free_midi;
 
 	usb_autopm_get_interface_no_resume(umidi->iface);
 
-- 
2.17.1

