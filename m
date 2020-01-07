Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A34131DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 03:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgAGCdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 21:33:45 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:41196 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgAGCdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:33:44 -0500
Received: by mail-qv1-f73.google.com with SMTP id u11so28509556qvo.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 18:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uDgGy4N5DtOaHRxIX87XlNisoWOld356Gqw2viQP+Cg=;
        b=GX2yPf97uYJ0DPsuAbjJiyRHt51aJEZzqcqZIcsevRT++LLQJUdvI4TYzJ5A7N8Pdv
         rLLSMt9pTbyQGc/KxO/MPhnl/ccD6LCaylu8LIXAvBaOSDEarCxs5antUNl6ob59pTxO
         /GK/LerdisX9BSTUZ8O7b/HDB0hK+bKFFr3tIzgUeWqKm+zeLtHbkrqtOfreCHOV77vk
         Ogid1uLmTo42YP3ImEMC3IkV9lG/iDuOZUPQytqPXodTv4dNbwRAoj0apAbQ3qyxkNh0
         xr6LcOkLPvBwVdb+kIhbWCewiXoDB5iZl+w+xU8S+3P1d/eShQAj4m1M3VAYgaJT2AI6
         h1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uDgGy4N5DtOaHRxIX87XlNisoWOld356Gqw2viQP+Cg=;
        b=nXWnG2XarniXLsZC3PbEQ+JRZLJOQI3HAvzoCQUwnGZ5MgQyF0vvUA5iRt9lCtUwAx
         prvRXJXmw+EAQ5vLXm6xKxZuk9+PuT546SgL+j/8rmdTB7Kj2GVhwaT1sBBj9qfNXjCQ
         G4WI55rmowW1U+07zcc43pRM1LtwvMfddqk9wF9Pm3XVosNdZLQ8ZAA7l9HV+LG138Hi
         ZkXOtka3ITJT26FBW1dHNKXyOBJY51k+kpJywlZ/obqzwyUYj3g8VLdf7XwJIirAmmuI
         7HkFeWpXR8orIzT+EL9yUWpoEWG3PQZb6/jla+IV/r3fqp5WvbFSKwLH7yWZxdJEzsll
         fu/Q==
X-Gm-Message-State: APjAAAUXlto/y+TcQhtdZjjYVUgnnYTrAtnz2iLLCuDDA6RyXYRVtDZQ
        uPUwxy4MUgpRn2mbgz9L/vnCEbSpCVA=
X-Google-Smtp-Source: APXvYqxLQJi+pvRpSXTlckecgXNJr0DUPtu42xLMPCNoQAZRXqAYa9bgLpEC5ZxaN47fWYeCKLaDXCZan7Q=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr77460446qtr.7.1578364422392;
 Mon, 06 Jan 2020 18:33:42 -0800 (PST)
Date:   Mon,  6 Jan 2020 18:33:22 -0800
In-Reply-To: <20200107023323.38394-1-drosen@google.com>
Message-Id: <20200107023323.38394-3-drosen@google.com>
Mime-Version: 1.0
References: <20200107023323.38394-1-drosen@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 2/3] fscrypt: Don't allow v1 policies with casefolding
From:   Daniel Rosenberg <drosen@google.com>
To:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casefolding currently requires a derived key for computing the siphash.
This is available for v2 policies, but not v1, so we disallow it for v1.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/keysetup.c    |  7 ++++---
 fs/crypto/policy.c      | 39 +++++++++++++++++++++++++++++++++++++++
 fs/inode.c              |  7 +++++++
 include/linux/fscrypt.h | 11 +++++++++++
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index c1bd897c9310..7445ab76e0b3 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -224,10 +224,11 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 					  FS_KEY_DERIVATION_NONCE_SIZE,
 					  (u8 *)&ci->ci_hash_key,
 					  sizeof(ci->ci_hash_key));
-		if (!err)
-			ci->ci_hash_key_initialized = true;
+		if (err)
+			return err;
+		ci->ci_hash_key_initialized = true;
 	}
-	return err;
+	return 0;
 }
 
 /*
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index f1cff83c151a..9e937cfa732c 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -124,6 +124,12 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 					policy->filenames_encryption_mode))
 		return false;
 
+	if (IS_CASEFOLDED(inode)) {
+		fscrypt_warn(inode,
+			     "v1 policy does not support casefolded directories");
+		return false;
+	}
+
 	return true;
 }
 
@@ -579,3 +585,36 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	return preload ? fscrypt_get_encryption_info(child): 0;
 }
 EXPORT_SYMBOL(fscrypt_inherit_context);
+
+static int fscrypt_set_casefolding_allowed(struct inode *inode)
+{
+	union fscrypt_policy policy;
+	int err = fscrypt_get_policy(inode, &policy);
+
+	if (err)
+		return err;
+
+	if (policy.version != FSCRYPT_POLICY_V2)
+		return -EINVAL;
+
+	return 0;
+}
+
+int fscrypt_ioc_setflags_prepare(struct inode *inode,
+				 unsigned int oldflags,
+				 unsigned int flags)
+{
+	int err;
+
+	/*
+	 * When a directory is encrypted, the CASEFOLD flag can only be turned
+	 * on if the fscrypt policy supports it.
+	 */
+	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
+		err = fscrypt_set_casefolding_allowed(inode);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/fs/inode.c b/fs/inode.c
index 96d62d97694e..77f3e6e2e934 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
+#include <linux/fscrypt.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
@@ -2242,6 +2243,8 @@ EXPORT_SYMBOL(current_time);
 int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 			     unsigned int flags)
 {
+	int err;
+
 	/*
 	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
 	 * the relevant capability.
@@ -2252,6 +2255,10 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
+	err = fscrypt_ioc_setflags_prepare(inode, oldflags, flags);
+	if (err)
+		return err;
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 1dfbed855bee..2c292f19c6b9 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -142,6 +142,10 @@ extern int fscrypt_ioctl_get_policy_ex(struct file *, void __user *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
+extern int fscrypt_ioc_setflags_prepare(struct inode *inode,
+					unsigned int oldflags,
+					unsigned int flags);
+
 /* keyring.c */
 extern void fscrypt_sb_free(struct super_block *sb);
 extern int fscrypt_ioctl_add_key(struct file *filp, void __user *arg);
@@ -383,6 +387,13 @@ static inline int fscrypt_inherit_context(struct inode *parent,
 	return -EOPNOTSUPP;
 }
 
+static inline int fscrypt_ioc_setflags_prepare(struct inode *inode,
+					       unsigned int oldflags,
+					       unsigned int flags)
+{
+	return 0;
+}
+
 /* keyring.c */
 static inline void fscrypt_sb_free(struct super_block *sb)
 {
-- 
2.24.1.735.g03f4e72817-goog

