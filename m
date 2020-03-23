Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4388E18EF90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 06:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCWFwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 01:52:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgCWFwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:52:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id b1so6639180pgm.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/SlUjTtocf8V+J3dKBKuBijXBEV2naB5SratdivUvVI=;
        b=d9fAE/5/i+dc7/3phOjE1iYfCR7OP3bX6oxpfS5O2KGCff3+fCR9iEqkGuwSoBNODR
         wN4f5xioriSkxQSyKFo8UOo0mydksvXO8mD9oVz35TxqSXkd3aodmXOhLQeqcr9WCCCB
         NN4DhkxJR/xDATuX2Z4kXRDuoyNJuQoRfQgMGwK5KVlbKCyio/OsJKJ8ZxqV8Wu7Xcgd
         Nai0iockbJvfP3ir2WFY5Ebc/KvyEwrENixfrqM+ZcQWTZAH6A+DajDT69WK35jKj0YE
         xUFnUYAlKlV57sQH/no/vKeXxmpvBCX4Sc7aUSZXT4F/nwTJFKtiUlrhjXTtzqwPo4ih
         A7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/SlUjTtocf8V+J3dKBKuBijXBEV2naB5SratdivUvVI=;
        b=H77b5nCYS762J2KkPaNwd2g3H95t5wHajMgyR76S6Eu1kWQ2fzhpv8wpLWdIaHk6SL
         sUlztrFSwDys8x2Hn0PPe2IYJ8VCCKhWU8m+q9r4sHvx23ZvUM1B0Gf55GURkGouZt23
         85NoRtMn7sS0YjWKz3Hr9XRIQLszgtaoGj1uQpmGwsOGno4AWC1XJI7yJqp+PyLM32+G
         E0mIwO1/NDNP0BUQigQEwXOGqQLqHbJ0VQmOgdHvhFENkv9gjcoHA8lqY6YhCdGO2hl8
         7iat6B9RkjXzzOe4y5MsOcxl9Ktqmv6pRG+Fwhabqf7E7osBPNMKhW2PTbqG79Mc041U
         q8JQ==
X-Gm-Message-State: ANhLgQ2+64XURlkJTu4+7UoB/JSEK3mENwt78dkSCPClIpmG4ynVtMao
        k3W2Zkvd7lYczw0apOKbXpg=
X-Google-Smtp-Source: ADFU+vs9ghT9Rh1yf7517f2w89WeZdvlwSmplpAYrrJYr6sN5IMKf3AgAJq+3px1JX+TchRofpVohw==
X-Received: by 2002:a63:6c8a:: with SMTP id h132mr20717130pgc.42.1584942755714;
        Sun, 22 Mar 2020 22:52:35 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y30sm12563058pff.67.2020.03.22.22.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 22:52:35 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v4 2/8] mm/vmscan: protect the workingset on anonymous LRU
Date:   Mon, 23 Mar 2020 14:52:06 +0900
Message-Id: <1584942732-2184-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

In current implementation, newly created or swap-in anonymous page
is started on active list. Growing active list results in rebalancing
active/inactive list so old pages on active list are demoted to inactive
list. Hence, the page on active list isn't protected at all.

Following is an example of this situation.

Assume that 50 hot pages on active list. Numbers denote the number of
pages on active/inactive list (active | inactive).

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(uo) | 50(h)

3. workload: another 50 newly created (used-once) pages
50(uo) | 50(uo), swap-out 50(h)

This patch tries to fix this issue.
Like as file LRU, newly created or swap-in anonymous pages will be
inserted to the inactive list. They are promoted to active list if
enough reference happens. This simple modification changes the above
example as following.

1. 50 hot pages on active list
50(h) | 0

2. workload: 50 newly created (used-once) pages
50(h) | 50(uo)

3. workload: another 50 newly created (used-once) pages
50(h) | 50(uo), swap-out 50(uo)

As you can see, hot pages on active list would be protected.

Note that, this implementation has a drawback that the page cannot
be promoted and will be swapped-out if re-access interval is greater than
the size of inactive list but less than the size of total(active+inactive).
To solve this potential issue, following patch will apply workingset
detection that is applied to file LRU some day before.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/swap.h    |  2 +-
 kernel/events/uprobes.c |  2 +-
 mm/huge_memory.c        |  6 +++---
 mm/khugepaged.c         |  2 +-
 mm/memory.c             |  9 ++++-----
 mm/migrate.c            |  2 +-
 mm/swap.c               | 13 +++++++------
 mm/swapfile.c           |  2 +-
 mm/userfaultfd.c        |  2 +-
 mm/vmscan.c             |  4 +---
 10 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7a..954e13e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -344,7 +344,7 @@ extern void deactivate_page(struct page *page);
 extern void mark_page_lazyfree(struct page *page);
 extern void swap_setup(void);
 
-extern void lru_cache_add_active_or_unevictable(struct page *page,
+extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
 
 /* linux/mm/vmscan.c */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13..14156fc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -190,7 +190,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		get_page(new_page);
 		page_add_new_anon_rmap(new_page, vma, addr, false);
 		mem_cgroup_commit_charge(new_page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 	} else
 		/* no new page, just dec_mm_counter for old_page */
 		dec_mm_counter(mm, MM_ANONPAGES);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a880932..6356dfd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -638,7 +638,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		page_add_new_anon_rmap(page, vma, haddr, true);
 		mem_cgroup_commit_charge(page, memcg, false, true);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1282,7 +1282,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 		set_page_private(pages[i], 0);
 		page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
 		mem_cgroup_commit_charge(pages[i], memcg, false, false);
-		lru_cache_add_active_or_unevictable(pages[i], vma);
+		lru_cache_add_inactive_or_unevictable(pages[i], vma);
 		vmf->pte = pte_offset_map(&_pmd, haddr);
 		VM_BUG_ON(!pte_none(*vmf->pte));
 		set_pte_at(vma->vm_mm, haddr, vmf->pte, entry);
@@ -1435,7 +1435,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
 		page_add_new_anon_rmap(new_page, vma, haddr, true);
 		mem_cgroup_commit_charge(new_page, memcg, false, true);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		if (!page) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908..246c155 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1092,7 +1092,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	page_add_new_anon_rmap(new_page, vma, address, true);
 	mem_cgroup_commit_charge(new_page, memcg, false, true);
 	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
-	lru_cache_add_active_or_unevictable(new_page, vma);
+	lru_cache_add_inactive_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 45442d9..5f7813a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2513,7 +2513,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
 		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(new_page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(new_page, vma);
+		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
 		 * mmu page tables (such as kvm shadow page tables), we want the
@@ -3038,11 +3038,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(page != swapcache && swapcache)) {
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true, false);
-		activate_page(page);
 	}
 
 	swap_free(entry);
@@ -3186,7 +3185,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
-	lru_cache_add_active_or_unevictable(page, vma);
+	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
@@ -3449,7 +3448,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
diff --git a/mm/migrate.c b/mm/migrate.c
index 86873b6..ef034c0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2784,7 +2784,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	page_add_new_anon_rmap(page, vma, addr, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
 	if (!is_zone_device_page(page))
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	get_page(page);
 
 	if (flush) {
diff --git a/mm/swap.c b/mm/swap.c
index 5341ae9..442d27e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -448,23 +448,24 @@ void lru_cache_add(struct page *page)
 }
 
 /**
- * lru_cache_add_active_or_unevictable
+ * lru_cache_add_inactive_or_unevictable
  * @page:  the page to be added to LRU
  * @vma:   vma in which page is mapped for determining reclaimability
  *
- * Place @page on the active or unevictable LRU list, depending on its
+ * Place @page on the inactive or unevictable LRU list, depending on its
  * evictability.  Note that if the page is not evictable, it goes
  * directly back onto it's zone's unevictable list, it does NOT use a
  * per cpu pagevec.
  */
-void lru_cache_add_active_or_unevictable(struct page *page,
+void lru_cache_add_inactive_or_unevictable(struct page *page,
 					 struct vm_area_struct *vma)
 {
+	bool unevictable;
+
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
-		SetPageActive(page);
-	else if (!TestSetPageMlocked(page)) {
+	unevictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED;
+	if (unevictable && !TestSetPageMlocked(page)) {
 		/*
 		 * We use the irq-unsafe __mod_zone_page_stat because this
 		 * counter is not modified from interrupt context, and the pte
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bb3261d..6bdcbf9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1888,7 +1888,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
-		lru_cache_add_active_or_unevictable(page, vma);
+		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	swap_free(entry);
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 1b0d7ab..875e329 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -120,7 +120,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	inc_mm_counter(dst_mm, MM_ANONPAGES);
 	page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
-	lru_cache_add_active_or_unevictable(page, dst_vma);
+	lru_cache_add_inactive_or_unevictable(page, dst_vma);
 
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e772f3f..c932141 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1010,8 +1010,6 @@ static enum page_references page_check_references(struct page *page,
 		return PAGEREF_RECLAIM;
 
 	if (referenced_ptes) {
-		if (PageSwapBacked(page))
-			return PAGEREF_ACTIVATE;
 		/*
 		 * All mapped pages start out with page table
 		 * references from the instantiating fault, so we need
@@ -1034,7 +1032,7 @@ static enum page_references page_check_references(struct page *page,
 		/*
 		 * Activate file-backed executable pages after first usage.
 		 */
-		if (vm_flags & VM_EXEC)
+		if ((vm_flags & VM_EXEC) && !PageSwapBacked(page))
 			return PAGEREF_ACTIVATE;
 
 		return PAGEREF_KEEP;
-- 
2.7.4

