Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225B575D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 05:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfGZDhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 23:37:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45119 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZDhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:37:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so23774901pfq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M/dmflRr/NepNopOSDC4tuzevpZEc0NIjlEXnYoSWJE=;
        b=esnI3VZO3PmynZHGPx0Whcmwt7ECIQGYdGt72S+UxlO4n0TFKPWFLghGQOp0XLlV9/
         63GPEcLkupA6ZReN2ONNnPrUKTN/JJX0xpFNfzuYabRttbwnSL74TeTv4r5HS2/i1QLI
         uXSTmq1cN3YhM2Kx3DdogzC1uQGOcBTSGwe+jZvNS/74E/9XYE0U8zQ1MSKC4bBy/INv
         x7CkVbiUsxHGlWTmmMzbnYK/9JQ4TQ0QR3N3WvhRr3vb0bCnTi7tgtNe3VzHy/2qFH3I
         AKuBohqfInn1+bpeZdnGKy047+u2pAln1QzRVvuPUf1Y9JIuWffDwwlgGjDRLN8uEHlG
         piEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M/dmflRr/NepNopOSDC4tuzevpZEc0NIjlEXnYoSWJE=;
        b=GfGWoPLcerEX557e61kb18mvGrkAJqqEyC0HM+/oIFRI2/k9KMD4pBhvgM3g3az3Jm
         wxBAOo4ohJ3Yxn2u89D2Ue8xXOuVpj9tnZVL/Uad56WZBEbKKO0LF11PoR1VDMoxTQQ6
         RpBWYYQMWSfw6wGBMrm37dl75eL0s0f6nGK3WOhsXp4J1VCvaLe01rTl6ZOeQ7Wvfrk0
         ijSQZB5oyQdsA/Dxx5I8Auc34Azs0zUIA6fTRswozZ/sfmMiOl/WIQ3aulLzQaKDj2sp
         A/ODxWBA0GuIfU3jpkAUHYB0ajYxO+HnzVTisjjlJnD1a9QA7SM0RQrTbxSYPwxy4Pce
         WqqA==
X-Gm-Message-State: APjAAAUnhBFNtQNItmaHzRluZh9HwC41TemMgx5p9e7NqvXft1gC5KwH
        +WeRg+CzNGmmYDyGXbly7Ek=
X-Google-Smtp-Source: APXvYqyxHHhDfFUrRQkI3z0haOW9QjFe/dnSiw7HRTJmE65MHylzj2memzoR/een6PTG31Mr0qHpiQ==
X-Received: by 2002:aa7:8e17:: with SMTP id c23mr20005240pfr.227.1564112232125;
        Thu, 25 Jul 2019 20:37:12 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id p20sm81487393pgj.47.2019.07.25.20.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 20:37:11 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/3] fs: ocfs2: Fix a possible null-pointer dereference in ocfs2_write_end_nolock()
Date:   Fri, 26 Jul 2019 11:37:05 +0800
Message-Id: <20190726033705.32307-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ocfs2_write_end_nolock(), there are an if statement on lines 1976, 
2047 and 2058, to check whether handle is NULL:
    if (handle)

When handle is NULL, it is used on line 2045:
	ocfs2_update_inode_fsync_trans(handle, inode, 1);
        oi->i_sync_tid = handle->h_transaction->t_tid;

Thus, a possible null-pointer dereference may occur.

To fix this bug, handle is checked before calling
ocfs2_update_inode_fsync_trans().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/ocfs2/aops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index a4c905d6b575..5473bd99043e 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2042,7 +2042,8 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 		di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
 		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
-		ocfs2_update_inode_fsync_trans(handle, inode, 1);
+		if (handle)
+			ocfs2_update_inode_fsync_trans(handle, inode, 1);
 	}
 	if (handle)
 		ocfs2_journal_dirty(handle, wc->w_di_bh);
-- 
2.17.0

