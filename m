Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A94418C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408071AbfFKXSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 19:18:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46262 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408044AbfFKXSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:18:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BN9aFB031322
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Tffvx74eRN7sOmy9DcF9GcEFiD3Crn+QmEOXHigsbRc=;
 b=D2jzOp2PflUbmHqEVfc7rVBqWuylvhKlJDwk4z50trsh5OnSL8V0XdAJx156r+1jIQ87
 pWGXmoZ5D/ZMEHXRJhwunP7szIiqp221o3oIPGl0Gtd0fVuOUf1r7cC6euRTFPP0d+VD
 0tRIEwxDkaym8d3Uox+TFQ1JXaEQOcnVSBE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t2ha1926c-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:34 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Jun 2019 16:18:22 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 4A8F8130CBF77; Tue, 11 Jun 2019 16:18:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v7 09/10] mm: stop setting page->mem_cgroup pointer for slab pages
Date:   Tue, 11 Jun 2019 16:18:12 -0700
Message-ID: <20190611231813.3148843-10-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611231813.3148843-1-guro@fb.com>
References: <20190611231813.3148843-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=658 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every slab page charged to a non-root memory cgroup has a pointer
to the memory cgroup and holds a reference to it, which protects
a non-empty memory cgroup from being released. At the same time
the page has a pointer to the corresponding kmem_cache, and also
hold a reference to the kmem_cache. And kmem_cache by itself
holds a reference to the cgroup.

So there is clearly some redundancy, which allows to stop setting
the page->mem_cgroup pointer and rely on getting memcg pointer
indirectly via kmem_cache. Further it will allow to change this
pointer easier, without a need to go over all charged pages.

So let's stop setting page->mem_cgroup pointer for slab pages,
and stop using the css refcounter directly for protecting
the memory cgroup from going away. Instead rely on kmem_cache
as an intermediate object.

Make sure that vmstats and shrinker lists are working as previously,
as well as /proc/kpagecgroup interface.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
---
 mm/list_lru.c   |  3 +-
 mm/memcontrol.c | 12 ++++----
 mm/slab.h       | 74 ++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 927d85be32f6..0f1f6b06b7f3 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
+#include "slab.h"
 
 #ifdef CONFIG_MEMCG_KMEM
 static LIST_HEAD(list_lrus);
@@ -63,7 +64,7 @@ static __always_inline struct mem_cgroup *mem_cgroup_from_kmem(void *ptr)
 	if (!memcg_kmem_enabled())
 		return NULL;
 	page = virt_to_head_page(ptr);
-	return page->mem_cgroup;
+	return memcg_from_slab_page(page);
 }
 
 static inline struct list_lru_one *
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 43a42bc3ed3f..25e72779fd33 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -486,7 +486,10 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino = 0;
 
 	rcu_read_lock();
-	memcg = READ_ONCE(page->mem_cgroup);
+	if (PageHead(page) && PageSlab(page))
+		memcg = memcg_from_slab_page(page);
+	else
+		memcg = READ_ONCE(page->mem_cgroup);
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
 		memcg = parent_mem_cgroup(memcg);
 	if (memcg)
@@ -2807,9 +2810,6 @@ int __memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 		cancel_charge(memcg, nr_pages);
 		return -ENOMEM;
 	}
-
-	page->mem_cgroup = memcg;
-
 	return 0;
 }
 
@@ -2832,8 +2832,10 @@ int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 	memcg = get_mem_cgroup_from_current();
 	if (!mem_cgroup_is_root(memcg)) {
 		ret = __memcg_kmem_charge_memcg(page, gfp, order, memcg);
-		if (!ret)
+		if (!ret) {
+			page->mem_cgroup = memcg;
 			__SetPageKmemcg(page);
+		}
 	}
 	css_put(&memcg->css);
 	return ret;
diff --git a/mm/slab.h b/mm/slab.h
index 5d2b8511e6fb..7ead47cb9338 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -255,30 +255,67 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
 	return s->memcg_params.root_cache;
 }
 
+/*
+ * Expects a pointer to a slab page. Please note, that PageSlab() check
+ * isn't sufficient, as it returns true also for tail compound slab pages,
+ * which do not have slab_cache pointer set.
+ * So this function assumes that the page can pass PageHead() and PageSlab()
+ * checks.
+ */
+static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
+{
+	struct kmem_cache *s;
+
+	s = READ_ONCE(page->slab_cache);
+	if (s && !is_root_cache(s))
+		return s->memcg_params.memcg;
+
+	return NULL;
+}
+
+/*
+ * Charge the slab page belonging to the non-root kmem_cache.
+ * Can be called for non-root kmem_caches only.
+ */
 static __always_inline int memcg_charge_slab(struct page *page,
 					     gfp_t gfp, int order,
 					     struct kmem_cache *s)
 {
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
 	int ret;
 
-	if (is_root_cache(s))
-		return 0;
-
-	ret = memcg_kmem_charge_memcg(page, gfp, order, s->memcg_params.memcg);
+	memcg = s->memcg_params.memcg;
+	ret = memcg_kmem_charge_memcg(page, gfp, order, memcg);
 	if (ret)
 		return ret;
 
+	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
+	mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
+
+	/* transer try_charge() page references to kmem_cache */
 	percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
+	css_put_many(&memcg->css, 1 << order);
 
 	return 0;
 }
 
+/*
+ * Uncharge a slab page belonging to a non-root kmem_cache.
+ * Can be called for non-root kmem_caches only.
+ */
 static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 						struct kmem_cache *s)
 {
-	if (!is_root_cache(s))
-		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
-	memcg_kmem_uncharge(page, order);
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+
+	memcg = s->memcg_params.memcg;
+	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
+	mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
+	memcg_kmem_uncharge_memcg(page, order, memcg);
+
+	percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
 }
 
 extern void slab_init_memcg_params(struct kmem_cache *);
@@ -314,6 +351,11 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
 	return s;
 }
 
+static inline struct mem_cgroup *memcg_from_slab_page(struct page *page)
+{
+	return NULL;
+}
+
 static inline int memcg_charge_slab(struct page *page, gfp_t gfp, int order,
 				    struct kmem_cache *s)
 {
@@ -351,18 +393,24 @@ static __always_inline int charge_slab_page(struct page *page,
 					    gfp_t gfp, int order,
 					    struct kmem_cache *s)
 {
-	int ret = memcg_charge_slab(page, gfp, order, s);
-
-	if (!ret)
-		mod_lruvec_page_state(page, cache_vmstat_idx(s), 1 << order);
+	if (is_root_cache(s)) {
+		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+				    1 << order);
+		return 0;
+	}
 
-	return ret;
+	return memcg_charge_slab(page, gfp, order, s);
 }
 
 static __always_inline void uncharge_slab_page(struct page *page, int order,
 					       struct kmem_cache *s)
 {
-	mod_lruvec_page_state(page, cache_vmstat_idx(s), -(1 << order));
+	if (is_root_cache(s)) {
+		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+				    -(1 << order));
+		return;
+	}
+
 	memcg_uncharge_slab(page, order, s);
 }
 
-- 
2.21.0

