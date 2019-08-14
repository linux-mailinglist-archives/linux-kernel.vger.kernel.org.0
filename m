Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9D8CEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfHNIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 04:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfHNIls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EB9E307D84B;
        Wed, 14 Aug 2019 08:41:47 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DBD1348C8;
        Wed, 14 Aug 2019 08:41:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH V4 3/3] genirq/affinity: Spread vectors on node according to nr_cpu ratio
Date:   Wed, 14 Aug 2019 16:40:44 +0800
Message-Id: <20190814084044.21699-4-ming.lei@redhat.com>
In-Reply-To: <20190814084044.21699-1-ming.lei@redhat.com>
References: <20190814084044.21699-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 14 Aug 2019 08:41:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now __irq_build_affinity_masks() spreads vectors evenly per node, and
all vectors may not be spread in case that each numa node has different
CPU number, then the warning in irq_build_affinity_masks() can
be triggered.

Improve current spreading algorithm by assigning vectors according to
the ratio of node's nr_cpu to nr_remaining_cpus, meantime running the
assignment from smaller nodes to bigger nodes to guarantee that every
active node gets allocated at least one vector, then we can avoid
cross-node spread.

Meantime the reported warning can be fixed.

Another big goodness is that the spread approach becomes more fair if
node has different CPU number.

For example, on the following machine:
	[root@ktest-01 ~]# lscpu
	...
	CPU(s):              16
	On-line CPU(s) list: 0-15
	Thread(s) per core:  1
	Core(s) per socket:  8
	Socket(s):           2
	NUMA node(s):        2
	...
	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
	NUMA node1 CPU(s):   2,4,10,12

When driver requests to allocate 8 vectors, the following spread can
be got:
	irq 31, cpu list 2,4
	irq 32, cpu list 10,12
	irq 33, cpu list 0-1
	irq 34, cpu list 3,5
	irq 35, cpu list 6-7
	irq 36, cpu list 8-9
	irq 37, cpu list 11,13
	irq 38, cpu list 14-15

Without this patch, kernel warning is triggered on above situation, and
allocation result was supposed to be 4 vectors for each node.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 246 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 206 insertions(+), 40 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4e329495e9dc..3998b382ac29 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/sort.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_vec)
@@ -94,6 +95,177 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
+struct node_nr_vectors {
+	unsigned n;
+
+	union {
+		unsigned nvectors;
+		unsigned ncpus;
+	};
+};
+
+static int ncpus_cmp_func(const void *l, const void *r)
+{
+	const struct node_nr_vectors *ln = l;
+	const struct node_nr_vectors *rn = r;
+
+	return ln->ncpus - rn->ncpus;
+}
+
+static void alloc_nodes_vectors(unsigned int numvecs,
+				const cpumask_var_t *node_to_cpumask,
+				const struct cpumask *cpu_mask,
+				const nodemask_t nodemsk,
+				struct cpumask *nmsk,
+				struct node_nr_vectors *node_vectors)
+{
+	unsigned remaining_ncpus = 0;
+	unsigned n;
+
+	for (n = 0; n < nr_node_ids; n++) {
+		node_vectors[n].n = n;
+		node_vectors[n].ncpus = UINT_MAX;
+	}
+
+	for_each_node_mask(n, nodemsk) {
+		unsigned ncpus;
+
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		ncpus = cpumask_weight(nmsk);
+
+		if (!ncpus)
+			continue;
+		remaining_ncpus += ncpus;
+		node_vectors[n].ncpus = ncpus;
+	}
+
+	WARN_ON_ONCE(remaining_ncpus < numvecs);
+
+	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
+	     ncpus_cmp_func, NULL);
+
+	/*
+	 * Allocate vectors for each node according to the ratio of this
+	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
+	 * bigger than number of active numa nodes. Always start the
+	 * allocation from the node with minimized nr_cpus.
+	 *
+	 * This way guarantees that each active node gets allocated at
+	 * least one vector, and the theory is simple: over-allocation
+	 * is only done when this node is assigned by one vector, so
+	 * other nodes will be allocated >= 1 vector, since 'numvecs' is
+	 * bigger than number of numa nodes.
+	 *
+	 * One perfect invariant is that number of allocated vectors for
+	 * each node is <= CPU count of this node:
+	 *
+	 * 1) suppose there are two nodes: A and B
+	 * 	ncpu(X) is CPU count of node X
+	 * 	vecs(X) is the vector count allocated to node X via this
+	 * 	algorithm
+	 *
+	 * 	ncpu(A) <= ncpu(B)
+	 * 	ncpu(A) + ncpu(B) = N
+	 * 	vecs(A) + vecs(B) = V
+	 *
+	 * 	vecs(A) = max(1, round_down(V * ncpu(A) / N))
+	 * 	vecs(B) = V - vecs(A)
+	 *
+	 * 	both N and V are integer, and 2 <= V <= N, suppose
+	 * 	V = N - delta, and 0 <= delta <= N - 2
+	 *
+	 * 2) obviously vecs(A) <= ncpu(A) because:
+	 *
+	 * 	if vecs(A) is 1, then vecs(A) <= ncpu(A) given
+	 * 	ncpu(A) >= 1
+	 *
+	 * 	otherwise,
+	 * 		vecs(A) <= V * ncpu(A) / N <= ncpu(A), given V <= N
+	 *
+	 * 3) prove how vecs(B) <= ncpu(B):
+	 *
+	 * 	if round_down(V * ncpu(A) / N) == 0, vecs(B) won't be
+	 * 	over-allocated, so vecs(B) <= ncpu(B),
+	 *
+	 * 	otherwise:
+	 *
+	 * 	vecs(A) =
+	 * 		round_down(V * ncpu(A) / N) =
+	 * 		round_down((N - delta) * ncpu(A) / N) =
+	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=
+	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =
+	 * 		cpu(A) - delta
+	 *
+	 * 	then:
+	 *
+	 * 	vecs(A) - V >= cpu(A) - delta - V
+	 * 	=>
+	 * 	V - vecs(A) <= V + delta - cpu(A)
+	 * 	=>
+	 * 	vecs(B) <= N - cpu(A)
+	 * 	=>
+	 * 	vecs(B) <= cpu(B)
+	 *
+	 *
+	 * For nodes >= 3, it can be thought as one node and another big
+	 * node given that is exactly what this algorithm is implemented,
+	 * and we always re-calculate 'remaining_ncpus' & 'numvecs', and
+	 * finally for each node X: vecs(X) <= ncpu(X).
+	 *
+	 */
+	for (n = 0; n < nr_node_ids; n++) {
+		unsigned nvectors, ncpus;
+
+		if (node_vectors[n].ncpus == UINT_MAX)
+			continue;
+
+		WARN_ON_ONCE(numvecs == 0);
+
+		ncpus = node_vectors[n].ncpus;
+		nvectors = max_t(unsigned, 1,
+				 numvecs * ncpus / remaining_ncpus);
+		WARN_ON_ONCE(nvectors > ncpus);
+
+		node_vectors[n].nvectors = nvectors;
+
+		remaining_ncpus -= ncpus;
+		numvecs -= nvectors;
+	}
+}
+
+/**
+ * irq_spread_vectors_on_node - Spread vectors on one node
+ * @curvec:	The 1st vector to be spread
+ * @numvecs:	The number of vectors to be spread
+ * @nmsk:	The cpumask of this node
+ * @masks:	The cpumask array for storing vector affinity
+ */
+static void irq_spread_vectors_on_node(unsigned curvec, unsigned numvecs,
+				       struct cpumask *nmsk,
+				       struct irq_affinity_desc *masks)
+{
+	unsigned ncpus = cpumask_weight(nmsk);
+	unsigned v, vecs_to_assign, extra_vecs;
+
+	vecs_to_assign = numvecs;
+	WARN_ON_ONCE(vecs_to_assign > ncpus);
+
+	/* Account for rounding errors */
+	extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
+
+	for (v = 0; v < vecs_to_assign; v++, curvec++) {
+		unsigned cpus_per_vec = ncpus / vecs_to_assign;
+
+		/* Account for extra vectors to compensate rounding errors */
+		if (extra_vecs) {
+			cpus_per_vec++;
+			--extra_vecs;
+		}
+		irq_spread_init_one(&masks[curvec].mask, nmsk,
+					cpus_per_vec);
+	}
+}
+
 static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
@@ -102,10 +274,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 				      struct cpumask *nmsk,
 				      struct irq_affinity_desc *masks)
 {
-	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	unsigned int i, n, nodes, done = 0;
 	unsigned int last_affv = firstvec + numvecs;
 	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
+	struct node_nr_vectors *node_vectors;
 
 	if (!cpumask_weight(cpu_mask))
 		return 0;
@@ -126,52 +299,36 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		return numvecs;
 	}
 
-	for_each_node_mask(n, nodemsk) {
-		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
+	node_vectors = kcalloc(nr_node_ids,
+			       sizeof(struct node_nr_vectors),
+			       GFP_KERNEL);
+	if (!node_vectors)
+		return -ENOMEM;
+
+	alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
+			    nodemsk, nmsk, node_vectors);
+
+	for (i = 0; i < nr_node_ids; i++) {
+		unsigned int ncpus;
+		struct node_nr_vectors *nv = &node_vectors[i];
+
+		if (nv->nvectors == UINT_MAX)
+			continue;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->n]);
 		ncpus = cpumask_weight(nmsk);
 		if (!ncpus)
 			continue;
 
-		/*
-		 * Calculate the number of cpus per vector
-		 *
-		 * Spread the vectors evenly per node. If the requested
-		 * vector number has been reached, simply allocate one
-		 * vector for each remaining node so that all nodes can
-		 * be covered
-		 */
-		if (numvecs > done)
-			vecs_per_node = max_t(unsigned,
-					(numvecs - done) / nodes, 1);
-		else
-			vecs_per_node = 1;
-
-		vecs_to_assign = min(vecs_per_node, ncpus);
-
-		/* Account for rounding errors */
-		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
-
-		for (v = 0; curvec < last_affv && v < vecs_to_assign;
-		     curvec++, v++) {
-			cpus_per_vec = ncpus / vecs_to_assign;
-
-			/* Account for extra vectors to compensate rounding errors */
-			if (extra_vecs) {
-				cpus_per_vec++;
-				--extra_vecs;
-			}
-			irq_spread_init_one(&masks[curvec].mask, nmsk,
-						cpus_per_vec);
-		}
+		WARN_ON_ONCE(nv->nvectors == UINT_MAX);
+		WARN_ON_ONCE(curvec + nv->nvectors > last_affv);
+		irq_spread_vectors_on_node(curvec, nv->nvectors, nmsk, masks);
 
-		done += v;
-		if (curvec >= last_affv)
-			curvec = firstvec;
-		--nodes;
+		curvec += nv->nvectors;
+		done += nv->nvectors;
 	}
+	kfree(node_vectors);
 	return done < numvecs ? done : numvecs;
 }
 
@@ -208,6 +365,10 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	nr_present = __irq_build_affinity_masks(curvec, numvecs,
 						firstvec, node_to_cpumask,
 						cpu_present_mask, nmsk, masks);
+	if (nr_present < 0) {
+		ret = nr_present;
+		goto fail_build_affinity;
+	}
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -223,9 +384,14 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	nr_others = __irq_build_affinity_masks(curvec, numvecs,
 					       firstvec, node_to_cpumask,
 					       npresmsk, nmsk, masks);
+	if (nr_others < 0)
+		ret = nr_others;
+
+ fail_build_affinity:
 	put_online_cpus();
 
-	WARN_ON(max(nr_present, nr_others) < numvecs);
+	WARN_ON(min(nr_present, nr_others) >= 0 &&
+			max(nr_present, nr_others) < numvecs);
 
 	free_node_to_cpumask(node_to_cpumask);
 
-- 
2.20.1

