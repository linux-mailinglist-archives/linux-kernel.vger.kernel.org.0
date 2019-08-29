Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E4A28C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfH2VSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 17:18:42 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42077 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfH2VSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:18:42 -0400
Received: by mail-pf1-f201.google.com with SMTP id e13so3506558pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qsIc6ouvJm25vCwwIEUG+MZjJjlVm8TuIpZN+dimnLk=;
        b=IW9w26bXUH8R8hRCOZ/wKUA1wpLGP6x8CSqZ7pMb+T0iZ4NFzODHJihIjF2YmhQVg8
         fsiayonaJwtOv2rBBKT2UHrIg0Ywz3cuQQNEcEpUqk7cIGqv9IzHTq4nQwV/1CzTmysf
         QzTrRqm/jXq8Obj0SlnJs8XGGotx81Esv/z8i44U3aG+ooK4ghK1SPd7ToEBSe10Dx3C
         Ju+0ik08lPfD5UTkK0B60m1LG5wB7nh0iPJrBz0Tnjv98Yguwey17bc3BQV0eg/Zqe2D
         yjv0BKqvwuuTmlYtf5gdO3+UtdArtPz1lmRVRqONZTPgnoXzUWilfPUMZ6wA5eaAml8X
         qXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qsIc6ouvJm25vCwwIEUG+MZjJjlVm8TuIpZN+dimnLk=;
        b=A2hCN2u5JE43gqN6Qkiq2WlLVZC1TWJVuhkUeudzCYLiL6e5V0bihb02cYbj3kJYzQ
         L0i6X5xe/4EnU51X1mlvmzvCRIFYPjR/EPaXU/9xKyabEC1qnDyG9ziU+0t10mH7760O
         ENq+ry4p5o0HXpsXqHlPykGC7bNgCANma7X+mNvSW07CAYT1CJL2GZnyY/MeyDNoL0+U
         DGb6H1E08l5fnO+f91uk/Kj8R6wljfKJHtZQLdaJUHt/GxMmihB0jfZRjY2zNeiVd6yY
         TUJHndLr6m0nz8EUH+Nc1cx8jet+s2CCFIZ8ZuackWuHrHFiaP6t2Ji7gtge4IQfiuPJ
         tjGg==
X-Gm-Message-State: APjAAAU2WjWR9NKyxF8tYIbFkKIIV3gtIk1bwukItokKbJnXA34ro+b3
        pT/RpcMJtXezKGY/Mc3+pWuaUIt5Ppk=
X-Google-Smtp-Source: APXvYqz8VUFSZAIRWeP5TVZHuCqfiV3u2jYKX6CDZcPvKIcjnnQy4HrAf+hlV7HKY2deBxh9PFxy82mmsjs=
X-Received: by 2002:a63:2685:: with SMTP id m127mr10100602pgm.6.1567113521021;
 Thu, 29 Aug 2019 14:18:41 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:18:10 -0700
In-Reply-To: <20190829211812.32520-1-hridya@google.com>
Message-Id: <20190829211812.32520-3-hridya@google.com>
Mime-Version: 1.0
References: <20190829211812.32520-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 2/4] binder: Add stats, state and transactions files
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

 Changes in v2:
 - Consistently name variables across functions as per Christian
   Brauner.
 - Improve check for binderfs device in binderfs_evict_inode()
   as per Christian Brauner.

 drivers/android/binder.c          |  15 ++--
 drivers/android/binder_internal.h |   8 ++
 drivers/android/binderfs.c        | 140 +++++++++++++++++++++++++++++-
 3 files changed, 153 insertions(+), 10 deletions(-)

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
index 7045bfe5b52b..0e1e7c87cd33 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -280,7 +280,7 @@ static void binderfs_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 
-	if (!device)
+	if (!S_ISCHR(inode->i_mode) || !device)
 		return;
 
 	mutex_lock(&binderfs_minors_mutex);
@@ -502,6 +502,141 @@ static const struct inode_operations binderfs_dir_inode_operations = {
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
+static struct dentry *binderfs_create_dentry(struct dentry *parent,
+					     const char *name)
+{
+	struct dentry *dentry;
+
+	dentry = lookup_one_len(name, parent, strlen(name));
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
+static struct dentry *binderfs_create_file(struct dentry *parent,
+					   const char *name,
+					   const struct file_operations *fops,
+					   void *data)
+{
+	struct dentry *dentry;
+	struct inode *new_inode, *parent_inode;
+	struct super_block *sb;
+
+	parent_inode = parent->d_inode;
+	inode_lock(parent_inode);
+
+	dentry = binderfs_create_dentry(parent, name);
+	if (IS_ERR(dentry))
+		goto out;
+
+	sb = parent_inode->i_sb;
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
+	fsnotify_create(parent_inode, dentry);
+
+out:
+	inode_unlock(parent_inode);
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
+
+out:
+	inode_unlock(parent_inode);
+	return dentry;
+}
+
+static int init_binder_logs(struct super_block *sb)
+{
+	struct dentry *binder_logs_root_dir, *dentry;
+	int ret = 0;
+
+	binder_logs_root_dir = binderfs_create_dir(sb->s_root,
+						   "binder_logs");
+	if (IS_ERR(binder_logs_root_dir)) {
+		ret = PTR_ERR(binder_logs_root_dir);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir, "stats",
+				      &binder_stats_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir, "state",
+				      &binder_state_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
+				      &binder_transactions_fops, NULL);
+	if (IS_ERR(dentry))
+		ret = PTR_ERR(dentry);
+
+out:
+	return ret;
+}
+
 static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int ret;
@@ -580,6 +715,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	}
 
+	if (info->mount_opts.stats_mode == STATS_GLOBAL)
+		return init_binder_logs(sb);
+
 	return 0;
 }
 
-- 
2.23.0.187.g17f5b7556c-goog

