Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60089AB042
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 03:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbfIFBlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 21:41:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391915AbfIFBlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:41:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x861ck45189430;
        Fri, 6 Sep 2019 01:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=1s4nuL/PMKbVHVILGI6lwhVsen/3JOXUr2oCSjWjR2k=;
 b=c2PBu0xWun+wz3Rgbq1aQxYGVMFJByzI77EWGxP/vaCW6pM09FUL2B7No/QILMilWcgg
 J9UYh+lfQ1mb5T9v2A4Jsg9HkcoYvzLWezd7N2r4DwHCjxv9P/uC/Ie4O8VXe5ZY29Qt
 4evuIR8wlj0wvGOH1eXNLDvY17nyOjqufZ213tIztmAVy03n07QLupPQvEL4jei3oRsZ
 xfYOJh5EHMHv71OWXvR7fONhEiB0STkkKZOVt+b+n5B06mN0v95Y5tZ5fs+NvyxJDZwB
 l0S6k0PUFYQ0sPZz3t3B6m3um5HfnmL5OTchudGjRmdyncS6Gub7SATSvIsAZXpKrOSX jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uudjc82w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 01:40:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x861bhd6107503;
        Fri, 6 Sep 2019 01:40:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uud7p0vg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 01:40:46 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x861eha3007174;
        Fri, 6 Sep 2019 01:40:43 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Sep 2019 18:40:42 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v3 7/9] padata: use separate workqueues for parallel and serial work
Date:   Thu,  5 Sep 2019 21:40:27 -0400
Message-Id: <20190906014029.3345-8-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906014029.3345-1-daniel.m.jordan@oracle.com>
References: <20190906014029.3345-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

padata currently uses one per-CPU workqueue per instance for all work.

Prepare for running parallel jobs on an unbound workqueue by introducing
dedicated workqueues for parallel and serial work.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/padata.h |  6 ++++--
 kernel/padata.c        | 28 ++++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index f7851f8e2190..e7978f8942ca 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -127,7 +127,8 @@ struct parallel_data {
  * struct padata_instance - The overall control structure.
  *
  * @cpu_notifier: cpu hotplug notifier.
- * @wq: The workqueue in use.
+ * @parallel_wq: The workqueue used for parallel work.
+ * @serial_wq: The workqueue used for serial work.
  * @pd: The internal control structure.
  * @cpumask: User supplied cpumasks for parallel and serial works.
  * @cpumask_change_notifier: Notifiers chain for user-defined notify
@@ -139,7 +140,8 @@ struct parallel_data {
  */
 struct padata_instance {
 	struct hlist_node		 node;
-	struct workqueue_struct		*wq;
+	struct workqueue_struct		*parallel_wq;
+	struct workqueue_struct		*serial_wq;
 	struct parallel_data		*pd;
 	struct padata_cpumask		cpumask;
 	struct blocking_notifier_head	 cpumask_change_notifier;
diff --git a/kernel/padata.c b/kernel/padata.c
index 8a362923c488..669f5d53d357 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -152,7 +152,7 @@ int padata_do_parallel(struct padata_instance *pinst,
 	list_add_tail(&padata->list, &queue->parallel.list);
 	spin_unlock(&queue->parallel.lock);
 
-	queue_work_on(target_cpu, pinst->wq, &queue->work);
+	queue_work_on(target_cpu, pinst->parallel_wq, &queue->work);
 
 out:
 	rcu_read_unlock_bh();
@@ -261,7 +261,7 @@ static void padata_reorder(struct parallel_data *pd)
 		list_add_tail(&padata->list, &squeue->serial.list);
 		spin_unlock(&squeue->serial.lock);
 
-		queue_work_on(cb_cpu, pinst->wq, &squeue->work);
+		queue_work_on(cb_cpu, pinst->serial_wq, &squeue->work);
 	}
 
 	spin_unlock_bh(&pd->lock);
@@ -278,7 +278,7 @@ static void padata_reorder(struct parallel_data *pd)
 
 	next_queue = per_cpu_ptr(pd->pqueue, pd->cpu);
 	if (!list_empty(&next_queue->reorder.list))
-		queue_work(pinst->wq, &pd->reorder_work);
+		queue_work(pinst->serial_wq, &pd->reorder_work);
 }
 
 static void invoke_padata_reorder(struct work_struct *work)
@@ -818,7 +818,8 @@ static void __padata_free(struct padata_instance *pinst)
 	padata_free_pd(pinst->pd);
 	free_cpumask_var(pinst->cpumask.pcpu);
 	free_cpumask_var(pinst->cpumask.cbcpu);
-	destroy_workqueue(pinst->wq);
+	destroy_workqueue(pinst->serial_wq);
+	destroy_workqueue(pinst->parallel_wq);
 	kfree(pinst);
 }
 
@@ -967,18 +968,23 @@ static struct padata_instance *padata_alloc(const char *name,
 	if (!pinst)
 		goto err;
 
-	pinst->wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE,
-				    1, name);
-	if (!pinst->wq)
+	pinst->parallel_wq = alloc_workqueue("%s_parallel", WQ_MEM_RECLAIM |
+					     WQ_CPU_INTENSIVE, 1, name);
+	if (!pinst->parallel_wq)
 		goto err_free_inst;
 
 	get_online_cpus();
 
-	if (!alloc_cpumask_var(&pinst->cpumask.pcpu, GFP_KERNEL))
+	pinst->serial_wq = alloc_workqueue("%s_serial", WQ_MEM_RECLAIM |
+					   WQ_CPU_INTENSIVE, 1, name);
+	if (!pinst->serial_wq)
 		goto err_put_cpus;
+
+	if (!alloc_cpumask_var(&pinst->cpumask.pcpu, GFP_KERNEL))
+		goto err_free_serial_wq;
 	if (!alloc_cpumask_var(&pinst->cpumask.cbcpu, GFP_KERNEL)) {
 		free_cpumask_var(pinst->cpumask.pcpu);
-		goto err_put_cpus;
+		goto err_free_serial_wq;
 	}
 	if (!padata_validate_cpumask(pinst, pcpumask) ||
 	    !padata_validate_cpumask(pinst, cbcpumask))
@@ -1010,9 +1016,11 @@ static struct padata_instance *padata_alloc(const char *name,
 err_free_masks:
 	free_cpumask_var(pinst->cpumask.pcpu);
 	free_cpumask_var(pinst->cpumask.cbcpu);
+err_free_serial_wq:
+	destroy_workqueue(pinst->serial_wq);
 err_put_cpus:
 	put_online_cpus();
-	destroy_workqueue(pinst->wq);
+	destroy_workqueue(pinst->parallel_wq);
 err_free_inst:
 	kfree(pinst);
 err:
-- 
2.23.0

