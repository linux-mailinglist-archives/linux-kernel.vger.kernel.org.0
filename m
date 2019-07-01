Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05AF58779
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfF0QnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 12:43:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59284 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0QnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:43:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hgXUK-0006E9-9s; Thu, 27 Jun 2019 16:43:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix sign unintended sign extension on left shifts
Date:   Thu, 27 Jun 2019 17:43:08 +0100
Message-Id: <20190627164308.21286-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of left shifts of unsigned 8 bit values that
first get promoted to signed ints and hence get sign extended
on the shift if the top bit of the 8 bit values are set. Fix
this by casting the 8 bit values to unsigned ints to stop the
unintentional sign extension.

Addresses-Coverity: ("Unintended sign extension")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1f6011f36bb0..199fa157a411 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -741,7 +741,7 @@ static int snd_ni_control_init_val(struct usb_mixer_interface *mixer,
 		return err;
 	}
 
-	kctl->private_value |= (value << 24);
+	kctl->private_value |= ((unsigned int)value << 24);
 	return 0;
 }
 
@@ -902,7 +902,7 @@ static int snd_ftu_eff_switch_init(struct usb_mixer_interface *mixer,
 	if (err < 0)
 		return err;
 
-	kctl->private_value |= value[0] << 24;
+	kctl->private_value |= (unsigned int)value[0] << 24;
 	return 0;
 }
 
-- 
2.20.1

