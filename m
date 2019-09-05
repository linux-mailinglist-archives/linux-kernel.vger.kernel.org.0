Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477E3A9F5D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfIEKP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 06:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbfIEKP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:15:57 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0FE7C059B80
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 10:15:56 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id t24so1449594pfe.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 03:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6jD3QrhOaKmK0EuyaVvKU+JdqlKP+u0W9Mccju17fc=;
        b=qIGCMEqHdduoBPMPsmXMsFZwgxSnAcXL9Yc123y/W47UD6fYWaJv4rg5GG2jjdLrRD
         6f70i7FL84Vdi1yp/Yu1tMb4lhEnT+51trEa0WQJDFzbz7qJt1EG+z/KotGa3fA73VMX
         0/a62VwcQzAC7ZeRYD3GekICv/GdARGYL4/YX+CD6Yrty5q04V578x47ZgJMtQ7Pm930
         CPrhzJE+areww1fUMOYwvoRx1eNWC2gWWBUwk4Mj50+0nLoa/m2QrwSnV6BZZj+J1MpH
         179KK+U5+N8VXY0i7bLAMJ1d+FfmoNTZJK8EumHJve1B3nerXYLy8oIQ1+cBm53CNx2M
         ScNQ==
X-Gm-Message-State: APjAAAWFDvqDT0zn3AdNKrYcar4YDAwawRNbZfkWnCqjhgIA/s/LjnYI
        PpwQ2mIfkx0bUOXBwR/5gs2eT9cFA0/UghdHszb1+TfzTVOexqDVUJ6wCpzTNy1ImCgRT5Ay2Fo
        ewss3TRvaH+Wmsom3Fb143Zfm
X-Received: by 2002:a62:ee0e:: with SMTP id e14mr2873479pfi.31.1567678556100;
        Thu, 05 Sep 2019 03:15:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLZrMDTh45FeN+eUEDYn/HUog7bmtWQpvM3Fo3USpydbbe3iJMJ/OqTwL2izDvJ0YR0cnVLQ==
X-Received: by 2002:a62:ee0e:: with SMTP id e14mr2873454pfi.31.1567678555825;
        Thu, 05 Sep 2019 03:15:55 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a20sm413852pfo.33.2019.09.05.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 03:15:55 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v2 1/7] mm/gup: Rename "nonblocking" to "locked" where proper
Date:   Thu,  5 Sep 2019 18:15:28 +0800
Message-Id: <20190905101534.9637-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905101534.9637-1-peterx@redhat.com>
References: <20190905101534.9637-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 98f13ab37bac..eddbb95dcb8f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -622,12 +622,12 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
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
@@ -639,7 +639,7 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		fault_flags |= FAULT_FLAG_WRITE;
 	if (*flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
-	if (nonblocking)
+	if (locked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
@@ -665,8 +665,8 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	}
 
 	if (ret & VM_FAULT_RETRY) {
-		if (nonblocking && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
-			*nonblocking = 0;
+		if (locked && !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
+			*locked = 0;
 		return -EBUSY;
 	}
 
@@ -743,7 +743,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  *		only intends to ensure the pages are faulted in.
  * @vmas:	array of pointers to vmas corresponding to each page.
  *		Or NULL if the caller does not require them.
- * @nonblocking: whether waiting for disk IO or mmap_sem contention
+ * @locked:     whether we're still with the mmap_sem held
  *
  * Returns number of pages pinned. This may be fewer than the number
  * requested. If nr_pages is 0 or negative, returns 0. If no pages
@@ -772,13 +772,11 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
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
@@ -790,7 +788,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, unsigned long nr_pages,
 		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas, int *nonblocking)
+		struct vm_area_struct **vmas, int *locked)
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
@@ -834,7 +832,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			if (is_vm_hugetlb_page(vma)) {
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
-						gup_flags, nonblocking);
+						gup_flags, locked);
 				continue;
 			}
 		}
@@ -852,7 +850,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page) {
 			ret = faultin_page(tsk, vma, start, &foll_flags,
-					nonblocking);
+					   locked);
 			switch (ret) {
 			case 0:
 				goto retry;
@@ -1178,7 +1176,7 @@ EXPORT_SYMBOL(get_user_pages_remote);
  * @vma:   target vma
  * @start: start address
  * @end:   end address
- * @nonblocking:
+ * @locked: whether the mmap_sem is still held
  *
  * This takes care of mlocking the pages too if VM_LOCKED is set.
  *
@@ -1186,14 +1184,14 @@ EXPORT_SYMBOL(get_user_pages_remote);
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
@@ -1228,7 +1226,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * not result in a stack expansion that recurses back here.
 	 */
 	return __get_user_pages(current, mm, start, nr_pages, gup_flags,
-				NULL, NULL, nonblocking);
+				NULL, NULL, locked);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ede7e7f5d1ab..5f816ee42206 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4251,7 +4251,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
-			 long i, unsigned int flags, int *nonblocking)
+			 long i, unsigned int flags, int *locked)
 {
 	unsigned long pfn_offset;
 	unsigned long vaddr = *position;
@@ -4322,7 +4322,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				spin_unlock(ptl);
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
-			if (nonblocking)
+			if (locked)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 			if (flags & FOLL_NOWAIT)
 				fault_flags |= FAULT_FLAG_ALLOW_RETRY |
@@ -4339,9 +4339,9 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
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

