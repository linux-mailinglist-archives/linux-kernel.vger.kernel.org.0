Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C1E16576D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 07:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBTGPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 01:15:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:51493 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgBTGPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:15:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 22:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,463,1574150400"; 
   d="scan'208";a="436484740"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 19 Feb 2020 22:15:14 -0800
Date:   Thu, 20 Feb 2020 14:15:34 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        mhocko@suse.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 3/7] mm/sparse.c: introduce a new function
 clear_subsection_map()
Message-ID: <20200220061534.GC32521@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220043316.19668-4-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:33:12PM +0800, Baoquan He wrote:
>Wrap the codes which clear subsection map of one memory region from
>section_deactivate() into clear_subsection_map().
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> mm/sparse.c | 46 ++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 38 insertions(+), 8 deletions(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 977b47acd38d..df857ee9330c 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -726,14 +726,25 @@ static void free_map_bootmem(struct page *memmap)
> }
> #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> 
>-static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>-		struct vmem_altmap *altmap)
>+/**
>+ * clear_subsection_map - Clear subsection map of one memory region
>+ *
>+ * @pfn - start pfn of the memory range
>+ * @nr_pages - number of pfns to add in the region
>+ *
>+ * This is only intended for hotplug, and clear the related subsection
>+ * map inside one section.
>+ *
>+ * Return:
>+ * * -EINVAL	- Section already deactived.
>+ * * 0		- Subsection map is emptied.
>+ * * 1		- Subsection map is not empty.
>+ */
>+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> {
> 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> 	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> 	struct mem_section *ms = __pfn_to_section(pfn);
>-	bool section_is_early = early_section(ms);
>-	struct page *memmap = NULL;
> 	unsigned long *subsection_map = ms->usage
> 		? &ms->usage->subsection_map[0] : NULL;
> 
>@@ -744,8 +755,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> 				"section already deactivated (%#lx + %ld)\n",
> 				pfn, nr_pages))
>-		return;
>+		return -EINVAL;
>+
>+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> 
>+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>+		return 0;
>+
>+	return 1;
>+}
>+
>+static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>+		struct vmem_altmap *altmap)
>+{
>+	struct mem_section *ms = __pfn_to_section(pfn);
>+	bool section_is_early = early_section(ms);
>+	struct page *memmap = NULL;
>+	int rc;
>+
>+
>+	rc = clear_subsection_map(pfn, nr_pages);
>+	if (IS_ERR_VALUE((unsigned long)rc))
>+		return;
> 	/*
> 	 * There are 3 cases to handle across two configurations
> 	 * (SPARSEMEM_VMEMMAP={y,n}):
>@@ -763,8 +794,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 	 *
> 	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> 	 */
>-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
>-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
>+	if (!rc) {
> 		unsigned long section_nr = pfn_to_section_nr(pfn);
> 
> 		/*
>@@ -786,7 +816,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 	else
> 		depopulate_section_memmap(pfn, nr_pages, altmap);
> 
>-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
>+	if (!rc)
> 		ms->section_mem_map = (unsigned long)NULL;
> }
> 
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
