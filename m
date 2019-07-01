Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48ECF57C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfD3L0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:26:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3L0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:26:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBQDBG1350029
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:26:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBQDBG1350029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623575;
        bh=BC+4bx5WkZ0UdWa31Z5nh+00EjeJneeRxrRiV+oolq4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IvLEuXdiWCU9Btbd/IbwqdKzrAT/SrunumaoQ6azXSbzD1HGVl+gQj24qNmPgf8VI
         qXo9JyR799HJ5nCTFSGcb7tSUoRBZ6cimt6DexAUNqLczm1V5p5gnJRWFX1wgm2wTi
         wRHcdxCFICNrlvVGOSMMkUP7iOGi8hjt4kV0AiFHaufS80zpPxvwW683Mqx+thTEnZ
         GQ6+RF+YHe4GAFNJSzki+zRQZJIWQFTLKlaep+LMO3U/QTZArvm6P0EhwtByAuwmC6
         rUQgCmkYWZcg4g7qAukBa0lHTdkI6Bm6V0sbENWMErWTx/bPlJdAMh5jfuUwg9Fjli
         NTudosSFqtfwQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBQDmW1350026;
        Tue, 30 Apr 2019 04:26:13 -0700
Date:   Tue, 30 Apr 2019 04:26:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rick Edgecombe <tipbot@zytor.com>
Message-ID: <tip-868b104d7379e28013e9d48bdd2db25e0bdcf751@git.kernel.org>
Cc:     rick.p.edgecombe@intel.com, mingo@kernel.org, will.deacon@arm.com,
        riel@surriel.com, hpa@zytor.com, torvalds@linux-foundation.org,
        linux_dti@icloud.com, nadav.amit@gmail.com,
        ard.biesheuvel@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, kristen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de,
        kernel-hardening@lists.openwall.com, deneen.t.dock@intel.com,
        luto@kernel.org
Reply-To: peterz@infradead.org, bp@alien8.de, deneen.t.dock@intel.com,
          luto@kernel.org, kernel-hardening@lists.openwall.com,
          dave.hansen@intel.com, akpm@linux-foundation.org,
          kristen@linux.intel.com, linux-kernel@vger.kernel.org,
          ard.biesheuvel@linaro.org, tglx@linutronix.de,
          will.deacon@arm.com, mingo@kernel.org,
          rick.p.edgecombe@intel.com, hpa@zytor.com, linux_dti@icloud.com,
          riel@surriel.com, torvalds@linux-foundation.org,
          nadav.amit@gmail.com
In-Reply-To: <20190426001143.4983-17-namit@vmware.com>
References: <20190426001143.4983-17-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] mm/vmalloc: Add flag for freeing of special
 permsissions
Git-Commit-ID: 868b104d7379e28013e9d48bdd2db25e0bdcf751
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  868b104d7379e28013e9d48bdd2db25e0bdcf751
Gitweb:     https://git.kernel.org/tip/868b104d7379e28013e9d48bdd2db25e0bdcf751
Author:     Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate: Thu, 25 Apr 2019 17:11:36 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:58 +0200

mm/vmalloc: Add flag for freeing of special permsissions

Add a new flag VM_FLUSH_RESET_PERMS, for enabling vfree operations to
immediately clear executable TLB entries before freeing pages, and handle
resetting permissions on the directmap. This flag is useful for any kind
of memory with elevated permissions, or where there can be related
permissions changes on the directmap. Today this is RO+X and RO memory.

Although this enables directly vfreeing non-writeable memory now,
non-writable memory cannot be freed in an interrupt because the allocation
itself is used as a node on deferred free list. So when RO memory needs to
be freed in an interrupt the code doing the vfree needs to have its own
work queue, as was the case before the deferred vfree list was added to
vmalloc.

For architectures with set_direct_map_ implementations this whole operation
can be done with one TLB flush when centralized like this. For others with
directmap permissions, currently only arm64, a backup method using
set_memory functions is used to reset the directmap. When arm64 adds
set_direct_map_ functions, this backup can be removed.

When the TLB is flushed to both remove TLB entries for the vmalloc range
mapping and the direct map permissions, the lazy purge operation could be
done to try to save a TLB flush later. However today vm_unmap_aliases
could flush a TLB range that does not include the directmap. So a helper
is added with extra parameters that can allow both the vmalloc address and
the direct mapping to be flushed during this operation. The behavior of the
normal vm_unmap_aliases function is unchanged.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-17-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/vmalloc.h |  15 +++++++
 mm/vmalloc.c            | 113 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 109 insertions(+), 19 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 398e9c95cd61..c6eebb839552 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -21,6 +21,11 @@ struct notifier_block;		/* in notifier.h */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
+/*
+ * Memory with VM_FLUSH_RESET_PERMS cannot be freed in an interrupt or with
+ * vfree_atomic().
+ */
+#define VM_FLUSH_RESET_PERMS	0x00000100      /* Reset direct map and flush TLB on unmap */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
@@ -142,6 +147,13 @@ extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
 				    pgprot_t prot, struct page **pages);
 extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
 extern void unmap_kernel_range(unsigned long addr, unsigned long size);
+static inline void set_vm_flush_reset_perms(void *addr)
+{
+	struct vm_struct *vm = find_vm_area(addr);
+
+	if (vm)
+		vm->flags |= VM_FLUSH_RESET_PERMS;
+}
 #else
 static inline int
 map_kernel_range_noflush(unsigned long start, unsigned long size,
@@ -157,6 +169,9 @@ static inline void
 unmap_kernel_range(unsigned long addr, unsigned long size)
 {
 }
+static inline void set_vm_flush_reset_perms(void *addr)
+{
+}
 #endif
 
 /* Allocate/destroy a 'vmalloc' VM area. */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e86ba6e74b50..e5e9e1fcac01 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/set_memory.h>
 #include <linux/debugobjects.h>
 #include <linux/kallsyms.h>
 #include <linux/list.h>
@@ -1059,24 +1060,9 @@ static void vb_free(const void *addr, unsigned long size)
 		spin_unlock(&vb->lock);
 }
 
-/**
- * vm_unmap_aliases - unmap outstanding lazy aliases in the vmap layer
- *
- * The vmap/vmalloc layer lazily flushes kernel virtual mappings primarily
- * to amortize TLB flushing overheads. What this means is that any page you
- * have now, may, in a former life, have been mapped into kernel virtual
- * address by the vmap layer and so there might be some CPUs with TLB entries
- * still referencing that page (additional to the regular 1:1 kernel mapping).
- *
- * vm_unmap_aliases flushes all such lazy mappings. After it returns, we can
- * be sure that none of the pages we have control over will have any aliases
- * from the vmap layer.
- */
-void vm_unmap_aliases(void)
+static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 {
-	unsigned long start = ULONG_MAX, end = 0;
 	int cpu;
-	int flush = 0;
 
 	if (unlikely(!vmap_initialized))
 		return;
@@ -1113,6 +1099,27 @@ void vm_unmap_aliases(void)
 		flush_tlb_kernel_range(start, end);
 	mutex_unlock(&vmap_purge_lock);
 }
+
+/**
+ * vm_unmap_aliases - unmap outstanding lazy aliases in the vmap layer
+ *
+ * The vmap/vmalloc layer lazily flushes kernel virtual mappings primarily
+ * to amortize TLB flushing overheads. What this means is that any page you
+ * have now, may, in a former life, have been mapped into kernel virtual
+ * address by the vmap layer and so there might be some CPUs with TLB entries
+ * still referencing that page (additional to the regular 1:1 kernel mapping).
+ *
+ * vm_unmap_aliases flushes all such lazy mappings. After it returns, we can
+ * be sure that none of the pages we have control over will have any aliases
+ * from the vmap layer.
+ */
+void vm_unmap_aliases(void)
+{
+	unsigned long start = ULONG_MAX, end = 0;
+	int flush = 0;
+
+	_vm_unmap_aliases(start, end, flush);
+}
 EXPORT_SYMBOL_GPL(vm_unmap_aliases);
 
 /**
@@ -1505,6 +1512,72 @@ struct vm_struct *remove_vm_area(const void *addr)
 	return NULL;
 }
 
+static inline void set_area_direct_map(const struct vm_struct *area,
+				       int (*set_direct_map)(struct page *page))
+{
+	int i;
+
+	for (i = 0; i < area->nr_pages; i++)
+		if (page_address(area->pages[i]))
+			set_direct_map(area->pages[i]);
+}
+
+/* Handle removing and resetting vm mappings related to the vm_struct. */
+static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
+{
+	unsigned long addr = (unsigned long)area->addr;
+	unsigned long start = ULONG_MAX, end = 0;
+	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
+	int i;
+
+	/*
+	 * The below block can be removed when all architectures that have
+	 * direct map permissions also have set_direct_map_() implementations.
+	 * This is concerned with resetting the direct map any an vm alias with
+	 * execute permissions, without leaving a RW+X window.
+	 */
+	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
+		set_memory_nx(addr, area->nr_pages);
+		set_memory_rw(addr, area->nr_pages);
+	}
+
+	remove_vm_area(area->addr);
+
+	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
+	if (!flush_reset)
+		return;
+
+	/*
+	 * If not deallocating pages, just do the flush of the VM area and
+	 * return.
+	 */
+	if (!deallocate_pages) {
+		vm_unmap_aliases();
+		return;
+	}
+
+	/*
+	 * If execution gets here, flush the vm mapping and reset the direct
+	 * map. Find the start and end range of the direct mappings to make sure
+	 * the vm_unmap_aliases() flush includes the direct map.
+	 */
+	for (i = 0; i < area->nr_pages; i++) {
+		if (page_address(area->pages[i])) {
+			start = min(addr, start);
+			end = max(addr, end);
+		}
+	}
+
+	/*
+	 * Set direct map to something invalid so that it won't be cached if
+	 * there are any accesses after the TLB flush, then flush the TLB and
+	 * reset the direct map permissions to the default.
+	 */
+	set_area_direct_map(area, set_direct_map_invalid_noflush);
+	_vm_unmap_aliases(start, end, 1);
+	set_area_direct_map(area, set_direct_map_default_noflush);
+}
+
 static void __vunmap(const void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
@@ -1526,7 +1599,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
-	remove_vm_area(addr);
+	vm_remove_mappings(area, deallocate_pages);
+
 	if (deallocate_pages) {
 		int i;
 
@@ -1961,8 +2035,9 @@ EXPORT_SYMBOL(vzalloc_node);
  */
 void *vmalloc_exec(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, PAGE_KERNEL_EXEC,
-			      NUMA_NO_NODE, __builtin_return_address(0));
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
+			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
