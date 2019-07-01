Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFD21F735
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfEOPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 11:12:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:36794 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfEOPMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:12:02 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hQvZI-0001YA-DL; Wed, 15 May 2019 18:11:44 +0300
Subject: [PATCH RFC 5/5] mm: Add process_vm_mmap()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        alexander.h.duyck@linux.intel.com, ira.weiny@intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, keescook@chromium.org,
        hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 15 May 2019 18:11:44 +0300
Message-ID: <155793310413.13922.4749810361688380807.stgit@localhost.localdomain>
In-Reply-To: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new syscall to map from or to another
process vma. Flag PVMMAP_FIXED may be specified,
its meaning is similar to mmap()'s MAP_FIXED.

@pid > 0 means to map from process of @pid to current,
@pid < 0 means to map from current to @pid process.

VMA are merged on destination, i.e. if source task
has VMA with address [start; end], and we map it sequentially
twice:

process_vm_mmap(@pid, start, start + (end - start)/2, ...);
process_vm_mmap(@pid, start + (end - start)/2, end,   ...);

the destination task will have single vma [start, end].

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/mm.h                     |    4 +
 include/linux/mm_types.h               |    2 +
 include/uapi/asm-generic/mman-common.h |    5 +
 mm/mmap.c                              |  108 ++++++++++++++++++++++++++++++++
 mm/process_vm_access.c                 |   71 +++++++++++++++++++++
 5 files changed, 190 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 54328d08dbdd..c49bcfac593c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2382,6 +2382,10 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
+extern unsigned long mmap_process_vm(struct mm_struct *, unsigned long,
+				     struct mm_struct *, unsigned long,
+				     unsigned long, unsigned long,
+				     struct list_head *);
 
 static inline unsigned long
 do_mmap_pgoff(struct file *file, unsigned long addr,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1815fbc40926..885f256f2fb7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -261,11 +261,13 @@ struct vm_region {
 
 #ifdef CONFIG_USERFAULTFD
 #define NULL_VM_UFFD_CTX ((struct vm_userfaultfd_ctx) { NULL, })
+#define IS_NULL_VM_UFFD_CTX(uctx) ((uctx)->ctx == NULL)
 struct vm_userfaultfd_ctx {
 	struct userfaultfd_ctx *ctx;
 };
 #else /* CONFIG_USERFAULTFD */
 #define NULL_VM_UFFD_CTX ((struct vm_userfaultfd_ctx) {})
+#define IS_NULL_VM_UFFD_CTX(uctx) (true)
 struct vm_userfaultfd_ctx {};
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..44cb6cf77e93 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -28,6 +28,11 @@
 /* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
+/*
+ * Flags for process_vm_mmap
+ */
+#define PVMMAP_FIXED	0x01
+
 /*
  * Flags for mlock
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index b2a1f77643cd..3dbf280e9f8e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3274,6 +3274,114 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return NULL;
 }
 
+static int do_mmap_process_vm(struct vm_area_struct *src_vma,
+			      unsigned long src_addr,
+			      struct mm_struct *dst_mm,
+			      unsigned long dst_addr,
+			      unsigned long len,
+			      struct list_head *uf)
+{
+	struct vm_area_struct *dst_vma;
+	unsigned long pgoff, ret;
+	bool unused;
+
+	if (do_munmap(dst_mm, dst_addr, len, uf))
+		return -ENOMEM;
+
+	if (src_vma->vm_flags & VM_ACCOUNT) {
+		if (security_vm_enough_memory_mm(dst_mm, len >> PAGE_SHIFT))
+			return -ENOMEM;
+	}
+
+	pgoff = src_vma->vm_pgoff +
+			((src_addr - src_vma->vm_start) >> PAGE_SHIFT);
+	dst_vma = copy_vma(&src_vma, dst_mm, dst_addr,
+			   len, pgoff, &unused, false);
+	if (!dst_vma) {
+		ret = -ENOMEM;
+		goto unacct;
+	}
+
+	ret = copy_page_range(dst_mm, src_vma->vm_mm, src_vma,
+			      dst_addr, src_addr, src_addr + len);
+	if (ret) {
+		do_munmap(dst_mm, dst_addr, len, uf);
+		return -ENOMEM;
+	}
+
+	if (dst_vma->vm_file)
+		uprobe_mmap(dst_vma);
+	perf_event_mmap(dst_vma);
+
+	dst_vma->vm_flags |= VM_SOFTDIRTY;
+	vma_set_page_prot(dst_vma);
+
+	vm_stat_account(dst_mm, dst_vma->vm_flags, len >> PAGE_SHIFT);
+	return 0;
+
+unacct:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return ret;
+}
+
+unsigned long mmap_process_vm(struct mm_struct *src_mm,
+			      unsigned long src_addr,
+			      struct mm_struct *dst_mm,
+			      unsigned long dst_addr,
+			      unsigned long len,
+			      unsigned long flags,
+			      struct list_head *uf)
+{
+	struct vm_area_struct *src_vma = find_vma(src_mm, src_addr);
+	unsigned long gua_flags = 0;
+	unsigned long ret;
+
+	if (!src_vma || src_vma->vm_start > src_addr)
+		return -EFAULT;
+	if (len > src_vma->vm_end - src_addr)
+		return -EFAULT;
+	if (src_vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
+		return -EFAULT;
+	if (is_vm_hugetlb_page(src_vma) || (src_vma->vm_flags & VM_IO))
+		return -EINVAL;
+        if (dst_mm->map_count + 2 > sysctl_max_map_count)
+                return -ENOMEM;
+	if (!IS_NULL_VM_UFFD_CTX(&src_vma->vm_userfaultfd_ctx))
+		return -ENOTSUPP;
+
+	if (src_vma->vm_flags & VM_SHARED)
+		gua_flags |= MAP_SHARED;
+	else
+		gua_flags |= MAP_PRIVATE;
+	if (vma_is_anonymous(src_vma) || vma_is_shmem(src_vma))
+		gua_flags |= MAP_ANONYMOUS;
+	if (flags & PVMMAP_FIXED)
+		gua_flags |= MAP_FIXED;
+	ret = get_unmapped_area(src_vma->vm_file, dst_addr, len,
+				src_vma->vm_pgoff +
+				((src_addr - src_vma->vm_start) >> PAGE_SHIFT),
+				gua_flags);
+	if (offset_in_page(ret))
+                return ret;
+	dst_addr = ret;
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(dst_mm, src_vma->vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		nr_pages = count_vma_pages_range(dst_mm, dst_addr, dst_addr + len);
+		if (!may_expand_vm(dst_mm, src_vma->vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	ret = do_mmap_process_vm(src_vma, src_addr, dst_mm, dst_addr, len, uf);
+	if (ret)
+                return ret;
+
+	return dst_addr;
+}
+
 /*
  * Return true if the calling process may expand its vm space by the passed
  * number of pages
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index a447092d4635..7fca2c5c7edd 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -17,6 +17,8 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
+#include <linux/mman.h>
+#include <linux/userfaultfd_k.h>
 
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
@@ -295,6 +297,68 @@ static ssize_t process_vm_rw(pid_t pid,
 	return rc;
 }
 
+static unsigned long process_vm_mmap(pid_t pid, unsigned long src_addr,
+				     unsigned long len, unsigned long dst_addr,
+				     unsigned long flags)
+{
+	struct mm_struct *src_mm, *dst_mm;
+	struct task_struct *task;
+	unsigned long ret;
+	int depth = 0;
+	LIST_HEAD(uf);
+
+	len = PAGE_ALIGN(len);
+	src_addr = round_down(src_addr, PAGE_SIZE);
+	if (flags & PVMMAP_FIXED)
+		dst_addr = round_down(dst_addr, PAGE_SIZE);
+	else
+		dst_addr = round_hint_to_min(dst_addr);
+
+	if ((flags & ~PVMMAP_FIXED) || len == 0 || len > TASK_SIZE ||
+	    src_addr == 0 || dst_addr > TASK_SIZE - len)
+		return -EINVAL;
+	task = find_get_task_by_vpid(pid > 0 ? pid : -pid);
+	if (!task)
+		return -ESRCH;
+	if (unlikely(task->flags & PF_KTHREAD)) {
+		ret = -EINVAL;
+		goto out_put_task;
+	}
+
+	src_mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+	if (!src_mm || IS_ERR(src_mm)) {
+		ret = IS_ERR(src_mm) ? PTR_ERR(src_mm) : -ESRCH;
+		goto out_put_task;
+	}
+	dst_mm = current->mm;
+	mmget(dst_mm);
+
+	if (pid < 0)
+		swap(src_mm, dst_mm);
+
+	/* Double lock mm in address order: smallest is the first */
+	if (src_mm < dst_mm) {
+		down_write(&src_mm->mmap_sem);
+		depth = SINGLE_DEPTH_NESTING;
+	}
+	down_write_nested(&dst_mm->mmap_sem, depth);
+	if (src_mm > dst_mm)
+		down_write_nested(&src_mm->mmap_sem, SINGLE_DEPTH_NESTING);
+
+	ret = mmap_process_vm(src_mm, src_addr, dst_mm, dst_addr, len, flags, &uf);
+
+	up_write(&dst_mm->mmap_sem);
+	if (dst_mm != src_mm)
+		up_write(&src_mm->mmap_sem);
+
+	userfaultfd_unmap_complete(dst_mm, &uf);
+	mmput(src_mm);
+	mmput(dst_mm);
+out_put_task:
+	put_task_struct(task);
+	return ret;
+}
+
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
 		unsigned long, liovcnt, const struct iovec __user *, rvec,
 		unsigned long, riovcnt,	unsigned long, flags)
@@ -310,6 +374,13 @@ SYSCALL_DEFINE6(process_vm_writev, pid_t, pid,
 	return process_vm_rw(pid, lvec, liovcnt, rvec, riovcnt, flags, 1);
 }
 
+SYSCALL_DEFINE5(process_vm_mmap, pid_t, pid,
+		unsigned long, src_addr, unsigned long, len,
+		unsigned long, dst_addr, unsigned long, flags)
+{
+	return process_vm_mmap(pid, src_addr, len, dst_addr, flags);
+}
+
 #ifdef CONFIG_COMPAT
 
 static ssize_t

