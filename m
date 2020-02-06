Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548B5154F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 00:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBFXRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 18:17:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:6959 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBFXRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:17:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 15:17:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="232200544"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 15:17:35 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        david@redhat.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/3] mm/sparsemem: get physical address to page struct instead of virtual address to pfn
Date:   Fri,  7 Feb 2020 07:16:28 +0800
Message-Id: <20200206231629.14151-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206231629.14151-1-richardw.yang@linux.intel.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap should be the physical address to page struct instead of virtual
address to pfn.

Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid at
this point.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index b5da121bdd6e..56816f653588 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	/* Align memmap to section boundary in the subsection case */
 	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
 		section_nr_to_pfn(section_nr) != start_pfn)
-		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
+		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
 	sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
 
 	return 0;
-- 
2.17.1

