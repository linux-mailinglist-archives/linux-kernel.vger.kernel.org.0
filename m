Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9519B4E8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbgDARva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 13:51:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:55330 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbgDARv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:51:26 -0400
IronPort-SDR: 5wf7e/rdUByZ5P2mZgdXs5n6xFzhoTUv75RL5Y9mFWmEIh0gM1kLHRGbhpxXYRXxAJK+pdBzcz
 npNCEQXJGo0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 10:51:25 -0700
IronPort-SDR: 6aqzB7MVLFyXXnNawJl/9zpoW7rrsre3Uqf3HeVLGuWQzR5KvV7qMxbeqZx+iXcTWBTEyGnpn8
 C3UXbWI7y2qA==
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="422809392"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 10:51:24 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 1/2] x86/resctrl: Maintain MBM counter width per resource
Date:   Wed,  1 Apr 2020 10:51:01 -0700
Message-Id: <8c41a185db1f07dd79a57f5039441ad2c74fcf1b.1585763047.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1585763047.git.reinette.chatre@intel.com>
References: <cover.1585763047.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits in the IA32_QM_CTR MSR,
and the first-generation MBM implementation uses 24 bit counters.
Software is required to poll at 1 second or faster to ensure that
data is retrieved before a counter rollover occurs more than once
under worst conditions.

As system bandwidths scale the software requirement is maintained with
the introduction of a per-resource enumerable MBM counter width.

In preparation for supporting hardware with an enumerable MBM counter
width the current globally static MBM counter width is moved to a
per-resource MBM counter width. Currently initialized to 24 always
to result in no functional change.

In essence there is one function, mbm_overflow_count() that needs to
know the counter width to handle rollovers. The static value
used within mbm_overflow_count() will be replaced with a value
discovered from the hardware. Support for learning the MBM counter
width from hardware is added in the change that follows.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  8 +++++---
 arch/x86/kernel/cpu/resctrl/internal.h    |  7 +++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 21 +++++++++++++--------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 055c8613b531..934c8fb8a64a 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -495,14 +495,16 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 	return ret;
 }
 
-void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
-		    struct rdtgroup *rdtgrp, int evtid, int first)
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    int evtid, int first)
 {
 	/*
 	 * setup the parameters to send to the IPI to read the data.
 	 */
 	rr->rgrp = rdtgrp;
 	rr->evtid = evtid;
+	rr->r = r;
 	rr->d = d;
 	rr->val = 0;
 	rr->first = first;
@@ -539,7 +541,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		goto out;
 	}
 
-	mon_event_read(&rr, d, rdtgrp, evtid, false);
+	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
 	if (rr.val & RMID_VAL_ERROR)
 		seq_puts(m, "Error\n");
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 181c992f448c..28947c790faa 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -87,6 +87,7 @@ union mon_data_bits {
 
 struct rmid_read {
 	struct rdtgroup		*rgrp;
+	struct rdt_resource	*r;
 	struct rdt_domain	*d;
 	int			evtid;
 	bool			first;
@@ -460,6 +461,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	int			num_rmid;
 	unsigned int		mon_scale;
+	unsigned int		mbm_width;
 	unsigned long		fflags;
 };
 
@@ -587,8 +589,9 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    unsigned int dom_id);
 void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    struct rdt_domain *d);
-void mon_event_read(struct rmid_read *rr, struct rdt_domain *d,
-		    struct rdtgroup *rdtgrp, int evtid, int first);
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
+		    int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 773124b0e18a..df964c03f6c6 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -214,9 +214,9 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr)
+static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 {
-	u64 shift = 64 - MBM_CNTR_WIDTH, chunks;
+	u64 shift = 64 - width, chunks;
 
 	chunks = (cur_msr << shift) - (prev_msr << shift);
 	return chunks >>= shift;
@@ -256,7 +256,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	chunks = mbm_overflow_count(m->prev_msr, tval);
+	chunks = mbm_overflow_count(m->prev_msr, tval, rr->r->mbm_width);
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
@@ -278,7 +278,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
 		return;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval);
+	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
 	m->chunks_bw += chunks;
 	m->chunks = m->chunks_bw;
 	cur_bw = (chunks * r->mon_scale) >> 20;
@@ -433,11 +433,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	}
 }
 
-static void mbm_update(struct rdt_domain *d, int rmid)
+static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 {
 	struct rmid_read rr;
 
 	rr.first = false;
+	rr.r = r;
 	rr.d = d;
 
 	/*
@@ -510,6 +511,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	struct rdtgroup *prgrp, *crgrp;
 	int cpu = smp_processor_id();
 	struct list_head *head;
+	struct rdt_resource *r;
 	struct rdt_domain *d;
 
 	mutex_lock(&rdtgroup_mutex);
@@ -517,16 +519,18 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
-	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3]);
+	r = &rdt_resources_all[RDT_RESOURCE_L3];
+
+	d = get_domain_from_cpu(cpu, r);
 	if (!d)
 		goto out_unlock;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(d, prgrp->mon.rmid);
+		mbm_update(r, d, prgrp->mon.rmid);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(d, crgrp->mon.rmid);
+			mbm_update(r, d, crgrp->mon.rmid);
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
@@ -619,6 +623,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	r->mbm_width = MBM_CNTR_WIDTH;
 
 	/*
 	 * A reasonable upper limit on the max threshold is the number
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9d4e73a9b5a9..210a6fd375bd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2459,7 +2459,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 			goto out_destroy;
 
 		if (is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, d, prgrp, mevt->evtid, true);
+			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
 	kernfs_activate(kn);
 	return 0;
-- 
2.21.0

