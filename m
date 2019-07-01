Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193391C29F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 07:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfENFxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 01:53:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38642 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 01:53:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id 14so13121305ljj.5;
        Mon, 13 May 2019 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bM8hX4jppxiiULCsRqeT+54oxj9AT3t2fWeo8Qg5H18=;
        b=Dob32DPoL28AKLt8YMC5ibe91NtjpjbzGPVHHk8989EBn9rOV27UBxAiE9y5p9T1nE
         fLc3Sk2ckq+3v/VDhuZq67lIbfDE/2xLNa1ul3s+hN0SwcrsPQHePrwWRU5SmASrF2wB
         Kceqql6z0YU/4HAP2PxGQWot0rJDixIGSMhwGOPWTew8N/0DB7dLXkUmXEqbtYvRgaz2
         v8ZTqlPv+do87EQ162FcrGCOXmTMDMEs8abJno+7PblkZCcjMpNCVO/ctt8bg2R6/alF
         1sjQxbH36CWqJj3CGd7c3FX7clQxVFQl6IeQBFqff3zmwClmL65/2YePRBj8FfXLrmyF
         DtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bM8hX4jppxiiULCsRqeT+54oxj9AT3t2fWeo8Qg5H18=;
        b=s4pV+oDnGi5BlFcgpiKPxTQg+G2Fds/j2wGKSlUYbEYGLBn3hgtyBwpIJKC8Ws5TBN
         3J7pFTj4t+6jpxKNimwP1nWzAdfiTkDaMiyA+1xizdIbfGq+ZndRqemYBCpS8PBC2r9f
         Pu07Au6CZ8hU155puyZwq7G/VNntQSqcRkNxdd6PbhRO+TwgESKwWk7q2OfOjimmzxOs
         WOitFjHyboSNtfHBR2vG7vqVktLHogpuXE/6OTfvkuN1oRvz5eMaq+1yGBRWIrPVLFMo
         IL6IowLADixISfqRIponMNpi/KON2bHMAARwJUUgYfmG2TrNJaLrCblabImz8gYQ8dlJ
         9wQA==
X-Gm-Message-State: APjAAAX5lIdTZmpbdPiVMrfthGPh1gxqqyC5yGa0M92Q6icXhAydvL88
        m8L+6mVc8HnyV35YMZNKEfQ=
X-Google-Smtp-Source: APXvYqzuGAt6PH1pi+yzKaxNkn0AG7TBFPHbW5+hx5CYlVXf4WXfqqLPsFmrqnUUKbHAmIvFhV4ftQ==
X-Received: by 2002:a2e:89cc:: with SMTP id c12mr11613738ljk.90.1557813214576;
        Mon, 13 May 2019 22:53:34 -0700 (PDT)
Received: from k8s-master.localdomain (kovt.soborka.net. [94.158.152.75])
        by smtp.googlemail.com with ESMTPSA id y7sm3465555ljj.34.2019.05.13.22.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 22:53:33 -0700 (PDT)
From:   Kovtunenko Oleksandr <alexander198961@gmail.com>
To:     sfrench@samba.org
Cc:     linux-kernel@vger.kernel.org, samba-technical@lists.samba.org,
        linux-cifs@vger.kernel.org,
        Kovtunenko Oleksandr <alexander198961@gmail.com>
Subject: [PATCH] Fixed  https://bugzilla.kernel.org/show_bug.cgi?id=202935 allow write on the same file
Date:   Tue, 14 May 2019 05:52:34 +0000
Message-Id: <1557813154-6663-1-git-send-email-alexander198961@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kovtunenko Oleksandr <alexander198961@gmail.com>
---
 fs/cifs/cifsfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index a05bf1d..2964438 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1073,11 +1073,6 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 
 	cifs_dbg(FYI, "copychunk range\n");
 
-	if (src_inode == target_inode) {
-		rc = -EINVAL;
-		goto out;
-	}
-
 	if (!src_file->private_data || !dst_file->private_data) {
 		rc = -EBADF;
 		cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");
-- 
1.8.3.1

