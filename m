Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BD38427
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 08:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfFGGIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 02:08:16 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50096 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbfFGGIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:08:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TTcZLUN_1559887677;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TTcZLUN_1559887677)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Jun 2019 14:08:11 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm: shrinker: make shrinker not depend on memcg kmem
Date:   Fri,  7 Jun 2019 14:07:39 +0800
Message-Id: <1559887659-23121-5-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1559887659-23121-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently shrinker is just allocated and can work when memcg kmem is
enabled.  But, THP deferred split shrinker is not slab shrinker, it
doesn't make too much sense to have such shrinker depend on memcg kmem.
It should be able to reclaim THP even though memcg kmem is disabled.

Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker,
i.e. THP deferred split shrinker.  When memcg kmem is disabled, just
such shrinkers can be called in shrinking memcg slab.

Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/shrinker.h |  3 +--
 mm/huge_memory.c         |  3 ++-
 mm/vmscan.c              | 27 ++++++---------------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 9443caf..e14f68e 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -69,10 +69,8 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
-#ifdef CONFIG_MEMCG_KMEM
 	/* ID in shrinker_idr */
 	int id;
-#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
@@ -81,6 +79,7 @@ struct shrinker {
 /* Flags */
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
+#define SHRINKER_NONSLAB	(1 << 2)
 
 extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 50f4720..e77a9fc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2913,7 +2913,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	.count_objects = deferred_split_count,
 	.scan_objects = deferred_split_scan,
 	.seeks = DEFAULT_SEEKS,
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
+	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
+		 SHRINKER_NONSLAB,
 };
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7acd0af..62000ae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -174,8 +174,6 @@ struct scan_control {
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
-#ifdef CONFIG_MEMCG_KMEM
-
 /*
  * We allow subsystems to populate their shrinker-related
  * LRU lists before register_shrinker_prepared() is called
@@ -227,16 +225,6 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 	idr_remove(&shrinker_idr, id);
 	up_write(&shrinker_rwsem);
 }
-#else /* CONFIG_MEMCG_KMEM */
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
-{
-	return 0;
-}
-
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
@@ -579,7 +567,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
@@ -587,7 +574,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	unsigned long ret, freed = 0;
 	int i;
 
-	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+	if (!mem_cgroup_online(memcg))
 		return 0;
 
 	if (!down_read_trylock(&shrinker_rwsem))
@@ -613,6 +600,11 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 		}
 
+		/* Call non-slab shrinkers even though kmem is disabled */
+		if (!memcg_kmem_enabled() &&
+		    !(shrinker->flags & SHRINKER_NONSLAB))
+			continue;
+
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY) {
 			clear_bit(i, map->map);
@@ -649,13 +641,6 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	up_read(&shrinker_rwsem);
 	return freed;
 }
-#else /* CONFIG_MEMCG_KMEM */
-static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
-			struct mem_cgroup *memcg, int priority)
-{
-	return 0;
-}
-#endif /* CONFIG_MEMCG_KMEM */
 
 /**
  * shrink_slab - shrink slab caches
-- 
1.8.3.1

