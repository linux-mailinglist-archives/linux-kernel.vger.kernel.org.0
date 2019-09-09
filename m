Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB2AD4D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389280AbfIIIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 04:24:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12389 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727965AbfIIIYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:24:31 -0400
X-UUID: 96a3632492f04e00a7a7c7b28a279f24-20190909
X-UUID: 96a3632492f04e00a7a7c7b28a279f24-20190909
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 150415789; Mon, 09 Sep 2019 16:24:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Sep 2019 16:24:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Sep 2019 16:24:13 +0800
From:   <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>
CC:     <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v2 0/2] mm/kasan: dump alloc/free stack for page allocator
Date:   Mon, 9 Sep 2019 16:24:12 +0800
Message-ID: <20190909082412.24356-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Walter Wu <walter-zh.wu@mediatek.com>

This patch is KASAN report adds the alloc/free stacks for page allocator
in order to help programmer to see memory corruption caused by page.

By default, KASAN doesn't record alloc and free stack for page allocator.
It is difficult to fix up page use-after-free or dobule-free issue.

Our patchsets will record the last stack of pages.
It is very helpful for solving the page use-after-free or double-free.

KASAN report will show the last stack of page, it may be:
a) If page is in-use state, then it prints alloc stack.
   It is useful to fix up page out-of-bound issue.

BUG: KASAN: slab-out-of-bounds in kmalloc_pagealloc_oob_right+0x88/0x90
Write of size 1 at addr ffffffc0d64ea00a by task cat/115
...
Allocation stack of page:
 set_page_stack.constprop.1+0x30/0xc8
 kasan_alloc_pages+0x18/0x38
 prep_new_page+0x5c/0x150
 get_page_from_freelist+0xb8c/0x17c8
 __alloc_pages_nodemask+0x1a0/0x11b0
 kmalloc_order+0x28/0x58
 kmalloc_order_trace+0x28/0xe0
 kmalloc_pagealloc_oob_right+0x2c/0x68

b) If page is freed state, then it prints free stack.
   It is useful to fix up page use-after-free or double-free issue.

BUG: KASAN: use-after-free in kmalloc_pagealloc_uaf+0x70/0x80
Write of size 1 at addr ffffffc0d651c000 by task cat/115
...
Free stack of page:
 kasan_free_pages+0x68/0x70
 __free_pages_ok+0x3c0/0x1328
 __free_pages+0x50/0x78
 kfree+0x1c4/0x250
 kmalloc_pagealloc_uaf+0x38/0x80

This has been discussed, please refer below link.
https://bugzilla.kernel.org/show_bug.cgi?id=203967

Changes since v1:
- slim page_owner and move it into kasan
- enable the feature by default

Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
---
 include/linux/kasan.h |  1 +
 lib/Kconfig.kasan     |  2 ++
 mm/kasan/common.c     | 32 ++++++++++++++++++++++++++++++++
 mm/kasan/kasan.h      |  5 +++++
 mm/kasan/report.c     | 27 +++++++++++++++++++++++++++
 5 files changed, 67 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index cc8a03cc9674..97e1bcb20489 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -19,6 +19,7 @@ extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
 extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
 extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
+extern struct page_ext_operations page_stack_ops;
 
 int kasan_populate_early_shadow(const void *shadow_start,
 				const void *shadow_end);
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 4fafba1a923b..b5a9410ba4e8 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -41,6 +41,7 @@ config KASAN_GENERIC
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	select STACKDEPOT
+	select PAGE_EXTENSION
 	help
 	  Enables generic KASAN mode.
 	  Supported in both GCC and Clang. With GCC it requires version 4.9.2
@@ -63,6 +64,7 @@ config KASAN_SW_TAGS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
 	select STACKDEPOT
+	select PAGE_EXTENSION
 	help
 	  Enables software tag-based KASAN mode.
 	  This mode requires Top Byte Ignore support by the CPU and therefore
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2277b82902d8..c349143d2587 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -211,10 +211,38 @@ void kasan_unpoison_stack_above_sp_to(const void *watermark)
 	kasan_unpoison_shadow(sp, size);
 }
 
+static bool need_page_stack(void)
+{
+	return true;
+}
+
+struct page_ext_operations page_stack_ops = {
+	.size = sizeof(depot_stack_handle_t),
+	.need = need_page_stack,
+};
+
+static void set_page_stack(struct page *page, gfp_t gfp_mask)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+	depot_stack_handle_t handle;
+	depot_stack_handle_t *page_stack;
+
+	if (unlikely(!page_ext))
+		return;
+
+	handle = save_stack(gfp_mask);
+
+	page_stack = get_page_stack(page_ext);
+	*page_stack = handle;
+}
+
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
 	u8 tag;
 	unsigned long i;
+	gfp_t gfp_flags = GFP_KERNEL;
+
+	set_page_stack(page, gfp_flags);
 
 	if (unlikely(PageHighMem(page)))
 		return;
@@ -227,6 +255,10 @@ void kasan_alloc_pages(struct page *page, unsigned int order)
 
 void kasan_free_pages(struct page *page, unsigned int order)
 {
+	gfp_t gfp_flags = GFP_KERNEL;
+
+	set_page_stack(page, gfp_flags);
+
 	if (likely(!PageHighMem(page)))
 		kasan_poison_shadow(page_address(page),
 				PAGE_SIZE << order,
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 014f19e76247..95b3b510d04f 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -126,6 +126,11 @@ static inline bool addr_has_shadow(const void *addr)
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
 
+static inline depot_stack_handle_t *get_page_stack(struct page_ext *page_ext)
+{
+	return (void *)page_ext + page_stack_ops.offset;
+}
+
 void kasan_poison_shadow(const void *address, size_t size, u8 value);
 
 /**
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 0e5f965f1882..2e26bc192114 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -344,6 +344,32 @@ static void print_address_stack_frame(const void *addr)
 	print_decoded_frame_descr(frame_descr);
 }
 
+static void dump_page_stack(struct page *page)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+	depot_stack_handle_t handle;
+	unsigned long *entries;
+	unsigned int nr_entries;
+	depot_stack_handle_t *page_stack;
+
+	if (unlikely(!page_ext))
+		return;
+
+	page_stack = get_page_stack(page_ext);
+
+	handle = READ_ONCE(*page_stack);
+	if (!handle)
+		return;
+
+	if ((unsigned long)page->flags & PAGE_FLAGS_CHECK_AT_PREP)
+		pr_info("Allocation stack of page:\n");
+	else
+		pr_info("Free stack of page:\n");
+
+	nr_entries = stack_depot_fetch(handle, &entries);
+	stack_trace_print(entries, nr_entries, 0);
+}
+
 static void print_address_description(void *addr)
 {
 	struct page *page = addr_to_page(addr);
@@ -366,6 +392,7 @@ static void print_address_description(void *addr)
 	if (page) {
 		pr_err("The buggy address belongs to the page:\n");
 		dump_page(page, "kasan: bad access detected");
+		dump_page_stack(page);
 	}
 
 	print_address_stack_frame(addr);
-- 
2.18.0

