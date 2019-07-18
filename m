Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198A46CF4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfGROBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 10:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGROBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:01:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8EBD821C1;
        Thu, 18 Jul 2019 14:01:04 +0000 (UTC)
Received: from redhat.com (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
        by smtp.corp.redhat.com (Postfix) with SMTP id 409086064C;
        Thu, 18 Jul 2019 14:01:01 +0000 (UTC)
Date:   Thu, 18 Jul 2019 10:00:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wei Wang <wei.w.wang@intel.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v4 1/2] mm/balloon_compaction: avoid duplicate page removal
Message-ID: <20190718140006.15052-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 18 Jul 2019 14:01:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <wei.w.wang@intel.com>

A #GP is reported in the guest when requesting balloon inflation via
virtio-balloon. The reason is that the virtio-balloon driver has
removed the page from its internal page list (via balloon_page_pop),
but balloon_page_enqueue_one also calls "list_del"  to do the removal.
This is necessary when it's used from balloon_page_enqueue_list, but
not from balloon_page_enqueue.

Move list_del to balloon_page_enqueue, and update comments accordingly.

Fixes: 418a3ab1e778 (mm/balloon_compaction: List interfaces)
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This patch is same as v3.

 mm/balloon_compaction.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 83a7b614061f..d25664e1857b 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -21,7 +21,6 @@ static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 	 * memory corruption is possible and we should stop execution.
 	 */
 	BUG_ON(!trylock_page(page));
-	list_del(&page->lru);
 	balloon_page_insert(b_dev_info, page);
 	unlock_page(page);
 	__count_vm_event(BALLOON_INFLATE);
@@ -47,6 +46,7 @@ size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	list_for_each_entry_safe(page, tmp, pages, lru) {
+		list_del(&page->lru);
 		balloon_page_enqueue_one(b_dev_info, page);
 		n_pages++;
 	}
@@ -128,13 +128,19 @@ struct page *balloon_page_alloc(void)
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
 /*
- * balloon_page_enqueue - allocates a new page and inserts it into the balloon
- *			  page list.
+ * balloon_page_enqueue - inserts a new page into the balloon page list.
+ *
  * @b_dev_info: balloon device descriptor where we will insert a new page to
  * @page: new page to enqueue - allocated using balloon_page_alloc.
  *
  * Driver must call it to properly enqueue a new allocated balloon page
  * before definitively removing it from the guest system.
+ *
+ * Drivers must not call balloon_page_enqueue on pages that have been
+ * pushed to a list with balloon_page_push before removing them with
+ * balloon_page_pop. To all pages on a list, use balloon_page_list_enqueue
+ * instead.
+ *
  * This function returns the page address for the recently enqueued page or
  * NULL in the case we fail to allocate a new page this turn.
  */
-- 
MST

