Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072E7A0254
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfH1M6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 08:58:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42008 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfH1M6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:58:24 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i2xWk-0003pA-Bx; Wed, 28 Aug 2019 12:58:18 +0000
Date:   Wed, 28 Aug 2019 14:58:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 2/4] binder: Add stats, state and transactions files
Message-ID: <20190828125816.cexbvn2dqy6to3ww@wittgenstein>
References: <20190827204152.114609-1-hridya@google.com>
 <20190827204152.114609-3-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827204152.114609-3-hridya@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 01:41:50PM -0700, Hridya Valsaraju wrote:
> The following binder stat files currently live in debugfs.
> 
> /sys/kernel/debug/binder/state
> /sys/kernel/debug/binder/stats
> /sys/kernel/debug/binder/transactions
> 
> This patch makes these files available in a binderfs instance
> mounted with the mount option 'stats=global'. For example, if a binderfs
> instance is mounted at path /dev/binderfs, the above files will be
> available at the following locations:
> 
> /dev/binderfs/binder_logs/state
> /dev/binderfs/binder_logs/stats
> /dev/binderfs/binder_logs/transactions
> 
> This provides a way to access them even when debugfs is not mounted.
> 
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> ---
>  drivers/android/binder.c          |  15 ++--
>  drivers/android/binder_internal.h |   8 ++
>  drivers/android/binderfs.c        | 137 +++++++++++++++++++++++++++++-
>  3 files changed, 150 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index ca6b21a53321..de795bd229c4 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6055,7 +6055,7 @@ static void print_binder_proc_stats(struct seq_file *m,
>  }
>  
>  
> -static int state_show(struct seq_file *m, void *unused)
> +int binder_state_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_proc *proc;
>  	struct binder_node *node;
> @@ -6094,7 +6094,7 @@ static int state_show(struct seq_file *m, void *unused)
>  	return 0;
>  }
>  
> -static int stats_show(struct seq_file *m, void *unused)
> +int binder_stats_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_proc *proc;
>  
> @@ -6110,7 +6110,7 @@ static int stats_show(struct seq_file *m, void *unused)
>  	return 0;
>  }
>  
> -static int transactions_show(struct seq_file *m, void *unused)
> +int binder_transactions_show(struct seq_file *m, void *unused)
>  {
>  	struct binder_proc *proc;
>  
> @@ -6198,9 +6198,6 @@ const struct file_operations binder_fops = {
>  	.release = binder_release,
>  };
>  
> -DEFINE_SHOW_ATTRIBUTE(state);
> -DEFINE_SHOW_ATTRIBUTE(stats);
> -DEFINE_SHOW_ATTRIBUTE(transactions);
>  DEFINE_SHOW_ATTRIBUTE(transaction_log);
>  
>  static int __init init_binder_device(const char *name)
> @@ -6256,17 +6253,17 @@ static int __init binder_init(void)
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    NULL,
> -				    &state_fops);
> +				    &binder_state_fops);
>  		debugfs_create_file("stats",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    NULL,
> -				    &stats_fops);
> +				    &binder_stats_fops);
>  		debugfs_create_file("transactions",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
>  				    NULL,
> -				    &transactions_fops);
> +				    &binder_transactions_fops);
>  		debugfs_create_file("transaction_log",
>  				    0444,
>  				    binder_debugfs_dir_entry_root,
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index fe8c745dc8e0..12ef96f256c6 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -57,4 +57,12 @@ static inline int __init init_binderfs(void)
>  }
>  #endif
>  
> +int binder_stats_show(struct seq_file *m, void *unused);
> +DEFINE_SHOW_ATTRIBUTE(binder_stats);
> +
> +int binder_state_show(struct seq_file *m, void *unused);
> +DEFINE_SHOW_ATTRIBUTE(binder_state);
> +
> +int binder_transactions_show(struct seq_file *m, void *unused);
> +DEFINE_SHOW_ATTRIBUTE(binder_transactions);
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index d95d179aec58..d542f9b8d8ab 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -280,7 +280,7 @@ static void binderfs_evict_inode(struct inode *inode)
>  
>  	clear_inode(inode);
>  
> -	if (!device)
> +	if (!device || S_ISREG(inode->i_mode))

Hm, remind me why we need the S_ISREG again?
Also we probably should do:

if (S_ISREG(inode->i_mode) || !device)

should this maybe be:

if (!S_ISCHR(inode->i_mode) || !device)

?

>  		return;
>  
>  	mutex_lock(&binderfs_minors_mutex);
> @@ -504,6 +504,138 @@ static const struct inode_operations binderfs_dir_inode_operations = {
>  	.unlink = binderfs_unlink,
>  };
>  
> +static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
> +{
> +	struct inode *ret;
> +
> +	ret = new_inode(sb);
> +	if (ret) {
> +		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
> +		ret->i_mode = mode;
> +		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> +	}
> +	return ret;
> +}
> +
> +static struct dentry *binderfs_create_dentry(struct dentry *dir,
> +					     const char *name)
> +{
> +	struct dentry *dentry;
> +
> +	dentry = lookup_one_len(name, dir, strlen(name));
> +	if (IS_ERR(dentry))
> +		return dentry;
> +
> +	/* Return error if the file/dir already exists. */
> +	if (d_really_is_positive(dentry)) {
> +		dput(dentry);
> +		return ERR_PTR(-EEXIST);
> +	}
> +
> +	return dentry;
> +}
> +
> +static struct dentry *binderfs_create_file(struct dentry *dir, const char *name,
> +				    const struct file_operations *fops,
> +				    void *data)
> +{
> +	struct dentry *dentry;
> +	struct inode *new_inode, *dir_inode;
> +	struct super_block *sb;
> +
> +	dir_inode = dir->d_inode;
> +	inode_lock(dir_inode);
> +
> +	dentry = binderfs_create_dentry(dir, name);
> +	if (IS_ERR(dentry))
> +		goto out;
> +
> +	sb = dir_inode->i_sb;
> +	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
> +	if (!new_inode) {
> +		dput(dentry);
> +		dentry = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	new_inode->i_fop = fops;
> +	new_inode->i_private = data;
> +	d_instantiate(dentry, new_inode);
> +	fsnotify_create(dir_inode, dentry);
> +
> +out:
> +	inode_unlock(dir_inode);
> +	return dentry;
> +}
> +
> +static struct dentry *binderfs_create_dir(struct dentry *parent,
> +					  const char *name)
> +{
> +	struct dentry *dentry;
> +	struct inode *new_inode, *parent_inode;
> +	struct super_block *sb;
> +
> +	parent_inode = d_inode(parent);

For consistency, could you use the same variable name for the directory
in which you create a new dentry? I don't care if its "dir_inode" like
above or "parent_inode".

> +	inode_lock(parent_inode);
> +
> +	dentry = binderfs_create_dentry(parent, name);
> +	if (IS_ERR(dentry))
> +		goto out;
> +
> +	sb = parent_inode->i_sb;
> +	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
> +	if (!new_inode) {
> +		dput(dentry);
> +		dentry = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
> +	new_inode->i_fop = &simple_dir_operations;
> +	new_inode->i_op = &simple_dir_inode_operations;
> +
> +	inc_nlink(new_inode);
> +	d_instantiate(dentry, new_inode);
> +	inc_nlink(parent_inode);
> +	fsnotify_mkdir(parent_inode, dentry);
> +out:

For consistency please leave a \n after fsnotify_mkdir and the goto
label like you did in the function above.

> +	inode_unlock(parent_inode);
> +	return dentry;
> +}
> +
> +static int init_binder_logs(struct super_block *sb)
> +{
> +	struct dentry *binder_logs_root_dir, *file_dentry;

Why "file_dentry" and not just simply "dentry" like everywhere else?

> +	int ret = 0;
> +
> +	binder_logs_root_dir = binderfs_create_dir(sb->s_root,
> +						   "binder_logs");
> +	if (IS_ERR(binder_logs_root_dir)) {
> +		ret = PTR_ERR(binder_logs_root_dir);
> +		goto out;
> +	}
> +
> +	file_dentry = binderfs_create_file(binder_logs_root_dir, "stats",
> +					   &binder_stats_fops, NULL);
> +	if (IS_ERR(file_dentry)) {
> +		ret = PTR_ERR(file_dentry);
> +		goto out;
> +	}
> +
> +	file_dentry = binderfs_create_file(binder_logs_root_dir, "state",
> +					   &binder_state_fops, NULL);
> +	if (IS_ERR(file_dentry)) {
> +		ret = PTR_ERR(file_dentry);
> +		goto out;
> +	}
> +
> +	file_dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
> +					   &binder_transactions_fops, NULL);
> +	if (IS_ERR(file_dentry))
> +		ret = PTR_ERR(file_dentry);
> +out:
> +	return ret;
> +}
> +
>  static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	int ret;
> @@ -582,6 +714,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	}
>  
> +	if (info->mount_opts.stats_mode == STATS_GLOBAL)
> +		return init_binder_logs(sb);
> +
>  	return 0;
>  }
>  
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
