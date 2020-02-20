Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF87165D84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBTM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:27:41 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:15380 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgBTM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:27:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 730133F3EC;
        Thu, 20 Feb 2020 13:27:39 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Ra2U7KTB;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H1dqCdNHo3ZM; Thu, 20 Feb 2020 13:27:38 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 03B253F3A8;
        Thu, 20 Feb 2020 13:27:37 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 04B3F36050D;
        Thu, 20 Feb 2020 13:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582201655; bh=64mAbjX11EJRavK+mR6T3m6NRmUWJ8BVZd3EsJB0Qx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ra2U7KTBmcqtvcddSfuGp21zhhYIGhuBGQls8x0N9bU12d0re3mCfkIkNg12Myo+B
         dIesvay4JHuauwSJN8O/QKDJZBto0U1lPeco7409QcpDys5fH02FWn0WyicGiID7e9
         29aYvFRhH/r/B9DchtajEfgDDmHf7Q7CMJu/ybDg=
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
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: [PATCH v4 6/9] drm/vmwgfx: Support huge page faults
Date:   Thu, 20 Feb 2020 13:27:16 +0100
Message-Id: <20200220122719.4302-7-thomas_os@shipmail.org>
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

With vmwgfx dirty-tracking we need a specialized huge_fault
callback. Implement and hook it up.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h        |  4 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 74 +++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c   |  5 +-
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index a31e726d6d71..82d86f2d2569 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1428,6 +1428,10 @@ void vmw_bo_dirty_unmap(struct vmw_buffer_object *vbo,
 			pgoff_t start, pgoff_t end);
 vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf);
 vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
+				enum page_entry_size pe_size);
+#endif
 
 /**
  * VMW_DEBUG_KMS - Debug output for kernel mode-setting
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 17a5dca7b921..cde3e07ebaf7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -473,7 +473,7 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 	 * a lot of unnecessary write faults.
 	 */
 	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE)
-		prot = vma->vm_page_prot;
+		prot = vm_get_page_prot(vma->vm_flags & ~VM_SHARED);
 	else
 		prot = vm_get_page_prot(vma->vm_flags);
 
@@ -486,3 +486,75 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 
 	return ret;
 }
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
+				enum page_entry_size pe_size)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
+	    vma->vm_private_data;
+	struct vmw_buffer_object *vbo =
+		container_of(bo, struct vmw_buffer_object, base);
+	pgprot_t prot;
+	vm_fault_t ret;
+	pgoff_t fault_page_size;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	bool is_cow_mapping =
+		(vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
+
+	switch (pe_size) {
+	case PE_SIZE_PMD:
+		fault_page_size = HPAGE_PMD_SIZE >> PAGE_SHIFT;
+		break;
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	case PE_SIZE_PUD:
+		fault_page_size = HPAGE_PUD_SIZE >> PAGE_SHIFT;
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return VM_FAULT_FALLBACK;
+	}
+
+	/* Always do write dirty-tracking and COW on PTE level. */
+	if (write && (READ_ONCE(vbo->dirty) || is_cow_mapping))
+		return VM_FAULT_FALLBACK;
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	if (vbo->dirty) {
+		pgoff_t allowed_prefault;
+		unsigned long page_offset;
+
+		page_offset = vmf->pgoff -
+			drm_vma_node_start(&bo->base.vma_node);
+		if (page_offset >= bo->num_pages ||
+		    vmw_resources_clean(vbo, page_offset,
+					page_offset + PAGE_SIZE,
+					&allowed_prefault)) {
+			ret = VM_FAULT_SIGBUS;
+			goto out_unlock;
+		}
+
+		/*
+		 * Write protect, so we get a new fault on write, and can
+		 * split.
+		 */
+		prot = vm_get_page_prot(vma->vm_flags & ~VM_SHARED);
+	} else {
+		prot = vm_get_page_prot(vma->vm_flags);
+	}
+
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, 1, fault_page_size);
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		return ret;
+
+out_unlock:
+	dma_resv_unlock(bo->base.resv);
+
+	return ret;
+}
+#endif
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
index ce288756531b..34100d1f5a9d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
@@ -34,7 +34,10 @@ int vmw_mmap(struct file *filp, struct vm_area_struct *vma)
 		.page_mkwrite = vmw_bo_vm_mkwrite,
 		.fault = vmw_bo_vm_fault,
 		.open = ttm_bo_vm_open,
-		.close = ttm_bo_vm_close
+		.close = ttm_bo_vm_close,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		.huge_fault = vmw_bo_vm_huge_fault,
+#endif
 	};
 	struct drm_file *file_priv = filp->private_data;
 	struct vmw_private *dev_priv = vmw_priv(file_priv->minor->dev);
-- 
2.21.1

