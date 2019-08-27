Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF85E9F468
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfH0UmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 16:42:20 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51588 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfH0UmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:42:19 -0400
Received: by mail-pl1-f202.google.com with SMTP id p9so189818pls.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=79V1gMu3mpRwfQnpXGlsn5QrZmPuAyWt8Xcf9P1KMvI=;
        b=oYrbQTm5JzHchAWZACmVa+5EhphTaf7rncLZMtRCVj/9s1HEFkbO3bEmR2kfdooPuv
         ng+AsxQex1ROIzHUDLi3CK1JAw+FBUTBzKkiicQ9jmBZiY4NsTmnJVcpFQRe64FcuSzA
         mFg3Lr4E3A9STh0Cb/aybAOYHYIJRJXdgSLaIRQBEpi5W/nIBfojVzEt4KuOKBBgcqL8
         UPt/vjVlofccmH2CGuYtmcU9zADVQUL12miZYnpf7UuSOkQfReg6+DyWUy09X35L461u
         1Uw885uwTh90ske1SDtXLd4xCi0Xmbia5AX2vKS7s7FxUFZEL66QYCDefNMk+Rr3mtYe
         OBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=79V1gMu3mpRwfQnpXGlsn5QrZmPuAyWt8Xcf9P1KMvI=;
        b=K0tkHh82JIf7K/pZfjolfK+LNWbFVfWHtdrhyeP+tLO2X1CuoV0GHCccQbNARBu67t
         kxBBZy+NcA9N8r6C4/cUo763WHZMlCQuwEaHBlGbihJR4jLv5H2Uv9OtVJmD98uQH4XS
         5ueQ8GA0dlaJvbaZ/44Zyyv3WvpdupmZjq+37s9wmuHO8U7KtSxvOVwqFgIn0ebqkE2g
         KOrmxOI+LTNcxgJow/octdHdeQXZMsgheqFC5+yVKNUuwtbB5EzfC3cJoVNudH/zYbjW
         ew5RHhOUmKP90b7LdehjcvMrZA6wieFUQFjOymi6lpl3LR0DJurQBMn4iRDjg9qMUKiN
         Rpqw==
X-Gm-Message-State: APjAAAWVGouydp69W5MaxiidhAdcOniu636/nbYIQWbtR0txew2sqQiM
        Jxoe8hcb4G3an8+6X4YwjtQQ/eQ2w2c=
X-Google-Smtp-Source: APXvYqwMXABw1SuvVBQ4ar9KAfLxCKr/1EItHtj+OdeGn9bWsEU6lVl0ljyi7q4dUFzRGAMhDhHysilRybc=
X-Received: by 2002:a65:6891:: with SMTP id e17mr275552pgt.305.1566938538598;
 Tue, 27 Aug 2019 13:42:18 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:41:50 -0700
In-Reply-To: <20190827204152.114609-1-hridya@google.com>
Message-Id: <20190827204152.114609-3-hridya@google.com>
Mime-Version: 1.0
References: <20190827204152.114609-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 2/4] binder: Add stats, state and transactions files
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following binder stat files currently live in debugfs.

/sys/kernel/debug/binder/state
/sys/kernel/debug/binder/stats
/sys/kernel/debug/binder/transactions

This patch makes these files available in a binderfs instance
mounted with the mount option 'stats=global'. For example, if a binderfs
instance is mounted at path /dev/binderfs, the above files will be
available at the following locations:

/dev/binderfs/binder_logs/state
/dev/binderfs/binder_logs/stats
/dev/binderfs/binder_logs/transactions

This provides a way to access them even when debugfs is not mounted.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
---
 drivers/android/binder.c          |  15 ++--
 drivers/android/binder_internal.h |   8 ++
 drivers/android/binderfs.c        | 137 +++++++++++++++++++++++++++++-
 3 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ca6b21a53321..de795bd229c4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6055,7 +6055,7 @@ static void print_binder_proc_stats(struct seq_file *m,
 }
 
 
-static int state_show(struct seq_file *m, void *unused)
+int binder_state_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 	struct binder_node *node;
@@ -6094,7 +6094,7 @@ static int state_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int stats_show(struct seq_file *m, void *unused)
+int binder_stats_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -6110,7 +6110,7 @@ static int stats_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int transactions_show(struct seq_file *m, void *unused)
+int binder_transactions_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -6198,9 +6198,6 @@ const struct file_operations binder_fops = {
 	.release = binder_release,
 };
 
-DEFINE_SHOW_ATTRIBUTE(state);
-DEFINE_SHOW_ATTRIBUTE(stats);
-DEFINE_SHOW_ATTRIBUTE(transactions);
 DEFINE_SHOW_ATTRIBUTE(transaction_log);
 
 static int __init init_binder_device(const char *name)
@@ -6256,17 +6253,17 @@ static int __init binder_init(void)
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &state_fops);
+				    &binder_state_fops);
 		debugfs_create_file("stats",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &stats_fops);
+				    &binder_stats_fops);
 		debugfs_create_file("transactions",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &transactions_fops);
+				    &binder_transactions_fops);
 		debugfs_create_file("transaction_log",
 				    0444,
 				    binder_debugfs_dir_entry_root,
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index fe8c745dc8e0..12ef96f256c6 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -57,4 +57,12 @@ static inline int __init init_binderfs(void)
 }
 #endif
 
+int binder_stats_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(binder_stats);
+
+int binder_state_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(binder_state);
+
+int binder_transactions_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(binder_transactions);
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index d95d179aec58..d542f9b8d8ab 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -280,7 +280,7 @@ static void binderfs_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 
-	if (!device)
+	if (!device || S_ISREG(inode->i_mode))
 		return;
 
 	mutex_lock(&binderfs_minors_mutex);
@@ -504,6 +504,138 @@ static const struct inode_operations binderfs_dir_inode_operations = {
 	.unlink = binderfs_unlink,
 };
 
+static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
+{
+	struct inode *ret;
+
+	ret = new_inode(sb);
+	if (ret) {
+		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
+		ret->i_mode = mode;
+		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
+	}
+	return ret;
+}
+
+static struct dentry *binderfs_create_dentry(struct dentry *dir,
+					     const char *name)
+{
+	struct dentry *dentry;
+
+	dentry = lookup_one_len(name, dir, strlen(name));
+	if (IS_ERR(dentry))
+		return dentry;
+
+	/* Return error if the file/dir already exists. */
+	if (d_really_is_positive(dentry)) {
+		dput(dentry);
+		return ERR_PTR(-EEXIST);
+	}
+
+	return dentry;
+}
+
+static struct dentry *binderfs_create_file(struct dentry *dir, const char *name,
+				    const struct file_operations *fops,
+				    void *data)
+{
+	struct dentry *dentry;
+	struct inode *new_inode, *dir_inode;
+	struct super_block *sb;
+
+	dir_inode = dir->d_inode;
+	inode_lock(dir_inode);
+
+	dentry = binderfs_create_dentry(dir, name);
+	if (IS_ERR(dentry))
+		goto out;
+
+	sb = dir_inode->i_sb;
+	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
+	if (!new_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	new_inode->i_fop = fops;
+	new_inode->i_private = data;
+	d_instantiate(dentry, new_inode);
+	fsnotify_create(dir_inode, dentry);
+
+out:
+	inode_unlock(dir_inode);
+	return dentry;
+}
+
+static struct dentry *binderfs_create_dir(struct dentry *parent,
+					  const char *name)
+{
+	struct dentry *dentry;
+	struct inode *new_inode, *parent_inode;
+	struct super_block *sb;
+
+	parent_inode = d_inode(parent);
+	inode_lock(parent_inode);
+
+	dentry = binderfs_create_dentry(parent, name);
+	if (IS_ERR(dentry))
+		goto out;
+
+	sb = parent_inode->i_sb;
+	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
+	if (!new_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	new_inode->i_fop = &simple_dir_operations;
+	new_inode->i_op = &simple_dir_inode_operations;
+
+	inc_nlink(new_inode);
+	d_instantiate(dentry, new_inode);
+	inc_nlink(parent_inode);
+	fsnotify_mkdir(parent_inode, dentry);
+out:
+	inode_unlock(parent_inode);
+	return dentry;
+}
+
+static int init_binder_logs(struct super_block *sb)
+{
+	struct dentry *binder_logs_root_dir, *file_dentry;
+	int ret = 0;
+
+	binder_logs_root_dir = binderfs_create_dir(sb->s_root,
+						   "binder_logs");
+	if (IS_ERR(binder_logs_root_dir)) {
+		ret = PTR_ERR(binder_logs_root_dir);
+		goto out;
+	}
+
+	file_dentry = binderfs_create_file(binder_logs_root_dir, "stats",
+					   &binder_stats_fops, NULL);
+	if (IS_ERR(file_dentry)) {
+		ret = PTR_ERR(file_dentry);
+		goto out;
+	}
+
+	file_dentry = binderfs_create_file(binder_logs_root_dir, "state",
+					   &binder_state_fops, NULL);
+	if (IS_ERR(file_dentry)) {
+		ret = PTR_ERR(file_dentry);
+		goto out;
+	}
+
+	file_dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
+					   &binder_transactions_fops, NULL);
+	if (IS_ERR(file_dentry))
+		ret = PTR_ERR(file_dentry);
+out:
+	return ret;
+}
+
 static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int ret;
@@ -582,6 +714,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	}
 
+	if (info->mount_opts.stats_mode == STATS_GLOBAL)
+		return init_binder_logs(sb);
+
 	return 0;
 }
 
-- 
2.23.0.187.g17f5b7556c-goog

