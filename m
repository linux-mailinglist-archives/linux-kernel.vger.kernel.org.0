Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675E816225D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 09:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgBRI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 03:27:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:18962 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgBRI1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:27:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:27:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="235466702"
Received: from yhuang-dev.sh.intel.com ([10.239.159.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 00:27:31 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Zhou, Jianshi" <jianshi.zhou@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V2 6/8] autonuma, memory tiering: Select hotter pages to promote to fast memory node
Date:   Tue, 18 Feb 2020 16:26:32 +0800
Message-Id: <20200218082634.1596727-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218082634.1596727-1-ying.huang@intel.com>
References: <20200218082634.1596727-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In memory tiering system, to maximize the overall system performance,
the hot pages should be put in the fast memory node while the cold
pages should be put in the slow memory node.  In original memory
tiering autonuma implementation, we will try to promote almost all
recently accessed pages, and use the LRU algorithm in page reclaiming
to keep the hot pages in the fast memory node and demote the cold
pages to the slow memory node.  The problem of this solution is that
the cold pages with a low access frequency may be promoted then
demoted too.  So that the memory bandwidth is wasted.  And because
migration is rate-limited, the hot pages need to compete with the cold
pages for the limited migration bandwidth.

If we could select the hotter pages to promote to the fast memory node
in the first place, then the wasted migration bandwidth would be
reduced and the hot pages would be promoted more quickly.

The patch "autonuma, memory tiering: Only promote page if accessed
twice" in the series will prevent the really cold pages that are not
accessed in the last scan period from being promoted.  But the scan
period could be as long as tens seconds, so it doesn't work well
enough on selecting the hotter pages.

To identify the hotter pages, in this patch we implemented a method
suggested by Jianshi and Fengguang.  Which is based on autonuma page
table scanning and hint page fault as follows,

- When a range of the page table is scanned in autonuma, the timestamp
  and the address range is recorded in a ring buffer in struct
  mm_struct.  So we have information of recent N scans.

- When the autonuma hint page fault occurs, the fault address is
  searched in the ring buffer to get its scanning timestamp.  The hint
  page fault latency is defined as

    hint page fault timestamp - scan timestamp

  If the access frequency of the hotter pages is higher, the
  probability for their hint page fault latency to be shorter is
  higher too.  So the hint page fault latency is a good estimation of
  the page heat.

The size of ring buffer should record NUMA scanning history reasonably
long.  From task_scan_min(), the minimal interval between
task_numa_work() running is about 100 ms by default.  So we can keep
1600 ms history by default if set the size to 16.  If user choose to
use smaller sysctl_numa_balancing_scan_size, then we can only keep
shorter history.  In general, we want to keep no less than 1000 ms
history.  So 16 seems a reasonable choice.

The remaining problem is how to determine the hot threshold.  It's not
easy to be done automatically.  So we provide a sysctl knob:
kernel.numa_balancing_hot_threshold_ms.  All pages with hint page
fault latency < the threshold will be considered hot.  The system
administrator can determine the hot threshold via various information,
such as PMEM bandwidth limit, the average number of the pages pass the
hot threshold, etc.  The default hot threshold is 1 second, which
works well in our performance test.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
9.2% with 50.3% fewer NUMA page migrations on a 2 socket Intel server
with Optance DC Persistent Memory.  That is, the cost of autonuma page
migration reduces considerably.

The downside of the patch is that the response time to the workload
hot spot changing may be much longer.  For example,

- A previous cold memory area becomes hot

- The hint page fault will be triggered.  But the hint page fault
  latency may not be shorter than the hot threshold.  So the pages may
  not be promoted.

- When the memory area is scanned again, maybe after a scan period,
  the hint page fault latency measured will be shorter than the hot
  threshold and the pages will be promoted.

To mitigate this,

- If there are enough free space in the fast memory node (> high
  watermark + 2 * promotion rate limit), the hot threshold will not be
  used, all pages will be promoted upon the hint page fault for fast
  response.

- If fast response is more important for system performance, the
  administrator can set a higher hot threshold.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: "Zhou, Jianshi" <jianshi.zhou@intel.com>
Suggested-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>

Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mempolicy.h            |  5 +-
 include/linux/mm_types.h             |  9 ++++
 include/linux/sched/numa_balancing.h |  8 ++-
 include/linux/sched/sysctl.h         |  1 +
 kernel/sched/fair.c                  | 78 +++++++++++++++++++++++++---
 kernel/sysctl.c                      |  7 +++
 mm/huge_memory.c                     |  6 +--
 mm/memory.c                          |  7 ++-
 mm/mempolicy.c                       |  7 ++-
 9 files changed, 108 insertions(+), 20 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5228c62af416..674aaa7614ed 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -202,7 +202,8 @@ static inline bool vma_migratable(struct vm_area_struct *vma)
 	return true;
 }
 
-extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long);
+extern int mpol_misplaced(struct page *, struct vm_area_struct *, unsigned long,
+			  int flags);
 extern void mpol_put_task_policy(struct task_struct *);
 
 #else
@@ -300,7 +301,7 @@ static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
 #endif
 
 static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
-				 unsigned long address)
+				 unsigned long address, int flags)
 {
 	return -1; /* no node preference */
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 270aa8fd2800..2fed3d92bbc1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -508,6 +508,15 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads setting pte_numa */
 		int numa_scan_seq;
+
+		/*
+		 * Keep 1600ms history of NUMA scanning, when default
+		 * 100ms minimal scanning interval is used.
+		 */
+#define NUMA_SCAN_NR_HIST	16
+		int numa_scan_idx;
+		unsigned long numa_scan_jiffies[NUMA_SCAN_NR_HIST];
+		unsigned long numa_scan_starts[NUMA_SCAN_NR_HIST];
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..4899ec000245 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -14,6 +14,7 @@
 #define TNF_SHARED	0x04
 #define TNF_FAULT_LOCAL	0x08
 #define TNF_MIGRATE_FAIL 0x10
+#define TNF_YOUNG	0x20
 
 #ifdef CONFIG_NUMA_BALANCING
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
@@ -21,7 +22,8 @@ extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
 extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
-					int src_nid, int dst_cpu);
+				       int src_nid, int dst_cpu,
+				       unsigned long addr, int flags);
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
@@ -38,7 +40,9 @@ static inline void task_numa_free(struct task_struct *p, bool final)
 {
 }
 static inline bool should_numa_migrate_memory(struct task_struct *p,
-				struct page *page, int src_nid, int dst_cpu)
+					      struct page *page, int src_nid,
+					      int dst_cpu, unsigned long addr,
+					      int flags)
 {
 	return true;
 }
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c4b27790b901..c207709ff498 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -42,6 +42,7 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+extern unsigned int sysctl_numa_balancing_hot_threshold;
 
 #ifdef CONFIG_NUMA_BALANCING
 extern unsigned int sysctl_numa_balancing_rate_limit;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef694816150b..773f3220efc4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1070,6 +1070,9 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
  */
 unsigned int sysctl_numa_balancing_rate_limit;
 
+/* The page with hint page fault latency < threshold in ms is considered hot */
+unsigned int sysctl_numa_balancing_hot_threshold = 1000;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1430,6 +1433,43 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
 	return false;
 }
 
+static long numa_hint_fault_latency(struct task_struct *p, unsigned long addr)
+{
+	struct mm_struct *mm = p->mm;
+	unsigned long now = jiffies;
+	unsigned long start, end;
+	int i, j;
+	long latency = 0;
+
+	/*
+	 * Paired with smp_store_release() in task_numa_work() to check
+	 * scan range buffer after get current index
+	 */
+	i = smp_load_acquire(&mm->numa_scan_idx);
+	i = (i - 1) % NUMA_SCAN_NR_HIST;
+
+	end = READ_ONCE(mm->numa_scan_offset);
+	start = READ_ONCE(mm->numa_scan_starts[i]);
+	if (start == end)
+		end = start + MAX_SCAN_WINDOW * (1UL << 22);
+	for (j = 0; j < NUMA_SCAN_NR_HIST; j++) {
+		latency = now - READ_ONCE(mm->numa_scan_jiffies[i]);
+		start = READ_ONCE(mm->numa_scan_starts[i]);
+		/* Scan pass the end of address space */
+		if (end < start)
+			end = TASK_SIZE;
+		if (addr >= start && addr < end)
+			return latency;
+		end = start;
+		i = (i - 1) % NUMA_SCAN_NR_HIST;
+	}
+	/*
+	 * The tracking window isn't large enough, approximate to the
+	 * max latency in the tracking window.
+	 */
+	return latency;
+}
+
 static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 					    unsigned long rate_limit, int nr)
 {
@@ -1448,7 +1488,8 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 }
 
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
-				int src_nid, int dst_cpu)
+				int src_nid, int dst_cpu, unsigned long addr,
+				int flags)
 {
 	struct numa_group *ng = deref_curr_numa_group(p);
 	int dst_nid = cpu_to_node(dst_cpu);
@@ -1461,12 +1502,21 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    next_promotion_node(src_nid) != -1) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit;
+		unsigned long rate_limit, latency, th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
 			return true;
 
+		/* The page hasn't been accessed in the last scan period */
+		if (!(flags & TNF_YOUNG))
+			return false;
+
+		th = msecs_to_jiffies(sysctl_numa_balancing_hot_threshold);
+		latency = numa_hint_fault_latency(p, addr);
+		if (latency > th)
+			return false;
+
 		rate_limit =
 			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
 		return numa_migration_check_rate_limit(pgdat, rate_limit,
@@ -2540,7 +2590,7 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	 * expensive, to avoid any form of compiler optimizations:
 	 */
 	WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
-	p->mm->numa_scan_offset = 0;
+	WRITE_ONCE(p->mm->numa_scan_offset, 0);
 }
 
 /*
@@ -2557,6 +2607,7 @@ static void task_numa_work(struct callback_head *work)
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
+	int idx;
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -2615,6 +2666,15 @@ static void task_numa_work(struct callback_head *work)
 		start = 0;
 		vma = mm->mmap;
 	}
+	idx = mm->numa_scan_idx;
+	WRITE_ONCE(mm->numa_scan_starts[idx], start);
+	WRITE_ONCE(mm->numa_scan_jiffies[idx], jiffies);
+	/*
+	 * Paired with smp_load_acquire() in numa_hint_fault_latency()
+	 * to update scan range buffer index after update the buffer
+	 * contents.
+	 */
+	smp_store_release(&mm->numa_scan_idx, (idx + 1) % NUMA_SCAN_NR_HIST);
 	for (; vma; vma = vma->vm_next) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
@@ -2642,6 +2702,7 @@ static void task_numa_work(struct callback_head *work)
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
 			end = min(end, vma->vm_end);
+			WRITE_ONCE(mm->numa_scan_offset, end);
 			nr_pte_updates = change_prot_numa(vma, start, end);
 
 			/*
@@ -2671,9 +2732,7 @@ static void task_numa_work(struct callback_head *work)
 	 * would find the !migratable VMA on the next scan but not reset the
 	 * scanner to the start so check it now.
 	 */
-	if (vma)
-		mm->numa_scan_offset = start;
-	else
+	if (!vma)
 		reset_ptenuma_scan(p);
 	up_read(&mm->mmap_sem);
 
@@ -2691,7 +2750,7 @@ static void task_numa_work(struct callback_head *work)
 
 void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
-	int mm_users = 0;
+	int i, mm_users = 0;
 	struct mm_struct *mm = p->mm;
 
 	if (mm) {
@@ -2699,6 +2758,11 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 		if (mm_users == 1) {
 			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 			mm->numa_scan_seq = 0;
+			mm->numa_scan_idx = 0;
+			for (i = 0; i < NUMA_SCAN_NR_HIST; i++) {
+				mm->numa_scan_jiffies[i] = 0;
+				mm->numa_scan_starts[i] = 0;
+			}
 		}
 	}
 	p->node_stamp			= 0;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2d19e821267a..da1fc0303cca 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -427,6 +427,13 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "numa_balancing_hot_threshold_ms",
+		.data		= &sysctl_numa_balancing_hot_threshold,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 	{
 		.procname	= "numa_balancing",
 		.data		= &sysctl_numa_balancing_mode,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8808e50ad921..08d25763e65f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1559,8 +1559,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 		goto out_unlock;
 
 	/* Only migrate if accessed twice */
-	if (!pmd_young(*vmf->pmd))
-		goto out_unlock;
+	if (pmd_young(*vmf->pmd))
+		flags |= TNF_YOUNG;
 
 	/*
 	 * If there are potential migrations, wait for completion and retry
@@ -1595,7 +1595,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	 * page_table_lock if at all possible
 	 */
 	page_locked = trylock_page(page);
-	target_nid = mpol_misplaced(page, vma, haddr);
+	target_nid = mpol_misplaced(page, vma, haddr, flags);
 	if (target_nid == NUMA_NO_NODE) {
 		/* If the page was locked, there are no parallel migrations */
 		if (page_locked)
diff --git a/mm/memory.c b/mm/memory.c
index afb4c55cb278..207caa9e61da 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3789,7 +3789,7 @@ static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
-	return mpol_misplaced(page, vma, addr);
+	return mpol_misplaced(page, vma, addr, *flags);
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
@@ -3826,9 +3826,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 
-	/* Only migrate if accessed twice */
-	if (!pte_young(old_pte))
-		goto unmap_out;
+	if (pte_young(old_pte))
+		flags |= TNF_YOUNG;
 
 	page = vm_normal_page(vma, vmf->address, pte);
 	if (!page)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 22b4d1a0ea53..4f9301195de5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2394,6 +2394,7 @@ static void sp_free(struct sp_node *n)
  * @page: page to be checked
  * @vma: vm area where page mapped
  * @addr: virtual address where page mapped
+ * @flags: numa balancing flags
  *
  * Lookup current policy node id for vma,addr and "compare to" page's
  * node id.
@@ -2405,7 +2406,8 @@ static void sp_free(struct sp_node *n)
  * Policy determination "mimics" alloc_page_vma().
  * Called from fault path where we know the vma and faulting address.
  */
-int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr)
+int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
+		   unsigned long addr, int flags)
 {
 	struct mempolicy *pol;
 	struct zoneref *z;
@@ -2459,7 +2461,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	if (pol->flags & MPOL_F_MORON) {
 		polnid = thisnid;
 
-		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
+		if (!should_numa_migrate_memory(current, page, curnid,
+						thiscpu, addr, flags))
 			goto out;
 	}
 
-- 
2.24.1

