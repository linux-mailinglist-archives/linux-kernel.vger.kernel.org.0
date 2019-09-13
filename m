Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527FBB1ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 11:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfIMJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 05:32:44 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:39518 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388005AbfIMJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:32:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D65743F712;
        Fri, 13 Sep 2019 11:32:33 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=E6BAZgR+;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dDA1F9XuZwPV; Fri, 13 Sep 2019 11:32:30 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5AD1C3F21C;
        Fri, 13 Sep 2019 11:32:28 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id AD27F360248;
        Fri, 13 Sep 2019 11:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568367147; bh=O7CkVSfbqrZbq1k5SqaS6g94hqbxrwcsGFU1Ild1cks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6BAZgR+y6UMLcc92a5xk+hww9ed0cP2nftJGTFhB5/uZ4mxev50mo58VXDwlP7kP
         h7xCIv6GyIwo+nZ6cw6bTKPqxgbLF4Y/qaxpOhuN2olO29/h0XCXQCacDcaR386n7s
         U7vJ1QYfj1LvkeRmFX0vK+Ghef0RvN5SIEnld42Q=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 3/7] drm/ttm: TTM fault handler helpers
Date:   Fri, 13 Sep 2019 11:32:09 +0200
Message-Id: <20190913093213.27254-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913093213.27254-1-thomas_os@shipmail.org>
References: <20190913093213.27254-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

With the vmwgfx dirty tracking, the default TTM fault handler is not
completely sufficient (vmwgfx need to modify the vma->vm_flags member,
and also needs to restrict the number of prefaults).

We also want to replicate the new ttm_bo_vm_reserve() functionality

So start turning the TTM vm code into helpers: ttm_bo_vm_fault_reserved()
and ttm_bo_vm_reserve(), and provide a default TTM fault handler for other
drivers to use.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: "Christian König" <christian.koenig@amd.com> #v1
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 176 +++++++++++++++++++-------------
 include/drm/ttm/ttm_bo_api.h    |  10 ++
 2 files changed, 114 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 03f702c296cf..5a580adeb9d1 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -42,8 +42,6 @@
 #include <linux/uaccess.h>
 #include <linux/mem_encrypt.h>
 
-#define TTM_BO_VM_NUM_PREFAULT 16
-
 static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
 				struct vm_fault *vmf)
 {
@@ -106,31 +104,30 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
 		+ page_offset;
 }
 
-static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
+/**
+ * ttm_bo_vm_reserve - Reserve a buffer object in a retryable vm callback
+ * @bo: The buffer object
+ * @vmf: The fault structure handed to the callback
+ *
+ * vm callbacks like fault() and *_mkwrite() allow for the mm_sem to be dropped
+ * during long waits, and after the wait the callback will be restarted. This
+ * is to allow other threads using the same virtual memory space concurrent
+ * access to map(), unmap() completely unrelated buffer objects. TTM buffer
+ * object reservations sometimes wait for GPU and should therefore be
+ * considered long waits. This function reserves the buffer object interruptibly
+ * taking this into account. Starvation is avoided by the vm system not
+ * allowing too many repeated restarts.
+ * This function is intended to be used in customized fault() and _mkwrite()
+ * handlers.
+ *
+ * Return:
+ *    0 on success and the bo was reserved.
+ *    VM_FAULT_RETRY if blocking wait.
+ *    VM_FAULT_NOPAGE if blocking wait and retrying was not allowed.
+ */
+vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
+			     struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
-	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
-	    vma->vm_private_data;
-	struct ttm_bo_device *bdev = bo->bdev;
-	unsigned long page_offset;
-	unsigned long page_last;
-	unsigned long pfn;
-	struct ttm_tt *ttm = NULL;
-	struct page *page;
-	int err;
-	int i;
-	vm_fault_t ret = VM_FAULT_NOPAGE;
-	unsigned long address = vmf->address;
-	struct ttm_mem_type_manager *man =
-		&bdev->man[bo->mem.mem_type];
-	struct vm_area_struct cvma;
-
-	/*
-	 * Work around locking order reversal in fault / nopfn
-	 * between mmap_sem and bo_reserve: Perform a trylock operation
-	 * for reserve, and if it fails, retry the fault after waiting
-	 * for the buffer to become unreserved.
-	 */
 	if (unlikely(!dma_resv_trylock(bo->base.resv))) {
 		if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
 			if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
@@ -151,14 +148,55 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL(ttm_bo_vm_reserve);
+
+/**
+ * ttm_bo_vm_fault_reserved - TTM fault helper
+ * @vmf: The struct vm_fault given as argument to the fault callback
+ * @prot: The page protection to be used for this memory area.
+ * @num_prefault: Maximum number of prefault pages. The caller may want to
+ * specify this based on madvice settings and the size of the GPU object
+ * backed by the memory.
+ *
+ * This function inserts one or more page table entries pointing to the
+ * memory backing the buffer object, and then returns a return code
+ * instructing the caller to retry the page access.
+ *
+ * Return:
+ *   VM_FAULT_NOPAGE on success or pending signal
+ *   VM_FAULT_SIGBUS on unspecified error
+ *   VM_FAULT_OOM on out-of-memory
+ *   VM_FAULT_RETRY if retryable wait
+ */
+vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
+				    pgprot_t prot,
+				    pgoff_t num_prefault)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct cvma = *vma;
+	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
+	    vma->vm_private_data;
+	struct ttm_bo_device *bdev = bo->bdev;
+	unsigned long page_offset;
+	unsigned long page_last;
+	unsigned long pfn;
+	struct ttm_tt *ttm = NULL;
+	struct page *page;
+	int err;
+	pgoff_t i;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
+	unsigned long address = vmf->address;
+	struct ttm_mem_type_manager *man =
+		&bdev->man[bo->mem.mem_type];
+
 	/*
 	 * Refuse to fault imported pages. This should be handled
 	 * (if at all) by redirecting mmap to the exporter.
 	 */
-	if (bo->ttm && (bo->ttm->page_flags & TTM_PAGE_FLAG_SG)) {
-		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
-	}
+	if (bo->ttm && (bo->ttm->page_flags & TTM_PAGE_FLAG_SG))
+		return VM_FAULT_SIGBUS;
 
 	if (bdev->driver->fault_reserve_notify) {
 		struct dma_fence *moving = dma_fence_get(bo->moving);
@@ -169,11 +207,9 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 			break;
 		case -EBUSY:
 		case -ERESTARTSYS:
-			ret = VM_FAULT_NOPAGE;
-			goto out_unlock;
+			return VM_FAULT_NOPAGE;
 		default:
-			ret = VM_FAULT_SIGBUS;
-			goto out_unlock;
+			return VM_FAULT_SIGBUS;
 		}
 
 		if (bo->moving != moving) {
@@ -189,26 +225,15 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	 * move.
 	 */
 	ret = ttm_bo_vm_fault_idle(bo, vmf);
-	if (unlikely(ret != 0)) {
-		if (ret == VM_FAULT_RETRY &&
-		    !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
-			/* The BO has already been unreserved. */
-			return ret;
-		}
-
-		goto out_unlock;
-	}
+	if (unlikely(ret != 0))
+		return ret;
 
 	err = ttm_mem_io_lock(man, true);
-	if (unlikely(err != 0)) {
-		ret = VM_FAULT_NOPAGE;
-		goto out_unlock;
-	}
+	if (unlikely(err != 0))
+		return VM_FAULT_NOPAGE;
 	err = ttm_mem_io_reserve_vm(bo);
-	if (unlikely(err != 0)) {
-		ret = VM_FAULT_SIGBUS;
-		goto out_io_unlock;
-	}
+	if (unlikely(err != 0))
+		return VM_FAULT_SIGBUS;
 
 	page_offset = ((address - vma->vm_start) >> PAGE_SHIFT) +
 		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
@@ -220,18 +245,8 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		goto out_io_unlock;
 	}
 
-	/*
-	 * Make a local vma copy to modify the page_prot member
-	 * and vm_flags if necessary. The vma parameter is protected
-	 * by mmap_sem in write mode.
-	 */
-	cvma = *vma;
-	cvma.vm_page_prot = vm_get_page_prot(cvma.vm_flags);
-
-	if (bo->mem.bus.is_iomem) {
-		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
-						cvma.vm_page_prot);
-	} else {
+	cvma.vm_page_prot = ttm_io_prot(bo->mem.placement, prot);
+	if (!bo->mem.bus.is_iomem) {
 		struct ttm_operation_ctx ctx = {
 			.interruptible = false,
 			.no_wait_gpu = false,
@@ -240,24 +255,21 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		};
 
 		ttm = bo->ttm;
-		cvma.vm_page_prot = ttm_io_prot(bo->mem.placement,
-						cvma.vm_page_prot);
-
-		/* Allocate all page at once, most common usage */
-		if (ttm_tt_populate(ttm, &ctx)) {
+		if (ttm_tt_populate(bo->ttm, &ctx)) {
 			ret = VM_FAULT_OOM;
 			goto out_io_unlock;
 		}
+	} else {
+		/* Iomem should not be marked encrypted */
+		cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
 	}
 
 	/*
 	 * Speculatively prefault a number of pages. Only error on
 	 * first page.
 	 */
-	for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
+	for (i = 0; i < num_prefault; ++i) {
 		if (bo->mem.bus.is_iomem) {
-			/* Iomem should not be marked encrypted */
-			cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
 			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
 		} else {
 			page = ttm->pages[page_offset];
@@ -295,8 +307,28 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 	ret = VM_FAULT_NOPAGE;
 out_io_unlock:
 	ttm_mem_io_unlock(man);
-out_unlock:
+	return ret;
+}
+EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
+
+static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t prot;
+	struct ttm_buffer_object *bo = vma->vm_private_data;
+	vm_fault_t ret;
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	prot = vm_get_page_prot(vma->vm_flags);
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		return ret;
+
 	dma_resv_unlock(bo->base.resv);
+
 	return ret;
 }
 
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 43c4929a2171..d7ad8721d641 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -785,4 +785,14 @@ static inline bool ttm_bo_uses_embedded_gem_object(struct ttm_buffer_object *bo)
 {
 	return bo->base.dev != NULL;
 }
+
+/* Default number of pre-faulted pages in the TTM fault handler */
+#define TTM_BO_VM_NUM_PREFAULT 16
+
+vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
+			     struct vm_fault *vmf);
+
+vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
+				    pgprot_t prot,
+				    pgoff_t num_prefault);
 #endif
-- 
2.20.1

