Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0980DE880
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfJUJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 05:51:12 -0400
Received: from www9186uo.sakura.ne.jp ([153.121.56.200]:37462 "EHLO
        www9186uo.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfJUJvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:51:12 -0400
Received: by www9186uo.sakura.ne.jp (Postfix, from userid 500)
        id 4F87B1E10EA; Mon, 21 Oct 2019 18:51:09 +0900 (JST)
Date:   Mon, 21 Oct 2019 18:51:09 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/16] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
Message-ID: <20191021095106.GA22933@www9186uo.sakura.ne.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-10-osalvador@suse.de>
 <20191021070439.GC9037@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <20191021070439.GC9037@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:04:40AM +0000, Naoya Horiguchi wrote:
> On Thu, Oct 17, 2019 at 04:21:16PM +0200, Oscar Salvador wrote:
> > Place the THP's page handling in a helper and use it
> > from both hard and soft-offline machinery, so we get rid
> > of some duplicated code.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
...
> > @@ -1288,21 +1307,8 @@ int memory_failure(unsigned long pfn, int flags)
> >  	}
> >  
> >  	if (PageTransHuge(hpage)) {
> > -		lock_page(p);
> > -		if (!PageAnon(p) || unlikely(split_huge_page(p))) {
> > -			unlock_page(p);
> > -			if (!PageAnon(p))
> > -				pr_err("Memory failure: %#lx: non anonymous thp\n",
> > -					pfn);
> > -			else
> > -				pr_err("Memory failure: %#lx: thp split failed\n",
> > -					pfn);
> > -			if (TestClearPageHWPoison(p))
> > -				num_poisoned_pages_dec();
> > -			put_page(p);
> > +		if (try_to_split_thp_page(p, "Memory Failure") < 0)
> >  			return -EBUSY;
> 
> Although this is not a cleanup thing, this failure path means that
> hwpoison is handled (PG_hwpoison is marked), so action_result() should
> be called.  I'll add a patch for this later.

Here's the one.  So Oscar, If you like, could you append this to
your tree in the next spin (with your credit or signed-off-by)?

Thanks,
Naoya Horiguchi
---
From b920f965485f6679ddc27e1a51da5bff7a5cc81a Mon Sep 17 00:00:00 2001
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Mon, 21 Oct 2019 18:42:33 +0900
Subject: [PATCH] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP

memory_failure() is supposed to call action_result() when it handles
a memory error event, but there's one missing case. So let's add it.

I find that include/ras/ras_event.h has some other MF_MSG_* undefined,
so this patch also adds them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 include/linux/mm.h      | 1 +
 include/ras/ras_event.h | 3 +++
 mm/memory-failure.c     | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3eba26324ff1..022033cc6782 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2818,6 +2818,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_BUDDY_2ND,
 	MF_MSG_DAX,
+	MF_MSG_UNSPLIT_THP,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 36c5c5e38c1d..0bdbc0d17d2f 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -361,6 +361,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
+	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
 	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
 	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
@@ -373,6 +374,8 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )		\
+	EM ( MF_MSG_DAX, "dax page" )					\
+	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 46ca856703f6..b15086ad8948 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -583,6 +583,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
 	[MF_MSG_DAX]			= "dax page",
+	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1361,8 +1362,10 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
-		if (try_to_split_thp_page(p, "Memory Failure") < 0)
+		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
+			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			return -EBUSY;
+		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
 		hpage = compound_head(p);
 	}
-- 
2.17.1

