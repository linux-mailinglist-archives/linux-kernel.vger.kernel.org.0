Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2468E9D3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbfHZQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 12:10:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35207 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfHZQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:10:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so15646979lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netforce.ua; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlZtTdio1Y6VVz0EfywAkxBeMP9JChkSpHZKD+louec=;
        b=FNGfQGkzzUQS1d1t0+p6lBcGEh/BEgDQpEU/6aO5W2NUJ6rKeUb9ErEUoQ6Eb2gjjb
         2HMc/gN68B0VMh1ZT08BkF6lumorqI5v6RZZpVEDkSOj5jxTpxAUxGwyQMGHlm0/qYm5
         4EPVTbWYaJCh+l4yvT3m6u1g0+OD2v2dges2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlZtTdio1Y6VVz0EfywAkxBeMP9JChkSpHZKD+louec=;
        b=QfKFNhxBimYeSKIbShBTu6hDTI4/tWqHanlB9oP21brrpo+oc4e3I8DZCzUYEgBjWg
         +0Nvs/rdVv7ydVzFH5PMA8Imv7z4/GJ9wsXC6cGnEoH2AuqzRxd/kI1pOliXXX6oSQJ0
         3Z4OofGyFE2+GQXfSOgVKmLm6NumycZsJcqouSpKdIx6uUvNe3B/ycpLRLk928dujkb9
         /nix/YE9EZ1F6N4CwnlW7OUGwyWk047k7JyV5Tpf2u1C10PAn/Q3ua04ceSiF4N3IhB1
         AnF+FFEu3NctR5KBkhi0NhUupEh+i2PciE/gI31AbLkO4ZulYeXcJGo7uRwyHgUZvcif
         CNMQ==
X-Gm-Message-State: APjAAAUQ1op1xELrFRbuXOGUfSJ8NNLUw4wSj7IBYDIc+BWpkwSgQrPg
        aB7ibW+bZHN2js4Yt2La2Mi2+w==
X-Google-Smtp-Source: APXvYqxlTonBs8rkrpFa1ptcl0dgRDel7sYOE1vswwwW/SGZR/d/6ozTyUsG0N9t9ONO6p4fPlQXNg==
X-Received: by 2002:a2e:8455:: with SMTP id u21mr10702408ljh.20.1566835799242;
        Mon, 26 Aug 2019 09:09:59 -0700 (PDT)
Received: from rhea.localdomain ([37.46.255.109])
        by smtp.gmail.com with ESMTPSA id s4sm1327826lfd.77.2019.08.26.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 09:09:58 -0700 (PDT)
From:   ilya.pshonkin@netforce.ua
To:     ilya.pshonkin@netforce.ua
Cc:     Sudokamikaze <sudokamikaze@protonmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jussi Laako <jussi@sonarnerd.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Manuel Reinhardt <manuel.rhdt@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add Hiby R3 to quirks for native DSD support
Date:   Mon, 26 Aug 2019 19:09:52 +0300
Message-Id: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudokamikaze <sudokamikaze@protonmail.com>

This patch adds quirk VID/PID IDs for Hiby R3 portable DSD player DSD support

Signed-off-by: Sudokamikaze <sudokamikaze@protonmail.com>
---
 sound/usb/quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 78858918cbc1..f90418149e4e 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1588,6 +1588,12 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
+	
+	/* ESS Sabre based USB DACs */
+	case USB_ID(0xc502, 0x0051): /* Hiby R3 */
+		if (fp->altsetting == 4)
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
+		break;
 
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3; with fp->dsd_raw */
-- 
2.23.0

