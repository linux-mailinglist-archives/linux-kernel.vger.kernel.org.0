Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64E7B00E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfG3RcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:32:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:35737 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfG3RcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:32:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 10:32:10 -0700
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="162655275"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 10:32:09 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 03/10] x86/resctrl: Constrain C-states during pseudo-lock region init
Date:   Tue, 30 Jul 2019 10:29:37 -0700
Message-Id: <09cf7df01a110f5b50dd570017a2c23e5a957643.1564504901.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1564504901.git.reinette.chatre@intel.com>
References: <cover.1564504901.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1564504901.git.reinette.chatre@intel.com>
References: <cover.1564504901.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUs associated with a pseudo-locked cache region are prevented
from entering C6 and deeper C-states to ensure that the
power savings associated with those C-states cannot impact
the pseudo-locked region by forcing the pseudo-locked memory to
be evicted.

When supporting pseudo-locked regions that span L2 and L3 cache
levels it is not necessary to prevent all CPUs associated with both
cache levels from entering deeper C-states. Instead, only the
CPUs associated with the L2 cache need to be limited. This would
potentially result in more power savings since another L2 cache
that does not have a pseudo-locked region but share the L3 cache
would be able to enter power savings.

In preparation for limiting the C-states only where required the code to
do so is moved to earlier in the pseudo-lock region initialization.
Moving this code has the consequence that its actions need to be undone
in more error paths. This is accommodated by moving the C-state cleanup
code to the generic cleanup code (pseudo_lock_region_clear()) and
ensuring that the C-state cleanup code can handle the case when C-states
have not yet been constrained.

Also in preparation for limiting the C-states only on required CPUs the
function now accepts a parameter that specifies which CPUs should have
their C-states constrained - at this time the parameter is still used
for all CPUs associated with the pseudo-locked region.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 30 ++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d7623e1b927d..110ae4b4f2e4 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -175,6 +175,9 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
 {
 	struct pseudo_lock_pm_req *pm_req, *next;
 
+	if (list_empty(&plr->pm_reqs))
+		return;
+
 	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
 		dev_pm_qos_remove_request(&pm_req->req);
 		list_del(&pm_req->list);
@@ -184,6 +187,8 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
 
 /**
  * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ * @plr: pseudo-lock region requiring the C-states to be restricted
+ * @cpu_mask: the CPUs that should have their C-states restricted
  *
  * To prevent the cache from being affected by power management entering
  * C6 has to be avoided. This is accomplished by requesting a latency
@@ -197,13 +202,14 @@ static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
  * may be set to map to deeper sleep states. In this case the latency
  * requirement needs to prevent entering C2 also.
  */
-static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
+static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr,
+					 struct cpumask *cpu_mask)
 {
 	struct pseudo_lock_pm_req *pm_req;
 	int cpu;
 	int ret;
 
-	for_each_cpu(cpu, &plr->d->cpu_mask) {
+	for_each_cpu(cpu, cpu_mask) {
 		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
 		if (!pm_req) {
 			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
@@ -251,6 +257,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 		plr->d->plr = NULL;
 	plr->d = NULL;
 	plr->cbm = 0;
+	pseudo_lock_cstates_relax(plr);
 	plr->debugfs_dir = NULL;
 }
 
@@ -292,6 +299,10 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 
 	plr->size = rdtgroup_cbm_to_size(plr->r, plr->d, plr->cbm);
 
+	ret = pseudo_lock_cstates_constrain(plr, &plr->d->cpu_mask);
+	if (ret < 0)
+		goto out_region;
+
 	for (i = 0; i < ci->num_leaves; i++) {
 		if (ci->info_list[i].level == plr->r->cache_level) {
 			plr->line_size = ci->info_list[i].coherency_line_size;
@@ -1280,12 +1291,6 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	if (ret < 0)
 		return ret;
 
-	ret = pseudo_lock_cstates_constrain(plr);
-	if (ret < 0) {
-		ret = -EINVAL;
-		goto out_region;
-	}
-
 	plr->thread_done = 0;
 
 	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
@@ -1294,7 +1299,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
 		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
-		goto out_cstates;
+		goto out_region;
 	}
 
 	kthread_bind(thread, plr->cpu);
@@ -1312,13 +1317,13 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 		 * empty pseudo-locking loop.
 		 */
 		rdt_last_cmd_puts("Locking thread interrupted\n");
-		goto out_cstates;
+		goto out_region;
 	}
 
 	ret = pseudo_lock_minor_get(&new_minor);
 	if (ret < 0) {
 		rdt_last_cmd_puts("Unable to obtain a new minor number\n");
-		goto out_cstates;
+		goto out_region;
 	}
 
 	/*
@@ -1375,8 +1380,6 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 out_debugfs:
 	debugfs_remove_recursive(plr->debugfs_dir);
 	pseudo_lock_minor_release(new_minor);
-out_cstates:
-	pseudo_lock_cstates_relax(plr);
 out_region:
 	pseudo_lock_region_clear(plr);
 out:
@@ -1410,7 +1413,6 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 		goto free;
 	}
 
-	pseudo_lock_cstates_relax(plr);
 	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
 	device_destroy(pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
 	pseudo_lock_minor_release(plr->minor);
-- 
2.17.2

