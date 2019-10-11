Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3BD4127
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfJKN3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 09:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfJKN3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:29:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197992053B;
        Fri, 11 Oct 2019 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800579;
        bh=FT9KtEdwX4w508YLS0mCRmB5GkJMnczDIx1mCy7Pq9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLLyZGTzYHwfNFxDt79XiKo1af9x0jW9lDEOk0vgF7TLN6Zct6NVPlC6RTwSyPL7k
         c/hUXo0lXyblyTHJ0iM0W9E2cevVi8HSZUluvAK7N5Q675+FaA2YZpJH45tblMCpdp
         7ZZQqfCTwcAxT0Mb67eFQC0JrYLW4gQyMewAhZ1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/8] debugfs: remove return value of debugfs_create_u16()
Date:   Fri, 11 Oct 2019 15:29:25 +0200
Message-Id: <20191011132931.1186197-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
References: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_u16(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     | 15 +++------------
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index c146f18eb8ac..6abcf41fbd37 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -70,8 +70,8 @@ created with any of:
 
     void debugfs_create_u8(const char *name, umode_t mode,
 			   struct dentry *parent, u8 *value);
-    struct dentry *debugfs_create_u16(const char *name, umode_t mode,
-				      struct dentry *parent, u16 *value);
+    void debugfs_create_u16(const char *name, umode_t mode,
+			    struct dentry *parent, u16 *value);
     struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				      struct dentry *parent, u32 *value);
     struct dentry *debugfs_create_u64(const char *name, umode_t mode,
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 2d5d9a0a6f57..8091a7ef3589 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -456,20 +456,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_u16_wo, NULL, debugfs_u16_set, "%llu\n");
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value %ERR_PTR(-ENODEV) will
- * be returned.
  */
-struct dentry *debugfs_create_u16(const char *name, umode_t mode,
-				  struct dentry *parent, u16 *value)
+void debugfs_create_u16(const char *name, umode_t mode, struct dentry *parent,
+			u16 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u16,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_u16,
 				   &fops_u16_ro, &fops_u16_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_u16);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 8e071f599245..c83a33a76b6c 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -99,8 +99,8 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 
 void debugfs_create_u8(const char *name, umode_t mode, struct dentry *parent,
 		       u8 *value);
-struct dentry *debugfs_create_u16(const char *name, umode_t mode,
-				  struct dentry *parent, u16 *value);
+void debugfs_create_u16(const char *name, umode_t mode, struct dentry *parent,
+			u16 *value);
 struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 				  struct dentry *parent, u32 *value);
 struct dentry *debugfs_create_u64(const char *name, umode_t mode,
@@ -247,12 +247,8 @@ static inline struct dentry *debugfs_rename(struct dentry *old_dir, struct dentr
 static inline void debugfs_create_u8(const char *name, umode_t mode,
 				     struct dentry *parent, u8 *value) { }
 
-static inline struct dentry *debugfs_create_u16(const char *name, umode_t mode,
-						struct dentry *parent,
-						u16 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_u16(const char *name, umode_t mode,
+				      struct dentry *parent, u16 *value) { }
 
 static inline struct dentry *debugfs_create_u32(const char *name, umode_t mode,
 						struct dentry *parent,
-- 
2.23.0

