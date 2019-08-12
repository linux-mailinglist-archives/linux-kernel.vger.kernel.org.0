Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00CF8AA66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfHLW3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 18:29:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61928 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbfHLW3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:29:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CMSIeW006487
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Mfrr8Xw2C4rnCe8MlSyOOMv/TBZbeQfOjb2uduJ/SA8=;
 b=esPmQS0x5+14wqSBGe0culn+uPAo/uPoHKejhGJBlCxLikT6Hc39ra0WkS6oPyENrGBI
 V3Pyom+9D+Xv9H73tlGoxlRE+kAeoICFI4Ac/Zbh8ltCW3QZbIe8zMS4HwpLlgEpbcx/
 +S9zwR3bbPjeKBC0o2alxUQD7lxA9hf1epc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ubecv8nc3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:29:19 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 12 Aug 2019 15:29:16 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 1A7FA163FCBF6; Mon, 12 Aug 2019 15:29:14 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/2] mm: memcontrol: flush percpu vmstats before releasing memcg
Date:   Mon, 12 Aug 2019 15:29:10 -0700
Message-ID: <20190812222911.2364802-2-guro@fb.com>
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120219
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Percpu caching of local vmstats with the conditional propagation
by the cgroup tree leads to an accumulation of errors on non-leaf
levels.

Let's imagine two nested memory cgroups A and A/B. Say, a process
belonging to A/B allocates 100 pagecache pages on the CPU 0.
The percpu cache will spill 3 times, so that 32*3=96 pages will be
accounted to A/B and A atomic vmstat counters, 4 pages will remain
in the percpu cache.

Imagine A/B is nearby memory.max, so that every following allocation
triggers a direct reclaim on the local CPU. Say, each such attempt
will free 16 pages on a new cpu. That means every percpu cache will
have -16 pages, except the first one, which will have 4 - 16 = -12.
A/B and A atomic counters will not be touched at all.

Now a user removes A/B. All percpu caches are freed and corresponding
vmstat numbers are forgotten. A has 96 pages more than expected.

As memory cgroups are created and destroyed, errors do accumulate.
Even 1-2 pages differences can accumulate into large numbers.

To fix this issue let's accumulate and propagate percpu vmstat
values before releasing the memory cgroup. At this point these
numbers are stable and cannot be changed.

Since on cpu hotplug we do flush percpu vmstats anyway, we can
iterate only over online cpus.

Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e821f34399f..348f685ab94b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3412,6 +3412,41 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	return 0;
 }
 
+static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
+{
+	unsigned long stat[MEMCG_NR_STAT];
+	struct mem_cgroup *mi;
+	int node, cpu, i;
+
+	for (i = 0; i < MEMCG_NR_STAT; i++)
+		stat[i] = 0;
+
+	for_each_online_cpu(cpu)
+		for (i = 0; i < MEMCG_NR_STAT; i++)
+			stat[i] += raw_cpu_read(memcg->vmstats_percpu->stat[i]);
+
+	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
+		for (i = 0; i < MEMCG_NR_STAT; i++)
+			atomic_long_add(stat[i], &mi->vmstats[i]);
+
+	for_each_node(node) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
+		struct mem_cgroup_per_node *pi;
+
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+			stat[i] = 0;
+
+		for_each_online_cpu(cpu)
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				stat[i] += raw_cpu_read(
+					pn->lruvec_stat_cpu->count[i]);
+
+		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
+	}
+}
+
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 	struct cgroup_subsys_state *css;
@@ -4805,6 +4840,11 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	int node;
 
+	/*
+	 * Flush percpu vmstats to guarantee the value correctness
+	 * on parent's and all ancestor levels.
+	 */
+	memcg_flush_percpu_vmstats(memcg);
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
 	free_percpu(memcg->vmstats_percpu);
-- 
2.21.0

