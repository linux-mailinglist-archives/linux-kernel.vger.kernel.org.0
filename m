Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB1E3716
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409831AbfJXPyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:23 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54374 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409778AbfJXPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:20 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsJjC026761
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:19 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsDde023039
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:19 -0400
Received: by mail-qt1-f198.google.com with SMTP id q54so23078485qtk.15
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HC8F6K721XcrFfe6PL9r+w9DRvlfMBW1HH2bOAKZbBk=;
        b=BOA9WECu67U4Gh2I37L1/gvVg/XSjGxd+p6umrTV0ViAbmpmaSxm+YBzsOoIBPC9RP
         XuI95++ipRuJK0SSXzj3yGN/7Fx9zSV8m6jZAgtXvc9wz4AXYxqmzlUEE6YeM65j3hMX
         MrevyAyVhwC5lRxIVrWAWTpTNvdt/Ge5vsyaBOzhuejxEeITUOAp12lwshcgarLUa7sb
         uSTmO8eRAigySIAAodnUgvLcpLXm1EtaFRS2Lw08gNaxcNfcZvs+WG9G6+1OVPNE7ht1
         a2+fBnDYQxgJ98wgreQ4yDdvpuboqaMF3EQy4iAaas+frCCdFCCp1FzgietOyW8Imfan
         2N1g==
X-Gm-Message-State: APjAAAUfo6w9H7DayIIjM3oTg0W+gq3DUeCIXQLAKo3KGdQP/JmuDL7V
        NqmXYLQ5ac38MMMHF5UndGq8s0tHw/Lvimxim1Xmt6Rzlcfn/mUVsyJY/XKxDKEx+nOMj0BfIKp
        Az9Ajjgjd9VexXlu/pZqi8ZZQi2mD5jruU0k=
X-Received: by 2002:a05:620a:a8d:: with SMTP id v13mr2276826qkg.113.1571932453735;
        Thu, 24 Oct 2019 08:54:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzXZCBzmmQ+hEAhyBvlB5KizY+kshvHx0pXuyB03RkLB5Z9bOBJFYlqXoD+NPrxM3nFlZCkw==
X-Received: by 2002:a05:620a:a8d:: with SMTP id v13mr2276794qkg.113.1571932453397;
        Thu, 24 Oct 2019 08:54:13 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:12 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] staging: exfat: Clean up return codes - FFS_PERMISSIONERR
Date:   Thu, 24 Oct 2019 11:53:15 -0400
Message-Id: <20191024155327.1095907-5-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_PERMISSIONERR to -EPERM

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index ec52237b01cd..86bdcf222a5a 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -217,7 +217,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_INVALIDPATH         7
 #define FFS_INVALIDFID          8
 #define FFS_FILEEXIST           10
-#define FFS_PERMISSIONERR       11
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 566cfba0a522..fd5d8ba0d8bc 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -702,7 +702,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 
@@ -832,7 +832,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 
@@ -1079,7 +1079,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 
@@ -1246,7 +1246,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	/* check if the old file is "." or ".." */
 	if (p_fs->vol_type != EXFAT) {
 		if ((olddir.dir != p_fs->root_dir) && (dentry < 2)) {
-			ret = FFS_PERMISSIONERR;
+			ret = -EPERM;
 			goto out2;
 		}
 	}
@@ -1258,7 +1258,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	}
 
 	if (p_fs->fs_func->get_entry_attr(ep) & ATTR_READONLY) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out2;
 	}
 
@@ -1365,7 +1365,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 	}
 
 	if (p_fs->fs_func->get_entry_attr(ep) & ATTR_READONLY) {
-		ret = FFS_PERMISSIONERR;
+		ret = -EPERM;
 		goto out;
 	}
 	fs_set_vol_flags(sb, VOL_DIRTY);
@@ -1947,7 +1947,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_DIR)
-		return FFS_PERMISSIONERR;
+		return -EPERM;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -2145,7 +2145,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	/* check if the file is "." or ".." */
 	if (p_fs->vol_type != EXFAT) {
 		if ((dir.dir != p_fs->root_dir) && (dentry < 2))
-			return FFS_PERMISSIONERR;
+			return -EPERM;
 	}
 
 	/* acquire the lock for file system critical section */
@@ -2526,7 +2526,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
 	if (err) {
-		if (err == FFS_PERMISSIONERR)
+		if (err == -EPERM)
 			err = -EPERM;
 		else
 			err = -EIO;
@@ -2746,7 +2746,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
 			  new_dentry);
 	if (err) {
-		if (err == FFS_PERMISSIONERR)
+		if (err == -EPERM)
 			err = -EPERM;
 		else if (err == FFS_INVALIDPATH)
 			err = -EINVAL;
-- 
2.23.0

