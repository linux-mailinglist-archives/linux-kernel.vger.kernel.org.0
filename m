Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD0F0DBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 05:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfKFEXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 23:23:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43698 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfKFEXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:23:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so17840238pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 20:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=457zRy8Q3s9wRgu8y/sPdERdJPxGVqMQEwUnz4TtqNA=;
        b=cYHuXTl9Ol149SzIVmlYNhJG5BWhM89aNnpaJd7dDgTk9piI2EoSeKuP36f3dnka4z
         Vk8rCOzbLDOHUZVtWH7TYE4FuPy7CcHPduI9q8ukSl7ZxvJFdhtrjFX8iFI/iaga/Rzo
         qZlYPTQdl5AFk5ekgab2O8My52wE6AlEhLVmdtFTJhXZlvF/9yMmcfFTdBR1i9rIO65R
         kc21Z6fWYaS8yftLvD9Tgfx27KI3YPj09QfJEA8tAKwjla+wp0jT1zjfzav2cHx/xRTA
         XHCJFzMUbUI4ubLo78i1AgFn5yop+73lpxG21WclcJtXxOoBEh7E0F5WpNPxPIv3Txjb
         Lp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=457zRy8Q3s9wRgu8y/sPdERdJPxGVqMQEwUnz4TtqNA=;
        b=ZKyRS048tJLmUjJ7LofK8+ewy3ikerhj6vcwP1rS1fkaYKVf/xp8VWI0M1fEoX1jHc
         KgWo0KnCAR1Nwa3cfwEWUU3ub7RlGd58HX4AcwXoWpY1oAcQazmlCInIg4Pa97Gd9o5Y
         qMHWNubb/mKYsvub+5T+uO2Q7frl24g8yLfFfIRKtBPnD6H7B118mC326HEmfp0J5jTM
         tIbbeM9PRKp5eiXcYT2fX2HoVUE0IlGy0hc0YjkVeaa8NnqDz55wWUeWLhER6DGge3bp
         KHeU8dSP08rCMnEdubERjY9I05/9DEaAGk96LD3xo2PzGn0ekpukMVMLKJk9NND/5Rls
         bSLA==
X-Gm-Message-State: APjAAAUU+CZmrs1NS30kywu50WbTiol38idRZmwevQZgEwUEPo7L+Bot
        Pq0zftLlb+2P53L58/XxXdZFWX91Opw=
X-Google-Smtp-Source: APXvYqxEVpGKes2M4yeN4NKEiS/7KmJE5pinYK2D3KkWYOw3gNOvS0Y6NZ71sMmhlImli5PsEVf4hw==
X-Received: by 2002:a62:2f43:: with SMTP id v64mr730702pfv.13.1573014183726;
        Tue, 05 Nov 2019 20:23:03 -0800 (PST)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id n15sm23730289pfq.146.2019.11.05.20.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:23:03 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v15 2/5] dma-buf: heaps: Add heap helpers
Date:   Wed,  6 Nov 2019 04:22:49 +0000
Message-Id: <20191106042252.72452-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106042252.72452-1-john.stultz@linaro.org>
References: <20191106042252.72452-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic helper dmabuf ops for dma heaps, so we can reduce
the amount of duplicative code for the exported dmabufs.

This code is an evolution of the Android ION implementation, so
thanks to its original authors and maintainters:
  Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Sandeep Patil <sspatil@android.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Removed cache management performance hack that I had
  accidentally folded in.
* Removed stats code that was in helpers
* Lots of checkpatch cleanups
v3:
* Uninline INIT_HEAP_HELPER_BUFFER (suggested by Christoph)
* Switch to WARN on buffer destroy failure (suggested by Brian)
* buffer->kmap_cnt decrementing cleanup (suggested by Christoph)
* Extra buffer->vaddr checking in dma_heap_dma_buf_kmap
  (suggested by Brian)
* Switch to_helper_buffer from macro to inline function
  (suggested by Benjamin)
* Rename kmap->vmap (folded in from Andrew)
* Use vmap for vmapping - not begin_cpu_access (folded in from
  Andrew)
* Drop kmap for now, as its optional (folded in from Andrew)
* Fold dma_heap_map_user into the single caller (foled in from
  Andrew)
* Folded in patch from Andrew to track page list per heap not
  sglist, which simplifies the tracking logic
v4:
* Moved dma-heap.h change out to previous patch
v6:
* Minor cleanups and typo fixes suggested by Brian
v7:
* Removed stray ;
* Make init_heap_helper_buffer lowercase, as suggested by Christoph
* Add dmabuf export helper to reduce boilerplate code
v8:
* Remove unused private_flags value
* Condense dma_heap_buffer and heap_helper_buffer (suggested by
  Christoph)
* Fix indentation by using shorter argument names (suggested by
  Christoph)
* Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
  (suggested by Christoph)
* Checkpatch whitespace fixups
v9:
* Minor cleanups suggested by Brian Starkey
v10:
* Fix missing vmalloc.h inclusion in heap helpers (found by
  kbuild test robot <lkp@intel.com>)
v12:
* Add symbol exports for heaps as modules
v13:
* Re-remove symbol exports, per discussion with Brian, as I'll
  resubmit the change for review independently.
v14:
* Fix missing argment to WARN() in dma_heap_buffer_destroy()
  found and fixed by Dan Carpenter <dan.carpenter@oracle.com>
* Add check in fault hanlder that pgoff isn't larger then
  pagecount, reported by Dan Carpenter
v15:
* Drop unused flags field from heap_helper_buffer as suggested
  by Sandeep Patil
---
 drivers/dma-buf/Makefile             |   1 +
 drivers/dma-buf/heaps/Makefile       |   2 +
 drivers/dma-buf/heaps/heap-helpers.c | 271 +++++++++++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h |  53 ++++++
 4 files changed, 327 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h

diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index caee5eb3d351..9c190026bfab 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -2,6 +2,7 @@
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
 	 dma-resv.o seqno-fence.o
 obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
+obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
 obj-$(CONFIG_UDMABUF)		+= udmabuf.o
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
new file mode 100644
index 000000000000..de49898112db
--- /dev/null
+++ b/drivers/dma-buf/heaps/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y					+= heap-helpers.o
diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
new file mode 100644
index 000000000000..9f964ca3f59c
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/err.h>
+#include <linux/highmem.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+#include <uapi/linux/dma-heap.h>
+
+#include "heap-helpers.h"
+
+void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
+			     void (*free)(struct heap_helper_buffer *))
+{
+	buffer->priv_virt = NULL;
+	mutex_init(&buffer->lock);
+	buffer->vmap_cnt = 0;
+	buffer->vaddr = NULL;
+	buffer->pagecount = 0;
+	buffer->pages = NULL;
+	INIT_LIST_HEAD(&buffer->attachments);
+	buffer->free = free;
+}
+
+struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
+					  int fd_flags)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+
+	exp_info.ops = &heap_helper_ops;
+	exp_info.size = buffer->size;
+	exp_info.flags = fd_flags;
+	exp_info.priv = buffer;
+
+	return dma_buf_export(&exp_info);
+}
+
+static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
+{
+	void *vaddr;
+
+	vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
+	if (!vaddr)
+		return ERR_PTR(-ENOMEM);
+
+	return vaddr;
+}
+
+static void dma_heap_buffer_destroy(struct heap_helper_buffer *buffer)
+{
+	if (buffer->vmap_cnt > 0) {
+		WARN(1, "%s: buffer still mapped in the kernel\n", __func__);
+		vunmap(buffer->vaddr);
+	}
+
+	buffer->free(buffer);
+}
+
+static void *dma_heap_buffer_vmap_get(struct heap_helper_buffer *buffer)
+{
+	void *vaddr;
+
+	if (buffer->vmap_cnt) {
+		buffer->vmap_cnt++;
+		return buffer->vaddr;
+	}
+	vaddr = dma_heap_map_kernel(buffer);
+	if (IS_ERR(vaddr))
+		return vaddr;
+	buffer->vaddr = vaddr;
+	buffer->vmap_cnt++;
+	return vaddr;
+}
+
+static void dma_heap_buffer_vmap_put(struct heap_helper_buffer *buffer)
+{
+	if (!--buffer->vmap_cnt) {
+		vunmap(buffer->vaddr);
+		buffer->vaddr = NULL;
+	}
+}
+
+struct dma_heaps_attachment {
+	struct device *dev;
+	struct sg_table table;
+	struct list_head list;
+};
+
+static int dma_heap_attach(struct dma_buf *dmabuf,
+			   struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a;
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+	int ret;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
+					buffer->pagecount, 0,
+					buffer->pagecount << PAGE_SHIFT,
+					GFP_KERNEL);
+	if (ret) {
+		kfree(a);
+		return ret;
+	}
+
+	a->dev = attachment->dev;
+	INIT_LIST_HEAD(&a->list);
+
+	attachment->priv = a;
+
+	mutex_lock(&buffer->lock);
+	list_add(&a->list, &buffer->attachments);
+	mutex_unlock(&buffer->lock);
+
+	return 0;
+}
+
+static void dma_heap_detach(struct dma_buf *dmabuf,
+			    struct dma_buf_attachment *attachment)
+{
+	struct dma_heaps_attachment *a = attachment->priv;
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->lock);
+
+	sg_free_table(&a->table);
+	kfree(a);
+}
+
+static
+struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+				      enum dma_data_direction direction)
+{
+	struct dma_heaps_attachment *a = attachment->priv;
+	struct sg_table *table;
+
+	table = &a->table;
+
+	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
+			direction))
+		table = ERR_PTR(-ENOMEM);
+	return table;
+}
+
+static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
+{
+	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+}
+
+static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct heap_helper_buffer *buffer = vma->vm_private_data;
+
+	if (vmf->pgoff > buffer->pagecount)
+		return VM_FAULT_SIGBUS;
+
+	vmf->page = buffer->pages[vmf->pgoff];
+	get_page(vmf->page);
+
+	return 0;
+}
+
+static const struct vm_operations_struct dma_heap_vm_ops = {
+	.fault = dma_heap_vm_fault,
+};
+
+static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+
+	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+		return -EINVAL;
+
+	vma->vm_ops = &dma_heap_vm_ops;
+	vma->vm_private_data = buffer;
+
+	return 0;
+}
+
+static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+
+	dma_heap_buffer_destroy(buffer);
+}
+
+static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
+					     enum dma_data_direction direction)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+	struct dma_heaps_attachment *a;
+	int ret = 0;
+
+	mutex_lock(&buffer->lock);
+
+	if (buffer->vmap_cnt)
+		invalidate_kernel_vmap_range(buffer->vaddr, buffer->size);
+
+	list_for_each_entry(a, &buffer->attachments, list) {
+		dma_sync_sg_for_cpu(a->dev, a->table.sgl, a->table.nents,
+				    direction);
+	}
+	mutex_unlock(&buffer->lock);
+
+	return ret;
+}
+
+static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
+					   enum dma_data_direction direction)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+	struct dma_heaps_attachment *a;
+
+	mutex_lock(&buffer->lock);
+
+	if (buffer->vmap_cnt)
+		flush_kernel_vmap_range(buffer->vaddr, buffer->size);
+
+	list_for_each_entry(a, &buffer->attachments, list) {
+		dma_sync_sg_for_device(a->dev, a->table.sgl, a->table.nents,
+				       direction);
+	}
+	mutex_unlock(&buffer->lock);
+
+	return 0;
+}
+
+static void *dma_heap_dma_buf_vmap(struct dma_buf *dmabuf)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+	void *vaddr;
+
+	mutex_lock(&buffer->lock);
+	vaddr = dma_heap_buffer_vmap_get(buffer);
+	mutex_unlock(&buffer->lock);
+
+	return vaddr;
+}
+
+static void dma_heap_dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)
+{
+	struct heap_helper_buffer *buffer = dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
+	dma_heap_buffer_vmap_put(buffer);
+	mutex_unlock(&buffer->lock);
+}
+
+const struct dma_buf_ops heap_helper_ops = {
+	.map_dma_buf = dma_heap_map_dma_buf,
+	.unmap_dma_buf = dma_heap_unmap_dma_buf,
+	.mmap = dma_heap_mmap,
+	.release = dma_heap_dma_buf_release,
+	.attach = dma_heap_attach,
+	.detach = dma_heap_detach,
+	.begin_cpu_access = dma_heap_dma_buf_begin_cpu_access,
+	.end_cpu_access = dma_heap_dma_buf_end_cpu_access,
+	.vmap = dma_heap_dma_buf_vmap,
+	.vunmap = dma_heap_dma_buf_vunmap,
+};
diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps/heap-helpers.h
new file mode 100644
index 000000000000..805d2df88024
--- /dev/null
+++ b/drivers/dma-buf/heaps/heap-helpers.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMABUF Heaps helper code
+ *
+ * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#ifndef _HEAP_HELPERS_H
+#define _HEAP_HELPERS_H
+
+#include <linux/dma-heap.h>
+#include <linux/list.h>
+
+/**
+ * struct heap_helper_buffer - helper buffer metadata
+ * @heap:		back pointer to the heap the buffer came from
+ * @dmabuf:		backing dma-buf for this buffer
+ * @size:		size of the buffer
+ * @priv_virt		pointer to heap specific private value
+ * @lock		mutext to protect the data in this structure
+ * @vmap_cnt		count of vmap references on the buffer
+ * @vaddr		vmap'ed virtual address
+ * @pagecount		number of pages in the buffer
+ * @pages		list of page pointers
+ * @attachments		list of device attachments
+ *
+ * @free		heap callback to free the buffer
+ */
+struct heap_helper_buffer {
+	struct dma_heap *heap;
+	struct dma_buf *dmabuf;
+	size_t size;
+
+	void *priv_virt;
+	struct mutex lock;
+	int vmap_cnt;
+	void *vaddr;
+	pgoff_t pagecount;
+	struct page **pages;
+	struct list_head attachments;
+
+	void (*free)(struct heap_helper_buffer *buffer);
+};
+
+void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
+			     void (*free)(struct heap_helper_buffer *));
+
+struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
+					  int fd_flags);
+
+extern const struct dma_buf_ops heap_helper_ops;
+#endif /* _HEAP_HELPERS_H */
-- 
2.17.1

