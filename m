Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDD15444A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 13:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBFMxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 07:53:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:53131 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbgBFMxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:53:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 04:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="255079976"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2020 04:53:28 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        bhe@redhat.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Date:   Thu,  6 Feb 2020 20:53:43 +0800
Message-Id: <20200206125343.9070-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
doesn't work before sparse_init_one_section() is called. This leads to a
crash when hotplug memory.

We should use memmap as it did.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 5a8599041a2a..2efb24ff8f96 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
+	page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-- 
2.17.1

