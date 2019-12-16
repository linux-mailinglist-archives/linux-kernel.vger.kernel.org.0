Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3649C121654
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 19:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfLPS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 13:28:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27799 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731463AbfLPS2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576520884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sBKmDiOZxVBZuxe758DLG5r3Ymi6EhqTYIfa17LOS4Y=;
        b=Tdw7fD00yAAwWOBMoOgT5D/wpoLvF1K24ErtpuSzW5S4bblpjXNwH8ly7xm1wJqvzp0N99
        rQRiynxMmWueonNIIJ/Zbnv1XrQgiiOtImoirG6B6Gr36I6d/+CR0I9f0bCfqYW33VGbhK
        ZGFJ5ydIqgH0owtHSWg6xBnOZPCJmWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-3nJ98Xw1NJ69_WUh9cBy0w-1; Mon, 16 Dec 2019 13:28:00 -0500
X-MC-Unique: 3nJ98Xw1NJ69_WUh9cBy0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41557593A0;
        Mon, 16 Dec 2019 18:27:58 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A05FD9CA3;
        Mon, 16 Dec 2019 18:27:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/hugetlb: Defer freeing of huge pages if in non-task context
Date:   Mon, 16 Dec 2019 13:27:39 -0500
Message-Id: <20191216182739.26880-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep splat was observed when a certain hugetlbfs test
was run:

[  612.388273] ================================
[  612.411273] WARNING: inconsistent lock state
[  612.432273] 4.18.0-159.el8.x86_64+debug #1 Tainted: G        W --------- -  -
[  612.469273] --------------------------------
[  612.489273] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  612.517273] swapper/30/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[  612.541273] ffffffff9acdc038 (hugetlb_lock){+.?.}, at: free_huge_page+0x36f/0xaa0
[  612.576273] {SOFTIRQ-ON-W} state was registered at:
[  612.598273]   lock_acquire+0x14f/0x3b0
[  612.616273]   _raw_spin_lock+0x30/0x70
[  612.634273]   __nr_hugepages_store_common+0x11b/0xb30
[  612.657273]   hugetlb_sysctl_handler_common+0x209/0x2d0
[  612.681273]   proc_sys_call_handler+0x37f/0x450
[  612.703273]   vfs_write+0x157/0x460
[  612.719273]   ksys_write+0xb8/0x170
[  612.736273]   do_syscall_64+0xa5/0x4d0
[  612.753273]   entry_SYSCALL_64_after_hwframe+0x6a/0xdf
[  612.777273] irq event stamp: 691296
[  612.794273] hardirqs last  enabled at (691296): [<ffffffff99bb034b>] _raw_spin_unlock_irqrestore+0x4b/0x60
[  612.839273] hardirqs last disabled at (691295): [<ffffffff99bb0ad2>] _raw_spin_lock_irqsave+0x22/0x81
[  612.882273] softirqs last  enabled at (691284): [<ffffffff97ff0c63>] irq_enter+0xc3/0xe0
[  612.922273] softirqs last disabled at (691285): [<ffffffff97ff0ebe>] irq_exit+0x23e/0x2b0
[  612.962273]
[  612.962273] other info that might help us debug this:
[  612.993273]  Possible unsafe locking scenario:
[  612.993273]
[  613.020273]        CPU0
[  613.031273]        ----
[  613.042273]   lock(hugetlb_lock);
[  613.057273]   <Interrupt>
[  613.069273]     lock(hugetlb_lock);
[  613.085273]
[  613.085273]  *** DEADLOCK ***
      :
[  613.245273] Call Trace:
[  613.256273]  <IRQ>
[  613.265273]  dump_stack+0x9a/0xf0
[  613.281273]  mark_lock+0xd0c/0x12f0
[  613.297273]  ? print_shortest_lock_dependencies+0x80/0x80
[  613.322273]  ? sched_clock_cpu+0x18/0x1e0
[  613.341273]  __lock_acquire+0x146b/0x48c0
[  613.360273]  ? trace_hardirqs_on+0x10/0x10
[  613.379273]  ? trace_hardirqs_on_caller+0x27b/0x580
[  613.401273]  lock_acquire+0x14f/0x3b0
[  613.419273]  ? free_huge_page+0x36f/0xaa0
[  613.440273]  _raw_spin_lock+0x30/0x70
[  613.458273]  ? free_huge_page+0x36f/0xaa0
[  613.477273]  free_huge_page+0x36f/0xaa0
[  613.495273]  bio_check_pages_dirty+0x2fc/0x5c0
[  613.516273]  clone_endio+0x17f/0x670 [dm_mod]
[  613.536273]  ? disable_discard+0x90/0x90 [dm_mod]
[  613.558273]  ? bio_endio+0x4ba/0x930
[  613.575273]  ? blk_account_io_completion+0x400/0x530
[  613.598273]  blk_update_request+0x276/0xe50
[  613.617273]  scsi_end_request+0x7b/0x6a0
[  613.636273]  ? lock_downgrade+0x6f0/0x6f0
[  613.654273]  scsi_io_completion+0x1c6/0x1570
[  613.674273]  ? sd_completed_bytes+0x3a0/0x3a0 [sd_mod]
[  613.698273]  ? scsi_mq_requeue_cmd+0xc0/0xc0
[  613.718273]  blk_done_softirq+0x22e/0x350
[  613.737273]  ? blk_softirq_cpu_dead+0x230/0x230
[  613.758273]  __do_softirq+0x23d/0xad8
[  613.776273]  irq_exit+0x23e/0x2b0
[  613.792273]  do_IRQ+0x11a/0x200
[  613.806273]  common_interrupt+0xf/0xf
[  613.823273]  </IRQ>

Both the hugetbl_lock and the subpool lock can be acquired in
free_huge_page(). One way to solve the problem is to make both locks
irq-safe. Another alternative is to defer the freeing to a workqueue job.

This patch implements the deferred freeing by adding a
free_hpage_workfn() work function to do the actual freeing. The
free_huge_page() call in a non-task context saves the page to be freed
in the hpage_freelist linked list in a lockless manner.

The generic workqueue is used to process the work, but a dedicated
workqueue can be used instead if it is desirable to have the huge page
freed ASAP.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/hugetlb.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac65bb5e38ac..1dfebd898943 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1136,7 +1136,7 @@ static inline void ClearPageHugeTemporary(struct page *page)
 	page[2].mapping = NULL;
 }
 
-void free_huge_page(struct page *page)
+static void __free_huge_page(struct page *page)
 {
 	/*
 	 * Can't pass hstate in here because it is called from the
@@ -1199,6 +1199,73 @@ void free_huge_page(struct page *page)
 	spin_unlock(&hugetlb_lock);
 }
 
+/*
+ * As free_huge_page() can be called from a non-task context, we have
+ * to defer the actual freeing in a workqueue to prevent potential
+ * hugetlb_lock deadlock.
+ *
+ * free_hpage_workfn() locklessly retrieves the linked list of pages to
+ * be freed and frees them one-by-one. As the page->mapping pointer is
+ * going to be cleared in __free_huge_page() anyway, it is reused as the
+ * next pointer of a singly linked list of huge pages to be freed.
+ */
+#define NEXT_PENDING	((struct page *)-1)
+static struct page *hpage_freelist;
+
+static void free_hpage_workfn(struct work_struct *work)
+{
+	struct page *curr, *next;
+	int cnt = 0;
+
+	do {
+		curr = xchg(&hpage_freelist, NULL);
+		if (!curr)
+			break;
+
+		while (curr) {
+			next = (struct page *)READ_ONCE(curr->mapping);
+			if (next == NEXT_PENDING) {
+				cpu_relax();
+				continue;
+			}
+			__free_huge_page(curr);
+			curr = next;
+			cnt++;
+		}
+	} while (!READ_ONCE(hpage_freelist));
+
+	if (!cnt)
+		return;
+	pr_debug("HugeTLB: free_hpage_workfn() frees %d huge page(s)\n", cnt);
+}
+static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
+
+void free_huge_page(struct page *page)
+{
+	/*
+	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
+	 */
+	if (!in_task()) {
+		struct page *next;
+
+		page->mapping = (struct address_space *)NEXT_PENDING;
+		next = xchg(&hpage_freelist, page);
+		WRITE_ONCE(page->mapping, (struct address_space *)next);
+		schedule_work(&free_hpage_work);
+		return;
+	}
+
+	/*
+	 * Racing may prevent some deferred huge pages in hpage_freelist
+	 * from being freed. Check here and call schedule_work() if that
+	 * is the case.
+	 */
+	if (unlikely(hpage_freelist && !work_pending(&free_hpage_work)))
+		schedule_work(&free_hpage_work);
+
+	__free_huge_page(page);
+}
+
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
 	INIT_LIST_HEAD(&page->lru);
-- 
2.18.1

