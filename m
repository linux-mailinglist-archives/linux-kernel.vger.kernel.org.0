Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4763FAF63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 12:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfKMLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 06:13:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:44634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbfKMLNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:13:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31ABBB358;
        Wed, 13 Nov 2019 11:13:06 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix incorrect NULL check in create_yamaha_midi_quirk()
Date:   Wed, 13 Nov 2019 12:12:59 +0100
Message-Id: <20191113111259.24123-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 60849562a5db ("ALSA: usb-audio: Fix possible NULL
dereference at create_yamaha_midi_quirk()") added NULL checks in
create_yamaha_midi_quirk(), but there was an overlook.  The code
allows one of either injd or outjd is NULL, but the second if check
made returning -ENODEV if any of them is NULL.  Fix it in a proper
form.

Fixes: 60849562a5db ("ALSA: usb-audio: Fix possible NULL dereference at create_yamaha_midi_quirk()")
Reported-by: Pavel Machek <pavel@denx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0bbe1201a6ac..349e1e52996d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -248,8 +248,8 @@ static int create_yamaha_midi_quirk(struct snd_usb_audio *chip,
 					NULL, USB_MS_MIDI_OUT_JACK);
 	if (!injd && !outjd)
 		return -ENODEV;
-	if (!(injd && snd_usb_validate_midi_desc(injd)) ||
-	    !(outjd && snd_usb_validate_midi_desc(outjd)))
+	if ((injd && !snd_usb_validate_midi_desc(injd)) ||
+	    (outjd && !snd_usb_validate_midi_desc(outjd)))
 		return -ENODEV;
 	if (injd && (injd->bLength < 5 ||
 		     (injd->bJackType != USB_MS_EMBEDDED &&
-- 
2.16.4

