Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3A1421D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 04:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgATDEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 22:04:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:51507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgATDEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:04:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 19:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="scan'208";a="306802495"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2020 19:04:22 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, richardw.yang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com
Subject: [Patch v2 1/4] mm: enable dump several reasons for __dump_page()
Date:   Mon, 20 Jan 2020 11:04:12 +0800
Message-Id: <20200120030415.15925-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120030415.15925-1-richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation to dump all reasons during check page.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/linux/mmdebug.h |  2 +-
 mm/debug.c              | 11 ++++++-----
 mm/page_alloc.c         |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 2ad72d2c8cc5..f0a612db8bae 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -10,7 +10,7 @@ struct vm_area_struct;
 struct mm_struct;
 
 extern void dump_page(struct page *page, const char *reason);
-extern void __dump_page(struct page *page, const char *reason);
+extern void __dump_page(struct page *page, int num, const char **reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
 
diff --git a/mm/debug.c b/mm/debug.c
index 0461df1207cb..a8ac6f951f9f 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,11 +42,11 @@ const struct trace_print_flags vmaflag_names[] = {
 	{0, NULL}
 };
 
-void __dump_page(struct page *page, const char *reason)
+void __dump_page(struct page *page, int num, const char **reason)
 {
 	struct address_space *mapping;
 	bool page_poisoned = PagePoisoned(page);
-	int mapcount;
+	int mapcount, i;
 
 	/*
 	 * If struct page is poisoned don't access Page*() functions as that
@@ -97,8 +97,9 @@ void __dump_page(struct page *page, const char *reason)
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
 
-	if (reason)
-		pr_warn("page dumped because: %s\n", reason);
+	pr_warn("page dumped because:\n");
+	for (i = 0; i < num; i++)
+		pr_warn("\t%s\n", reason[i]);
 
 #ifdef CONFIG_MEMCG
 	if (!page_poisoned && page->mem_cgroup)
@@ -108,7 +109,7 @@ void __dump_page(struct page *page, const char *reason)
 
 void dump_page(struct page *page, const char *reason)
 {
-	__dump_page(page, reason);
+	__dump_page(page, 1, &reason);
 	dump_page_owner(page);
 }
 EXPORT_SYMBOL(dump_page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d047bf7d8fd4..0cf6218aaba7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -638,7 +638,7 @@ static void bad_page(struct page *page, const char *reason,
 
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
-	__dump_page(page, reason);
+	__dump_page(page, 1, &reason);
 	bad_flags &= page->flags;
 	if (bad_flags)
 		pr_alert("bad because of flags: %#lx(%pGp)\n",
-- 
2.17.1

