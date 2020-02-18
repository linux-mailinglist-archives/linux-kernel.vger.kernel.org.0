Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1431E162253
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 09:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBRI1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 03:27:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:18962 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgBRI1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:27:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 00:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="235466684"
Received: from yhuang-dev.sh.intel.com ([10.239.159.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 00:27:27 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V2 5/8] autonuma, memory tiering: Only promote page if accessed twice
Date:   Tue, 18 Feb 2020 16:26:31 +0800
Message-Id: <20200218082634.1596727-6-ying.huang@intel.com>
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

The original assumption of auto NUMA balancing is that the memory
privately or mainly accessed by the CPUs of a NUMA node (called
private memory) should fit the memory size of the NUMA node.  So if a
page is identified to be private memory, it will be migrated to the
target node immediately.  Eventually all private memory will be
migrated.

But this assumption isn't true in memory tiering system.  In a typical
memory tiering system, there are CPUs, fast memory, and slow memory in
each physical NUMA node.  The CPUs and the fast memory will be put in
one logical node (called fast memory node), while the slow memory will
be put in another (faked) logical node (called slow memory node).  To
take full advantage of the system resources, it's common that the size
of the private memory of the workload is larger than the memory size
of the fast memory node.

To resolve the issue, we will try to migrate only the hot pages in the
private memory to the fast memory node.  A private page that was
accessed at least twice in the current and the last scanning periods
will be identified as the hot page and migrated.  Otherwise, the page
isn't considered hot enough to be migrated.

To record whether a page is accessed in the last scanning period, the
Accessed bit of the PTE/PMD is used.  When the page tables are scanned
for autonuma, if the pte_protnone(pte) is true, the page isn't
accessed in the last scan period, and the Accessed bit will be
cleared, otherwise the Accessed bit will be kept.  When NUMA page
fault occurs, if the Accessed bit is set, the page has been accessed
at least twice in the current and the last scanning period and will be
migrated.

The Accessed bit of PTE/PMD is used by page reclaiming too.  So the
conflict is possible.  Considering the following situation,

a) the page is moved from active list to inactive list with Accessed
   bit cleared

b) the page is accessed, so Accessed bit is set

c) the page table is scanned by autonuma, PTE is set to
   PROTNONE+Accessed

c) the page isn't accessed

d) the page table is scanned by autonuma again, Accessed is cleared

e) the inactive list is scanned for reclaiming, the page is reclaimed
   wrongly because Accessed bit is cleared by autonuma

Although the page is reclaimed wrongly, it hasn't been accessed for
one numa balancing scanning period at least.  So the page isn't so hot
too.  That is, this shouldn't be a severe issue.

The patch improves the score of pmbench memory accessing benchmark
with 80:20 read/write ratio and normal access address distribution by
3.1% on a 2 socket Intel server with Optance DC Persistent Memory.  In
the test, the number of the promoted pages for autonuma reduces 7.2%
because the pages fail to pass the twice access checking.

Problems:

 - how to adjust scanning period upon hot page identification
   requirement.  E.g. if the count of page promotion is much larger
   than free memory, we need to scan faster to identify really hot
   pages.  But his will trigger too many page faults too.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
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
 mm/huge_memory.c | 17 ++++++++++++++++-
 mm/memory.c      | 28 +++++++++++++++-------------
 mm/mprotect.c    | 15 ++++++++++++++-
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d45de9b1ead9..8808e50ad921 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1558,6 +1558,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	if (unlikely(!pmd_same(pmd, *vmf->pmd)))
 		goto out_unlock;
 
+	/* Only migrate if accessed twice */
+	if (!pmd_young(*vmf->pmd))
+		goto out_unlock;
+
 	/*
 	 * If there are potential migrations, wait for completion and retry
 	 * without disrupting NUMA hinting information. Do not relock and
@@ -1978,8 +1982,19 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		if (is_huge_zero_pmd(*pmd))
 			goto unlock;
 
-		if (pmd_protnone(*pmd))
+		if (pmd_protnone(*pmd)) {
+			if (!(sysctl_numa_balancing_mode &
+			      NUMA_BALANCING_MEMORY_TIERING))
+				goto unlock;
+
+			/*
+			 * PMD young bit is used to record whether the
+			 * page is accessed in last scan period
+			 */
+			if (pmd_young(*pmd))
+				set_pmd_at(mm, addr, pmd, pmd_mkold(*pmd));
 			goto unlock;
+		}
 
 		page = pmd_page(*pmd);
 		/*
diff --git a/mm/memory.c b/mm/memory.c
index 45442d9a4f52..afb4c55cb278 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3811,10 +3811,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 */
 	vmf->ptl = pte_lockptr(vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
-	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		goto out;
-	}
+	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
+		goto unmap_out;
 
 	/*
 	 * Make it present again, Depending on how arch implementes non
@@ -3828,17 +3826,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 
+	/* Only migrate if accessed twice */
+	if (!pte_young(old_pte))
+		goto unmap_out;
+
 	page = vm_normal_page(vma, vmf->address, pte);
-	if (!page) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
-	}
+	if (!page)
+		goto unmap_out;
 
 	/* TODO: handle PTE-mapped THP */
-	if (PageCompound(page)) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
-	}
+	if (PageCompound(page))
+		goto unmap_out;
 
 	/*
 	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
@@ -3876,10 +3874,14 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	} else
 		flags |= TNF_MIGRATE_FAIL;
 
-out:
 	if (page_nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, page_nid, 1, flags);
 	return 0;
+
+unmap_out:
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+out:
+	return 0;
 }
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7322c98284ac..1948105d23d5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -83,8 +83,21 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				int nid;
 
 				/* Avoid TLB flush if possible */
-				if (pte_protnone(oldpte))
+				if (pte_protnone(oldpte)) {
+					if (!(sysctl_numa_balancing_mode &
+					      NUMA_BALANCING_MEMORY_TIERING))
+						continue;
+
+					/*
+					 * PTE young bit is used to record
+					 * whether the page is accessed in
+					 * last scan period
+					 */
+					if (pte_young(oldpte))
+						set_pte_at(vma->vm_mm, addr, pte,
+							   pte_mkold(oldpte));
 					continue;
+				}
 
 				page = vm_normal_page(vma, addr, oldpte);
 				if (!page || PageKsm(page))
-- 
2.24.1

