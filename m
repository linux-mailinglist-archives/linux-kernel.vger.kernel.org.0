Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB24AADF7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390927AbfIEVqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 17:46:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389557AbfIEVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:46:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x85LgVK5015053
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 14:46:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=n22EwJTVKLxIpi5IStATWjFYKvAR7CWIFYBmP0R5+4M=;
 b=UtZZyZA3eSqmEQvlEKbwypax1MB6y22iErMnVILfPF5WXZ+6ISD5dFDpFIKmb3pPvciD
 2UA148CEzKMUekkg0GTKGVAULgwceoBqPt4BCHI4y+Pn3aNsw7kXoMNxOHyLZHsLJnVx
 cMVsI9MHVdF5kmculaaZihRgWGaDpAKx9Oo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2utxy63a75-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:46:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Sep 2019 14:46:08 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id BC95E17229E04; Thu,  5 Sep 2019 14:46:06 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH RFC 07/14] mm: memcg/slab: save memcg ownership data for non-root slab objects
Date:   Thu, 5 Sep 2019 14:45:51 -0700
Message-ID: <20190905214553.1643060-8-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905214553.1643060-1-guro@fb.com>
References: <20190905214553.1643060-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_08:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=3 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050202
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store a memcg_ptr in the corresponding place of the mem_cgroup_vec
for each allocated non-root slab object. Make sure that each allocated
object holds a reference to the mem_cgroup_ptr.

To get the memcg_ptr in the post alloc hook, we need a memcg pointer.
Because all memory cgroup will soon share the same set of kmem_caches,
let's not use the kmem_cache->memcg_params.memcg. Instead, let's pass
the pointer directly from memcg_kmem_get_cache(). This will guarantee
that we will use the same cgroup in pre- and post-alloc hooks.

Please, note that the code is a bit bulky now, because we have to
manage 3 types of objects with reference counters: memcg, kmem_cache
and memcg_ptr. The following commits in the series will simplify it.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h |  3 +-
 mm/memcontrol.c            |  8 +++--
 mm/slab.c                  | 18 ++++++-----
 mm/slab.h                  | 64 ++++++++++++++++++++++++++++++++++----
 mm/slub.c                  | 14 ++++++---
 5 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dd5ebfe5a86c..b9643d758fc9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1395,7 +1395,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 }
 #endif
 
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
+					struct mem_cgroup **memcgp);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
 
 #ifdef CONFIG_MEMCG_KMEM
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4af9810b59e..761b646eb968 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3015,7 +3015,8 @@ static inline bool memcg_kmem_bypass(void)
  * done with it, memcg_kmem_put_cache() must be called to release the
  * reference.
  */
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
+					struct mem_cgroup **memcgp)
 {
 	struct mem_cgroup *memcg;
 	struct kmem_cache *memcg_cachep;
@@ -3071,8 +3072,11 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
 	 */
 	if (unlikely(!memcg_cachep))
 		memcg_schedule_kmem_cache_create(memcg, cachep);
-	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt))
+	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt)) {
+		css_get(&memcg->css);
+		*memcgp = memcg;
 		cachep = memcg_cachep;
+	}
 out_unlock:
 	rcu_read_unlock();
 	return cachep;
diff --git a/mm/slab.c b/mm/slab.c
index f0833f287dcf..956aab3b9035 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3222,9 +3222,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
 	unsigned long save_flags;
 	void *ptr;
 	int slab_node = numa_mem_id();
+	struct mem_cgroup *memcg = NULL;
 
 	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, flags);
+	cachep = slab_pre_alloc_hook(cachep, &memcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
 
@@ -3260,7 +3261,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid,
 	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
 		memset(ptr, 0, cachep->object_size);
 
-	slab_post_alloc_hook(cachep, flags, 1, &ptr);
+	slab_post_alloc_hook(cachep, memcg, flags, 1, &ptr);
 	return ptr;
 }
 
@@ -3301,9 +3302,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
 {
 	unsigned long save_flags;
 	void *objp;
+	struct mem_cgroup *memcg = NULL;
 
 	flags &= gfp_allowed_mask;
-	cachep = slab_pre_alloc_hook(cachep, flags);
+	cachep = slab_pre_alloc_hook(cachep, &memcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
 
@@ -3317,7 +3319,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, unsigned long caller)
 	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
 		memset(objp, 0, cachep->object_size);
 
-	slab_post_alloc_hook(cachep, flags, 1, &objp);
+	slab_post_alloc_hook(cachep, memcg, flags, 1, &objp);
 	return objp;
 }
 
@@ -3439,6 +3441,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 		memset(objp, 0, cachep->object_size);
 	kmemleak_free_recursive(objp, cachep->flags);
 	objp = cache_free_debugcheck(cachep, objp, caller);
+	memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
 
 	/*
 	 * Skip calling cache_free_alien() when the platform is not numa.
@@ -3504,8 +3507,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			  void **p)
 {
 	size_t i;
+	struct mem_cgroup *memcg = NULL;
 
-	s = slab_pre_alloc_hook(s, flags);
+	s = slab_pre_alloc_hook(s, &memcg, size, flags);
 	if (!s)
 		return 0;
 
@@ -3528,13 +3532,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 		for (i = 0; i < size; i++)
 			memset(p[i], 0, s->object_size);
 
-	slab_post_alloc_hook(s, flags, size, p);
+	slab_post_alloc_hook(s, memcg, flags, size, p);
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
 	return size;
 error:
 	local_irq_enable();
 	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
-	slab_post_alloc_hook(s, flags, i, p);
+	slab_post_alloc_hook(s, memcg, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
diff --git a/mm/slab.h b/mm/slab.h
index 16d7ea30a2d3..39d93c970839 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -423,6 +423,45 @@ static inline void memcg_free_page_memcg_vec(struct page *page)
 	page->mem_cgroup_vec = NULL;
 }
 
+static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					      struct mem_cgroup *memcg,
+					      size_t size, void **p)
+{
+	struct mem_cgroup_ptr *memcg_ptr;
+	struct page *page;
+	unsigned long off;
+	size_t i;
+
+	memcg_ptr = mem_cgroup_get_kmem_ptr(memcg);
+	for (i = 0; i < size; i++) {
+		if (likely(p[i])) {
+			page = virt_to_head_page(p[i]);
+			off = obj_to_index(s, page, p[i]);
+			mem_cgroup_ptr_get(memcg_ptr);
+			page->mem_cgroup_vec[off] = memcg_ptr;
+		}
+	}
+	mem_cgroup_ptr_put(memcg_ptr);
+	mem_cgroup_put(memcg);
+
+	memcg_kmem_put_cache(s);
+}
+
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
+					void *p)
+{
+	struct mem_cgroup_ptr *memcg_ptr;
+	unsigned int off;
+
+	if (!memcg_kmem_enabled() || is_root_cache(s))
+		return;
+
+	off = obj_to_index(s, page, p);
+	memcg_ptr = page->mem_cgroup_vec[off];
+	page->mem_cgroup_vec[off] = NULL;
+	mem_cgroup_ptr_put(memcg_ptr);
+}
+
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *memcg);
 
@@ -482,6 +521,17 @@ static inline void memcg_free_page_memcg_vec(struct page *page)
 {
 }
 
+static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					      struct mem_cgroup *memcg,
+					      size_t size, void **p)
+{
+}
+
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
+					void *p)
+{
+}
+
 static inline void slab_init_memcg_params(struct kmem_cache *s)
 {
 }
@@ -591,7 +641,8 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 }
 
 static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
-						     gfp_t flags)
+						     struct mem_cgroup **memcgp,
+						     size_t size, gfp_t flags)
 {
 	flags &= gfp_allowed_mask;
 
@@ -605,13 +656,14 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
 	if (memcg_kmem_enabled() &&
 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
-		return memcg_kmem_get_cache(s);
+		return memcg_kmem_get_cache(s, memcgp);
 
 	return s;
 }
 
-static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
-					size_t size, void **p)
+static inline void slab_post_alloc_hook(struct kmem_cache *s,
+					struct mem_cgroup *memcg,
+					gfp_t flags, size_t size, void **p)
 {
 	size_t i;
 
@@ -623,8 +675,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 					 s->flags, flags);
 	}
 
-	if (memcg_kmem_enabled())
-		memcg_kmem_put_cache(s);
+	if (!is_root_cache(s))
+		memcg_slab_post_alloc_hook(s, memcg, size, p);
 }
 
 #ifndef CONFIG_SLOB
diff --git a/mm/slub.c b/mm/slub.c
index b043cfb673c9..e8c44144a85f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2686,8 +2686,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	struct kmem_cache_cpu *c;
 	struct page *page;
 	unsigned long tid;
+	struct mem_cgroup *memcg = NULL;
 
-	s = slab_pre_alloc_hook(s, gfpflags);
+	s = slab_pre_alloc_hook(s, &memcg, 1, gfpflags);
 	if (!s)
 		return NULL;
 redo:
@@ -2767,7 +2768,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
 		memset(object, 0, s->object_size);
 
-	slab_post_alloc_hook(s, gfpflags, 1, &object);
+	slab_post_alloc_hook(s, memcg, gfpflags, 1, &object);
 
 	return object;
 }
@@ -2972,6 +2973,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	void *tail_obj = tail ? : head;
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
+
+	memcg_slab_free_hook(s, page, head);
 redo:
 	/*
 	 * Determine the currently cpus per cpu slab.
@@ -3149,9 +3152,10 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 {
 	struct kmem_cache_cpu *c;
 	int i;
+	struct mem_cgroup *memcg = NULL;
 
 	/* memcg and kmem_cache debug support */
-	s = slab_pre_alloc_hook(s, flags);
+	s = slab_pre_alloc_hook(s, &memcg, size, flags);
 	if (unlikely(!s))
 		return false;
 	/*
@@ -3193,11 +3197,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 
 	/* memcg and kmem_cache debug support */
-	slab_post_alloc_hook(s, flags, size, p);
+	slab_post_alloc_hook(s, memcg, flags, size, p);
 	return i;
 error:
 	local_irq_enable();
-	slab_post_alloc_hook(s, flags, i, p);
+	slab_post_alloc_hook(s, memcg, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
-- 
2.21.0

