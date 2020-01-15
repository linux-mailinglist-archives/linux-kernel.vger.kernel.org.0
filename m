Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84B713C137
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgAOMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 07:41:28 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:55060 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgAOMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:41:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 4337A3F5B9;
        Wed, 15 Jan 2020 13:41:22 +0100 (CET)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="sP1irSv1";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aTovGtqjR91B; Wed, 15 Jan 2020 13:41:19 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id F040C3F573;
        Wed, 15 Jan 2020 13:41:17 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 6A9DD36034F;
        Wed, 15 Jan 2020 13:41:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1579092077; bh=NQPc7hArRXnkkg/rpqui/KurRt8CpyiG/SnSNxQvx/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sP1irSv1VCas9e21Phz219by0e/e18VwMPlDPMeeBrj56LAyMFYA+tIM4sxbvR1Z0
         E1myErsKLxDJmompwMASYFwTFfZzQuSwv1H+a+Te3SWoirTN7dv1//or0n3a1Wrdaf
         QaaSXqpKWDWJoLKSy3N4BnLojL2j6v4OZyI5BoFs=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v5 2/2] mm, drm/ttm: Fix vm page protection handling
Date:   Wed, 15 Jan 2020 13:41:07 +0100
Message-Id: <20200115124107.3845-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115124107.3845-1-thomas_os@shipmail.org>
References: <20200115124107.3845-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

TTM graphics buffer objects may, transparently to user-space,  move
between IO and system memory. When that happens, all PTEs pointing to the
old location are zapped before the move and then faulted in again if
needed. When that happens, the page protection caching mode- and
encryption bits may change and be different from those of
struct vm_area_struct::vm_page_prot.

We were using an ugly hack to set the page protection correctly.
Fix that and instead export and use vmf_insert_mixed_prot() or use
vmf_insert_pfn_prot().
Also get the default page protection from
struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
This way we catch modifications done by the vm system for drivers that
want write-notification.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 +++++++++++++++-------
 mm/memory.c                     |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 3e8c3de91ae4..78bfab81cf04 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -173,7 +173,6 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgoff_t num_prefault)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct vm_area_struct cvma = *vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
 	struct ttm_bo_device *bdev = bo->bdev;
 	unsigned long page_offset;
@@ -244,7 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		goto out_io_unlock;
 	}
 
-	cvma.vm_page_prot = ttm_io_prot(bo->mem.placement, prot);
+	prot = ttm_io_prot(bo->mem.placement, prot);
 	if (!bo->mem.bus.is_iomem) {
 		struct ttm_operation_ctx ctx = {
 			.interruptible = false,
@@ -260,7 +259,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		}
 	} else {
 		/* Iomem should not be marked encrypted */
-		cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
+		prot = pgprot_decrypted(prot);
 	}
 
 	/*
@@ -283,11 +282,20 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 			pfn = page_to_pfn(page);
 		}
 
+		/*
+		 * Note that the value of @prot at this point may differ from
+		 * the value of @vma->vm_page_prot in the caching- and
+		 * encryption bits. This is because the exact location of the
+		 * data may not be known at mmap() time and may also change
+		 * at arbitrary times while the data is mmap'ed.
+		 * See vmf_insert_mixed_prot() for a discussion.
+		 */
 		if (vma->vm_flags & VM_MIXEDMAP)
-			ret = vmf_insert_mixed(&cvma, address,
-					__pfn_to_pfn_t(pfn, PFN_DEV));
+			ret = vmf_insert_mixed_prot(vma, address,
+						    __pfn_to_pfn_t(pfn, PFN_DEV),
+						    prot);
 		else
-			ret = vmf_insert_pfn(&cvma, address, pfn);
+			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
@@ -319,7 +327,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	prot = vm_get_page_prot(vma->vm_flags);
+	prot = vma->vm_page_prot;
 	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 269a8a871e83..0f262acd1018 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1798,6 +1798,7 @@ vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
 {
 	return __vm_insert_mixed(vma, addr, pfn, pgprot, false);
 }
+EXPORT_SYMBOL(vmf_insert_mixed_prot);
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
-- 
2.21.0

