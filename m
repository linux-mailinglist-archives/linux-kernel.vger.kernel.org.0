Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64891290DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 03:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLWCYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 21:24:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:41143 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfLWCYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 21:24:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Dec 2019 18:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,346,1571727600"; 
   d="scan'208";a="211403168"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2019 18:24:43 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/rmap.c: split huge pmd when it really is
Date:   Mon, 23 Dec 2019 10:24:35 +0800
Message-Id: <20191223022435.30653-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two cases to call try_to_unmap_one() with TTU_SPLIT_HUGE_PMD
set:

  * unmap_page()
  * shrink_page_list()

In both case, the page passed to try_to_unmap_one() is PageHead() of the
THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
aligned, this means the THP is not mapped as PMD THP in this process.
This could happen when we do mremap() a PMD size range to an un-aligned
address.

Currently, this case is handled by following check in __split_huge_pmd()
luckily.

  page != pmd_page(*pmd)

This patch checks the address to skip some hard work.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/rmap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..79b9239f00e3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1386,7 +1386,19 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	    is_zone_device_page(page) && !is_device_private_page(page))
 		return true;
 
-	if (flags & TTU_SPLIT_HUGE_PMD) {
+	/*
+	 * There are two places set TTU_SPLIT_HUGE_PMD
+	 *
+	 *     unmap_page()
+	 *     shrink_page_list()
+	 *
+	 * In both cases, the "page" here is the PageHead() of the THP.
+	 *
+	 * If the page is not a real PMD huge page, e.g. after mremap(), it is
+	 * not necessary to split.
+	 */
+	if ((flags & TTU_SPLIT_HUGE_PMD) &&
+		IS_ALIGNED(address, HPAGE_PMD_SIZE)) {
 		split_huge_pmd_address(vma, address,
 				flags & TTU_SPLIT_FREEZE, page);
 	}
-- 
2.17.1

