Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2E7AC87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfG3PkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:40:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44350 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfG3PkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:40:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so30010481pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VL69OhOnAwL0XYVUd4iryHVhyGAPtRV3TIOYsddsZuM=;
        b=JnpuD7Lhn/qE7XJv7n7efhB9Y1FFuZ2F4tOy7xPNk3kBOJquUa5ZdXVE2CaWJEsrVh
         yMfhPN5d3zlY7lks50LSVx43a9lRWN3fEw+2mRlkOtiPyWUiI+jM084e7+I7io06LwW4
         kK68uPBHyuRVpRWRsz+aFk7D++UOdv1Lu2AkC6wYhYUrHLpHRAcI7yLQGzf4fxZ1UvEf
         MqI3XIEqPLJYE3iB6QcnVLgMG3zmHV68RS5MYxD0/c3AeU0Dct6278t6LVZ1T4B0j1Ew
         DlcnLz7xXh4kbs/9etasPC7viCglq3IR4SDSVF2nF9sw0Uiur+vimuBZvOX2mrvMzSNT
         29Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VL69OhOnAwL0XYVUd4iryHVhyGAPtRV3TIOYsddsZuM=;
        b=U1OGlnPysQqCIPwXX/XWbh5/H2I3IDRiPg0c57S1iKgbdSZHfsqwTBUfRMs2GC3EJc
         A3yP95LedsK93UbIcGDdkwqd52jBlI8r6BhFo7Yn/EV+EGFOiVDZwZtBydaiC86Yh2ns
         yyCc/n9guznEVR71qOp9G2BpvIx8tAMuEmqplLFjPrJB/qNZH4zYMqirThRAu+PJKioO
         jJ44oP5WKRXWxfz7LCPUtrAuKy7QpBVW64hsnfDhYXoxaGROjOGQ+0kEjwXumrielhfa
         caTnfLYsXuoIq7G2F+aFZXtrYk2jkEEruBGtntonJmt920jPAa1ev61CgvG/E+HHt6/l
         0Tpw==
X-Gm-Message-State: APjAAAWuhJwv3ugW/rw/jBY88CXmaX3cQTISLqlCH2XrFyxSaCO7Q4Qs
        C5YQfS/AiiUBGYksObOEvxY=
X-Google-Smtp-Source: APXvYqxzMdxms+bc78CL5gsMck7qwh7ISTe+alN65NyxUVXjwyMgBoEubKQB6gleAbfiP0OgFFPVqg==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id w11mr116924577pjn.125.1564501209516;
        Tue, 30 Jul 2019 08:40:09 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id 67sm36860864pfd.177.2019.07.30.08.40.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 08:40:09 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, arnd@arndb.de
Cc:     ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [Linux-kernel-mentees][PATCH v4 1/1] sgi-gru: Remove *pte_lookup functions
Date:   Tue, 30 Jul 2019 21:09:30 +0530
Message-Id: <1564501170-6830-2-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564501170-6830-1-git-send-email-linux.bhar@gmail.com>
References: <1564501170-6830-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *pte_lookup functions can be removed and be easily replaced with
get_user_pages_fast functions. In the case of atomic lookup,
__get_user_pages_fast is used which does not fall back to slow
get_user_pages. get_user_pages_fast on the other hand tries to use
__get_user_pages_fast but fallbacks to slow get_user_pages if
__get_user_pages_fast fails.

Also unnecessary ifdefs to check for CONFIG_HUGETLB is removed as the
check is redundant.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
This is a fold of the 3 patches in the v2 patch series.
The review tags were given to the individual patches.

Changes since v3
	- Used gup flags in get_user_pages_fast rather than
	boolean flags.
---
 drivers/misc/sgi-gru/grufault.c | 112 +++++++++-------------------------------
 1 file changed, 24 insertions(+), 88 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 4b713a8..304e9c5 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -166,96 +166,20 @@ static void get_clear_fault_map(struct gru_state *gru,
 }
 
 /*
- * Atomic (interrupt context) & non-atomic (user context) functions to
- * convert a vaddr into a physical address. The size of the page
- * is returned in pageshift.
- * 	returns:
- * 		  0 - successful
- * 		< 0 - error code
- * 		  1 - (atomic only) try again in non-atomic context
- */
-static int non_atomic_pte_lookup(struct vm_area_struct *vma,
-				 unsigned long vaddr, int write,
-				 unsigned long *paddr, int *pageshift)
-{
-	struct page *page;
-
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
-	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
-		return -EFAULT;
-	*paddr = page_to_phys(page);
-	put_page(page);
-	return 0;
-}
-
-/*
- * atomic_pte_lookup
+ * mmap_sem is already helod on entry to this function. This guarantees
+ * existence of the page tables.
  *
- * Convert a user virtual address to a physical address
  * Only supports Intel large pages (2MB only) on x86_64.
- *	ZZZ - hugepage support is incomplete
- *
- * NOTE: mmap_sem is already held on entry to this function. This
- * guarantees existence of the page tables.
+ *	ZZZ - hugepage support is incomplete.
  */
-static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
-	int write, unsigned long *paddr, int *pageshift)
-{
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t pte;
-
-	pgdp = pgd_offset(vma->vm_mm, vaddr);
-	if (unlikely(pgd_none(*pgdp)))
-		goto err;
-
-	p4dp = p4d_offset(pgdp, vaddr);
-	if (unlikely(p4d_none(*p4dp)))
-		goto err;
-
-	pudp = pud_offset(p4dp, vaddr);
-	if (unlikely(pud_none(*pudp)))
-		goto err;
-
-	pmdp = pmd_offset(pudp, vaddr);
-	if (unlikely(pmd_none(*pmdp)))
-		goto err;
-#ifdef CONFIG_X86_64
-	if (unlikely(pmd_large(*pmdp)))
-		pte = *(pte_t *) pmdp;
-	else
-#endif
-		pte = *pte_offset_kernel(pmdp, vaddr);
-
-	if (unlikely(!pte_present(pte) ||
-		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
-		return 1;
-
-	*paddr = pte_pfn(pte) << PAGE_SHIFT;
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
-	return 0;
-
-err:
-	return 1;
-}
-
 static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
 		    int write, int atomic, unsigned long *gpa, int *pageshift)
 {
 	struct mm_struct *mm = gts->ts_mm;
 	struct vm_area_struct *vma;
 	unsigned long paddr;
-	int ret, ps;
+	int ret;
+	struct page *page;
 
 	vma = find_vma(mm, vaddr);
 	if (!vma)
@@ -263,21 +187,33 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
 
 	/*
 	 * Atomic lookup is faster & usually works even if called in non-atomic
-	 * context.
+	 * context. get_user_pages_fast does atomic lookup before falling back to
+	 * slow gup.
 	 */
 	rmb();	/* Must/check ms_range_active before loading PTEs */
-	ret = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
-	if (ret) {
-		if (atomic)
+	if (atomic) {
+		ret = __get_user_pages_fast(vaddr, 1, write, &page);
+		if (!ret)
 			goto upm;
-		if (non_atomic_pte_lookup(vma, vaddr, write, &paddr, &ps))
+	} else {
+		ret = get_user_pages_fast(vaddr, 1, write ? FOLL_WRITE : 0, &page);
+		if (!ret)
 			goto inval;
 	}
+
+	paddr = page_to_phys(page);
+	put_user_page(page);
+
+	if (unlikely(is_vm_hugetlb_page(vma)))
+		*pageshift = HPAGE_SHIFT;
+	else
+		*pageshift = PAGE_SHIFT;
+
 	if (is_gru_paddr(paddr))
 		goto inval;
-	paddr = paddr & ~((1UL << ps) - 1);
+	paddr = paddr & ~((1UL << *pageshift) - 1);
 	*gpa = uv_soc_phys_ram_to_gpa(paddr);
-	*pageshift = ps;
+
 	return VTOP_SUCCESS;
 
 inval:
-- 
2.7.4

