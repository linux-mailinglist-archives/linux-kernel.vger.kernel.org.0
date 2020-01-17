Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8CA14134F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgAQVnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 16:43:01 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56678 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAQVm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:42:58 -0500
Received: by mail-pf1-f201.google.com with SMTP id h16so15875064pfn.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oVzP1lZIn+a9St2ynepuCubjBDmFUsIeC3EfH/4msv0=;
        b=RpJE0vRPtcFs+HwS/CjBwBybBr/6ggom40mvJvh3ijp1Iwn3zl70sBx/gr77hKICJW
         Nn+3hy98ID7+xceD3nY1pqc5rDoxEghmYiE44KXjp1v7sduUZaJffqZjavDWKbbW1pj/
         zvMqLu9v53P+kYkQf1EpgyOjfRf8tsQbfxmgAGShQ1s6rZFM4SwNE46oSlcAgkg3Svdr
         ad7rWRKJhiWki92ARxOdBSMv6FVelFEk33fmbCruHpr2B6yfyyI10LPh0QAmz8hu4++A
         65C7CE4mGfBlm9wXLVFLOmGV4Yze3r2BmuwbO/sz0YHYhTB8AqWnQ++5Hr4sN0Yqr88Z
         QNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oVzP1lZIn+a9St2ynepuCubjBDmFUsIeC3EfH/4msv0=;
        b=UNpg2hWcZO1RswRziXaj/P64fyuLu38wk4dRkCAtV9KkiJJ1+f63Piexb8V7Wl/3vi
         PWH6TLg45RC+BW8O4z5WQRbp06DOiTSkZsyohqFadLwDKSFanfmc9kFuBp5pklyJ4VCO
         jRbCsgwmdXDnmMoUbQG32rRqvDQse2swU+iDkKVPE3d4nIUTYnLufwIATXmgWLoOdHWM
         7JB6rrQfoprkS8dYp7Q240bDpqW28Cv1V4DaROkmcBAPF78ghNjLLvI/d4vGlLLmbcWi
         wSPbapAWWGpKanfA+qYiP1uO0OQHNekQcM7d0ircdyt6368LdZZohWZpMIkMlLRNw75L
         tM/g==
X-Gm-Message-State: APjAAAVz2IFjRwFCro7gExhI1zF6yt+vcHYbLKxek4yR6+8bkjM3YkT8
        u2qE5ba6aGHkuUBoRD1t3LnpO17bJYQ=
X-Google-Smtp-Source: APXvYqyIgLp3Uf69UUUDJ12oPBO4Pke5blxqDXg302lLv/U33gnMRHUKpFqg0f+AuwAB8CavAzgqN8TQNc0=
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr46768529pgv.55.1579297377257;
 Fri, 17 Jan 2020 13:42:57 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:42:38 -0800
In-Reply-To: <20200117214246.235591-1-drosen@google.com>
Message-Id: <20200117214246.235591-2-drosen@google.com>
Mime-Version: 1.0
References: <20200117214246.235591-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 1/9] fscrypt: Add siphash and hash key for policy v2
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With encryption and casefolding, we cannot simply take the hash of the
ciphertext because of case insensitivity, and we can't take the hash of
the unencrypted name since that would leak information about the
encrypted name. Instead we can use siphash to compute a keyed hash of
the file names.

When a v2 policy is used on a directory, we derive a key for use with
siphash.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/crypto/fname.c           | 22 ++++++++++++++++++++++
 fs/crypto/fscrypt_private.h |  9 +++++++++
 fs/crypto/keysetup.c        | 35 +++++++++++++++++++++++++----------
 include/linux/fscrypt.h     |  9 +++++++++
 4 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3fd27e14ebdd6..371e8f01d1c8e 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -402,6 +402,28 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 }
 EXPORT_SYMBOL(fscrypt_setup_filename);
 
+/**
+ * fscrypt_fname_siphash() - Calculate the siphash for a file name
+ * @dir: the parent directory
+ * @name: the name of the file to get the siphash of
+ *
+ * Given a user-provided filename @name, this function calculates the siphash of
+ * that name using the directory's hash key.
+ *
+ * This assumes the directory uses a v2 policy, and the key is available.
+ *
+ * Return: the siphash of @name using the hash key of @dir
+ */
+u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
+{
+	struct fscrypt_info *ci = dir->i_crypt_info;
+
+	WARN_ON(!ci->ci_hash_key_initialized);
+
+	return siphash(name->name, name->len, &ci->ci_hash_key);
+}
+EXPORT_SYMBOL(fscrypt_fname_siphash);
+
 /*
  * Validate dentries in encrypted directories to make sure we aren't potentially
  * caching stale dentries after a key has been added.
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index b22e8decebedd..8b37a5eebb574 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -12,6 +12,7 @@
 #define _FSCRYPT_PRIVATE_H
 
 #include <linux/fscrypt.h>
+#include <linux/siphash.h>
 #include <crypto/hash.h>
 
 #define CONST_STRLEN(str)	(sizeof(str) - 1)
@@ -188,6 +189,13 @@ struct fscrypt_info {
 	 */
 	struct fscrypt_direct_key *ci_direct_key;
 
+	/*
+	 * With v2 policies, this can be used with siphash
+	 * When the key has been set, ci_hash_key_initialized is set to true
+	 */
+	siphash_key_t ci_hash_key;
+	bool ci_hash_key_initialized;
+
 	/* The encryption policy used by this inode */
 	union fscrypt_policy ci_policy;
 
@@ -262,6 +270,7 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 #define HKDF_CONTEXT_PER_FILE_KEY	2
 #define HKDF_CONTEXT_DIRECT_KEY		3
 #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
+#define HKDF_CONTEXT_FNAME_HASH_KEY     5
 
 extern int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 			       const u8 *info, unsigned int infolen,
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 96074054bdbc8..7445ab76e0b32 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -189,7 +189,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * This ensures that the master key is consistently used only
 		 * for HKDF, avoiding key reuse issues.
 		 */
-		return setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
 					  HKDF_CONTEXT_DIRECT_KEY, false);
 	} else if (ci->ci_policy.v2.flags &
 		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
@@ -199,21 +199,36 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
 		 * the IVs.  This format is optimized for use with inline
 		 * encryption hardware compliant with the UFS or eMMC standards.
 		 */
-		return setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
+		err = setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
 					  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
 					  true);
+	} else {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+					  HKDF_CONTEXT_PER_FILE_KEY,
+					  ci->ci_nonce,
+					  FS_KEY_DERIVATION_NONCE_SIZE,
+					  derived_key, ci->ci_mode->keysize);
+		if (err)
+			return err;
+
+		err = fscrypt_set_derived_key(ci, derived_key);
+		memzero_explicit(derived_key, ci->ci_mode->keysize);
 	}
-
-	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
-				  HKDF_CONTEXT_PER_FILE_KEY,
-				  ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE,
-				  derived_key, ci->ci_mode->keysize);
 	if (err)
 		return err;
 
-	err = fscrypt_set_derived_key(ci, derived_key);
-	memzero_explicit(derived_key, ci->ci_mode->keysize);
-	return err;
+	if (S_ISDIR(ci->ci_inode->i_mode)) {
+		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+					  HKDF_CONTEXT_FNAME_HASH_KEY,
+					  ci->ci_nonce,
+					  FS_KEY_DERIVATION_NONCE_SIZE,
+					  (u8 *)&ci->ci_hash_key,
+					  sizeof(ci->ci_hash_key));
+		if (err)
+			return err;
+		ci->ci_hash_key_initialized = true;
+	}
+	return 0;
 }
 
 /*
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 6fe8d0f96a4ac..1dfbed855beeb 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -172,6 +172,8 @@ extern int fscrypt_fname_disk_to_usr(const struct inode *inode,
 				     u32 hash, u32 minor_hash,
 				     const struct fscrypt_str *iname,
 				     struct fscrypt_str *oname);
+extern u64 fscrypt_fname_siphash(const struct inode *dir,
+				 const struct qstr *name);
 
 #define FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE	32
 
@@ -468,6 +470,13 @@ static inline int fscrypt_fname_disk_to_usr(const struct inode *inode,
 	return -EOPNOTSUPP;
 }
 
+static inline u64 fscrypt_fname_siphash(const struct inode *dir,
+					const struct qstr *name)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
 static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
 				      const u8 *de_name, u32 de_name_len)
 {
-- 
2.25.0.341.g760bfbb309-goog

