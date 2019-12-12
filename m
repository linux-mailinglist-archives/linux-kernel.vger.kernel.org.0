Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9A11C871
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfLLIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 03:48:03 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:41312 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfLLIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:47:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id E48483F713;
        Thu, 12 Dec 2019 09:47:55 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=n/b6KwNU;
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
        with ESMTP id iF4Jam6OeP9h; Thu, 12 Dec 2019 09:47:54 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 7AB5E3F63C;
        Thu, 12 Dec 2019 09:47:51 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A13D23621B6;
        Thu, 12 Dec 2019 09:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1576140471; bh=jyqb+AEeV9/9Moj7O3xJDnnz7Mo2A9TsCql6OrJmNDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/b6KwNUp4OqN916NV9ZD0laqfxmAFJ6KCr3bBrebdnzCNkrA2htlk7KYuo1KSknO
         ccDPhEDnYX5YNtwBAHC6k0ytCa+2I8PNDSYKGWlsuvno1pTdZGjuWXSrg6LiptpAWc
         G19GjykWiI3PiOdOL/ig1runt3MtbZRE8jG9gQIQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v4 2/2] mm, drm/ttm: Fix vm page protection handling
Date:   Thu, 12 Dec 2019 09:47:41 +0100
Message-Id: <20191212084741.9251-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212084741.9251-1-thomas_os@shipmail.org>
References: <20191212084741.9251-1-thomas_os@shipmail.org>
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

