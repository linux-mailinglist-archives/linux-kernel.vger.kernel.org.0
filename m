Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA5418E11D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCUMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 08:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUMUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:20:00 -0400
Received: from localhost.localdomain (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308B020722;
        Sat, 21 Mar 2020 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584793199;
        bh=dAEeJBsBD8vPgIWoHtkB7iVfjDZMwlGNTPBlVTUgEyo=;
        h=From:To:Cc:Subject:Date:From;
        b=KQm646WSgVFJGEc8ROvdcbEXR7+q9y6Iuhid9lNRfvqAriTzuCIikvr5d0sHjMgV0
         oTDapfUuoeOfOqi9iE8Z2zgkUv5ZDh0WEFbiVKqZUZemvHZ8lXThAlYaSh8MQvvfFV
         Qclgk9KXTBQoucmzHypwjXFLik4SPjwZIWsM/rFA=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: clean up f2fs_may_encrypt()
Date:   Sat, 21 Mar 2020 20:19:33 +0800
Message-Id: <20200321121933.22297-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Merge below two conditions into f2fs_may_encrypt() for cleanup
- IS_ENCRYPTED()
- DUMMY_ENCRYPTION_ENABLED()

Check IS_ENCRYPTED(inode) condition in f2fs_init_inode_metadata()
is enough since we have already set encrypt flag in f2fs_new_inode().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- remove unneeded check condition in f2fs_init_inode_metadata() suggested
by Eric.
 fs/f2fs/dir.c   |  4 +---
 fs/f2fs/f2fs.h  | 13 +++++++++----
 fs/f2fs/namei.c |  4 +---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 0971ccc4664a..44bfc464df78 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -471,7 +471,6 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 			struct page *dpage)
 {
 	struct page *page;
-	int dummy_encrypt = DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(dir));
 	int err;
 
 	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
@@ -498,8 +497,7 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 		if (err)
 			goto put_error;
 
-		if ((IS_ENCRYPTED(dir) || dummy_encrypt) &&
-					f2fs_may_encrypt(inode)) {
+		if (IS_ENCRYPTED(inode)) {
 			err = fscrypt_inherit_context(dir, inode, page, false);
 			if (err)
 				goto put_error;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 09db79a20f8e..fcafa68212eb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3946,15 +3946,20 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
 }
 
-static inline bool f2fs_may_encrypt(struct inode *inode)
+static inline bool f2fs_may_encrypt(struct inode *dir, struct inode *inode)
 {
 #ifdef CONFIG_FS_ENCRYPTION
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	umode_t mode = inode->i_mode;
 
-	return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
-#else
-	return false;
+	/*
+	 * If the directory encrypted or dummy encryption enabled,
+	 * then we should encrypt the inode.
+	 */
+	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi))
+		return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
 #endif
+	return false;
 }
 
 static inline bool f2fs_may_compress(struct inode *inode)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b75c70813f9e..95cfbce062e8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -75,9 +75,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	set_inode_flag(inode, FI_NEW_INODE);
 
-	/* If the directory encrypted, then we should encrypt the inode. */
-	if ((IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) &&
-				f2fs_may_encrypt(inode))
+	if (f2fs_may_encrypt(dir, inode))
 		f2fs_set_encrypted_inode(inode);
 
 	if (f2fs_sb_has_extra_attr(sbi)) {
-- 
2.22.0

