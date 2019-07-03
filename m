Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D935E8DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGCQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 12:28:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33523 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:28:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so1520484pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q6zTyc1nJv74vcvWUitF7l7G4qhmg90JLY7Dww6BU2M=;
        b=bf5rKFF1VVweUEDVW7/N2C3+96UepGoqntMuJ4l8GRvxYH48sUaPglMQlPBIH/8i2S
         FU0TPl/G/Z0sVcAdC3x3GOuQ+OeE8U21/fO576KyFmLgdvn2p646emSbQcmqaAW2M0i0
         jfBrfPrROSgiaSh2UUF/g0AxZ8bzLYhGYgWb6F8gm6fnAFM43OMfX0eUbjcv8FE0+blB
         7WzuZ3luopqlqQ3CLP+//cnVWFcOdnD8mg6JYjBOEJTSNS+IJ7mXhpVX/ZykYfn3F2Kb
         BmDJ/ZGJn8QhyQlpD0dkGWCoLyLYFyNkDsMoXbxsy4M9J17gyVbrVTWFm8rNkGTNiCjt
         YEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q6zTyc1nJv74vcvWUitF7l7G4qhmg90JLY7Dww6BU2M=;
        b=AAaCW9idlngNafTSrz7DNSVHWcz+T/tDpvQkTwdVDYxJy4JRmCBzxMi3xA1ednVPfQ
         LAgGe0b5XeSfPZAXTW8k5MvYuF9swS50RRWOvEIReQ1JMEJdPJLfIvcZIsdrS6mgKJ+/
         fJ3nWhm6fF3eBnmCd5xmN1USiz6Q4mg8ACXtfwjdwOtfkf77AghCfJhVIM07pprVSnnz
         LYRJCMMZ5cr4FuzI4+NrgIMbHlqESZIBK5GQbOCD0IA1pEGaMn3zZRMhunH4Q9YYOCZM
         h3UF9muqedwJZIFfQ7Pm1P5AxYqzo7vP/ZedduzdYqjEd+jy9Ma39Z1cU7is/YJHd/c7
         YiNQ==
X-Gm-Message-State: APjAAAVhwyMw9Zy8sysdGP/Cyq9kIK8bwmkLbsIVtbtm0h44ZlHOYIMI
        KuMGPCgkr6Mt5u2qwG9FWsc=
X-Google-Smtp-Source: APXvYqzuBu3lAhBxTAQpWu9qrEW9LmiH0SxWOGf/XoqbG/JYoGdIN8FmDpjEURl3KtjESfKXkb8GMw==
X-Received: by 2002:a63:1e0b:: with SMTP id e11mr15175199pge.402.1562171313251;
        Wed, 03 Jul 2019 09:28:33 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id e11sm6589912pfm.35.2019.07.03.09.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:28:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 10/35] macintosh: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:28:21 +0800
Message-Id: <20190703162821.32322-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/macintosh/adbhid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 75482eeab2c4..5d14bebfb58f 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -789,7 +789,8 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 	switch (default_id) {
 	case ADB_KEYBOARD:
-		hid->keycode = kmalloc(sizeof(adb_to_linux_keycodes), GFP_KERNEL);
+		hid->keycode = kmemdup(adb_to_linux_keycodes,
+			sizeof(adb_to_linux_keycodes), GFP_KERNEL);
 		if (!hid->keycode) {
 			err = -ENOMEM;
 			goto fail;
@@ -797,8 +798,6 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 		sprintf(hid->name, "ADB keyboard");
 
-		memcpy(hid->keycode, adb_to_linux_keycodes, sizeof(adb_to_linux_keycodes));
-
 		switch (original_handler_id) {
 		default:
 			keyboard_type = "<unknown>";
-- 
2.11.0

