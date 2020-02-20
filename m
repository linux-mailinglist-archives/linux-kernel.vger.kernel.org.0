Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD00165D96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBTM2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:28:11 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:50586 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbgBTM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:27:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 33A993F6BD;
        Thu, 20 Feb 2020 13:27:39 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=DF3/n0mI;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NdrJJSha_YO7; Thu, 20 Feb 2020 13:27:37 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id DB8423F65E;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 637BE3602EF;
        Thu, 20 Feb 2020 13:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582201654; bh=SVQ3RAqEw090XnvDX2q3fl6XDeSe2sWac77JhhSBCNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DF3/n0mI9ef9nwepicupKS0qV4Cvlnx8rwt1dkjeh20zcvUljOhCHo/J9YPz4oIsj
         cM5aLlEtdFRwb2ZEfR7UnwFunijSFVpRrERqGKqDqXOaZlgrnETMWgVdoC1PqgNE7c
         DeQsa5qD/zizsj3BfQ5DcxFg1qSjNPY4Aw1ArXtk=
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
Subject: [PATCH v4 2/9] mm: Introduce vma_is_special_huge
Date:   Thu, 20 Feb 2020 13:27:12 +0100
Message-Id: <20200220122719.4302-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220122719.4302-1-thomas_os@shipmail.org>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
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
index 0157d293935f..d370ce2932a1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2822,6 +2822,23 @@ extern long copy_huge_page_from_user(struct page *dst_page,
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
index 41a0fbddc96b..f8d24fc3f4df 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1789,7 +1789,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	orig_pmd = pmdp_huge_get_and_clear_full(tlb->mm, addr, pmd,
 			tlb->fullmm);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2053,7 +2053,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
@@ -2162,7 +2162,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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

