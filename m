Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F54AADF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 23:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfIEVqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 17:46:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732646AbfIEVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:46:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85LgktF016046
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 14:46:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jUYA9V6/76PQuUuUoRBz8Z4hZkBQOhxwB/mAKjBuibo=;
 b=b0xo5seiQRBzPeolJLt20bUGceN0SA+D2w/06RSqqA+HMXoaYd6WRwRbLZYWDneA149q
 VPBE0N6l+ymMTHo1prbnguhUIGr1kM2zd/X5hGkOuv81ZHRzn5vbm1n0TlqELpIW/tRh
 PZaFZPhk3kh5CbM+NrCTLNRCVc5vYyEvHxo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uu93b0drb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 14:46:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Sep 2019 14:46:07 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id A65A717229DFA; Thu,  5 Sep 2019 14:46:06 -0700 (PDT)
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
Subject: [PATCH RFC 02/14] mm: memcg: introduce mem_cgroup_ptr
Date:   Thu, 5 Sep 2019 14:45:46 -0700
Message-ID: <20190905214553.1643060-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905214553.1643060-1-guro@fb.com>
References: <20190905214553.1643060-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_08:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=4
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050202
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces mem_cgroup_ptr structure and corresponding API.
It implements a pointer to a memory cgroup with a built-in reference
counter. The main goal of it is to implement reparenting efficiently.

If a number of objects (e.g. slab pages) have to keep a pointer and
a reference to a memory cgroup, they can use mem_cgroup_ptr instead.
On reparenting, only one mem_cgroup_ptr->memcg pointer has to be
changed, instead of walking over all accounted objects.

mem_cgroup_ptr holds a single reference to the corresponding memory
cgroup. Because it's initialized before the css reference counter,
css's refcounter can't be bumped at allocation time. Instead, it's
bumped on reparenting which happens during offlining. A cgroup is
never released online, so it's fine.

mem_cgroup_ptr is released using rcu, so memcg->kmem_memcg_ptr can
be accessed in a rcu read section. On reparenting it's atomically
switched to NULL. If the reader gets NULL, it can just read parent's
kmem_memcg_ptr instead.

Each memory cgroup contains a list of kmem_memcg_ptrs. On reparenting
the list is spliced into the parent's list. The list is protected
using the css set lock.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 50 ++++++++++++++++++++++
 mm/memcontrol.c            | 87 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 120d39066148..dd5ebfe5a86c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -23,6 +23,7 @@
 #include <linux/page-flags.h>
 
 struct mem_cgroup;
+struct mem_cgroup_ptr;
 struct page;
 struct mm_struct;
 struct kmem_cache;
@@ -197,6 +198,22 @@ struct memcg_cgwb_frn {
 	int memcg_id;			/* memcg->css.id of foreign inode */
 	u64 at;				/* jiffies_64 at the time of dirtying */
 	struct wb_completion done;	/* tracks in-flight foreign writebacks */
+}
+
+/*
+ * A pointer to a memory cgroup with a built-in reference counter.
+ * For a use as an intermediate object to simplify reparenting of
+ * objects charged to the cgroup. The memcg pointer can be switched
+ * to the parent cgroup without a need to modify all objects
+ * which hold the reference to the cgroup.
+ */
+struct mem_cgroup_ptr {
+	struct percpu_ref refcnt;
+	struct mem_cgroup *memcg;
+	union {
+		struct list_head list;
+		struct rcu_head rcu;
+	};
 };
 
 /*
@@ -312,6 +329,8 @@ struct mem_cgroup {
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
 	struct list_head kmem_caches;
+	struct mem_cgroup_ptr __rcu *kmem_memcg_ptr;
+	struct list_head kmem_memcg_ptr_list;
 #endif
 
 	int last_scanned_node;
@@ -440,6 +459,21 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
 
+static inline bool mem_cgroup_ptr_tryget(struct mem_cgroup_ptr *ptr)
+{
+	return percpu_ref_tryget(&ptr->refcnt);
+}
+
+static inline void mem_cgroup_ptr_get(struct mem_cgroup_ptr *ptr)
+{
+	percpu_ref_get(&ptr->refcnt);
+}
+
+static inline void mem_cgroup_ptr_put(struct mem_cgroup_ptr *ptr)
+{
+	percpu_ref_put(&ptr->refcnt);
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
@@ -1433,6 +1467,22 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+static inline struct mem_cgroup_ptr *
+mem_cgroup_get_kmem_ptr(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_ptr *memcg_ptr;
+
+	rcu_read_lock();
+	do {
+		memcg_ptr = rcu_dereference(memcg->kmem_memcg_ptr);
+		if (memcg_ptr && mem_cgroup_ptr_tryget(memcg_ptr))
+			break;
+	} while ((memcg = parent_mem_cgroup(memcg)));
+	rcu_read_unlock();
+
+	return memcg_ptr;
+}
+
 #else
 
 static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index effefcec47b3..cb9adb31360e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -266,6 +266,77 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
+extern spinlock_t css_set_lock;
+
+static void memcg_ptr_release(struct percpu_ref *ref)
+{
+	struct mem_cgroup_ptr *ptr = container_of(ref, struct mem_cgroup_ptr,
+						  refcnt);
+	unsigned long flags;
+
+	spin_lock_irqsave(&css_set_lock, flags);
+	list_del(&ptr->list);
+	spin_unlock_irqrestore(&css_set_lock, flags);
+
+	mem_cgroup_put(ptr->memcg);
+	percpu_ref_exit(ref);
+	kfree_rcu(ptr, rcu);
+}
+
+static int memcg_init_kmem_memcg_ptr(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_ptr *kmem_memcg_ptr;
+	int ret;
+
+	kmem_memcg_ptr = kmalloc(sizeof(struct mem_cgroup_ptr), GFP_KERNEL);
+	if (!kmem_memcg_ptr)
+		return -ENOMEM;
+
+	ret = percpu_ref_init(&kmem_memcg_ptr->refcnt, memcg_ptr_release,
+			      0, GFP_KERNEL);
+	if (ret) {
+		kfree(kmem_memcg_ptr);
+		return ret;
+	}
+
+	kmem_memcg_ptr->memcg = memcg;
+	INIT_LIST_HEAD(&kmem_memcg_ptr->list);
+	rcu_assign_pointer(memcg->kmem_memcg_ptr, kmem_memcg_ptr);
+	list_add(&kmem_memcg_ptr->list, &memcg->kmem_memcg_ptr_list);
+	return 0;
+}
+
+static void memcg_reparent_kmem_memcg_ptr(struct mem_cgroup *memcg,
+					  struct mem_cgroup *parent)
+{
+	unsigned int nr_reparented = 0;
+	struct mem_cgroup_ptr *memcg_ptr = NULL;
+
+	rcu_swap_protected(memcg->kmem_memcg_ptr, memcg_ptr, true);
+	percpu_ref_kill(&memcg_ptr->refcnt);
+
+	/*
+	 * kmem_memcg_ptr is initialized before css refcounter, so until now
+	 * it doesn't hold a reference to the memcg. Bump it here.
+	 */
+	css_get(&memcg->css);
+
+	spin_lock_irq(&css_set_lock);
+	list_for_each_entry(memcg_ptr, &memcg->kmem_memcg_ptr_list, list) {
+		xchg(&memcg_ptr->memcg, parent);
+		nr_reparented++;
+	}
+	if (nr_reparented)
+		list_splice(&memcg->kmem_memcg_ptr_list,
+			    &parent->kmem_memcg_ptr_list);
+	spin_unlock_irq(&css_set_lock);
+
+	if (nr_reparented) {
+		css_get_many(&parent->css, nr_reparented);
+		css_put_many(&memcg->css, nr_reparented);
+	}
+}
+
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
  * The main reason for not using cgroup id for this:
@@ -3554,7 +3625,7 @@ static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
-	int memcg_id;
+	int memcg_id, ret;
 
 	if (cgroup_memory_nokmem)
 		return 0;
@@ -3566,6 +3637,12 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	if (memcg_id < 0)
 		return memcg_id;
 
+	ret = memcg_init_kmem_memcg_ptr(memcg);
+	if (ret) {
+		memcg_free_cache_id(memcg_id);
+		return ret;
+	}
+
 	static_branch_inc(&memcg_kmem_enabled_key);
 	/*
 	 * A memory cgroup is considered kmem-online as soon as it gets
@@ -3601,12 +3678,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/*
-	 * Deactivate and reparent kmem_caches. Then flush percpu
-	 * slab statistics to have precise values at the parent and
-	 * all ancestor levels. It's required to keep slab stats
+	 * Deactivate and reparent kmem_caches and reparent kmem_memcg_ptr.
+	 * Then flush percpu slab statistics to have precise values at the
+	 * parent and all ancestor levels. It's required to keep slab stats
 	 * accurate after the reparenting of kmem_caches.
 	 */
 	memcg_deactivate_kmem_caches(memcg, parent);
+	memcg_reparent_kmem_memcg_ptr(memcg, parent);
 	memcg_flush_percpu_vmstats(memcg, true);
 
 	kmemcg_id = memcg->kmemcg_id;
@@ -5171,6 +5249,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure = jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
+	INIT_LIST_HEAD(&memcg->kmem_memcg_ptr_list);
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
-- 
2.21.0

