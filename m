Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66C2471B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 06:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfEUExq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 00:53:46 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:49360 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfEUExo (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 21 May 2019 00:53:44 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:53:42 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 05:53:10 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org,
        mgorman@techsingularity.net, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 07/14] fs: teach the mm about range locking
Date:   Mon, 20 May 2019 21:52:35 -0700
Message-Id: <20190521045242.24378-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521045242.24378-1-dave@stgolabs.net>
References: <20190521045242.24378-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion is straightforward, mmap_sem is used within the
the same function context most of the time. No change in
semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/aio.c                      |  5 +++--
 fs/coredump.c                 |  5 +++--
 fs/exec.c                     | 19 +++++++++-------
 fs/io_uring.c                 |  5 +++--
 fs/proc/base.c                | 23 ++++++++++++--------
 fs/proc/internal.h            |  2 ++
 fs/proc/task_mmu.c            | 32 +++++++++++++++------------
 fs/proc/task_nommu.c          | 22 +++++++++++--------
 fs/userfaultfd.c              | 50 ++++++++++++++++++++++++++-----------------
 include/linux/userfaultfd_k.h |  5 +++--
 10 files changed, 100 insertions(+), 68 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3490d1fa0e16..215d19dbbefa 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -461,6 +461,7 @@ static const struct address_space_operations aio_ctx_aops = {
 
 static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct aio_ring *ring;
 	struct mm_struct *mm = current->mm;
 	unsigned long size, unused;
@@ -521,7 +522,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ctx->mmap_size = nr_pages * PAGE_SIZE;
 	pr_debug("attempting mmap of %lu bytes\n", ctx->mmap_size);
 
-	if (down_write_killable(&mm->mmap_sem)) {
+	if (mm_write_lock_killable(mm, &mmrange)) {
 		ctx->mmap_size = 0;
 		aio_free_ring(ctx);
 		return -EINTR;
@@ -530,7 +531,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ctx->mmap_base = do_mmap_pgoff(ctx->aio_ring_file, 0, ctx->mmap_size,
 				       PROT_READ | PROT_WRITE,
 				       MAP_SHARED, 0, &unused, NULL);
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	if (IS_ERR((void *)ctx->mmap_base)) {
 		ctx->mmap_size = 0;
 		aio_free_ring(ctx);
diff --git a/fs/coredump.c b/fs/coredump.c
index e42e17e55bfd..433713b63187 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -409,6 +409,7 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
 
 static int coredump_wait(int exit_code, struct core_state *core_state)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	int core_waiters = -EBUSY;
@@ -417,12 +418,12 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	core_state->dumper.task = tsk;
 	core_state->dumper.next = NULL;
 
-	if (down_write_killable(&mm->mmap_sem))
+	if (mm_write_lock_killable(mm, &mmrange))
 		return -EINTR;
 
 	if (!mm->core_state)
 		core_waiters = zap_threads(tsk, mm, core_state, exit_code);
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
diff --git a/fs/exec.c b/fs/exec.c
index e96fd5328739..fbcb36bc4fd1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -241,6 +241,7 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
 
 static int __bprm_mm_init(struct linux_binprm *bprm)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	int err;
 	struct vm_area_struct *vma = NULL;
 	struct mm_struct *mm = bprm->mm;
@@ -250,7 +251,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 		return -ENOMEM;
 	vma_set_anonymous(vma);
 
-	if (down_write_killable(&mm->mmap_sem)) {
+	if (mm_write_lock_killable(mm, &mmrange)) {
 		err = -EINTR;
 		goto err_free;
 	}
@@ -273,11 +274,11 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
 
 	mm->stack_vm = mm->total_vm = 1;
 	arch_bprm_mm_init(mm, vma);
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	bprm->p = vma->vm_end - sizeof(void *);
 	return 0;
 err:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 err_free:
 	bprm->vma = NULL;
 	vm_area_free(vma);
@@ -691,6 +692,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	unsigned long ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
@@ -738,7 +740,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		bprm->loader -= stack_shift;
 	bprm->exec -= stack_shift;
 
-	if (down_write_killable(&mm->mmap_sem))
+	if (mm_write_lock_killable(mm, &mmrange))
 		return -EINTR;
 
 	vm_flags = VM_STACK_FLAGS;
@@ -795,7 +797,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		ret = -EFAULT;
 
 out_unlock:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	return ret;
 }
 EXPORT_SYMBOL(setup_arg_pages);
@@ -1010,6 +1012,7 @@ static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
 	struct mm_struct *old_mm, *active_mm;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
@@ -1024,9 +1027,9 @@ static int exec_mmap(struct mm_struct *mm)
 		 * through with the exec.  We must hold mmap_sem around
 		 * checking core_state and changing tsk->mm.
 		 */
-		down_read(&old_mm->mmap_sem);
+		mm_read_lock(old_mm, &mmrange);
 		if (unlikely(old_mm->core_state)) {
-			up_read(&old_mm->mmap_sem);
+			mm_read_unlock(old_mm, &mmrange);
 			return -EINTR;
 		}
 	}
@@ -1039,7 +1042,7 @@ static int exec_mmap(struct mm_struct *mm)
 	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
-		up_read(&old_mm->mmap_sem);
+		mm_read_unlock(old_mm, &mmrange);
 		BUG_ON(active_mm != old_mm);
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index e11d77181398..16c06811193b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2597,6 +2597,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 	struct page **pages = NULL;
 	int i, j, got_pages = 0;
 	int ret = -EINVAL;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	if (ctx->user_bufs)
 		return -EBUSY;
@@ -2671,7 +2672,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		}
 
 		ret = 0;
-		down_read(&current->mm->mmap_sem);
+		mm_read_lock(current->mm, &mmrange);
 		pret = get_user_pages(ubuf, nr_pages,
 				      FOLL_WRITE | FOLL_LONGTERM,
 				      pages, vmas);
@@ -2689,7 +2690,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		} else {
 			ret = pret < 0 ? pret : -EFAULT;
 		}
-		up_read(&current->mm->mmap_sem);
+		mm_read_unlock(current->mm, &mmrange);
 		if (ret) {
 			/*
 			 * if we did partial map, or found file backed vmas,
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9c8ca6cd3ce4..63d0fea104af 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1962,9 +1962,11 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out;
 
 	if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
-		down_read(&mm->mmap_sem);
+		DEFINE_RANGE_LOCK_FULL(mmrange);
+
+		mm_read_lock(mm, &mmrange);
 		exact_vma_exists = !!find_exact_vma(mm, vm_start, vm_end);
-		up_read(&mm->mmap_sem);
+		mm_read_unlock(mm, &mmrange);
 	}
 
 	mmput(mm);
@@ -1995,6 +1997,7 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 	struct task_struct *task;
 	struct mm_struct *mm;
 	int rc;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	rc = -ENOENT;
 	task = get_proc_task(d_inode(dentry));
@@ -2011,14 +2014,14 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 		goto out_mmput;
 
 	rc = -ENOENT;
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (vma && vma->vm_file) {
 		*path = vma->vm_file->f_path;
 		path_get(path);
 		rc = 0;
 	}
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 
 out_mmput:
 	mmput(mm);
@@ -2089,6 +2092,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 	struct task_struct *task;
 	struct dentry *result;
 	struct mm_struct *mm;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	result = ERR_PTR(-ENOENT);
 	task = get_proc_task(dir);
@@ -2107,7 +2111,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 	if (!mm)
 		goto out_put_task;
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (!vma)
 		goto out_no_vma;
@@ -2117,7 +2121,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 				(void *)(unsigned long)vma->vm_file->f_mode);
 
 out_no_vma:
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	mmput(mm);
 out_put_task:
 	put_task_struct(task);
@@ -2141,6 +2145,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	genradix_init(&fa);
 
@@ -2160,7 +2165,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	mm = get_task_mm(task);
 	if (!mm)
 		goto out_put_task;
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 
 	nr_files = 0;
 
@@ -2183,7 +2188,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p = genradix_ptr_alloc(&fa, nr_files++, GFP_KERNEL);
 		if (!p) {
 			ret = -ENOMEM;
-			up_read(&mm->mmap_sem);
+			mm_read_unlock(mm, &mmrange);
 			mmput(mm);
 			goto out_put_task;
 		}
@@ -2192,7 +2197,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->end = vma->vm_end;
 		p->mode = vma->vm_file->f_mode;
 	}
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index d1671e97f7fe..df6f0ec84a8f 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/binfmts.h>
+#include <linux/range_lock.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 
@@ -287,6 +288,7 @@ struct proc_maps_private {
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
+	struct range_lock mmrange;
 } __randomize_layout;
 
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a1c2ad9f960a..7ab5c6f5b8aa 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -128,7 +128,7 @@ static void vma_stop(struct proc_maps_private *priv)
 	struct mm_struct *mm = priv->mm;
 
 	release_task_mempolicy(priv);
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &priv->mmrange);
 	mmput(mm);
 }
 
@@ -166,7 +166,9 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 	if (!mm || !mmget_not_zero(mm))
 		return NULL;
 
-	down_read(&mm->mmap_sem);
+	range_lock_init_full(&priv->mmrange);
+
+	mm_read_lock(mm, &priv->mmrange);
 	hold_task_mempolicy(priv);
 	priv->tail_vma = get_gate_vma(mm);
 
@@ -828,7 +830,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 
 	memset(&mss, 0, sizeof(mss));
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &priv->mmrange);
 	hold_task_mempolicy(priv);
 
 	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
@@ -844,7 +846,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 	__show_smap(m, &mss);
 
 	release_task_mempolicy(priv);
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &priv->mmrange);
 	mmput(mm);
 
 out_put_task:
@@ -1080,6 +1082,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
 static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	struct task_struct *task;
 	char buffer[PROC_NUMBUF];
 	struct mm_struct *mm;
@@ -1118,7 +1121,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		};
 
 		if (type == CLEAR_REFS_MM_HIWATER_RSS) {
-			if (down_write_killable(&mm->mmap_sem)) {
+			if (mm_write_lock_killable(mm, &mmrange)) {
 				count = -EINTR;
 				goto out_mm;
 			}
@@ -1128,18 +1131,18 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			 * resident set size to this mm's current rss value.
 			 */
 			reset_mm_hiwater_rss(mm);
-			up_write(&mm->mmap_sem);
+			mm_write_unlock(mm, &mmrange);
 			goto out_mm;
 		}
 
-		down_read(&mm->mmap_sem);
+		mm_read_lock(mm, &mmrange);
 		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
-				up_read(&mm->mmap_sem);
-				if (down_write_killable(&mm->mmap_sem)) {
+				mm_read_unlock(mm, &mmrange);
+				if (mm_write_lock_killable(mm, &mmrange)) {
 					count = -EINTR;
 					goto out_mm;
 				}
@@ -1158,14 +1161,14 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 					 * failed like if
 					 * get_proc_task() fails?
 					 */
-					up_write(&mm->mmap_sem);
+					mm_write_unlock(mm, &mmrange);
 					goto out_mm;
 				}
 				for (vma = mm->mmap; vma; vma = vma->vm_next) {
 					vma->vm_flags &= ~VM_SOFTDIRTY;
 					vma_set_page_prot(vma);
 				}
-				downgrade_write(&mm->mmap_sem);
+				mm_downgrade_write(mm, &mmrange);
 				break;
 			}
 
@@ -1177,7 +1180,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		if (type == CLEAR_REFS_SOFT_DIRTY)
 			mmu_notifier_invalidate_range_end(&range);
 		tlb_finish_mmu(&tlb, 0, -1);
-		up_read(&mm->mmap_sem);
+		mm_read_unlock(mm, &mmrange);
 out_mm:
 		mmput(mm);
 	}
@@ -1484,6 +1487,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	unsigned long start_vaddr;
 	unsigned long end_vaddr;
 	int ret = 0, copied = 0;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	if (!mm || !mmget_not_zero(mm))
 		goto out;
@@ -1539,9 +1543,9 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 		/* overflow ? */
 		if (end < start_vaddr || end > end_vaddr)
 			end = end_vaddr;
-		down_read(&mm->mmap_sem);
+		mm_read_lock(mm, &mmrange);
 		ret = walk_page_range(start_vaddr, end, &pagemap_walk);
-		up_read(&mm->mmap_sem);
+		mm_read_unlock(mm, &mmrange);
 		start_vaddr = end;
 
 		len = min(count, PM_ENTRY_BYTES * pm.pos);
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 36bf0f2e102e..32bf2860eff3 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -23,9 +23,10 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	struct vm_region *region;
 	struct rb_node *p;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	unsigned long bytes = 0, sbytes = 0, slack = 0, size;
         
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
 		vma = rb_entry(p, struct vm_area_struct, vm_rb);
 
@@ -77,7 +78,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 		"Shared:\t%8lu bytes\n",
 		bytes, slack, sbytes);
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 }
 
 unsigned long task_vsize(struct mm_struct *mm)
@@ -85,13 +86,14 @@ unsigned long task_vsize(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	struct rb_node *p;
 	unsigned long vsize = 0;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
 		vma = rb_entry(p, struct vm_area_struct, vm_rb);
 		vsize += vma->vm_end - vma->vm_start;
 	}
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	return vsize;
 }
 
@@ -103,8 +105,9 @@ unsigned long task_statm(struct mm_struct *mm,
 	struct vm_region *region;
 	struct rb_node *p;
 	unsigned long size = kobjsize(mm);
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p)) {
 		vma = rb_entry(p, struct vm_area_struct, vm_rb);
 		size += kobjsize(vma);
@@ -119,7 +122,7 @@ unsigned long task_statm(struct mm_struct *mm,
 		>> PAGE_SHIFT;
 	*data = (PAGE_ALIGN(mm->start_stack) - (mm->start_data & PAGE_MASK))
 		>> PAGE_SHIFT;
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	size >>= PAGE_SHIFT;
 	size += *text + *data;
 	*resident = size;
@@ -201,6 +204,7 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 	struct mm_struct *mm;
 	struct rb_node *p;
 	loff_t n = *pos;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	/* pin the task and mm whilst we play with them */
 	priv->task = get_proc_task(priv->inode);
@@ -211,13 +215,13 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 	if (!mm || !mmget_not_zero(mm))
 		return NULL;
 
-	down_read(&mm->mmap_sem);
+	mm_read_lock(mm, &mmrange);
 	/* start from the Nth VMA */
 	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
 		if (n-- == 0)
 			return p;
 
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, &mmrange);
 	mmput(mm);
 	return NULL;
 }
@@ -227,7 +231,7 @@ static void m_stop(struct seq_file *m, void *_vml)
 	struct proc_maps_private *priv = m->private;
 
 	if (!IS_ERR_OR_NULL(_vml)) {
-		up_read(&priv->mm->mmap_sem);
+		mm_read_unlock(priv->mm, &mmrange);
 		mmput(priv->mm);
 	}
 	if (priv->task) {
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3b30301c90ec..3592f6d71778 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -220,13 +220,14 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 struct vm_area_struct *vma,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 unsigned long reason,
+					 struct range_lock *mmrange)
 {
 	struct mm_struct *mm = ctx->mm;
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	VM_BUG_ON(!mm_is_locked(mm, mmrange));
 
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
@@ -252,7 +253,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 struct vm_area_struct *vma,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 unsigned long reason,
+					 struct range_lock *mmrange)
+
 {
 	return false;	/* should never get here */
 }
@@ -268,7 +271,8 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 unsigned long reason,
+					 struct range_lock *mmrange)
 {
 	struct mm_struct *mm = ctx->mm;
 	pgd_t *pgd;
@@ -278,7 +282,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	VM_BUG_ON(!mm_is_locked(mm, mmrange));
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -368,7 +372,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	WARN_ON_ONCE(!rwsem_is_locked(&mm->mmap_sem));
+	WARN_ON_ONCE(!mm_is_locked(mm, vmf->lockrange));
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
@@ -476,12 +480,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (!is_vm_hugetlb_page(vmf->vma))
 		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
-						  reason);
+						  reason, vmf->lockrange);
 	else
 		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
 						       vmf->address,
-						       vmf->flags, reason);
-	up_read(&mm->mmap_sem);
+						       vmf->flags, reason,
+						       vmf->lockrange);
+	mm_read_unlock(mm, vmf->lockrange);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released) &&
 		   (return_to_userland ? !signal_pending(current) :
@@ -535,7 +540,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 			 * and there's no need to retake the mmap_sem
 			 * in such case.
 			 */
-			down_read(&mm->mmap_sem);
+			mm_read_lock(mm, vmf->lockrange);
 			ret = VM_FAULT_NOPAGE;
 		}
 	}
@@ -628,9 +633,10 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm = release_new_ctx->mm;
+		DEFINE_RANGE_LOCK_FULL(mmrange);
 
 		/* the various vma->vm_userfaultfd_ctx still points to it */
-		down_write(&mm->mmap_sem);
+		mm_write_lock(mm, &mmrange);
 		/* no task can run (and in turn coredump) yet */
 		VM_WARN_ON(!mmget_still_valid(mm));
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
@@ -638,7 +644,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
 			}
-		up_write(&mm->mmap_sem);
+		mm_write_unlock(mm, &mmrange);
 
 		userfaultfd_ctx_put(release_new_ctx);
 	}
@@ -780,7 +786,8 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 }
 
 bool userfaultfd_remove(struct vm_area_struct *vma,
-			unsigned long start, unsigned long end)
+			unsigned long start, unsigned long end,
+			struct range_lock *mmrange)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct userfaultfd_ctx *ctx;
@@ -792,7 +799,7 @@ bool userfaultfd_remove(struct vm_area_struct *vma,
 
 	userfaultfd_ctx_get(ctx);
 	WRITE_ONCE(ctx->mmap_changing, true);
-	up_read(&mm->mmap_sem);
+	mm_read_unlock(mm, mmrange);
 
 	msg_init(&ewq.msg);
 
@@ -872,6 +879,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
 	unsigned long new_flags;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	WRITE_ONCE(ctx->released, true);
 
@@ -886,7 +894,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	 * it's critical that released is set to true (above), before
 	 * taking the mmap_sem for writing.
 	 */
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	if (!mmget_still_valid(mm))
 		goto skip_mm;
 	prev = NULL;
@@ -912,7 +920,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
 skip_mm:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	mmput(mm);
 wakeup:
 	/*
@@ -1299,6 +1307,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	unsigned long vm_flags, new_flags;
 	bool found;
 	bool basic_ioctls;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 	unsigned long start, end, vma_end;
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
@@ -1339,7 +1348,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (!mmget_not_zero(mm))
 		goto out;
 
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	if (!mmget_still_valid(mm))
 		goto out_unlock;
 	vma = find_vma_prev(mm, start, &prev);
@@ -1483,7 +1492,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma = vma->vm_next;
 	} while (vma && vma->vm_start < end);
 out_unlock:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	mmput(mm);
 	if (!ret) {
 		/*
@@ -1511,6 +1520,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1528,7 +1538,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (!mmget_not_zero(mm))
 		goto out;
 
-	down_write(&mm->mmap_sem);
+	mm_write_lock(mm, &mmrange);
 	if (!mmget_still_valid(mm))
 		goto out_unlock;
 	vma = find_vma_prev(mm, start, &prev);
@@ -1645,7 +1655,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		vma = vma->vm_next;
 	} while (vma && vma->vm_start < end);
 out_unlock:
-	up_write(&mm->mmap_sem);
+	mm_write_unlock(mm, &mmrange);
 	mmput(mm);
 out:
 	return ret;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac9d71e24b81..c8d3c102ce5e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -68,7 +68,7 @@ extern void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *,
 
 extern bool userfaultfd_remove(struct vm_area_struct *vma,
 			       unsigned long start,
-			       unsigned long end);
+			       unsigned long end, struct range_lock *mmrange);
 
 extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 				  unsigned long start, unsigned long end,
@@ -125,7 +125,8 @@ static inline void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *ctx,
 
 static inline bool userfaultfd_remove(struct vm_area_struct *vma,
 				      unsigned long start,
-				      unsigned long end)
+				      unsigned long end,
+				      struct range_lock *mmrange)
 {
 	return true;
 }
-- 
2.16.4

