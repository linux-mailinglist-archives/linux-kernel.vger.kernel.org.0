Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C41051BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfFXTt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:49:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45997 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfFXTtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:49:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id z19so4712594pgl.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u/zFUO3yMoIyZsB9cMbMvZRrcD9xaq1bDUjQQ/exCxE=;
        b=jUxO4kdUYOs9pshrX+Xan74VySeFQJHDIl+iphGX9Z4AxgeKYs5JJzAHWoc9uHajaL
         eppVw06SwQ/zRYUha9mPNufPm2QrqOeJ7E53VzhaFmm7e9NN2Tt0D8yJ/B0SAREoQMpG
         XAImkg1b9BUVu4/U8vKwFLvQw6Uf6RnvfpLKI2yYxGV+yGGnYO8Thqf35mWLhEVkl6bV
         7dUkJr4oRjqKdD+cDglUowD6nQoVI7c1PNQikNjo1U1Jo7AuZM3lmW9g5pMobvl4budm
         Ew/sv5yLARmJmr+yll9NsMxMjZhxeIQeXkKX08G2XBIDhkZ50uxFjL5Auh8pKARz1z13
         erhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u/zFUO3yMoIyZsB9cMbMvZRrcD9xaq1bDUjQQ/exCxE=;
        b=Uh6cvBUq2OmvNbpFsU3FKcdwtTU28ft7h0nSTn3XEanRzvXBcTHmOAcGIFs/6LltLb
         32w51HHPK+tOF5PQ9hjXSbI5EZBTUUuEA3CytBJ6d66RiXp5Kz0qEWPnnO3w4qagLo1b
         H8qBQTZ46JgZr1FGkOCUBoawDPcnnyVY2vf2j1ucmNJPEIYfdW99bKBkXdwK3FqkCx/y
         kxKDP4H/jR576Fgefpl2CR7RXyTzgduGf8mOLcGUZUeVnBjGYn0Xfoew58q4cg5hktgj
         +1kv+R3Aus2/hgGciMrw8alo0NuqLcXPVL+jzjk4QO+bhedXdhtG8qrxCkACrtZbiRDw
         jCYg==
X-Gm-Message-State: APjAAAUAybWgRBEDbJ1u+pwgYilqacXBWz04PHtQem8rl38JJbPyNlz5
        dn/KnghyFocJiJa/zTjYFDSd+AXaqSE=
X-Google-Smtp-Source: APXvYqycDhB2rQp54g7Rc7xbJaAx5qPGV38UCten+IbY5pFy1HfClabiTmWOO99TuWZUa+g7Au/UiA==
X-Received: by 2002:a17:90a:8c06:: with SMTP id a6mr27486142pjo.45.1561405762232;
        Mon, 24 Jun 2019 12:49:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v3sm7957031pfm.188.2019.06.24.12.49.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 12:49:21 -0700 (PDT)
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
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
Date:   Mon, 24 Jun 2019 19:49:07 +0000
Message-Id: <20190624194908.121273-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624194908.121273-1-john.stultz@linaro.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a CMA heap, which allows userspace to allocate
a dma-buf of contiguous memory out of a CMA region.

This code is an evolution of the Android ION implementation, so
thanks to its original author and maintainters:
  Benjamin Gaignard, Laura Abbott, and others!

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
Cc: butao <butao@hisilicon.com>
Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Cc: Yudongbin <yudongbin@hisilicon.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: Ic2b0c5dfc0dbaff5245bd1c50170c64b06c73051
---
v2:
* Switch allocate to return dmabuf fd
* Simplify init code
* Checkpatch fixups
v3:
* Switch to inline function for to_cma_heap()
* Minor cleanups suggested by Brian
* Fold in new registration style from Andrew
* Folded in changes from Andrew to use simplified page list
  from the heap helpers
v4:
* Use the fd_flags when creating dmabuf fd (Suggested by
  Benjamin)
* Use precalculated pagecount (Suggested by Andrew)
v6:
* Changed variable names to improve clarity, as suggested
  by Brian
---
 drivers/dma-buf/heaps/Kconfig    |   8 ++
 drivers/dma-buf/heaps/Makefile   |   1 +
 drivers/dma-buf/heaps/cma_heap.c | 169 +++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/dma-buf/heaps/cma_heap.c

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index 205052744169..a5eef06c4226 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
 	help
 	  Choose this option to enable the system dmabuf heap. The system heap
 	  is backed by pages from the buddy allocator. If in doubt, say Y.
+
+config DMABUF_HEAPS_CMA
+	bool "DMA-BUF CMA Heap"
+	depends on DMABUF_HEAPS && DMA_CMA
+	help
+	  Choose this option to enable dma-buf CMA heap. This heap is backed
+	  by the Contiguous Memory Allocator (CMA). If your system has these
+	  regions, you should say Y here.
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
index d1808eca2581..6e54cdec3da0 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y					+= heap-helpers.o
 obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
+obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
new file mode 100644
index 000000000000..d2b10878b60b
--- /dev/null
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMABUF CMA heap exporter
+ *
+ * Copyright (C) 2012, 2019 Linaro Ltd.
+ * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/cma.h>
+#include <linux/scatterlist.h>
+#include <linux/highmem.h>
+
+#include "heap-helpers.h"
+
+struct cma_heap {
+	struct dma_heap *heap;
+	struct cma *cma;
+};
+
+static void cma_heap_free(struct heap_helper_buffer *buffer)
+{
+	struct cma_heap *cma_heap = dma_heap_get_data(buffer->heap_buffer.heap);
+	unsigned long nr_pages = buffer->pagecount;
+	struct page *cma_pages = buffer->priv_virt;
+
+	/* free page list */
+	kfree(buffer->pages);
+	/* release memory */
+	cma_release(cma_heap->cma, cma_pages, nr_pages);
+	kfree(buffer);
+}
+
+/* dmabuf heap CMA operations functions */
+static int cma_heap_allocate(struct dma_heap *heap,
+				unsigned long len,
+				unsigned long fd_flags,
+				unsigned long heap_flags)
+{
+	struct cma_heap *cma_heap = dma_heap_get_data(heap);
+	struct heap_helper_buffer *helper_buffer;
+	struct page *cma_pages;
+	size_t size = PAGE_ALIGN(len);
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long align = get_order(size);
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret = -ENOMEM;
+	pgoff_t pg;
+
+	if (align > CONFIG_CMA_ALIGNMENT)
+		align = CONFIG_CMA_ALIGNMENT;
+
+	helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
+	if (!helper_buffer)
+		return -ENOMEM;
+
+	INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
+	helper_buffer->heap_buffer.flags = heap_flags;
+	helper_buffer->heap_buffer.heap = heap;
+	helper_buffer->heap_buffer.size = len;
+
+	cma_pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
+	if (!cma_pages)
+		goto free_buf;
+
+	if (PageHighMem(cma_pages)) {
+		unsigned long nr_clear_pages = nr_pages;
+		struct page *page = cma_pages;
+
+		while (nr_clear_pages > 0) {
+			void *vaddr = kmap_atomic(page);
+
+			memset(vaddr, 0, PAGE_SIZE);
+			kunmap_atomic(vaddr);
+			page++;
+			nr_clear_pages--;
+		}
+	} else {
+		memset(page_address(cma_pages), 0, size);
+	}
+
+	helper_buffer->pagecount = nr_pages;
+	helper_buffer->pages = kmalloc_array(helper_buffer->pagecount,
+					     sizeof(*helper_buffer->pages),
+					     GFP_KERNEL);
+	if (!helper_buffer->pages) {
+		ret = -ENOMEM;
+		goto free_cma;
+	}
+
+	for (pg = 0; pg < helper_buffer->pagecount; pg++) {
+		helper_buffer->pages[pg] = &cma_pages[pg];
+		if (!helper_buffer->pages[pg])
+			goto free_pages;
+	}
+
+	/* create the dmabuf */
+	exp_info.ops = &heap_helper_ops;
+	exp_info.size = len;
+	exp_info.flags = fd_flags;
+	exp_info.priv = &helper_buffer->heap_buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_pages;
+	}
+
+	helper_buffer->heap_buffer.dmabuf = dmabuf;
+	helper_buffer->priv_virt = cma_pages;
+
+	ret = dma_buf_fd(dmabuf, fd_flags);
+	if (ret < 0) {
+		dma_buf_put(dmabuf);
+		/* just return, as put will call release and that will free */
+		return ret;
+	}
+
+	return ret;
+
+free_pages:
+	kfree(helper_buffer->pages);
+free_cma:
+	cma_release(cma_heap->cma, cma_pages, nr_pages);
+free_buf:
+	kfree(helper_buffer);
+	return ret;
+}
+
+static struct dma_heap_ops cma_heap_ops = {
+	.allocate = cma_heap_allocate,
+};
+
+static int __add_cma_heap(struct cma *cma, void *data)
+{
+	struct cma_heap *cma_heap;
+	struct dma_heap_export_info exp_info;
+
+	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
+	if (!cma_heap)
+		return -ENOMEM;
+	cma_heap->cma = cma;
+
+	exp_info.name = cma_get_name(cma);
+	exp_info.ops = &cma_heap_ops;
+	exp_info.priv = cma_heap;
+
+	cma_heap->heap = dma_heap_add(&exp_info);
+	if (IS_ERR(cma_heap->heap)) {
+		int ret = PTR_ERR(cma_heap->heap);
+
+		kfree(cma_heap);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int add_cma_heaps(void)
+{
+	cma_for_each_area(__add_cma_heap, NULL);
+	return 0;
+}
+device_initcall(add_cma_heaps);
-- 
2.17.1

