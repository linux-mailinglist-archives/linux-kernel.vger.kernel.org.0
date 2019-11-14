Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53FFC19C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfKNIea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 03:34:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:30256 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfKNIea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:34:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 00:34:29 -0800
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="208060570"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 00:34:29 -0800
Subject: [PATCH v2] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
From:   Dan Williams <dan.j.williams@intel.com>
To:     jhubbard@nvidia.com
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 14 Nov 2019 00:20:13 -0800
Message-ID: <157371938291.3055029.12105459405251950438.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of the device-public infrastructure there are only 2
->page_free() call backs in the kernel. One of those is a device-private
callback in the nouveau driver, the other is a generic wakeup needed in
the DAX case. In the hopes that all ->page_free() callbacks can be
migrated to common core kernel functionality, move the device-private
specific actions in __put_devmap_managed_page() under the
is_device_private_page() conditional, including the ->page_free()
callback. For the other page types just open-code the generic wakeup.

Yes, the wakeup is only needed in the MEMORY_DEVICE_FSDAX case, but it
does no harm in the MEMORY_DEVICE_DEVDAX and MEMORY_DEVICE_PCI_P2PDMA
case.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2:
- Stop requiring pgmap->ops for fsdax (Christoph)
- Clean up the indenting and organization in
  __put_devmap_managed_page(). (Christoph)


 drivers/nvdimm/pmem.c |    6 ----
 mm/memremap.c         |   77 ++++++++++++++++++++++++++-----------------------
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f9f76f6ba07b..21db1ce8c0ae 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -338,13 +338,7 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
-static void pmem_pagemap_page_free(struct page *page)
-{
-	wake_up_var(&page->_refcount);
-}
-
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
-	.page_free		= pmem_pagemap_page_free,
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
 };
diff --git a/mm/memremap.c b/mm/memremap.c
index 022e78e68ea0..b52dc566efd2 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -27,7 +27,8 @@ static void devmap_managed_enable_put(void)
 
 static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
 {
-	if (!pgmap->ops || !pgmap->ops->page_free) {
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE &&
+	    (!pgmap->ops || !pgmap->ops->page_free)) {
 		WARN(1, "Missing page_free method\n");
 		return -EINVAL;
 	}
@@ -444,44 +445,48 @@ void __put_devmap_managed_page(struct page *page)
 {
 	int count = page_ref_dec_return(page);
 
-	/*
-	 * If refcount is 1 then page is freed and refcount is stable as nobody
-	 * holds a reference on the page.
-	 */
-	if (count == 1) {
-		/* Clear Active bit in case of parallel mark_page_accessed */
-		__ClearPageActive(page);
-		__ClearPageWaiters(page);
+	if (count > 1) {
+		/* still busy */
+		return;
+	} else if (count == 0) {
+		/* only triggered by the dev_pagemap shutdown path */
+		__put_page(page);
+		return;
+	} else if (!is_device_private_page(page)) {
+		/* notify page idle for dax */
+		wake_up_var(&page->_refcount);
+		return;
+	}
 
-		mem_cgroup_uncharge(page);
+	/* Clear Active bit in case of parallel mark_page_accessed */
+	__ClearPageActive(page);
+	__ClearPageWaiters(page);
 
-		/*
-		 * When a device_private page is freed, the page->mapping field
-		 * may still contain a (stale) mapping value. For example, the
-		 * lower bits of page->mapping may still identify the page as
-		 * an anonymous page. Ultimately, this entire field is just
-		 * stale and wrong, and it will cause errors if not cleared.
-		 * One example is:
-		 *
-		 *  migrate_vma_pages()
-		 *    migrate_vma_insert_page()
-		 *      page_add_new_anon_rmap()
-		 *        __page_set_anon_rmap()
-		 *          ...checks page->mapping, via PageAnon(page) call,
-		 *            and incorrectly concludes that the page is an
-		 *            anonymous page. Therefore, it incorrectly,
-		 *            silently fails to set up the new anon rmap.
-		 *
-		 * For other types of ZONE_DEVICE pages, migration is either
-		 * handled differently or not done at all, so there is no need
-		 * to clear page->mapping.
-		 */
-		if (is_device_private_page(page))
-			page->mapping = NULL;
+	mem_cgroup_uncharge(page);
 
-		page->pgmap->ops->page_free(page);
-	} else if (!count)
-		__put_page(page);
+	/*
+	 * When a device_private page is freed, the page->mapping field
+	 * may still contain a (stale) mapping value. For example, the
+	 * lower bits of page->mapping may still identify the page as an
+	 * anonymous page. Ultimately, this entire field is just stale
+	 * and wrong, and it will cause errors if not cleared.  One
+	 * example is:
+	 *
+	 *  migrate_vma_pages()
+	 *    migrate_vma_insert_page()
+	 *      page_add_new_anon_rmap()
+	 *        __page_set_anon_rmap()
+	 *          ...checks page->mapping, via PageAnon(page) call,
+	 *            and incorrectly concludes that the page is an
+	 *            anonymous page. Therefore, it incorrectly,
+	 *            silently fails to set up the new anon rmap.
+	 *
+	 * For other types of ZONE_DEVICE pages, migration is either
+	 * handled differently or not done at all, so there is no need
+	 * to clear page->mapping.
+	 */
+	page->mapping = NULL;
+	page->pgmap->ops->page_free(page);
 }
 EXPORT_SYMBOL(__put_devmap_managed_page);
 #endif /* CONFIG_DEV_PAGEMAP_OPS */

