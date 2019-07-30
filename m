Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E417B016
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfG3Rcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 13:32:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:35736 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbfG3RcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:32:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 10:32:10 -0700
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="162655278"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 10:32:10 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 04/10] x86/resctrl: Set cache line size using new utility
Date:   Tue, 30 Jul 2019 10:29:38 -0700
Message-Id: <affb28c7095e94b6fa55870f8739e6184ff4859a.1564504901.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1564504901.git.reinette.chatre@intel.com>
References: <cover.1564504901.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1564504901.git.reinette.chatre@intel.com>
References: <cover.1564504901.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for support of pseudo-locked regions spanning two
cache levels the cache line size computation is moved to a utility.

Setting of the cache line size is moved a few lines earlier, before
the C-states are constrained, to reduce the amount of cleanup needed
on failure.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 42 +++++++++++++++++------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 110ae4b4f2e4..884976913326 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -101,6 +101,30 @@ static u64 get_prefetch_disable_bits(void)
 	return 0;
 }
 
+/**
+ * get_cache_line_size - Determine the cache coherency line size
+ * @cpu: CPU with which cache is associated
+ * @level: Cache level
+ *
+ * Context: @cpu has to be online.
+ * Return: The cache coherency line size for cache level @level associated
+ * with CPU @cpu. Zero on failure.
+ */
+static unsigned int get_cache_line_size(unsigned int cpu, int level)
+{
+	struct cpu_cacheinfo *ci;
+	int i;
+
+	ci = get_cpu_cacheinfo(cpu);
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == level)
+			return ci->info_list[i].coherency_line_size;
+	}
+
+	return 0;
+}
+
 /**
  * pseudo_lock_minor_get - Obtain available minor number
  * @minor: Pointer to where new minor number will be stored
@@ -281,9 +305,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
-	struct cpu_cacheinfo *ci;
 	int ret;
-	int i;
 
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
@@ -295,7 +317,12 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 		goto out_region;
 	}
 
-	ci = get_cpu_cacheinfo(plr->cpu);
+	plr->line_size = get_cache_line_size(plr->cpu, plr->r->cache_level);
+	if (plr->line_size == 0) {
+		rdt_last_cmd_puts("Unable to determine cache line size\n");
+		ret = -1;
+		goto out_region;
+	}
 
 	plr->size = rdtgroup_cbm_to_size(plr->r, plr->d, plr->cbm);
 
@@ -303,15 +330,8 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 	if (ret < 0)
 		goto out_region;
 
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == plr->r->cache_level) {
-			plr->line_size = ci->info_list[i].coherency_line_size;
-			return 0;
-		}
-	}
+	return 0;
 
-	ret = -1;
-	rdt_last_cmd_puts("Unable to determine cache line size\n");
 out_region:
 	pseudo_lock_region_clear(plr);
 	return ret;
-- 
2.17.2

