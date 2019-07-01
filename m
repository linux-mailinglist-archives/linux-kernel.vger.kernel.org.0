Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD544914
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfFMRNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 13:13:48 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:48138 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728941AbfFLV6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:58:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TU0Hbt._1560376624;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU0Hbt._1560376624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jun 2019 05:57:14 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/4] mm: thp: make deferred split shrinker memcg aware
Date:   Thu, 13 Jun 2019 05:56:49 +0800
Message-Id: <1560376609-113689-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently THP deferred split shrinker is not memcg aware, this may cause
premature OOM with some configuration. For example the below test would
run into premature OOM easily:

$ cgcreate -g memory:thp
$ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
$ cgexec -g memory:thp transhuge-stress 4000

transhuge-stress comes from kernel selftest.

It is easy to hit OOM, but there are still a lot THP on the deferred
split queue, memcg direct reclaim can't touch them since the deferred
split shrinker is not memcg aware.

Convert deferred split shrinker memcg aware by introducing per memcg
deferred split queue.  The THP should be on either per node or per memcg
deferred split queue if it belongs to a memcg.  When the page is
immigrated to the other memcg, it will be immigrated to the target
memcg's deferred split queue too.

Reuse the second tail page's deferred_list for per memcg list since the
same THP can't be on multiple deferred split queues.

Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/huge_mm.h    |  9 +++++++++
 include/linux/memcontrol.h |  4 ++++
 include/linux/mm_types.h   |  1 +
 mm/huge_memory.c           | 45 +++++++++++++++++++++++++++++++++------------
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c15..7738509 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -250,6 +250,15 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+static inline struct list_head *page_deferred_list(struct page *page)
+{
+	/*
+	 * Global or memcg deferred list in the second tail pages is
+	 * occupied by compound_head.
+	 */
+	return &page[2].deferred_list;
+}
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bc74d6a..5d3c10c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -316,6 +316,10 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	struct deferred_split deferred_split_queue;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8ec38b1..4eabf80 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -139,6 +139,7 @@ struct page {
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
 			unsigned long _compound_pad_2;
+			/* For both global and memcg */
 			struct list_head deferred_list;
 		};
 		struct {	/* Page table pages */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 81cf759..4f20273 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -492,10 +492,15 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 	return pmd;
 }
 
-static inline struct list_head *page_deferred_list(struct page *page)
+static inline struct deferred_split *get_deferred_split_queue(struct page *page)
 {
-	/* ->lru in the tail pages is occupied by compound_head. */
-	return &page[2].deferred_list;
+	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
+	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+
+	if (memcg)
+		return &memcg->deferred_split_queue;
+	else
+		return &pgdat->deferred_split_queue;
 }
 
 void prep_transhuge_page(struct page *page)
@@ -2658,7 +2663,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
 	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue = get_deferred_split_queue(page);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
@@ -2794,8 +2799,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 void free_transhuge_page(struct page *page)
 {
-	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue = get_deferred_split_queue(page);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
@@ -2809,8 +2813,8 @@ void free_transhuge_page(struct page *page)
 
 void deferred_split_huge_page(struct page *page)
 {
-	struct pglist_data *pgdata = NODE_DATA(page_to_nid(page));
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
@@ -2820,6 +2824,9 @@ void deferred_split_huge_page(struct page *page)
 		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
+		if (memcg)
+			memcg_set_shrinker_bit(memcg, page_to_nid(page),
+					       deferred_split_shrinker.id);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
@@ -2827,8 +2834,16 @@ void deferred_split_huge_page(struct page *page)
 static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	struct pglist_data *pgdata = NODE_DATA(sc->nid);
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue;
+
+	if (!sc->memcg) {
+		struct pglist_data *pgdata = NODE_DATA(sc->nid);
+
+		ds_queue = &pgdata->deferred_split_queue;
+		return READ_ONCE(ds_queue->split_queue_len);
+	}
+
+	ds_queue = &sc->memcg->deferred_split_queue;
 	return READ_ONCE(ds_queue->split_queue_len);
 }
 
@@ -2836,12 +2851,17 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 	LIST_HEAD(list), *pos, *next;
 	struct page *page;
 	int split = 0;
 
+	if (sc->memcg)
+		ds_queue = &sc->memcg->deferred_split_queue;
+	else
+		ds_queue = &pgdata->deferred_split_queue;
+
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	/* Take pin on all head pages to avoid freeing them under us */
 	list_for_each_safe(pos, next, &ds_queue->split_queue) {
@@ -2888,7 +2908,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	.count_objects = deferred_split_count,
 	.scan_objects = deferred_split_scan,
 	.seeks = DEFAULT_SEEKS,
-	.flags = SHRINKER_NUMA_AWARE,
+	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
+		 SHRINKER_NONSLAB,
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e50a2db..16f9390 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4579,6 +4579,11 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 #endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
+	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
+	memcg->deferred_split_queue.split_queue_len = 0;
+#endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
 fail:
@@ -4949,6 +4954,14 @@ static int mem_cgroup_move_account(struct page *page,
 		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
 	}
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (compound && !list_empty(page_deferred_list(page))) {
+		spin_lock(&from->deferred_split_queue.split_queue_lock);
+		list_del(page_deferred_list(page));
+		from->deferred_split_queue.split_queue_len--;
+		spin_unlock(&from->deferred_split_queue.split_queue_lock);
+	}
+#endif
 	/*
 	 * It is safe to change page->mem_cgroup here because the page
 	 * is referenced, charged, and isolated - we can't race with
@@ -4957,6 +4970,17 @@ static int mem_cgroup_move_account(struct page *page,
 
 	/* caller should have done css_get */
 	page->mem_cgroup = to;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (compound && list_empty(page_deferred_list(page))) {
+		spin_lock(&to->deferred_split_queue.split_queue_lock);
+		list_add_tail(page_deferred_list(page),
+			      &to->deferred_split_queue.split_queue);
+		to->deferred_split_queue.split_queue_len++;
+		spin_unlock(&to->deferred_split_queue.split_queue_lock);
+	}
+#endif
+
 	spin_unlock_irqrestore(&from->move_lock, flags);
 
 	ret = 0;
-- 
1.8.3.1

