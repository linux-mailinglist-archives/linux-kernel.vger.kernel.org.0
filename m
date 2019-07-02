Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93B65CA3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBIBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 04:01:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35935 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfGBIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:01:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so7287223pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZHcFy8+cGz5oukfe2+7Nj7Asc0mXW015dvqvbJgrv0Y=;
        b=UkhMHts/IVSYoKasfWnD8cy7ILwQLYzR5aqdURsriXt4IU7MUXkqljj4hfpqoBHiqs
         hdjfcUyDOhDJsPImS0tJMdzZFHOYaG90wN5tvSIg96yAhUO7NgH2LckAGaxSwrYF6sBf
         RjqSgICeCVwjiRQmPNMNJSnYg6qmBzA83GckApnOqvpEuTt34LxspurUsRbWyOY2BTpY
         mKtfxXT9FPoR+45IoBkDoV0Nktfad+0aKxBkixH1uqhUaxYTXkxNK3BEQMxecCX0Lr+n
         7wtgirEeM6ZsFQCt2eDGwxmb21cPhY4Zynkmf7gGnF1iRhwJjMfEVWMX1ygLGPOSMJF3
         A7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZHcFy8+cGz5oukfe2+7Nj7Asc0mXW015dvqvbJgrv0Y=;
        b=VMrlkLwxh4V8W9mJbrOwoz8Oz7FluYrTr0Txen+0rYf42dFNDeBd/eo5yB4hlW3rAH
         wULDSZFUT4Op+DZl5lM70Is01NkwAW1NaMsBGtsHhQYUX7MByiZHwkyDQ5fvwFoka3L8
         aZ5dZkCL6GhP3/h/ygnOc7o79/UuVec5NfsS5ZC25NVydHJc6fchiif9P4e6RpVDZPiy
         6sX0fY65ua7sYZZEa4y5lbQYolOuB6vxnW3zhnyvct0FShmkGA0C/hx9v+71N7pbAh0T
         1ZFyIV5QC4CuBWlmy8OilW68xSPcWm6LKvsrtCJ4WebiUzWz/70AEG1FTtLsDjwnp+oB
         IFuQ==
X-Gm-Message-State: APjAAAXCmXhNFlMVFB3s+NzIhBNC16/BvjNEaSwXQLs88oF+Zy9Xwuwp
        wgpHgZSyTCUOQ2/JzPzNobjP6wHPGHY=
X-Google-Smtp-Source: APXvYqyUCWnRapNIkdfOhc3lDQkKtngNOCTwli64t9i6nLCSXFA5hvaNs90kPt3DnT17gMljZ7p3iA==
X-Received: by 2002:a17:90a:2567:: with SMTP id j94mr4053582pje.121.1562054468392;
        Tue, 02 Jul 2019 01:01:08 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t96sm1527001pjb.1.2019.07.02.01.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:01:08 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 10/27] md: use kzalloc instead of kmalloc and memset
Date:   Tue,  2 Jul 2019 16:01:00 +0800
Message-Id: <20190702080100.24884-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc followed by a memset with kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 drivers/md/dm-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 44e76cda087a..f5db89b28757 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3358,7 +3358,7 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 				goto bad;
 			}
 
-			crypt_iv = kmalloc(ivsize, GFP_KERNEL);
+			crypt_iv = kzalloc(ivsize, GFP_KERNEL);
 			if (!crypt_iv) {
 				*error = "Could not allocate iv";
 				r = -ENOMEM;
@@ -3387,7 +3387,6 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 				sg_set_buf(&sg[i], va, PAGE_SIZE);
 			}
 			sg_set_buf(&sg[i], &ic->commit_ids, sizeof ic->commit_ids);
-			memset(crypt_iv, 0x00, ivsize);
 
 			skcipher_request_set_crypt(req, sg, sg,
 						   PAGE_SIZE * ic->journal_pages + sizeof ic->commit_ids, crypt_iv);
-- 
2.11.0

