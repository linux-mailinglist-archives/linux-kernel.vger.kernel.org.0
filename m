Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76417740C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgCCKXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 05:23:19 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:37312 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgCCKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:23:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 391823F713;
        Tue,  3 Mar 2020 11:23:17 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=q1xapct0;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A-6sDjxEzpWn; Tue,  3 Mar 2020 11:23:05 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id A26123F524;
        Tue,  3 Mar 2020 11:22:59 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 15E65360481;
        Tue,  3 Mar 2020 11:22:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583230979; bh=sjfw4EDUDCZlOzwRRGyUB4kL3vTEnAR8SOHYZEwYpC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1xapct0xWHb9eW5/I4M/fB4DJFAUYfAtsyDhsYEh1lyQt6hDuSG2nOOQDlFwZ+S9
         67vyqJIvAFDzy8MCte6k/L0G8M86vSlbFyh4h75iJABbrvJw/n9IUEoyLhFGzoadeU
         a4V01nF2Ec5TVZl/Cq3jE9Kvv566+jDNKIicgJjU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v5 2/9] mm: Introduce vma_is_special_huge
Date:   Tue,  3 Mar 2020 11:22:40 +0100
Message-Id: <20200303102247.4635-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200303102247.4635-1-thomas_os@shipmail.org>
References: <20200303102247.4635-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

For VM_PFNMAP and VM_MIXEDMAP vmas that want to support transhuge pages
and -page table entries, introduce vma_is_special_huge() that takes the
same codepaths as vma_is_dax().

The use of "special" follows the definition in memory.c, vm_normal_page():
"Special" mappings do not wish to be associated with a "struct page"
(either it doesn't exist, or it exists but they don't want to touch it)

For PAGE_SIZE pages, "special" is determined per page table entry to be
able to deal with COW pages. But since we don't have huge COW pages,
we can classify a vma as either "special huge" or "normal huge".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 include/linux/mm.h | 17 +++++++++++++++++
 mm/huge_memory.c   |  6 +++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..e61cf3f609b4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2863,6 +2863,23 @@ extern long copy_huge_page_from_user(struct page *dst_page,
 				const void __user *usr_src,
 				unsigned int pages_per_huge_page,
 				bool allow_pagefault);
+
+/**
+ * vma_is_special_huge - Are transhuge page-table entries considered special?
+ * @vma: Pointer to the struct vm_area_struct to consider
+ *
+ * Whether transhuge page-table entries are considered "special" following
+ * the definition in vm_normal_page().
+ *
+ * Return: true if transhuge page-table entries should be considered special,
+ * false otherwise.
+ */
+static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
+{
+	return vma_is_dax(vma) || (vma->vm_file &&
+				   (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
+}
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..ff7a8b85c3ba 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1802,7 +1802,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	orig_pmd = pmdp_huge_get_and_clear_full(tlb->mm, addr, pmd,
 			tlb->fullmm);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2066,7 +2066,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
@@ -2175,7 +2175,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_dax(vma))
+		if (vma_is_special_huge(vma))
 			return;
 		page = pmd_page(_pmd);
 		if (!PageDirty(page) && pmd_dirty(_pmd))
-- 
2.21.1

