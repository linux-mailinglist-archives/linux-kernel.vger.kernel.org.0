Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05A86F11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 03:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405173AbfHIBDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 21:03:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:61498 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHIBDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 21:03:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 18:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="350356786"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2019 18:03:22 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        pasha.tatashin@oracle.com, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/sparse: use __nr_to_section(section_nr) to get mem_section
Date:   Fri,  9 Aug 2019 09:02:42 +0800
Message-Id: <20190809010242.29797-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pfn_to_section is defined as __nr_to_section(pfn_to_section_nr(pfn)).

Since we already get section_nr, it is not necessary to get mem_section
from start_pfn. By doing so, we reduce one redundant operation.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 72f010d9bff5..95158a148cd1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -867,7 +867,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 */
 	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
 
-	ms = __pfn_to_section(start_pfn);
+	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
 	section_mark_present(ms);
 
-- 
2.17.1

