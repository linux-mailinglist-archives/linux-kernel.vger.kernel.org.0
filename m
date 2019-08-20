Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C073695FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfHTNSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:18:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbfHTNSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:18:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9EB9AD54;
        Tue, 20 Aug 2019 13:18:38 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 3/4] mm, page_owner: keep owner info when freeing the page
Date:   Tue, 20 Aug 2019 15:18:27 +0200
Message-Id: <20190820131828.22684-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820131828.22684-1-vbabka@suse.cz>
References: <20190820131828.22684-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For debugging purposes it might be useful to keep the owner info even after
page has been freed, and include it in e.g. dump_page() when detecting a bad
page state. For that, change the PAGE_EXT_OWNER flag meaning to "page owner
info has been set at least once" and add new PAGE_EXT_OWNER_ACTIVE for tracking
whether page is supposed to be currently tracked allocated or free. Adjust
dump_page() accordingly, distinguishing free and allocated pages. In the
page_owner debugfs file, keep printing only allocated pages so that existing
scripts are not confused, and also because free pages are irrelevant for the
memory statistics or leak detection that's the typical use case of the file,
anyway.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/page_ext.h |  1 +
 mm/page_owner.c          | 34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 09592951725c..682fd465df06 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -18,6 +18,7 @@ struct page_ext_operations {
 
 enum page_ext_flags {
 	PAGE_EXT_OWNER,
+	PAGE_EXT_OWNER_ACTIVE,
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
 	PAGE_EXT_YOUNG,
 	PAGE_EXT_IDLE,
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 813fcb70547b..4a48e018dbdf 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -111,7 +111,7 @@ void __reset_page_owner(struct page *page, unsigned int order)
 		page_ext = lookup_page_ext(page + i);
 		if (unlikely(!page_ext))
 			continue;
-		__clear_bit(PAGE_EXT_OWNER, &page_ext->flags);
+		__clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
 	}
 }
 
@@ -168,6 +168,7 @@ static inline void __set_page_owner_handle(struct page *page,
 		page_owner->gfp_mask = gfp_mask;
 		page_owner->last_migrate_reason = -1;
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
+		__set_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
 
 		page_ext = lookup_page_ext(page + i);
 	}
@@ -243,6 +244,7 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	 * the new page, which will be freed.
 	 */
 	__set_bit(PAGE_EXT_OWNER, &new_ext->flags);
+	__set_bit(PAGE_EXT_OWNER_ACTIVE, &new_ext->flags);
 }
 
 void pagetypeinfo_showmixedcount_print(struct seq_file *m,
@@ -302,7 +304,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 			if (unlikely(!page_ext))
 				continue;
 
-			if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
+			if (!test_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags))
 				continue;
 
 			page_owner = get_page_owner(page_ext);
@@ -413,21 +415,26 @@ void __dump_page_owner(struct page *page)
 	mt = gfpflags_to_migratetype(gfp_mask);
 
 	if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
-		pr_alert("page_owner info is not active (free page?)\n");
+		pr_alert("page_owner info is not present (never set?)\n");
 		return;
 	}
 
+	if (test_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags))
+		pr_alert("page_owner tracks the page as allocated\n");
+	else
+		pr_alert("page_owner tracks the page as freed\n");
+
+	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
+		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
+
 	handle = READ_ONCE(page_owner->handle);
 	if (!handle) {
-		pr_alert("page_owner info is not active (free page?)\n");
-		return;
+		pr_alert("page_owner allocation stack trace missing\n");
+	} else {
+		nr_entries = stack_depot_fetch(handle, &entries);
+		stack_trace_print(entries, nr_entries, 0);
 	}
 
-	nr_entries = stack_depot_fetch(handle, &entries);
-	pr_alert("page allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
-		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
-	stack_trace_print(entries, nr_entries, 0);
-
 	if (page_owner->last_migrate_reason != -1)
 		pr_alert("page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_owner->last_migrate_reason]);
@@ -489,6 +496,13 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
 			continue;
 
+		/*
+		 * Although we do have the info about past allocation of free
+		 * pages, it's not relevant for current memory usage.
+		 */
+		if (!test_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags))
+			continue;
+
 		page_owner = get_page_owner(page_ext);
 
 		/*
-- 
2.22.0

