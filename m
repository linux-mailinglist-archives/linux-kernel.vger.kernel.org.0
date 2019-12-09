Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6282E11716A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 17:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLIQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 11:21:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLIQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:21:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so7366308pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ivG1sogaJP93bTE4LGU6va4QS4V/Fw37s6F674FfD8=;
        b=oe+5C+o2ssEPEJg4vajO8v3ZF+0bJ8RMzXHtUw8k/N5UcGUYTL3+mwi3NeOA7S6sip
         Ml0YnEea19N3gxajFY+s144LflzHMoJkwtV8lXm6Qjj0FnWPfT/gcqygWfmWHs7KmQZX
         o4i/lmpRRGgpvNO63t7uEgc8/855nkXQemUMvgDV99FI8K7oHpGAs7MfQavtzAxz8S78
         Io7OWZa0+BCEv8Nozwwe1+G1qLQUE7nOtFKBnaCQhHlcFl/L/2o7ZQVuUbZiX30c0YO1
         hCkWjnaGZ3NVTI3iCFWQH6d6Z8gGquqqFYKlvilIbgz0n6KS8YAFZEQNdY0t8/Kxz56b
         G5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ivG1sogaJP93bTE4LGU6va4QS4V/Fw37s6F674FfD8=;
        b=XN7jHgUHp73y1x4ed6NW9RJW/aDLREMGedl2mbXfeZ2cWzYUewXeFuc8Zn0QnsWNxi
         msQMsxBQoWFpCRphrTfkX4UgodRTgDY0dq+j0O/luD8ZOhxDZ4P3OG0pgHEyJlpTvhpN
         pXZ/rBCgjVl1m42P1lZzZ0ioq0RqSdU34nr72wkvymYflKNudT15pBPYRnD0uqXuxZyz
         WX+uNT3es9R41zUDCpkxn3V10BTdGdiWON2eWsx9B5hEGiUXzyGYr4z+Nzy/LD/246YR
         7F2S37s7KR/rQwztNvyQ5tLwOjlELdU04z18cMucl/UfZz++IIA8hGerXOfa0LijfuaE
         GJTg==
X-Gm-Message-State: APjAAAX6ftcW0fEZ+i/x4sVTdGiuKZQcoUxIVX9mGXB3/flm5vmqfrGK
        IgBprz9KqW/oAqwJ5NGw7kA=
X-Google-Smtp-Source: APXvYqwtrxgz6QJcHHYTa6IyBm/KUca0VEZGe4yjjL2YzTMzsOiREc+CN40xHYRI/2lIoD/3oTFqdQ==
X-Received: by 2002:a65:530d:: with SMTP id m13mr19576837pgq.351.1575908495552;
        Mon, 09 Dec 2019 08:21:35 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id s2sm28695572pfb.109.2019.12.09.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:21:34 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ALSA: hda/ca0132 - add missed snd_hda_gen_parse_auto_config
Date:   Tue, 10 Dec 2019 00:21:19 +0800
Message-Id: <20191209162119.14820-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is found that all usages of snd_hda_parse_pin_defcfg() are followed
with snd_hda_gen_parse_auto_config() except here.
This should be a miss and needs to add the missed call.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b7a1abb3e231..ea1187a13241 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -24,6 +24,7 @@
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
+#include "hda_generic.h"
 
 #include "ca0132_regs.h"
 
@@ -8844,6 +8845,10 @@ static int patch_ca0132(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
+	err = snd_hda_gen_parse_auto_config(codec, &spec->autocfg);
+	if (err < 0)
+		goto error;
+
 	return 0;
 
  error:
-- 
2.24.0

