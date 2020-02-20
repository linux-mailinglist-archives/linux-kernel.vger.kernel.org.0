Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDF165D93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBTM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:28:01 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40868 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgBTM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:27:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id D8CE03F32A;
        Thu, 20 Feb 2020 13:27:41 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Iu4ligxm;
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
        with ESMTP id zc4uuzZMDVRb; Thu, 20 Feb 2020 13:27:39 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id CD99A3F3A0;
        Thu, 20 Feb 2020 13:27:38 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 525A2360549;
        Thu, 20 Feb 2020 13:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582201655; bh=2LUNS0ihPNGa71h7AdkyE1bKBSLMu6PTF7hbfe1+Dkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iu4ligxmua0yVOZE+J9dJHkYQD+vGs7Pi2NBw2yBv1pS9A0ZbmotXrfLhBVOnP+xB
         x64JU8e4hD0aSxLTKsk0/JBSdaurSRmrZ0x3viHqOs5hG1GGfMRRtyXyst9hID68hz
         IUt553YdOn6Is6IhJENw3wgdgyKHMm6JLwj64zYU=
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
Subject: [PATCH v4 8/9] drm/vmwgfx: Introduce a huge page aligning TTM range manager
Date:   Thu, 20 Feb 2020 13:27:18 +0100
Message-Id: <20200220122719.4302-9-thomas_os@shipmail.org>
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

Using huge page-table entries requires that the physical address of the
start of a buffer object is huge page size aligned.
Make a special version of the TTM range manager that accomplishes this,
but falls back to a smaller page size alignment (PUD->PMD, PMD->NORMAL)
to avoid eviction.
If other drivers want to use it in the future, it can be made a
TTM generic helper. Note that drivers can force eviction for a certain
alignment by assigning the TTM GPU alignment correspondingly.

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
 drivers/gpu/drm/vmwgfx/Makefile     |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |   7 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c | 166 ++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c

diff --git a/drivers/gpu/drm/vmwgfx/Makefile b/drivers/gpu/drm/vmwgfx/Makefile
index c877a21a0739..421dd2a497a5 100644
--- a/drivers/gpu/drm/vmwgfx/Makefile
+++ b/drivers/gpu/drm/vmwgfx/Makefile
@@ -11,4 +11,5 @@ vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.o vmwgfx_kms.o vmwgfx_drv.o \
 	    vmwgfx_validation.o vmwgfx_page_dirty.o \
 	    ttm_object.o ttm_lock.o
 
+vmwgfx-$(CONFIG_TRANSPARENT_HUGEPAGE) += vmwgfx_thp.o
 obj-$(CONFIG_DRM_VMWGFX) := vmwgfx.o
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 82d86f2d2569..06267184aa0a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1433,6 +1433,13 @@ vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
 				enum page_entry_size pe_size);
 #endif
 
+/* Transparent hugepage support - vmwgfx_thp.c */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern const struct ttm_mem_type_manager_func vmw_thp_func;
+#else
+#define vmw_thp_func ttm_bo_manager_func
+#endif
+
 /**
  * VMW_DEBUG_KMS - Debug output for kernel mode-setting
  *
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c b/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
new file mode 100644
index 000000000000..b7c816ba7166
--- /dev/null
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Huge page-table-entry support for IO memory.
+ *
+ * Copyright (C) 2007-2019 Vmware, Inc. All rights reservedd.
+ */
+#include "vmwgfx_drv.h"
+#include <drm/ttm/ttm_module.h>
+#include <drm/ttm/ttm_bo_driver.h>
+#include <drm/ttm/ttm_placement.h>
+
+/**
+ * struct vmw_thp_manager - Range manager implementing huge page alignment
+ *
+ * @mm: The underlying range manager. Protected by @lock.
+ * @lock: Manager lock.
+ */
+struct vmw_thp_manager {
+	struct drm_mm mm;
+	spinlock_t lock;
+};
+
+static int vmw_thp_insert_aligned(struct drm_mm *mm, struct drm_mm_node *node,
+				  unsigned long align_pages,
+				  const struct ttm_place *place,
+				  struct ttm_mem_reg *mem,
+				  unsigned long lpfn,
+				  enum drm_mm_insert_mode mode)
+{
+	if (align_pages >= mem->page_alignment &&
+	    (!mem->page_alignment || align_pages % mem->page_alignment == 0)) {
+		return drm_mm_insert_node_in_range(mm, node,
+						   mem->num_pages,
+						   align_pages, 0,
+						   place->fpfn, lpfn, mode);
+	}
+
+	return -ENOSPC;
+}
+
+static int vmw_thp_get_node(struct ttm_mem_type_manager *man,
+			    struct ttm_buffer_object *bo,
+			    const struct ttm_place *place,
+			    struct ttm_mem_reg *mem)
+{
+	struct vmw_thp_manager *rman = (struct vmw_thp_manager *) man->priv;
+	struct drm_mm *mm = &rman->mm;
+	struct drm_mm_node *node;
+	unsigned long align_pages;
+	unsigned long lpfn;
+	enum drm_mm_insert_mode mode = DRM_MM_INSERT_BEST;
+	int ret;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	lpfn = place->lpfn;
+	if (!lpfn)
+		lpfn = man->size;
+
+	mode = DRM_MM_INSERT_BEST;
+	if (place->flags & TTM_PL_FLAG_TOPDOWN)
+		mode = DRM_MM_INSERT_HIGH;
+
+	spin_lock(&rman->lock);
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)) {
+		align_pages = (HPAGE_PUD_SIZE >> PAGE_SHIFT);
+		if (mem->num_pages >= align_pages) {
+			ret = vmw_thp_insert_aligned(mm, node, align_pages,
+						     place, mem, lpfn, mode);
+			if (!ret)
+				goto found_unlock;
+		}
+	}
+
+	align_pages = (HPAGE_PMD_SIZE >> PAGE_SHIFT);
+	if (mem->num_pages >= align_pages) {
+		ret = vmw_thp_insert_aligned(mm, node, align_pages, place, mem,
+					     lpfn, mode);
+		if (!ret)
+			goto found_unlock;
+	}
+
+	ret = drm_mm_insert_node_in_range(mm, node, mem->num_pages,
+					  mem->page_alignment, 0,
+					  place->fpfn, lpfn, mode);
+found_unlock:
+	spin_unlock(&rman->lock);
+
+	if (unlikely(ret)) {
+		kfree(node);
+	} else {
+		mem->mm_node = node;
+		mem->start = node->start;
+	}
+
+	return 0;
+}
+
+
+
+static void vmw_thp_put_node(struct ttm_mem_type_manager *man,
+			     struct ttm_mem_reg *mem)
+{
+	struct vmw_thp_manager *rman = (struct vmw_thp_manager *) man->priv;
+
+	if (mem->mm_node) {
+		spin_lock(&rman->lock);
+		drm_mm_remove_node(mem->mm_node);
+		spin_unlock(&rman->lock);
+
+		kfree(mem->mm_node);
+		mem->mm_node = NULL;
+	}
+}
+
+static int vmw_thp_init(struct ttm_mem_type_manager *man,
+			unsigned long p_size)
+{
+	struct vmw_thp_manager *rman;
+
+	rman = kzalloc(sizeof(*rman), GFP_KERNEL);
+	if (!rman)
+		return -ENOMEM;
+
+	drm_mm_init(&rman->mm, 0, p_size);
+	spin_lock_init(&rman->lock);
+	man->priv = rman;
+	return 0;
+}
+
+static int vmw_thp_takedown(struct ttm_mem_type_manager *man)
+{
+	struct vmw_thp_manager *rman = (struct vmw_thp_manager *) man->priv;
+	struct drm_mm *mm = &rman->mm;
+
+	spin_lock(&rman->lock);
+	if (drm_mm_clean(mm)) {
+		drm_mm_takedown(mm);
+		spin_unlock(&rman->lock);
+		kfree(rman);
+		man->priv = NULL;
+		return 0;
+	}
+	spin_unlock(&rman->lock);
+	return -EBUSY;
+}
+
+static void vmw_thp_debug(struct ttm_mem_type_manager *man,
+			  struct drm_printer *printer)
+{
+	struct vmw_thp_manager *rman = (struct vmw_thp_manager *) man->priv;
+
+	spin_lock(&rman->lock);
+	drm_mm_print(&rman->mm, printer);
+	spin_unlock(&rman->lock);
+}
+
+const struct ttm_mem_type_manager_func vmw_thp_func = {
+	.init = vmw_thp_init,
+	.takedown = vmw_thp_takedown,
+	.get_node = vmw_thp_get_node,
+	.put_node = vmw_thp_put_node,
+	.debug = vmw_thp_debug
+};
-- 
2.21.1

