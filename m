Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8090154F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 00:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBFXRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 18:17:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:6959 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBFXRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:17:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 15:17:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="232200556"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 15:17:38 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        david@redhat.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 3/3] mm/sparsemem: avoid memmap overwrite for non-SPARSEMEM_VMEMMAP
Date:   Fri,  7 Feb 2020 07:16:29 +0800
Message-Id: <20200206231629.14151-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206231629.14151-1-richardw.yang@linux.intel.com>
References: <20200206231629.14151-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of SPARSEMEM, populate_section_memmap() would allocate memmap
for the whole section, even we just want a sub-section. This would lead
to memmap overwrite if we a sub-section to an already populated section.

Just return the populated memmap for non-SPARSEMEM_VMEMMAP case.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
---
 mm/sparse.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 56816f653588..c75ca40db513 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -836,6 +836,16 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
 		return pfn_to_page(pfn);
 
+	/*
+	 * If it is not SPARSEMEM_VMEMMAP, we always populate memmap for the
+	 * whole section, even for a sub-section.
+	 *
+	 * Return its memmap if already populated to avoid memmap overwrite.
+	 */
+	if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
+		valid_section(ms))
+		return __section_mem_map_addr(ms);
+
 	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap);
 	if (!memmap) {
 		section_deactivate(pfn, nr_pages, altmap);
-- 
2.17.1

