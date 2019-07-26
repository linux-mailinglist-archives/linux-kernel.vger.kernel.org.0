Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01F75C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 02:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGZA5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 20:57:13 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11773 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfGZA5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:57:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4fe10000>; Thu, 25 Jul 2019 17:57:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:57:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 17:57:07 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:57:07 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fe20000>; Thu, 25 Jul 2019 17:57:06 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 5/7] mm/hmm: make full use of walk_page_range()
Date:   Thu, 25 Jul 2019 17:56:48 -0700
Message-ID: <20190726005650.2566-6-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102625; bh=GyZ3LYNDHdPknOwN7r8eo0WLWm3OjKPNgGYZWHO3koQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=jkL74WIDmQa1QlupaV/bl/KqbTUH1ksEkEBYqKDVCv0gPT18+fIWkOYzYvA/JhIOQ
         WoaBiatsfQp4apyOEgWJmHcoEdUPR4iyjTzywVKgyNNm8afzWbdQXMTa9/hxtthL6D
         /LE78tMf67hTVoBMr8RtJYQVzlwb6HbvgmT6F/zz/N1x6ESVVbuCpM+rz7BljsWl27
         uC5J4Fa93NYNIxPT1yRulAC0TfLgGY7Kah/fiFeHkpm+tBTYaVXBUZGdk4m3bkr4fB
         RJUcwZpJbDqishirX9ybkZn+bh2oq918k2LQCl/jh1pLxkW0lN0hR53X03mm8AOhfy
         4ymbSl04N3uMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hmm_range_fault() calls find_vma() and walk_page_range() in a loop.
This is unnecessary duplication since walk_page_range() calls find_vma()
in a loop already.
Simplify hmm_range_fault() by defining a walk_test() callback function
to filter unhandled vmas.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 130 ++++++++++++++++++++++++-------------------------------
 1 file changed, 57 insertions(+), 73 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 1bc014cddd78..838cd1d50497 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -840,13 +840,44 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
 #endif
 }
=20
-static void hmm_pfns_clear(struct hmm_range *range,
-			   uint64_t *pfns,
-			   unsigned long addr,
-			   unsigned long end)
+static int hmm_vma_walk_test(unsigned long start,
+			     unsigned long end,
+			     struct mm_walk *walk)
 {
-	for (; addr < end; addr +=3D PAGE_SIZE, pfns++)
-		*pfns =3D range->values[HMM_PFN_NONE];
+	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
+	struct hmm_range *range =3D hmm_vma_walk->range;
+	struct vm_area_struct *vma =3D walk->vma;
+
+	/* If range is no longer valid, force retry. */
+	if (!range->valid)
+		return -EBUSY;
+
+	/*
+	 * Skip vma ranges that don't have struct page backing them or
+	 * map I/O devices directly.
+	 * TODO: handle peer-to-peer device mappings.
+	 */
+	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
+		return -EFAULT;
+
+	if (is_vm_hugetlb_page(vma)) {
+		if (huge_page_shift(hstate_vma(vma)) !=3D range->page_shift &&
+		    range->page_shift !=3D PAGE_SHIFT)
+			return -EINVAL;
+	} else {
+		if (range->page_shift !=3D PAGE_SHIFT)
+			return -EINVAL;
+	}
+
+	/*
+	 * If vma does not allow read access, then assume that it does not
+	 * allow write access, either. HMM does not support architectures
+	 * that allow write without read.
+	 */
+	if (!(vma->vm_flags & VM_READ))
+		return -EPERM;
+
+	return 0;
 }
=20
 /*
@@ -965,82 +996,35 @@ EXPORT_SYMBOL(hmm_range_unregister);
  */
 long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 {
-	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
-	unsigned long start =3D range->start, end;
-	struct hmm_vma_walk hmm_vma_walk;
+	unsigned long start =3D range->start;
+	struct hmm_vma_walk hmm_vma_walk =3D {};
 	struct hmm *hmm =3D range->hmm;
-	struct vm_area_struct *vma;
-	struct mm_walk mm_walk;
+	struct mm_walk mm_walk =3D {};
 	int ret;
=20
 	lockdep_assert_held(&hmm->mm->mmap_sem);
=20
-	do {
-		/* If range is no longer valid force retry. */
-		if (!range->valid)
-			return -EBUSY;
+	hmm_vma_walk.range =3D range;
+	hmm_vma_walk.last =3D start;
+	hmm_vma_walk.flags =3D flags;
+	mm_walk.private =3D &hmm_vma_walk;
=20
-		vma =3D find_vma(hmm->mm, start);
-		if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
-			return -EFAULT;
-
-		if (is_vm_hugetlb_page(vma)) {
-			if (huge_page_shift(hstate_vma(vma)) !=3D
-			    range->page_shift &&
-			    range->page_shift !=3D PAGE_SHIFT)
-				return -EINVAL;
-		} else {
-			if (range->page_shift !=3D PAGE_SHIFT)
-				return -EINVAL;
-		}
+	mm_walk.mm =3D hmm->mm;
+	mm_walk.pud_entry =3D hmm_vma_walk_pud;
+	mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
+	mm_walk.pte_hole =3D hmm_vma_walk_hole;
+	mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
+	mm_walk.test_walk =3D hmm_vma_walk_test;
=20
-		if (!(vma->vm_flags & VM_READ)) {
-			/*
-			 * If vma do not allow read access, then assume that it
-			 * does not allow write access, either. HMM does not
-			 * support architecture that allow write without read.
-			 */
-			hmm_pfns_clear(range, range->pfns,
-				range->start, range->end);
-			return -EPERM;
-		}
+	do {
+		ret =3D walk_page_range(start, range->end, &mm_walk);
+		start =3D hmm_vma_walk.last;
=20
-		range->vma =3D vma;
-		hmm_vma_walk.pgmap =3D NULL;
-		hmm_vma_walk.last =3D start;
-		hmm_vma_walk.flags =3D flags;
-		hmm_vma_walk.range =3D range;
-		mm_walk.private =3D &hmm_vma_walk;
-		end =3D min(range->end, vma->vm_end);
-
-		mm_walk.vma =3D vma;
-		mm_walk.mm =3D vma->vm_mm;
-		mm_walk.pte_entry =3D NULL;
-		mm_walk.test_walk =3D NULL;
-		mm_walk.hugetlb_entry =3D NULL;
-		mm_walk.pud_entry =3D hmm_vma_walk_pud;
-		mm_walk.pmd_entry =3D hmm_vma_walk_pmd;
-		mm_walk.pte_hole =3D hmm_vma_walk_hole;
-		mm_walk.hugetlb_entry =3D hmm_vma_walk_hugetlb_entry;
-
-		do {
-			ret =3D walk_page_range(start, end, &mm_walk);
-			start =3D hmm_vma_walk.last;
-
-			/* Keep trying while the range is valid. */
-		} while (ret =3D=3D -EBUSY && range->valid);
-
-		if (ret) {
-			unsigned long i;
-
-			i =3D (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
-			hmm_pfns_clear(range, &range->pfns[i],
-				hmm_vma_walk.last, range->end);
-			return ret;
-		}
-		start =3D end;
+		/* Keep trying while the range is valid. */
+	} while (ret =3D=3D -EBUSY && range->valid);
=20
-	} while (start < range->end);
+	if (ret)
+		return ret;
=20
 	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
--=20
2.20.1

