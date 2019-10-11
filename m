Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED09D413A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfJKN37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 09:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfJKN35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:29:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF1A2053B;
        Fri, 11 Oct 2019 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570800595;
        bh=Dd+5csIwFVYd/T5NWLwlErQHnZr3/z+Nq90zNk4eixo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRLkwxED+qLJsD6Lh/mG+B4pVP7hpKMa2gXsJRrRA8I4OFplPiI9L3rYpSwy3MbTP
         OzOSnyMxmAwIbrpqPPVn11QaiYljZudpRAA7Q2u60eTDvQGgAJjGrWXo2GsEwHntt/
         mfJZ429HLvtdargLc65lLC0r1S4L68zHb2HzjsEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/8] debugfs: remove return value of debugfs_create_x16()
Date:   Fri, 11 Oct 2019 15:29:29 +0200
Message-Id: <20191011132931.1186197-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
References: <20191011132931.1186197-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_x16(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.txt |  4 ++--
 fs/debugfs/file.c                     |  6 +++---
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 2c4ea9b73572..674ce905b7f7 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -84,8 +84,8 @@ the following functions can be used instead:
 
     void debugfs_create_x8(const char *name, umode_t mode,
 			   struct dentry *parent, u8 *value);
-    struct dentry *debugfs_create_x16(const char *name, umode_t mode,
-				      struct dentry *parent, u16 *value);
+    void debugfs_create_x16(const char *name, umode_t mode,
+			    struct dentry *parent, u16 *value);
     struct dentry *debugfs_create_x32(const char *name, umode_t mode,
 				      struct dentry *parent, u32 *value);
     struct dentry *debugfs_create_x64(const char *name, umode_t mode,
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 693c9336b040..046426db4644 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -651,10 +651,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_x8);
  * @value: a pointer to the variable that the file should read to and write
  *         from.
  */
-struct dentry *debugfs_create_x16(const char *name, umode_t mode,
-				 struct dentry *parent, u16 *value)
+void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
+			u16 *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x16,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_x16,
 				   &fops_x16_ro, &fops_x16_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_x16);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 70d38dc6b151..d081f51defd5 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -109,8 +109,8 @@ struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
 				    struct dentry *parent, unsigned long *value);
 void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
 		       u8 *value);
-struct dentry *debugfs_create_x16(const char *name, umode_t mode,
-				  struct dentry *parent, u16 *value);
+void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
+			u16 *value);
 struct dentry *debugfs_create_x32(const char *name, umode_t mode,
 				  struct dentry *parent, u32 *value);
 struct dentry *debugfs_create_x64(const char *name, umode_t mode,
@@ -271,12 +271,8 @@ static inline struct dentry *debugfs_create_ulong(const char *name,
 static inline void debugfs_create_x8(const char *name, umode_t mode,
 				     struct dentry *parent, u8 *value) { }
 
-static inline struct dentry *debugfs_create_x16(const char *name, umode_t mode,
-						struct dentry *parent,
-						u16 *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_x16(const char *name, umode_t mode,
+				      struct dentry *parent, u16 *value) { }
 
 static inline struct dentry *debugfs_create_x32(const char *name, umode_t mode,
 						struct dentry *parent,
-- 
2.23.0

