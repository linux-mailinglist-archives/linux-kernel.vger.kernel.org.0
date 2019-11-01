Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418D5EBEC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 08:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfKAH62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 03:58:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962470"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:24 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC 02/10] autonuma: Reduce cache footprint when scanning page tables
Date:   Fri,  1 Nov 2019 15:57:19 +0800
Message-Id: <20191101075727.26683-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101075727.26683-1-ying.huang@intel.com>
References: <20191101075727.26683-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In auto NUMA balancing page table scanning, if the pte_protnone() is
true, the PTE needs not to be changed because it's in target state
already.  So other checking on corresponding struct page is
unnecessary too.

So, if we check pte_protnone() firstly for each PTE, we can avoid
unnecessary struct page accessing, so that reduce the cache footprint
of NUMA balancing page table scanning.

In the performance test of pmbench memory accessing benchmark with
80:20 read/write ratio and normal access address distribution on a 2
socket Intel server with Optance DC Persistent Memory, perf profiling
shows that the autonuma page table scanning time reduces from 1.23% to
0.97% (that is, reduced 21%) with the patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/mprotect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index bf38dfbbb4b4..d69b9913388e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -80,6 +80,10 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (prot_numa) {
 				struct page *page;
 
+				/* Avoid TLB flush if possible */
+				if (pte_protnone(oldpte))
+					continue;
+
 				page = vm_normal_page(vma, addr, oldpte);
 				if (!page || PageKsm(page))
 					continue;
@@ -97,10 +101,6 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				if (page_is_file_cache(page) && PageDirty(page))
 					continue;
 
-				/* Avoid TLB flush if possible */
-				if (pte_protnone(oldpte))
-					continue;
-
 				/*
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
-- 
2.23.0

