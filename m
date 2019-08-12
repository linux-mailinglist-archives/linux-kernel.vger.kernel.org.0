Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7AE8AA65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHLW3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 18:29:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727017AbfHLW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:29:19 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x7CMTHZu029599
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:29:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=SQoTC+NCQQ9W6x5cD8PLwp0PTrO5Opz10F4qJlZ53tY=;
 b=TLnOzqgzRboIpRY4BnaeQovFE15XNzwfELwSI4KfQxuMZncrNZXqmf1zF3r+EKjgjk7m
 K8Xd09EQ8mjEcLt/zfM+r/aEnXuELcYzQWixQlfmYrrKJDV6w0kAbVWaLveswp8Wmhyq
 wDept8AaR4Knz+nTWsEabeI1zxjmo4E5Fz0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2ubbe5hkaw-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:29:18 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 15:29:15 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 1E13E163FCBF8; Mon, 12 Aug 2019 15:29:14 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 2/2] mm: memcontrol: flush percpu slab vmstats on kmem offlining
Date:   Mon, 12 Aug 2019 15:29:11 -0700
Message-ID: <20190812222911.2364802-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812222911.2364802-1-guro@fb.com>
References: <20190812222911.2364802-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=709 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120219
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that the "slab" value in memory.stat is sometimes 0,
even if some children memory cgroups have a non-zero "slab" value.
The following investigation showed that this is the result
of the kmem_cache reparenting in combination with the per-cpu
batching of slab vmstats.

At the offlining some vmstat value may leave in the percpu cache,
not being propagated upwards by the cgroup hierarchy. It means
that stats on ancestor levels are lower than actual. Later when
slab pages are released, the precise number of pages is substracted
on the parent level, making the value negative. We don't show negative
values, 0 is printed instead.

To fix this issue, let's flush percpu slab memcg and lruvec stats
on memcg offlining. This guarantees that numbers on all ancestor
levels are accurate and match the actual number of outstanding
slab pages.

Fixes: fb2f2b0adb98 ("mm: memcg/slab: reparent memcg kmem_caches on cgroup removal")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 348f685ab94b..6d2427abcc0c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3412,37 +3412,49 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	return 0;
 }
 
-static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
+static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg, bool slab_only)
 {
 	unsigned long stat[MEMCG_NR_STAT];
 	struct mem_cgroup *mi;
 	int node, cpu, i;
+	int min_idx, max_idx;
 
-	for (i = 0; i < MEMCG_NR_STAT; i++)
+	if (slab_only) {
+		min_idx = NR_SLAB_RECLAIMABLE;
+		max_idx = NR_SLAB_UNRECLAIMABLE;
+	} else {
+		min_idx = 0;
+		max_idx = MEMCG_NR_STAT;
+	}
+
+	for (i = min_idx; i < max_idx; i++)
 		stat[i] = 0;
 
 	for_each_online_cpu(cpu)
-		for (i = 0; i < MEMCG_NR_STAT; i++)
+		for (i = min_idx; i < max_idx; i++)
 			stat[i] += raw_cpu_read(memcg->vmstats_percpu->stat[i]);
 
 	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-		for (i = 0; i < MEMCG_NR_STAT; i++)
+		for (i = min_idx; i < max_idx; i++)
 			atomic_long_add(stat[i], &mi->vmstats[i]);
 
+	if (!slab_only)
+		max_idx = NR_VM_NODE_STAT_ITEMS;
+
 	for_each_node(node) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 		struct mem_cgroup_per_node *pi;
 
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+		for (i = min_idx; i < max_idx; i++)
 			stat[i] = 0;
 
 		for_each_online_cpu(cpu)
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+			for (i = min_idx; i < max_idx; i++)
 				stat[i] += raw_cpu_read(
 					pn->lruvec_stat_cpu->count[i]);
 
 		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+			for (i = min_idx; i < max_idx; i++)
 				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
 	}
 }
@@ -3467,7 +3479,14 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
+	/*
+	 * Deactivate and reparent kmem_caches. Then flush percpu
+	 * slab statistics to have precise values at the parent and
+	 * all ancestor levels. It's required to keep slab stats
+	 * accurate after the reparenting of kmem_caches.
+	 */
 	memcg_deactivate_kmem_caches(memcg, parent);
+	memcg_flush_percpu_vmstats(memcg, true);
 
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
@@ -4844,7 +4863,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 	 * Flush percpu vmstats to guarantee the value correctness
 	 * on parent's and all ancestor levels.
 	 */
-	memcg_flush_percpu_vmstats(memcg);
+	memcg_flush_percpu_vmstats(memcg, false);
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
 	free_percpu(memcg->vmstats_percpu);
-- 
2.21.0

