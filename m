Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14CDEF18E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 01:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfKEAAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 19:00:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35273 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfKEAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:00:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id r22so16691273qtt.2;
        Mon, 04 Nov 2019 16:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVpjuj8UwavcIst9QqE8NhYJae3gffaD1D5bpqdhhuo=;
        b=H/3BoZMxBFgl1e89uQ7H755KUcdc1zqubAuqyHKvxqLpyy86qI08EEtVpzioA8vwb+
         2jkJprRUUSkvGeWIl15GF4IWQqra3xH+CR8LyWMgC2qrvJpnTNcK9gscQP8F+woKggAq
         uZ3zMF3rfeJ2MnseMHcb+/F/s1bKLNWSfbrFGvEFXX+6pJyH9z/cHXaaVb6JpZra+yiF
         xfT8gv/1ZsFWY8HcgKWMuaXdSbNrv/9prv1yBxjNd6HLricuBiX9rXBGd2OoRLUMvYPM
         s1voSzZ7zGIQiiVlmP/rXnBO3968/c3ezOsNhmx/BkEUXRCnDsKvSFUDSWIi6PRz5K1D
         7clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=dVpjuj8UwavcIst9QqE8NhYJae3gffaD1D5bpqdhhuo=;
        b=snok3oZzf7hGD/+22kBZqKkBqbtsY6t/4MyezRXwlMvxAhz7jBM0Jih/l1ynO9enHL
         UhXLVaGZE6kZSXjwayeNfZcVSQrDWNlweG2tqWNO4F9D6bORewG3Rsq+IaDnWUr44+48
         yJouVVacFARoMB7d66QjsCkdWIHuPDK7kt2FLX0U5fappZZJmvEa+QYFg5SfdAMszD5u
         FIfJo9e8msCnewnDcF5Tge9wQoXSZ0a+Mqae9dh3uEEF+7EDradF7aptXuVJMtsIcEK/
         VkvVnNWCn3HKnE4Zhpz0Hnj9wYtRNF4w4Qsqw3al87HExVJcfy5kva28Pp+BgqAws7XI
         15Vg==
X-Gm-Message-State: APjAAAWB60uuMMMdF5cuYbdZr/3yyKAebKU4zDfhMRHD0l7N2NEwMXia
        6NlcnhhXhg7L1cMz56oyH8c=
X-Google-Smtp-Source: APXvYqwG/hjYPuydE72tiVp+e1M3XUrAoz+Dhhc6Cu/HgPTNJYvuT2o41WQpZsIEKS+ayT4QNPEqIQ==
X-Received: by 2002:a05:6214:1c9:: with SMTP id c9mr24721976qvt.128.1572912001014;
        Mon, 04 Nov 2019 16:00:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id u11sm7724001qtg.11.2019.11.04.16.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:00:00 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/10] kernfs: convert kernfs_node->id from union kernfs_node_id to u64
Date:   Mon,  4 Nov 2019 15:59:40 -0800
Message-Id: <20191104235944.3470866-7-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernfs_node->id is currently a union kernfs_node_id which represents
either a 32bit (ino, gen) pair or u64 value.  I can't see much value
in the usage of the union - all that's needed is a 64bit ID which the
current code is already limited to.  Using a union makes the code
unnecessarily complicated and prevents using 64bit ino without adding
practical benefits.

This patch drops union kernfs_node_id and makes kernfs_node->id a u64.
ino is stored in the lower 32bits and gen upper.  Accessors -
kernfs[_id]_ino() and kernfs[_id]_gen() - are added to retrieve the
ino and gen.  This simplifies ID handling less cumbersome and will
allow using 64bit inos on supported archs.

This patch doesn't make any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 fs/kernfs/dir.c                  | 10 ++---
 fs/kernfs/file.c                 |  4 +-
 fs/kernfs/inode.c                |  4 +-
 fs/kernfs/mount.c                |  7 ++--
 include/linux/cgroup.h           | 17 ++++----
 include/linux/kernfs.h           | 45 ++++++++++++---------
 include/trace/events/writeback.h |  4 +-
 kernel/bpf/helpers.c             |  2 +-
 kernel/bpf/local_storage.c       |  2 +-
 kernel/cgroup/cgroup.c           |  3 +-
 kernel/trace/blktrace.c          | 67 +++++++++++++++-----------------
 net/core/filter.c                |  4 +-
 12 files changed, 85 insertions(+), 84 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index beabb585a7d8..c67afb591e5b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -532,7 +532,7 @@ void kernfs_put(struct kernfs_node *kn)
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
 	spin_lock(&kernfs_idr_lock);
-	idr_remove(&root->ino_idr, kn->id.ino);
+	idr_remove(&root->ino_idr, kernfs_ino(kn));
 	spin_unlock(&kernfs_idr_lock);
 	kmem_cache_free(kernfs_node_cache, kn);
 
@@ -639,8 +639,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
-	kn->id.ino = ret;
-	kn->id.generation = gen;
+
+	kn->id = (u64)gen << 32 | ret;
 
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
@@ -671,7 +671,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
-	idr_remove(&root->ino_idr, kn->id.ino);
+	idr_remove(&root->ino_idr, kernfs_ino(kn));
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -1656,7 +1656,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		const char *name = pos->name;
 		unsigned int type = dt_type(pos);
 		int len = strlen(name);
-		ino_t ino = pos->id.ino;
+		ino_t ino = kernfs_ino(pos);
 
 		ctx->pos = pos->hash;
 		file->private_data = pos;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e8c792b49616..34366db3620d 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -892,7 +892,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		 * have the matching @file available.  Look up the inodes
 		 * and generate the events manually.
 		 */
-		inode = ilookup(info->sb, kn->id.ino);
+		inode = ilookup(info->sb, kernfs_ino(kn));
 		if (!inode)
 			continue;
 
@@ -901,7 +901,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (parent) {
 			struct inode *p_inode;
 
-			p_inode = ilookup(info->sb, parent->id.ino);
+			p_inode = ilookup(info->sb, kernfs_ino(parent));
 			if (p_inode) {
 				fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
 					 inode, FSNOTIFY_EVENT_INODE, &name, 0);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index f3eaa8869f42..eac277c63d42 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -201,7 +201,7 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
 	inode->i_private = kn;
 	inode->i_mapping->a_ops = &kernfs_aops;
 	inode->i_op = &kernfs_iops;
-	inode->i_generation = kn->id.generation;
+	inode->i_generation = kernfs_gen(kn);
 
 	set_default_inode_attr(inode, kn->mode);
 	kernfs_refresh_inode(kn, inode);
@@ -247,7 +247,7 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 {
 	struct inode *inode;
 
-	inode = iget_locked(sb, kn->id.ino);
+	inode = iget_locked(sb, kernfs_ino(kn));
 	if (inode && (inode->i_state & I_NEW))
 		kernfs_init_inode(kn, inode);
 
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 067b7c380056..f05d5d6f926d 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -57,15 +57,14 @@ const struct super_operations kernfs_sops = {
  * Similar to kernfs_fh_get_inode, this one gets kernfs node from inode
  * number and generation
  */
-struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root,
-	const union kernfs_node_id *id)
+struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root, u64 id)
 {
 	struct kernfs_node *kn;
 
-	kn = kernfs_find_and_get_node_by_ino(root, id->ino);
+	kn = kernfs_find_and_get_node_by_ino(root, kernfs_id_ino(id));
 	if (!kn)
 		return NULL;
-	if (kn->id.generation != id->generation) {
+	if (kernfs_gen(kn) != kernfs_id_gen(id)) {
 		kernfs_put(kn);
 		return NULL;
 	}
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f6b048902d6c..815fff49d555 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -616,7 +616,7 @@ static inline bool cgroup_is_populated(struct cgroup *cgrp)
 /* returns ino associated with a cgroup */
 static inline ino_t cgroup_ino(struct cgroup *cgrp)
 {
-	return cgrp->kn->id.ino;
+	return kernfs_ino(cgrp->kn);
 }
 
 /* cft/css accessors for cftype->write() operation */
@@ -687,13 +687,12 @@ static inline void cgroup_kthread_ready(void)
 	current->no_cgroup_migration = 0;
 }
 
-static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
+static inline u64 cgroup_get_kernfs_id(struct cgroup *cgrp)
 {
-	return &cgrp->kn->id;
+	return cgrp->kn->id;
 }
 
-void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
-					char *buf, size_t buflen);
+void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -718,9 +717,9 @@ static inline int cgroup_init_early(void) { return 0; }
 static inline int cgroup_init(void) { return 0; }
 static inline void cgroup_init_kthreadd(void) {}
 static inline void cgroup_kthread_ready(void) {}
-static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
+static inline union u64 cgroup_get_kernfs_id(struct cgroup *cgrp)
 {
-	return NULL;
+	return 0;
 }
 
 static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
@@ -739,8 +738,8 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 	return true;
 }
 
-static inline void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
-	char *buf, size_t buflen) {}
+static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
+{}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index f797ccc650e7..b2fc5c8ef6d9 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -104,21 +104,6 @@ struct kernfs_elem_attr {
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
 
-/* represent a kernfs node */
-union kernfs_node_id {
-	struct {
-		/*
-		 * blktrace will export this struct as a simplified 'struct
-		 * fid' (which is a big data struction), so userspace can use
-		 * it to find kernfs node. The layout must match the first two
-		 * fields of 'struct fid' exactly.
-		 */
-		u32		ino;
-		u32		generation;
-	};
-	u64			id;
-};
-
 /*
  * kernfs_node - the building block of kernfs hierarchy.  Each and every
  * kernfs node is represented by single kernfs_node.  Most fields are
@@ -155,7 +140,12 @@ struct kernfs_node {
 
 	void			*priv;
 
-	union kernfs_node_id	id;
+	/*
+	 * 64bit unique ID.  Lower 32bits carry the inode number and lower
+	 * generation.
+	 */
+	u64			id;
+
 	unsigned short		flags;
 	umode_t			mode;
 	struct kernfs_iattrs	*iattr;
@@ -292,6 +282,26 @@ static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
 	return kn->flags & KERNFS_TYPE_MASK;
 }
 
+static inline ino_t kernfs_id_ino(u64 id)
+{
+	return (u32)id;
+}
+
+static inline u32 kernfs_id_gen(u64 id)
+{
+	return id >> 32;
+}
+
+static inline ino_t kernfs_ino(struct kernfs_node *kn)
+{
+	return kernfs_id_ino(kn->id);
+}
+
+static inline ino_t kernfs_gen(struct kernfs_node *kn)
+{
+	return kernfs_id_gen(kn->id);
+}
+
 /**
  * kernfs_enable_ns - enable namespace under a directory
  * @kn: directory of interest, should be empty
@@ -383,8 +393,7 @@ void kernfs_kill_sb(struct super_block *sb);
 
 void kernfs_init(void);
 
-struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root,
-	const union kernfs_node_id *id);
+struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root, u64 id);
 #else	/* CONFIG_KERNFS */
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 95e50677476b..b4f0ffe1817e 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -152,7 +152,7 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
 
 static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
-	return wb->memcg_css->cgroup->kn->id.ino;
+	return cgroup_ino(wb->memcg_css->cgroup);
 }
 
 static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
@@ -260,7 +260,7 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
-		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
+		__entry->page_cgroup_ino = cgroup_ino(page->mem_cgroup->css.cgroup);
 	),
 
 	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5e28718928ca..912e761cd17a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -317,7 +317,7 @@ BPF_CALL_0(bpf_get_current_cgroup_id)
 {
 	struct cgroup *cgrp = task_dfl_cgroup(current);
 
-	return cgrp->kn->id.id;
+	return cgrp->kn->id;
 }
 
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index addd6fdceec8..5d867f6d7204 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -569,7 +569,7 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 		return;
 
 	storage->key.attach_type = type;
-	storage->key.cgroup_inode_id = cgroup->kn->id.id;
+	storage->key.cgroup_inode_id = cgroup->kn->id;
 
 	map = storage->map;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index cf32c0c7a45d..c6bd1a5a1977 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5786,8 +5786,7 @@ static int __init cgroup_wq_init(void)
 }
 core_initcall(cgroup_wq_init);
 
-void cgroup_path_from_kernfs_id(const union kernfs_node_id *id,
-					char *buf, size_t buflen)
+void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {
 	struct kernfs_node *kn;
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2d6e93ab0478..a986d2e74ca2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -64,8 +64,7 @@ static void blk_unregister_tracepoints(void);
  * Send out a notify message.
  */
 static void trace_note(struct blk_trace *bt, pid_t pid, int action,
-		       const void *data, size_t len,
-		       union kernfs_node_id *cgid)
+		       const void *data, size_t len, u64 cgid)
 {
 	struct blk_io_trace *t;
 	struct ring_buffer_event *event = NULL;
@@ -73,7 +72,7 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	int pc = 0;
 	int cpu = smp_processor_id();
 	bool blk_tracer = blk_tracer_enabled;
-	ssize_t cgid_len = cgid ? sizeof(*cgid) : 0;
+	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
 
 	if (blk_tracer) {
 		buffer = blk_tr->trace_buffer.buffer;
@@ -100,8 +99,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 		t->pid = pid;
 		t->cpu = cpu;
 		t->pdu_len = len + cgid_len;
-		if (cgid)
-			memcpy((void *)t + sizeof(*t), cgid, cgid_len);
+		if (cgid_len)
+			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
 		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);
 
 		if (blk_tracer)
@@ -122,7 +121,7 @@ static void trace_note_tsk(struct task_struct *tsk)
 	spin_lock_irqsave(&running_trace_lock, flags);
 	list_for_each_entry(bt, &running_trace_list, running_list) {
 		trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm,
-			   sizeof(tsk->comm), NULL);
+			   sizeof(tsk->comm), 0);
 	}
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
@@ -139,7 +138,7 @@ static void trace_note_time(struct blk_trace *bt)
 	words[1] = now.tv_nsec;
 
 	local_irq_save(flags);
-	trace_note(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), NULL);
+	trace_note(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0);
 	local_irq_restore(flags);
 }
 
@@ -172,9 +171,9 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 		blkcg = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n,
-		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : NULL);
+		blkcg ? cgroup_get_kernfs_id(blkcg->css.cgroup) : 0);
 #else
-	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n, NULL);
+	trace_note(bt, 0, BLK_TN_MESSAGE, buf, n, 0);
 #endif
 	local_irq_restore(flags);
 }
@@ -212,7 +211,7 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
  */
 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u32 what, int error, int pdu_len,
-		     void *pdu_data, union kernfs_node_id *cgid)
+		     void *pdu_data, u64 cgid)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -223,7 +222,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	pid_t pid;
 	int cpu, pc = 0;
 	bool blk_tracer = blk_tracer_enabled;
-	ssize_t cgid_len = cgid ? sizeof(*cgid) : 0;
+	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
 
 	if (unlikely(bt->trace_state != Blktrace_running && !blk_tracer))
 		return;
@@ -294,7 +293,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		t->pdu_len = pdu_len + cgid_len;
 
 		if (cgid_len)
-			memcpy((void *)t + sizeof(*t), cgid, cgid_len);
+			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
 		if (pdu_len)
 			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
 
@@ -751,31 +750,29 @@ void blk_trace_shutdown(struct request_queue *q)
 }
 
 #ifdef CONFIG_BLK_CGROUP
-static union kernfs_node_id *
-blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
+static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 {
 	struct blk_trace *bt = q->blk_trace;
 
 	if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
-		return NULL;
+		return 0;
 
 	if (!bio->bi_blkg)
-		return NULL;
+		return 0;
 	return cgroup_get_kernfs_id(bio_blkcg(bio)->css.cgroup);
 }
 #else
-static union kernfs_node_id *
-blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
+u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
 {
-	return NULL;
+	return 0;
 }
 #endif
 
-static union kernfs_node_id *
+static u64
 blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
 {
 	if (!rq->bio)
-		return NULL;
+		return 0;
 	/* Use the first bio */
 	return blk_trace_bio_get_cgid(q, rq->bio);
 }
@@ -797,8 +794,7 @@ blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
  *
  **/
 static void blk_add_trace_rq(struct request *rq, int error,
-			     unsigned int nr_bytes, u32 what,
-			     union kernfs_node_id *cgid)
+			     unsigned int nr_bytes, u32 what, u64 cgid)
 {
 	struct blk_trace *bt = rq->q->blk_trace;
 
@@ -913,7 +909,7 @@ static void blk_add_trace_getrq(void *ignore,
 
 		if (bt)
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
-					NULL, NULL);
+					NULL, 0);
 	}
 }
 
@@ -929,7 +925,7 @@ static void blk_add_trace_sleeprq(void *ignore,
 
 		if (bt)
 			__blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
-					0, 0, NULL, NULL);
+					0, 0, NULL, 0);
 	}
 }
 
@@ -938,7 +934,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 	struct blk_trace *bt = q->blk_trace;
 
 	if (bt)
-		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, NULL);
+		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
 }
 
 static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
@@ -955,7 +951,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 		else
 			what = BLK_TA_UNPLUG_TIMER;
 
-		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, NULL);
+		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
 	}
 }
 
@@ -1172,19 +1168,17 @@ const struct blk_io_trace *te_blk_io_trace(const struct trace_entry *ent)
 
 static inline const void *pdu_start(const struct trace_entry *ent, bool has_cg)
 {
-	return (void *)(te_blk_io_trace(ent) + 1) +
-		(has_cg ? sizeof(union kernfs_node_id) : 0);
+	return (void *)(te_blk_io_trace(ent) + 1) + (has_cg ? sizeof(u64) : 0);
 }
 
-static inline const void *cgid_start(const struct trace_entry *ent)
+static inline u64 t_cgid(const struct trace_entry *ent)
 {
-	return (void *)(te_blk_io_trace(ent) + 1);
+	return *(u64 *)(te_blk_io_trace(ent) + 1);
 }
 
 static inline int pdu_real_len(const struct trace_entry *ent, bool has_cg)
 {
-	return te_blk_io_trace(ent)->pdu_len -
-			(has_cg ? sizeof(union kernfs_node_id) : 0);
+	return te_blk_io_trace(ent)->pdu_len - (has_cg ? sizeof(u64) : 0);
 }
 
 static inline u32 t_action(const struct trace_entry *ent)
@@ -1257,7 +1251,7 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 
 	fill_rwbs(rwbs, t);
 	if (has_cg) {
-		const union kernfs_node_id *id = cgid_start(iter->ent);
+		u64 id = t_cgid(iter->ent);
 
 		if (blk_tracer_flags.val & TRACE_BLK_OPT_CGNAME) {
 			char blkcg_name_buf[NAME_MAX + 1] = "<...>";
@@ -1269,9 +1263,10 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 				 blkcg_name_buf, act, rwbs);
 		} else
 			trace_seq_printf(&iter->seq,
-				 "%3d,%-3d %x,%-x %2s %3s ",
+				 "%3d,%-3d %lx,%-x %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device),
-				 id->ino, id->generation, act, rwbs);
+				 kernfs_id_ino(id), kernfs_id_gen(id),
+				 act, rwbs);
 	} else
 		trace_seq_printf(&iter->seq, "%3d,%-3d %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device), act, rwbs);
diff --git a/net/core/filter.c b/net/core/filter.c
index ed6563622ce3..b360a7beb6fc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4089,7 +4089,7 @@ BPF_CALL_1(bpf_skb_cgroup_id, const struct sk_buff *, skb)
 		return 0;
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	return cgrp->kn->id.id;
+	return cgrp->kn->id;
 }
 
 static const struct bpf_func_proto bpf_skb_cgroup_id_proto = {
@@ -4114,7 +4114,7 @@ BPF_CALL_2(bpf_skb_ancestor_cgroup_id, const struct sk_buff *, skb, int,
 	if (!ancestor)
 		return 0;
 
-	return ancestor->kn->id.id;
+	return ancestor->kn->id;
 }
 
 static const struct bpf_func_proto bpf_skb_ancestor_cgroup_id_proto = {
-- 
2.17.1

