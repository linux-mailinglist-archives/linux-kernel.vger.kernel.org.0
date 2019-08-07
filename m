Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156A7842E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 05:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfHGDWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 23:22:48 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:43394 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfHGDWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:22:48 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x773MjL1057164
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 6 Aug 2019 23:22:46 -0400
Received: by mail-lf1-f41.google.com with SMTP id c19so62874256lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 20:22:46 -0700 (PDT)
X-Gm-Message-State: APjAAAV5BbwZnQEzqrmdgbllVBfcfBXhkNn9ebln8bz5MBcrSoy/JTJC
        L3kxHMEN7Bh2zuYw14BxIvdd/kkMf/0UCfGbfIM=
X-Google-Smtp-Source: APXvYqw3KascRBJeThGdIl1eMlrfY0MLn4+tPhdJYMi19pdSHHihKN0uMyQrgJJQBMdEzA/lLNkO+DuQuoIITtTaakI=
X-Received: by 2002:ac2:442f:: with SMTP id w15mr4617610lfl.9.1565148165415;
 Tue, 06 Aug 2019 20:22:45 -0700 (PDT)
MIME-Version: 1.0
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Tue, 6 Aug 2019 23:22:09 -0400
X-Gmail-Original-Message-ID: <CAAa=b7ebEkQZhPCbJPK=dVC+cR8_pTE3OOxX+PV+MNx7-Y25Cw@mail.gmail.com>
Message-ID: <CAAa=b7ebEkQZhPCbJPK=dVC+cR8_pTE3OOxX+PV+MNx7-Y25Cw@mail.gmail.com>
Subject: [PATCH] ALSA: usb-midi: fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __snd_usbmidi_create(), a MIDI streaming interface structure is
allocated through kzalloc() and the pointer is saved to 'umidi'. Later on,
the endpoint structures are created by invoking
snd_usbmidi_create_endpoints_midiman() or snd_usbmidi_create_endpoints(),
depending on the type of the audio quirk type. However, if the creation
fails, the allocated 'umidi' is not deallocated, leading to a memory leak
bug.

To fix the above issue, free 'umidi' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index b737f0e..22db37f 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2476,7 +2476,7 @@ int __snd_usbmidi_create(struct snd_card *card,
        else
                err = snd_usbmidi_create_endpoints(umidi, endpoints);
        if (err < 0)
-               goto exit;
+               goto free_midi;

        usb_autopm_get_interface_no_resume(umidi->iface);

-- 
2.7.4
