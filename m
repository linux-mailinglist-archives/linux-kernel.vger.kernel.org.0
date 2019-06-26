Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C772256750
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 13:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFZLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 07:00:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45860 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:00:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi6so1237903plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VdhU2ks81jo9UrjXZOm8gn8RMZx/sg7VdDnqoRepyqE=;
        b=rBDF2IbhJqsbejWYMTlxvc33psvRPXREmLlH1kdj1sffS2GEpRGBd/3KU+XhYKueKo
         X+EQyfMddlzhcC9Tl0wzQORvQ1bW66K6b0gsa9wt3R6/H1Axhm8w2kKwnFbpwFlcOdvz
         6tRlrliU4HwUEcR9KZQ09pXc+vpCSgC2wdEePTtVVRRSlKeQQ5s81RkbDssKTwnhZneg
         ct0dmSY17I3QbZ/5SUFm/H3tyoEyMLNhw2PFHI+ZNJscDX4J3xybD9YWMs9gYK+2Op7/
         en73nUmQ3xiIIGmzxayHgcccJ8POvkUb5YkUA2t14LWTKWYmjBgHKbXO17UO+1IBF+8j
         MZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VdhU2ks81jo9UrjXZOm8gn8RMZx/sg7VdDnqoRepyqE=;
        b=bWUH4DUZNrqe6lEHOYUnimFaLN6rH26q5xYZ5aH7Xs3Jf7F+YYcBsoKoDINN+p5/z6
         yTdwYCKtgKDdM582trlm7iTgrEK0ZgdR5hkElK1By9oXXvi00rxchYDlJLhxh9AbPJ7F
         5ZR+AZRtOEC8a9GIaeIQqISPrZvcAlJ01dY4JI78S6jMAIA2zBn7knKXEeP+TuQ+hHJJ
         U08vps9DckeaA4P8xTf/EXzKGrn0NSMe2Bk0Qi/nfqttAByVyq03ezPiaPSZq4Jjr1NR
         eYLkY3s0oKI3HOm+6fhYRJZT/hdkjZNFNEYoF4XQf3PfxppjbqKZnrKBecZifVz9w6eY
         v4Ag==
X-Gm-Message-State: APjAAAXrxBaddc6LVB422rwShSY09zpVYVQh4/UIjGed43VMSwWP6ZBk
        z84nMIw+gpR3AViiMff3ioQ=
X-Google-Smtp-Source: APXvYqzBd85hjMi95y7wvZswP72zOfwbAYxL/u39AlDoY64MjcDYg9no5lCwuw6Hum4qX/JCV/hAtQ==
X-Received: by 2002:a17:902:542:: with SMTP id 60mr4831596plf.68.1561546846595;
        Wed, 26 Jun 2019 04:00:46 -0700 (PDT)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id w187sm19008873pfb.4.2019.06.26.04.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 04:00:45 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH RESEND v2] staging: erofs: remove unsupported ->datamode check in fill_inline_data()
Date:   Wed, 26 Jun 2019 19:00:32 +0800
Message-Id: <20190626110032.3688-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Already check if ->datamode is supported in read_inode(), no need to check
again in the next fill_inline_data() only called by fill_inode().

Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
v2: add tags.

 drivers/staging/erofs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f..d6e1e16 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	const int mode = vi->datamode;
 
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
-
 	/* should be inode inline C */
 	if (mode != EROFS_INODE_LAYOUT_INLINE)
 		return 0;
-- 
1.9.1

