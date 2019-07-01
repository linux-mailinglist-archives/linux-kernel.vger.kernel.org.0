Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63E538494
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 08:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfFGGru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 02:47:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13891 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfFGGru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:47:50 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190607064747epoutp0443860471bf77d825b684330a61deea12~l18BhGgDL2631126311epoutp04E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:47:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190607064747epoutp0443860471bf77d825b684330a61deea12~l18BhGgDL2631126311epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559890067;
        bh=QEvH57eXXPVMkcf1TNSt78H8mGRr393UN9Ix5+l44Sw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UxkofAzTGKZtu0vLYLvh7z57Ruhqjtm2+4k2vw5YpKeH/Wz2ZoWqUdf4Lq+K5r05s
         z8MEK6e+F+MoC/Sb7pI/GJ9iPl/9P7bmgWr2bY+a4wO6rTRoc57Ebna/hWiqBHPZlK
         jUHc9MdxVXDxTKuUNOEU1YizMNK45yk66VHJW28w=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.194]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20190607064745epcas5p1448df41bde748e8c9ca175019018c766~l17-diJ-F1162411624epcas5p1L;
        Fri,  7 Jun 2019 06:47:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.B2.04067.0980AFC5; Fri,  7 Jun 2019 15:47:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607055426epcas5p24d6507b84fab957b8e0881d2ff727192~l1NcOvWb-0124101241epcas5p23;
        Fri,  7 Jun 2019 05:54:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607055426epsmtrp12956c9860cef28fa11b597c07108acd4~l1NcN2q1g1636316363epsmtrp10;
        Fri,  7 Jun 2019 05:54:26 +0000 (GMT)
X-AuditID: b6c32a4b-7a3ff70000000fe3-5e-5cfa0890609c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.EB.03662.11CF9FC5; Fri,  7 Jun 2019 14:54:25 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607055423epsmtip20a202002f35af9384384946531307c09~l1NZ4xbZh0286202862epsmtip2q;
        Fri,  7 Jun 2019 05:54:23 +0000 (GMT)
From:   Sai Charan Sane <s.charan@samsung.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, tglx@linutronix.de,
        rppt@linux.vnet.ibm.com, gregkh@linuxfoundation.org,
        joe@perches.com, miles.chen@mediatek.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com,
        Sai Charan Sane <s.charan@samsung.com>
Subject: [PATCH 1/1] mm/page_owner: store page_owner's gfp_mask in
 stackdepot itself
Date:   Fri,  7 Jun 2019 11:23:18 +0530
Message-Id: <1559886798-29585-1-git-send-email-s.charan@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRieb8/u2SPWHCvjK8rOSUONaje2DiMMMWfUmGYMP7QmZ9pPxd6c
        sxv5pdyjJBNdTU36IWW1kmURWym3JYpCF0phmsZ9qBlse7bh3/O+z/s8zzvf9xKYvBD3J9IM
        ZsQZWB2F+4gbmkJCw/KIMY2yYf8yut2B6FJrDU7vr7TidEnfgJh+dr0Up3tr/kjovtxV9PGO
        bkD3jlwR0cVNc+irHW9x+rKtAKOd98rAKhlj+5IvZUZdLinTVjguZvqdl8VMY1mNlDlwr1HM
        fKt+jjG59dWAsdZ3ipmvtsAEny265amI1SJOgQzJRm2aISWGituYtCZJHaVUhamW0tGUwsDq
        UQwVG58Qti5N516dUqSzOou7lcDyPBWxYjlntJiRItXIm2MoZNLqTKpIUzjP6nmLISU82ahf
        plIqI9XuyW261NYxp9RUHr3n4HuHZB+4FpYNphCQXAKHDjhE2cCHkJMOAM/0HPMWXwCs+j2A
        CcUPAO9+/gAmJYPHc4BA3ASwcqTDK/kO4MNbl/CJKZxcBG/fyPIQvmQVgKeG6zxeGHkOwIKi
        Hmxiaia5Gb7MHPBgMRkMH5w6IskGBCEjY2HD6TghLhB2u456tJB8gcOSlq+4QMTCi3cuiAQ8
        E35srZcK2B9+OHHIiw8DWDe4VhDnAVibb/cSK2F/V4t0IgwjQ6D1eoTQDoAF9y96PDFyOswZ
        H/T6y6D97CSm4JuTh702ELqav0sEzMCcGiFXTm6FtecbsDwQUPwvoRyAauCHTLw+BfFq02ID
        2v3/X9mA5ypD4+zA5op3ApIA1DRZoeiXRi5h0/kMvRNAAqN8ZelPfmrkMi2bsRdxxiTOokO8
        E6jdD3gS85+VbHTfuMGcpFJHRkUplyrVi+koFTVbli/p1MjJFNaMdiJkQtykTkRM8d8HsjY8
        /jS42neHLsZ0/ohVu6soIPfT51fDXX1DJ36PdjX9Ov2AamvcU7Hg0NP27eUZu7JKZUXO7o0R
        60f8FjCjU/OxRE1Qf2VZxBpuKDFxfJ5S7epQjDuwdcOb6ioyHNFVc0WZ9kejmWWv53PmW/b4
        hW2Bw8HTvzneWWbUO0KCmmsZSsynsqpQjOPZvzObBaOrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvK7gn58xBl9bbSwu7k61mLN+DZtF
        8+L1bBaz7z9msbi8aw6bxb01/1kt7vc5WPRcucloce/NViaLWYelLbZfecRmsXnTVGaLQyfn
        Mjrwemz6NInd4925c+weJ2b8ZvF4cGgzi8f+uWvYPVpO7mfx+LLqGrNH35ZVjB7rt1xl8fi8
        SS6AK4rLJiU1J7MstUjfLoEr4/ivQ+wFC8wrWl/sZm1g3KnbxcjJISFgIvGkp5exi5GLQ0hg
        N6PE/oaLLBAJCYl1TUfZIWxhiZX/nrNDFH1mlHi6vRMswSagI3FgTxMTSEJEYC2jxNL328Ac
        ZoFVjBLvV/QzgVQJC4RI/PuznBHEZhFQlTg9uYO1i5GDg1fARWLbNG+IDXISN891Mk9g5FnA
        yLCKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4YLW0djCeOBF/iFGAg1GJh3cG088Y
        IdbEsuLK3EOMEhzMSiK8ZRd+xAjxpiRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5Ykpqd
        mlqQWgSTZeLglGpgVDz8xPRD/YcZfFcfBEiFXsh8mGj+8m/XzFN7BRvZ73iyfeNPaNobdW3B
        9t8bI/9eWqOUwbbbdzuXU7jHwoAtWSonRTd+qnx/82X7TB+uzG3F+j9sJud3id3edySu5vI1
        X2kW0R/L7sv28yW3VejO/33vy3GmbU7Pe5IZa1/u/la9et6KIyns5UosxRmJhlrMRcWJANTp
        wWxUAgAA
X-CMS-MailID: 20190607055426epcas5p24d6507b84fab957b8e0881d2ff727192
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190607055426epcas5p24d6507b84fab957b8e0881d2ff727192
References: <CGME20190607055426epcas5p24d6507b84fab957b8e0881d2ff727192@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory overhead of 4MB is reduced by storing gfp_mask in stackdepot along
with stacktrace. Stackdepot memory usage increased by ~100kb for 4GB of RAM.

Page owner logs from dmesg:
	Before patch:
		allocated 20971520 bytes of page_ext
	After patch:
		allocated 16777216 bytes of page_ext

Signed-off-by: Sai Charan Sane <s.charan@samsung.com>
---
 mm/page_owner.c | 61 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index addcbb2..01856ed 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -16,13 +16,14 @@
 /*
  * TODO: teach PAGE_OWNER_STACK_DEPTH (__dump_page_owner and save_stack)
  * to use off stack temporal storage
+ * 16 stacktrace entries + 1 gfp mask
  */
-#define PAGE_OWNER_STACK_DEPTH (16)
+#define PAGE_OWNER_STACK_DEPTH (16 + 1)
+#define MAX_TRACE_ENTRIES(entries) (ARRAY_SIZE(entries) - 1)
 
 struct page_owner {
 	unsigned short order;
 	short last_migrate_reason;
-	gfp_t gfp_mask;
 	depot_stack_handle_t handle;
 };
 
@@ -57,10 +58,11 @@ static bool need_page_owner(void)
 
 static __always_inline depot_stack_handle_t create_dummy_stack(void)
 {
-	unsigned long entries[4];
+	unsigned long entries[8];
 	unsigned int nr_entries;
 
-	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	nr_entries = stack_trace_save(entries, MAX_TRACE_ENTRIES(entries), 0);
+	entries[nr_entries++] = 0;
 	return stack_depot_save(entries, nr_entries, GFP_KERNEL);
 }
 
@@ -134,7 +136,7 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	depot_stack_handle_t handle;
 	unsigned int nr_entries;
 
-	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
+	nr_entries = stack_trace_save(entries, MAX_TRACE_ENTRIES(entries), 2);
 
 	/*
 	 * We need to check recursion here because our request to
@@ -147,6 +149,8 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	if (check_recursive_alloc(entries, nr_entries, _RET_IP_))
 		return dummy_handle;
 
+	entries[nr_entries++] = flags;
+
 	handle = stack_depot_save(entries, nr_entries, flags);
 	if (!handle)
 		handle = failure_handle;
@@ -155,14 +159,13 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
-	depot_stack_handle_t handle, unsigned int order, gfp_t gfp_mask)
+	depot_stack_handle_t handle, unsigned int order)
 {
 	struct page_owner *page_owner;
 
 	page_owner = get_page_owner(page_ext);
 	page_owner->handle = handle;
 	page_owner->order = order;
-	page_owner->gfp_mask = gfp_mask;
 	page_owner->last_migrate_reason = -1;
 
 	__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
@@ -178,7 +181,7 @@ noinline void __set_page_owner(struct page *page, unsigned int order,
 		return;
 
 	handle = save_stack(gfp_mask);
-	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
+	__set_page_owner_handle(page_ext, handle, order);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
@@ -220,7 +223,6 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	old_page_owner = get_page_owner(old_ext);
 	new_page_owner = get_page_owner(new_ext);
 	new_page_owner->order = old_page_owner->order;
-	new_page_owner->gfp_mask = old_page_owner->gfp_mask;
 	new_page_owner->last_migrate_reason =
 		old_page_owner->last_migrate_reason;
 	new_page_owner->handle = old_page_owner->handle;
@@ -248,6 +250,10 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	unsigned long count[MIGRATE_TYPES] = { 0, };
 	int pageblock_mt, page_mt;
 	int i;
+	unsigned long *entries;
+	unsigned int nr_entries;
+	depot_stack_handle_t handle;
+	gfp_t gfp_mask;
 
 	/* Scan block by block. First and last block may be incomplete */
 	pfn = zone->zone_start_pfn;
@@ -298,8 +304,15 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 				continue;
 
 			page_owner = get_page_owner(page_ext);
-			page_mt = gfpflags_to_migratetype(
-					page_owner->gfp_mask);
+			handle = READ_ONCE(page_owner->handle);
+			if (!handle) {
+				pr_alert("page_owner info is not active (free page?)\n");
+				return;
+			}
+
+			nr_entries = stack_depot_fetch(handle, &entries);
+			gfp_mask = entries[--nr_entries];
+			page_mt = gfpflags_to_migratetype(gfp_mask);
 			if (pageblock_mt != page_mt) {
 				if (is_migrate_cma(pageblock_mt))
 					count[MIGRATE_MOVABLE]++;
@@ -329,23 +342,26 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	unsigned long *entries;
 	unsigned int nr_entries;
 	char *kbuf;
+	gfp_t gfp_mask;
 
 	count = min_t(size_t, count, PAGE_SIZE);
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 
+	nr_entries = stack_depot_fetch(handle, &entries);
+	gfp_mask = entries[--nr_entries];
+
 	ret = snprintf(kbuf, count,
 			"Page allocated via order %u, mask %#x(%pGg)\n",
-			page_owner->order, page_owner->gfp_mask,
-			&page_owner->gfp_mask);
+			page_owner->order, gfp_mask, &gfp_mask);
 
 	if (ret >= count)
 		goto err;
 
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
-	page_mt  = gfpflags_to_migratetype(page_owner->gfp_mask);
+	page_mt  = gfpflags_to_migratetype(gfp_mask);
 	ret += snprintf(kbuf + ret, count - ret,
 			"PFN %lu type %s Block %lu type %s Flags %#lx(%pGp)\n",
 			pfn,
@@ -357,7 +373,6 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	if (ret >= count)
 		goto err;
 
-	nr_entries = stack_depot_fetch(handle, &entries);
 	ret += stack_trace_snprint(kbuf + ret, count - ret, entries, nr_entries, 0);
 	if (ret >= count)
 		goto err;
@@ -401,21 +416,21 @@ void __dump_page_owner(struct page *page)
 	}
 
 	page_owner = get_page_owner(page_ext);
-	gfp_mask = page_owner->gfp_mask;
-	mt = gfpflags_to_migratetype(gfp_mask);
-
-	if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
+	handle = READ_ONCE(page_owner->handle);
+	if (!handle) {
 		pr_alert("page_owner info is not active (free page?)\n");
 		return;
 	}
 
-	handle = READ_ONCE(page_owner->handle);
-	if (!handle) {
+	nr_entries = stack_depot_fetch(handle, &entries);
+	gfp_mask = entries[--nr_entries];
+	mt = gfpflags_to_migratetype(gfp_mask);
+
+	if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
 		pr_alert("page_owner info is not active (free page?)\n");
 		return;
 	}
 
-	nr_entries = stack_depot_fetch(handle, &entries);
 	pr_alert("page allocated via order %u, migratetype %s, gfp_mask %#x(%pGg)\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask);
 	stack_trace_print(entries, nr_entries, 0);
@@ -562,7 +577,7 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 				continue;
 
 			/* Found early allocated page */
-			__set_page_owner_handle(page_ext, early_handle, 0, 0);
+			__set_page_owner_handle(page_ext, early_handle, 0);
 			count++;
 		}
 		cond_resched();
-- 
1.9.1

