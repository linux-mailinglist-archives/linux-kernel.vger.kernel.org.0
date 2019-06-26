Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323F756CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfFZOwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:52:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48959 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfFZOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:52:52 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hg9Hy-0004Rs-Fo; Wed, 26 Jun 2019 16:52:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] workqueue: Remove GPF argument from alloc_workqueue_attrs()
Date:   Wed, 26 Jun 2019 16:52:38 +0200
Message-Id: <20190626145238.19708-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626145238.19708-1-bigeasy@linutronix.de>
References: <[PATCH 0/2] Workqueeu code cleanup>
 <20190626145238.19708-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All callers use GFP_KERNEL. No point in having that argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8fa7afe6e7d8..601d61150b65d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3339,21 +3339,20 @@ static void free_workqueue_attrs(struct workqueue_attrs *attrs)
 
 /**
  * alloc_workqueue_attrs - allocate a workqueue_attrs
- * @gfp_mask: allocation mask to use
  *
  * Allocate a new workqueue_attrs, initialize with default settings and
  * return it.
  *
  * Return: The allocated new workqueue_attr on success. %NULL on failure.
  */
-static struct workqueue_attrs *alloc_workqueue_attrs(gfp_t gfp_mask)
+static struct workqueue_attrs *alloc_workqueue_attrs(void)
 {
 	struct workqueue_attrs *attrs;
 
-	attrs = kzalloc(sizeof(*attrs), gfp_mask);
+	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
 		goto fail;
-	if (!alloc_cpumask_var(&attrs->cpumask, gfp_mask))
+	if (!alloc_cpumask_var(&attrs->cpumask, GFP_KERNEL))
 		goto fail;
 
 	cpumask_copy(attrs->cpumask, cpu_possible_mask);
@@ -3431,7 +3430,7 @@ static int init_worker_pool(struct worker_pool *pool)
 	pool->refcnt = 1;
 
 	/* shouldn't fail above this point */
-	pool->attrs = alloc_workqueue_attrs(GFP_KERNEL);
+	pool->attrs = alloc_workqueue_attrs();
 	if (!pool->attrs)
 		return -ENOMEM;
 	return 0;
@@ -3896,8 +3895,8 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 
 	ctx = kzalloc(struct_size(ctx, pwq_tbl, nr_node_ids), GFP_KERNEL);
 
-	new_attrs = alloc_workqueue_attrs(GFP_KERNEL);
-	tmp_attrs = alloc_workqueue_attrs(GFP_KERNEL);
+	new_attrs = alloc_workqueue_attrs();
+	tmp_attrs = alloc_workqueue_attrs();
 	if (!ctx || !new_attrs || !tmp_attrs)
 		goto out_free;
 
@@ -4241,7 +4240,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 		return NULL;
 
 	if (flags & WQ_UNBOUND) {
-		wq->unbound_attrs = alloc_workqueue_attrs(GFP_KERNEL);
+		wq->unbound_attrs = alloc_workqueue_attrs();
 		if (!wq->unbound_attrs)
 			goto err_free_wq;
 	}
@@ -5394,7 +5393,7 @@ static struct workqueue_attrs *wq_sysfs_prep_attrs(struct workqueue_struct *wq)
 
 	lockdep_assert_held(&wq_pool_mutex);
 
-	attrs = alloc_workqueue_attrs(GFP_KERNEL);
+	attrs = alloc_workqueue_attrs();
 	if (!attrs)
 		return NULL;
 
@@ -5816,7 +5815,7 @@ static void __init wq_numa_init(void)
 		return;
 	}
 
-	wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs(GFP_KERNEL);
+	wq_update_unbound_numa_attrs_buf = alloc_workqueue_attrs();
 	BUG_ON(!wq_update_unbound_numa_attrs_buf);
 
 	/*
@@ -5891,7 +5890,7 @@ int __init workqueue_init_early(void)
 	for (i = 0; i < NR_STD_WORKER_POOLS; i++) {
 		struct workqueue_attrs *attrs;
 
-		BUG_ON(!(attrs = alloc_workqueue_attrs(GFP_KERNEL)));
+		BUG_ON(!(attrs = alloc_workqueue_attrs()));
 		attrs->nice = std_nice[i];
 		unbound_std_wq_attrs[i] = attrs;
 
@@ -5900,7 +5899,7 @@ int __init workqueue_init_early(void)
 		 * guaranteed by max_active which is enforced by pwqs.
 		 * Turn off NUMA so that dfl_pwq is used for all nodes.
 		 */
-		BUG_ON(!(attrs = alloc_workqueue_attrs(GFP_KERNEL)));
+		BUG_ON(!(attrs = alloc_workqueue_attrs()));
 		attrs->nice = std_nice[i];
 		attrs->no_numa = true;
 		ordered_wq_attrs[i] = attrs;
-- 
2.20.1

