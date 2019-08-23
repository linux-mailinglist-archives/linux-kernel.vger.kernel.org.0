Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529809B883
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 00:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406246AbfHWWSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 18:18:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10166 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404808AbfHWWSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:18:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6066230000>; Fri, 23 Aug 2019 15:18:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 23 Aug 2019 15:18:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 23 Aug 2019 15:18:11 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 22:18:10 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 22:18:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Aug 2019 22:18:08 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6066200001>; Fri, 23 Aug 2019 15:18:08 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 1/2] mm/hmm: hmm_range_fault() NULL pointer bug
Date:   Fri, 23 Aug 2019 15:17:52 -0700
Message-ID: <20190823221753.2514-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823221753.2514-1-rcampbell@nvidia.com>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566598691; bh=KyPc8c5coEeaWyED4oOxl50+aKdesFPM9yZHDro83x0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Hen0jCZnlwep5U1y8LSyUogocyncUlU8ncNOkdizYSGrpz0PWiTpWbpyXqvih6gF+
         3qM1vKPirI+eZhD9UBcD2rfGfX74o53wuqQ2rhVZQESI2bl/mdp0CgojyL1mtxb5Ob
         ir8YSrHdcr998BKtxBB/eEKh7i1GORjBa8cuXwOmDZ/V0k9Iyw4bAWSCMlLHs4ccfk
         Wt5oaufB+AfvTNVTT0Pq9TclkBcHR/CNerxUzXKz8H04CUc/qNXXq93VqSEU5uK80W
         pCzPYHqan8YLxW66Ob9wjgncemYyfZJiszrN4yrr0WCyhls1D6yjDovJ7pYDNxAIfA
         +LLT4nPogr8Bg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although hmm_range_fault() calls find_vma() to make sure that a vma exists
before calling walk_page_range(), hmm_vma_walk_hole() can still be called
with walk->vma =3D=3D NULL if the start and end address are not contained
within the vma range.

 hmm_range_fault() /* calls find_vma() but no range check */
  walk_page_range() /* calls find_vma(), sets walk->vma =3D NULL */
   __walk_page_range()
    walk_pgd_range()
     walk_p4d_range()
      walk_pud_range()
       hmm_vma_walk_hole()
        hmm_vma_walk_hole_()
         hmm_vma_do_fault()
          handle_mm_fault(vma=3D0)

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/hmm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index fc05c8fe78b4..29371485fe94 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -229,6 +229,9 @@ static int hmm_vma_do_fault(struct mm_walk *walk, unsig=
ned long addr,
 	struct vm_area_struct *vma =3D walk->vma;
 	vm_fault_t ret;
=20
+	if (!vma)
+		goto err;
+
 	if (hmm_vma_walk->flags & HMM_FAULT_ALLOW_RETRY)
 		flags |=3D FAULT_FLAG_ALLOW_RETRY;
 	if (write_fault)
@@ -239,12 +242,14 @@ static int hmm_vma_do_fault(struct mm_walk *walk, uns=
igned long addr,
 		/* Note, handle_mm_fault did up_read(&mm->mmap_sem)) */
 		return -EAGAIN;
 	}
-	if (ret & VM_FAULT_ERROR) {
-		*pfn =3D range->values[HMM_PFN_ERROR];
-		return -EFAULT;
-	}
+	if (ret & VM_FAULT_ERROR)
+		goto err;
=20
 	return -EBUSY;
+
+err:
+	*pfn =3D range->values[HMM_PFN_ERROR];
+	return -EFAULT;
 }
=20
 static int hmm_pfns_bad(unsigned long addr,
--=20
2.20.1

