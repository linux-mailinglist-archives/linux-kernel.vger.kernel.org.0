Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA87598A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfF1KpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 06:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfF1KpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:45:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 951A1308624A;
        Fri, 28 Jun 2019 10:44:59 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D5EC5D756;
        Fri, 28 Jun 2019 10:44:48 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 1/7] mm/gup: Rename "nonblocking" to "locked" where proper
Date:   Fri, 28 Jun 2019 18:44:26 +0800
Message-Id: <20190628104432.12799-2-peterx@redhat.com>
In-Reply-To: <20190628104432.12799-1-peterx@redhat.com>
References: <20190628104432.12799-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 10:45:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's plenty of places around __get_user_pages() that has a parameter
"nonblocking" which does not really mean that "it won't block" (because
it can really block) but instead it shows whether the mmap_sem is
released by up_read() during the page fault handling mostly when
VM_FAULT_RETRY is returned.

We have the correct naming in e.g. get_user_pages_locked() or
get_user_pages_remote() as "locked", however there're still many places
that are using the "nonblocking" as name.

Renaming the places to "locked" where proper to better suite the
functionality of the variable.  While at it, fixing up some of the
comments accordingly.

Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c     | 44 +++++++++++++++++++++-----------------------
 mm/hugetlb.c |  8 ++++----
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf9e4..58d282115d9b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -625,12 +625,12 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 }
 
 /*
- * mmap_sem must be held on entry.  If @nonblocking != NULL and
- * *@flags does not include FOLL_NOWAIT, the mmap_sem may be released.
- * If it is, *@nonblocking will be set to 0 and -EBUSY returned.
+ * mmap_sem must be held on entry.  If @locked != NULL and *@flags
+ * does not include FOLL_NOWAIT, the mmap_sem may be released.  If it
+ * is, *@locked will be set to 0 and -EBUSY returned.
  */
 static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
-		unsigned long address, unsigned int *flags, int *nonblocking)
+		unsigned long address, unsigned int *flags, int *locked)
 {
 	unsigned int fault_flags = 0;
 	vm_fault_t ret;
@@ -642,7 +642,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		fault_flags |= FAULT_FLAG_WRITE;
 	if (*flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
-	if (nonblocking)
+	if (locked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
@@ -668,8 +668,8 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	}
 
 	if (ret & VM_FAULT_RETRY) {
-		if (nonblocking && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
-			*nonblocking = 0;
+		if (locked && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
+			*locked = 0;
 		return -EBUSY;
 	}
 
@@ -746,7 +746,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  *		only intends to ensure the pages are faulted in.
  * @vmas:	array of pointers to vmas corresponding to each page.
  *		Or NULL if the caller does not require them.
- * @nonblocking: whether waiting for disk IO or mmap_sem contention
+ * @locked:     whether we're still with the mmap_sem held
  *
  * Returns number of pages pinned. This may be fewer than the number
  * requested. If nr_pages is 0 or negative, returns 0. If no pages
@@ -775,13 +775,11 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  * appropriate) must be called after the page is finished with, and
  * before put_page is called.
  *
- * If @nonblocking != NULL, __get_user_pages will not wait for disk IO
- * or mmap_sem contention, and if waiting is needed to pin all pages,
- * *@nonblocking will be set to 0.  Further, if @gup_flags does not
- * include FOLL_NOWAIT, the mmap_sem will be released via up_read() in
- * this case.
+ * If @locked != NULL, *@locked will be set to 0 when mmap_sem is
+ * released by an up_read().  That can happen if @gup_flags does not
+ * have FOLL_NOWAIT.
  *
- * A caller using such a combination of @nonblocking and @gup_flags
+ * A caller using such a combination of @locked and @gup_flags
  * must therefore hold the mmap_sem for reading only, and recognize
  * when it's been released.  Otherwise, it must be held for either
  * reading or writing and will not be released.
@@ -793,7 +791,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas, int *nonblocking)
+		struct vm_area_struct **vmas, int *locked)
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
@@ -837,7 +835,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			if (is_vm_hugetlb_page(vma)) {
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
-						gup_flags, nonblocking);
+						gup_flags, locked);
 				continue;
 			}
 		}
@@ -855,7 +853,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page) {
 			ret = faultin_page(tsk, vma, start, &foll_flags,
-					nonblocking);
+					   locked);
 			switch (ret) {
 			case 0:
 				goto retry;
@@ -1508,7 +1506,7 @@ EXPORT_SYMBOL(get_user_pages);
  * @vma:   target vma
  * @start: start address
  * @end:   end address
- * @nonblocking:
+ * @locked: whether the mmap_sem is still held
  *
  * This takes care of mlocking the pages too if VM_LOCKED is set.
  *
@@ -1516,14 +1514,14 @@ EXPORT_SYMBOL(get_user_pages);
  *
  * vma->vm_mm->mmap_sem must be held.
  *
- * If @nonblocking is NULL, it may be held for read or write and will
+ * If @locked is NULL, it may be held for read or write and will
  * be unperturbed.
  *
- * If @nonblocking is non-NULL, it must held for read only and may be
- * released.  If it's released, *@nonblocking will be set to 0.
+ * If @locked is non-NULL, it must held for read only and may be
+ * released.  If it's released, *@locked will be set to 0.
  */
 long populate_vma_page_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, int *nonblocking)
+		unsigned long start, unsigned long end, int *locked)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long nr_pages = (end - start) / PAGE_SIZE;
@@ -1558,7 +1556,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * not result in a stack expansion that recurses back here.
 	 */
 	return __get_user_pages(current, mm, start, nr_pages, gup_flags,
-				NULL, NULL, nonblocking);
+				NULL, NULL, locked);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac843d32b019..ba179c2fa8fb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4240,7 +4240,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
-			 long i, unsigned int flags, int *nonblocking)
+			 long i, unsigned int flags, int *locked)
 {
 	unsigned long pfn_offset;
 	unsigned long vaddr = *position;
@@ -4311,7 +4311,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				spin_unlock(ptl);
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
-			if (nonblocking)
+			if (locked)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 			if (flags & FOLL_NOWAIT)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
@@ -4328,9 +4328,9 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				break;
 			}
 			if (ret & VM_FAULT_RETRY) {
-				if (nonblocking &&
+				if (locked &&
 				    !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
-					*nonblocking = 0;
+					*locked = 0;
 				*nr_pages = 0;
 				/*
 				 * VM_FAULT_RETRY must not return an
-- 
2.21.0

