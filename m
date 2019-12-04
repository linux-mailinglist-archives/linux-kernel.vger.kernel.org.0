Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CBD1136B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfLDUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 15:46:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:50568 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbfLDUqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:46:16 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5] helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1icbWx-0001lh-Px; Wed, 04 Dec 2019 23:45:52 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Daniel Axtens <dja@axtens.net>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com
Subject: [PATCH 1/2] kasan: fix crashes on access to memory mapped by vm_map_ram()
Date:   Wed,  4 Dec 2019 23:45:33 +0300
Message-Id: <20191204204534.32202-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_KASAN_VMALLOC=y any use of memory obtained via vm_map_ram()
will crash because there is no shadow backing that memory.

Instead of sprinkling additional kasan_populate_vmalloc() calls all over
the vmalloc code, move it into alloc_vmap_area(). This will fix
vm_map_ram() and simplify the code a bit.

Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/kasan.h | 15 +++++++++------
 mm/kasan/common.c     | 27 +++++++++++++++++---------
 mm/vmalloc.c          | 45 ++++++++++++++++++-------------------------
 3 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4f404c565db1..e18fe54969e9 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -205,20 +205,23 @@ static inline void *kasan_reset_tag(const void *addr)
 #endif /* CONFIG_KASAN_SW_TAGS */
 
 #ifdef CONFIG_KASAN_VMALLOC
-int kasan_populate_vmalloc(unsigned long requested_size,
-			   struct vm_struct *area);
-void kasan_poison_vmalloc(void *start, unsigned long size);
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
+void kasan_poison_vmalloc(const void *start, unsigned long size);
+void kasan_unpoison_vmalloc(const void *start, unsigned long size);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
 #else
-static inline int kasan_populate_vmalloc(unsigned long requested_size,
-					 struct vm_struct *area)
+static inline int kasan_populate_vmalloc(unsigned long start,
+					unsigned long size)
 {
 	return 0;
 }
 
-static inline void kasan_poison_vmalloc(void *start, unsigned long size) {}
+static inline void kasan_poison_vmalloc(const void *start, unsigned long size)
+{ }
+static inline void kasan_unpoison_vmalloc(const void *start, unsigned long size)
+{ }
 static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long end,
 					 unsigned long free_region_start,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index df3371d5c572..a1e6273be8c3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -777,15 +777,17 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	return 0;
 }
 
-int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 {
 	unsigned long shadow_start, shadow_end;
 	int ret;
 
-	shadow_start = (unsigned long)kasan_mem_to_shadow(area->addr);
+	if (!is_vmalloc_or_module_addr((void *)addr))
+		return 0;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
 	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
-	shadow_end = (unsigned long)kasan_mem_to_shadow(area->addr +
-							area->size);
+	shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
 	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
 
 	ret = apply_to_page_range(&init_mm, shadow_start,
@@ -796,10 +798,6 @@ int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
 
 	flush_cache_vmap(shadow_start, shadow_end);
 
-	kasan_unpoison_shadow(area->addr, requested_size);
-
-	area->flags |= VM_KASAN;
-
 	/*
 	 * We need to be careful about inter-cpu effects here. Consider:
 	 *
@@ -842,12 +840,23 @@ int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
  * Poison the shadow for a vmalloc region. Called as part of the
  * freeing process at the time the region is freed.
  */
-void kasan_poison_vmalloc(void *start, unsigned long size)
+void kasan_poison_vmalloc(const void *start, unsigned long size)
 {
+	if (!is_vmalloc_or_module_addr(start))
+		return;
+
 	size = round_up(size, KASAN_SHADOW_SCALE_SIZE);
 	kasan_poison_shadow(start, size, KASAN_VMALLOC_INVALID);
 }
 
+void kasan_unpoison_vmalloc(const void *start, unsigned long size)
+{
+	if (!is_vmalloc_or_module_addr(start))
+		return;
+
+	kasan_unpoison_shadow(start, size);
+}
+
 static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 					void *unused)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4d3b3d60d893..a5412f14f57f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1073,6 +1073,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	struct vmap_area *va, *pva;
 	unsigned long addr;
 	int purged = 0;
+	int ret = -EBUSY;
 
 	BUG_ON(!size);
 	BUG_ON(offset_in_page(size));
@@ -1139,6 +1140,10 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->va_end = addr + size;
 	va->vm = NULL;
 
+	ret = kasan_populate_vmalloc(addr, size);
+	if (ret)
+		goto out;
+
 	spin_lock(&vmap_area_lock);
 	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
 	spin_unlock(&vmap_area_lock);
@@ -1169,8 +1174,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
 			size);
 
+out:
 	kmem_cache_free(vmap_area_cachep, va);
-	return ERR_PTR(-EBUSY);
+	return ERR_PTR(ret);
 }
 
 int register_vmap_purge_notifier(struct notifier_block *nb)
@@ -1771,6 +1777,8 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	BUG_ON(addr > VMALLOC_END);
 	BUG_ON(!PAGE_ALIGNED(addr));
 
+	kasan_poison_vmalloc(mem, size);
+
 	if (likely(count <= VMAP_MAX_ALLOC)) {
 		debug_check_no_locks_freed(mem, size);
 		vb_free(mem, size);
@@ -1821,6 +1829,9 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 		addr = va->va_start;
 		mem = (void *)addr;
 	}
+
+	kasan_unpoison_vmalloc(mem, size);
+
 	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
@@ -2075,6 +2086,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 {
 	struct vmap_area *va;
 	struct vm_struct *area;
+	unsigned long requested_size = size;
 
 	BUG_ON(in_interrupt());
 	size = PAGE_ALIGN(size);
@@ -2098,23 +2110,9 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 		return NULL;
 	}
 
-	setup_vmalloc_vm(area, va, flags, caller);
+	kasan_unpoison_vmalloc((void *)va->va_start, requested_size);
 
-	/*
-	 * For KASAN, if we are in vmalloc space, we need to cover the shadow
-	 * area with real memory. If we come here through VM_ALLOC, this is
-	 * done by a higher level function that has access to the true size,
-	 * which might not be a full page.
-	 *
-	 * We assume module space comes via VM_ALLOC path.
-	 */
-	if (is_vmalloc_addr(area->addr) && !(area->flags & VM_ALLOC)) {
-		if (kasan_populate_vmalloc(area->size, area)) {
-			unmap_vmap_area(va);
-			kfree(area);
-			return NULL;
-		}
-	}
+	setup_vmalloc_vm(area, va, flags, caller);
 
 	return area;
 }
@@ -2293,8 +2291,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
-	if (area->flags & VM_KASAN)
-		kasan_poison_vmalloc(area->addr, area->size);
+	kasan_poison_vmalloc(area->addr, area->size);
 
 	vm_remove_mappings(area, deallocate_pages);
 
@@ -2539,7 +2536,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
 		goto fail;
 
-	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
+	area = __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZED |
 				vm_flags, start, end, node, gfp_mask, caller);
 	if (!area)
 		goto fail;
@@ -2548,11 +2545,6 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	if (!addr)
 		return NULL;
 
-	if (is_vmalloc_or_module_addr(area->addr)) {
-		if (kasan_populate_vmalloc(real_size, area))
-			return NULL;
-	}
-
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
 	 * flag. It means that vm_struct is not fully initialized.
@@ -3437,7 +3429,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	/* populate the shadow space outside of the lock */
 	for (area = 0; area < nr_vms; area++) {
 		/* assume success here */
-		kasan_populate_vmalloc(sizes[area], vms[area]);
+		kasan_populate_vmalloc(vas[area]->va_start, sizes[area]);
+		kasan_unpoison_vmalloc((void *)vms[area]->addr, sizes[area]);
 	}
 
 	kfree(vas);
-- 
2.23.0

