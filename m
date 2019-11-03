Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED4EED3D4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfKCQN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 11:13:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42123 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfKCQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:13:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id s23so6282331pgo.9
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wLcYNoHMVtsrBLAKrAMEQ1YgkjKW53QggHrjbrxlgZw=;
        b=ts1NVnxfIPhoc/mRGKzcK+c8J2EoYwHnfwTcyjkDHTkw9yQn3HwoZdFPNEdUHYNWMD
         XZiPX7lA81v7X/BZa90RLUfYmd4TPBOTJScbsSLngke0hszQgnxJFfkTyxt7gvvaxa7y
         3tlxNdOS4TVB6W4OFwoDb5sMdtQ3/3cP+czWpzqMYNyu0VWphrS4/Qz41BJO9JzVfhAp
         +26eOZG/NOEUiXJVrL1GsPQu5xdjwK0YLlBcdZDaNDzVedh5/7VPQWVih6ZI5dZc8GyU
         nPi9NR9/Jyqvah5OPpywP+SmB8cOswAr4z2wN1nAk0rAwbRjfbhHQy0gF209Uho1f9yV
         FLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLcYNoHMVtsrBLAKrAMEQ1YgkjKW53QggHrjbrxlgZw=;
        b=WpRP6hfCsEeKbZ9O7lZsY6knI1j2ptyB7D2z+cVtBWmiCDdSoH3I1OwpCgZGKaNQ59
         B8dEmOceQse18g8clqLLuL5pc7vrA2OiBKPMscl5TrzD2f2+OiaFNf2W7o2GL0z5d2XZ
         1/jtRcVJx4bmAN8jc/5DKlBTHqLuvySYtyKk+rzLhYrMzEKkShiUKeLMKDajtuyLOdnp
         Wd81vTZ1ARRfjxk9DuuUUWWdUCqaOuHSzaMVJwQLlBmMkP8DdIkWDI2tVUcSlXqE5VlM
         Ka1g3Y2ozE+ncbu4D0tIXidfPruB0x7sSVBsk0dUXCDqt6U2R36u7gD/P+ghjbAMjR0W
         b5GA==
X-Gm-Message-State: APjAAAWNCOsJ8mswLSahG1qIjz59LWRli4KF16V8Ewni5Uo2vZ8msLFf
        DJUXsCtUUustFX/Ebo/gTSI4LA==
X-Google-Smtp-Source: APXvYqyKuScJCQRJxBrVw2cJ+Jgg9SRAzxcAVUqeuzUwdEcAhH9TlLQvdDrg7PN0q+OSlIWxfhRvEQ==
X-Received: by 2002:a65:654e:: with SMTP id a14mr1945635pgw.170.1572797634813;
        Sun, 03 Nov 2019 08:13:54 -0800 (PST)
Received: from sspatil-glaptop2.roam.corp.google.com ([66.167.121.235])
        by smtp.gmail.com with ESMTPSA id l62sm526181pgl.24.2019.11.03.08.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 08:13:53 -0800 (PST)
Date:   Sun, 3 Nov 2019 08:13:48 -0800
From:   sspatil@google.com
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        labbott@redhat.com, benjamin.gaignard@linaro.org,
        sumit.semwal@linaro.org, lmark@codeaurora.org,
        pratikp@codeaurora.org, Brian.Starkey@arm.com,
        Vincent.Donnefort@arm.com, Sudipto.Paul@arm.com, afd@ti.com,
        hch@infradead.org, fengc@google.com, astrachan@google.com,
        hridya@google.com, hdanton@sina.com, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, sspatil+mutt@google.com
Cc:     lkml <linux-kernel@vger.kernel.org>,
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
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 2/5] dma-buf: heaps: Add heap helpers
Message-ID: <20191103161348.GB13344@google.com>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101214238.78015-3-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:42:35PM +0000, John Stultz wrote:
> Add generic helper dmabuf ops for dma heaps, so we can reduce
> the amount of duplicative code for the exported dmabufs.
> 
> This code is an evolution of the Android ION implementation, so
> thanks to its original authors and maintainters:
>   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Acked-by: Laura Abbott <labbott@redhat.com>
> Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

I have one question and a naming suggestin below (sorry).

Acked-by: Sandeep Patil <sspatil@android.com>

> ---
> v2:
> * Removed cache management performance hack that I had
>   accidentally folded in.
> * Removed stats code that was in helpers
> * Lots of checkpatch cleanups
> v3:
> * Uninline INIT_HEAP_HELPER_BUFFER (suggested by Christoph)
> * Switch to WARN on buffer destroy failure (suggested by Brian)
> * buffer->kmap_cnt decrementing cleanup (suggested by Christoph)
> * Extra buffer->vaddr checking in dma_heap_dma_buf_kmap
>   (suggested by Brian)
> * Switch to_helper_buffer from macro to inline function
>   (suggested by Benjamin)
> * Rename kmap->vmap (folded in from Andrew)
> * Use vmap for vmapping - not begin_cpu_access (folded in from
>   Andrew)
> * Drop kmap for now, as its optional (folded in from Andrew)
> * Fold dma_heap_map_user into the single caller (foled in from
>   Andrew)
> * Folded in patch from Andrew to track page list per heap not
>   sglist, which simplifies the tracking logic
> v4:
> * Moved dma-heap.h change out to previous patch
> v6:
> * Minor cleanups and typo fixes suggested by Brian
> v7:
> * Removed stray ;
> * Make init_heap_helper_buffer lowercase, as suggested by Christoph
> * Add dmabuf export helper to reduce boilerplate code
> v8:
> * Remove unused private_flags value
> * Condense dma_heap_buffer and heap_helper_buffer (suggested by
>   Christoph)
> * Fix indentation by using shorter argument names (suggested by
>   Christoph)
> * Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
>   (suggested by Christoph)
> * Checkpatch whitespace fixups
> v9:
> * Minor cleanups suggested by Brian Starkey
> v10:
> * Fix missing vmalloc.h inclusion in heap helpers (found by
>   kbuild test robot <lkp@intel.com>)
> v12:
> * Add symbol exports for heaps as modules
> v13:
> * Re-remove symbol exports, per discussion with Brian, as I'll
>   resubmit the change for review independently.
> v14:
> * Fix missing argment to WARN() in dma_heap_buffer_destroy()
>   found and fixed by Dan Carpenter <dan.carpenter@oracle.com>
> * Add check in fault hanlder that pgoff isn't larger then
>   pagecount, reported by Dan Carpenter
> 
> ---
>  drivers/dma-buf/Makefile             |   1 +
>  drivers/dma-buf/heaps/Makefile       |   2 +
>  drivers/dma-buf/heaps/heap-helpers.c | 271 +++++++++++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h |  55 ++++++
>  4 files changed, 329 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
> 
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index caee5eb3d351..9c190026bfab 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -2,6 +2,7 @@
>  obj-y := dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
>  	 dma-resv.o seqno-fence.o
>  obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
> +obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
>  obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
>  obj-$(CONFIG_UDMABUF)		+= udmabuf.o
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
> new file mode 100644
> index 000000000000..de49898112db
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y					+= heap-helpers.o
> diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
> new file mode 100644
> index 000000000000..9f964ca3f59c
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/err.h>
> +#include <linux/highmem.h>
> +#include <linux/idr.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
> +#include <uapi/linux/dma-heap.h>
> +
> +#include "heap-helpers.h"
> +
> +void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
> +			     void (*free)(struct heap_helper_buffer *))
> +{
> +	buffer->priv_virt = NULL;
> +	mutex_init(&buffer->lock);
> +	buffer->vmap_cnt = 0;
> +	buffer->vaddr = NULL;
> +	buffer->pagecount = 0;
> +	buffer->pages = NULL;
> +	INIT_LIST_HEAD(&buffer->attachments);
> +	buffer->free = free;
> +}
> +
> +struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
> +					  int fd_flags)
> +{
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +
> +	exp_info.ops = &heap_helper_ops;
> +	exp_info.size = buffer->size;
> +	exp_info.flags = fd_flags;
> +	exp_info.priv = buffer;
> +
> +	return dma_buf_export(&exp_info);
> +}
> +
> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> +{
> +	void *vaddr;
> +
> +	vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}
> +
> +static void dma_heap_buffer_destroy(struct heap_helper_buffer *buffer)
> +{
> +	if (buffer->vmap_cnt > 0) {
> +		WARN(1, "%s: buffer still mapped in the kernel\n", __func__);
> +		vunmap(buffer->vaddr);
> +	}
> +
> +	buffer->free(buffer);
> +}
> +
> +static void *dma_heap_buffer_vmap_get(struct heap_helper_buffer *buffer)
> +{
> +	void *vaddr;
> +
> +	if (buffer->vmap_cnt) {
> +		buffer->vmap_cnt++;
> +		return buffer->vaddr;
> +	}
> +	vaddr = dma_heap_map_kernel(buffer);
> +	if (IS_ERR(vaddr))
> +		return vaddr;
> +	buffer->vaddr = vaddr;
> +	buffer->vmap_cnt++;
> +	return vaddr;
> +}
> +
> +static void dma_heap_buffer_vmap_put(struct heap_helper_buffer *buffer)
> +{
> +	if (!--buffer->vmap_cnt) {

nit: just checking here cause I don't know the order in which vmap_get() and
vmap_put() is expected to be called from dmabuf, the manual refcounting
based map/unmap is ok?

I know ion had this for a while and it worked fine over the years, but I
don't know if anybody saw any issues with it.
> +		vunmap(buffer->vaddr);
> +		buffer->vaddr = NULL;
> +	}
> +}
> +
> +struct dma_heaps_attachment {
> +	struct device *dev;
> +	struct sg_table table;
> +	struct list_head list;
> +};
> +
> +static int dma_heap_attach(struct dma_buf *dmabuf,
> +			   struct dma_buf_attachment *attachment)
> +{
> +	struct dma_heaps_attachment *a;
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +	int ret;
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
> +					buffer->pagecount, 0,
> +					buffer->pagecount << PAGE_SHIFT,
> +					GFP_KERNEL);
> +	if (ret) {
> +		kfree(a);
> +		return ret;
> +	}
> +
> +	a->dev = attachment->dev;
> +	INIT_LIST_HEAD(&a->list);
> +
> +	attachment->priv = a;
> +
> +	mutex_lock(&buffer->lock);
> +	list_add(&a->list, &buffer->attachments);
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +static void dma_heap_detach(struct dma_buf *dmabuf,
> +			    struct dma_buf_attachment *attachment)
> +{
> +	struct dma_heaps_attachment *a = attachment->priv;
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +
> +	mutex_lock(&buffer->lock);
> +	list_del(&a->list);
> +	mutex_unlock(&buffer->lock);
> +
> +	sg_free_table(&a->table);
> +	kfree(a);
> +}
> +
> +static
> +struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
> +				      enum dma_data_direction direction)
> +{
> +	struct dma_heaps_attachment *a = attachment->priv;
> +	struct sg_table *table;
> +
> +	table = &a->table;
> +
> +	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> +			direction))
> +		table = ERR_PTR(-ENOMEM);
> +	return table;
> +}
> +
> +static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +				   struct sg_table *table,
> +				   enum dma_data_direction direction)
> +{
> +	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +}
> +
> +static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct heap_helper_buffer *buffer = vma->vm_private_data;
> +
> +	if (vmf->pgoff > buffer->pagecount)
> +		return VM_FAULT_SIGBUS;
> +
> +	vmf->page = buffer->pages[vmf->pgoff];
> +	get_page(vmf->page);
> +
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct dma_heap_vm_ops = {
> +	.fault = dma_heap_vm_fault,
> +};
> +
> +static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +
> +	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> +		return -EINVAL;
> +
> +	vma->vm_ops = &dma_heap_vm_ops;
> +	vma->vm_private_data = buffer;
> +
> +	return 0;
> +}
> +
> +static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +
> +	dma_heap_buffer_destroy(buffer);
> +}
> +
> +static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> +					     enum dma_data_direction direction)
> +{
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +	struct dma_heaps_attachment *a;
> +	int ret = 0;
> +
> +	mutex_lock(&buffer->lock);
> +
> +	if (buffer->vmap_cnt)
> +		invalidate_kernel_vmap_range(buffer->vaddr, buffer->size);
> +
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_cpu(a->dev, a->table.sgl, a->table.nents,
> +				    direction);
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return ret;
> +}
> +
> +static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
> +					   enum dma_data_direction direction)
> +{
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +	struct dma_heaps_attachment *a;
> +
> +	mutex_lock(&buffer->lock);
> +
> +	if (buffer->vmap_cnt)
> +		flush_kernel_vmap_range(buffer->vaddr, buffer->size);
> +
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_device(a->dev, a->table.sgl, a->table.nents,
> +				       direction);
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +static void *dma_heap_dma_buf_vmap(struct dma_buf *dmabuf)
> +{
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +	void *vaddr;
> +
> +	mutex_lock(&buffer->lock);
> +	vaddr = dma_heap_buffer_vmap_get(buffer);
> +	mutex_unlock(&buffer->lock);
> +
> +	return vaddr;
> +}
> +
> +static void dma_heap_dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)
> +{
> +	struct heap_helper_buffer *buffer = dmabuf->priv;
> +
> +	mutex_lock(&buffer->lock);
> +	dma_heap_buffer_vmap_put(buffer);
> +	mutex_unlock(&buffer->lock);
> +}
> +
> +const struct dma_buf_ops heap_helper_ops = {
> +	.map_dma_buf = dma_heap_map_dma_buf,
> +	.unmap_dma_buf = dma_heap_unmap_dma_buf,
> +	.mmap = dma_heap_mmap,
> +	.release = dma_heap_dma_buf_release,
> +	.attach = dma_heap_attach,
> +	.detach = dma_heap_detach,
> +	.begin_cpu_access = dma_heap_dma_buf_begin_cpu_access,
> +	.end_cpu_access = dma_heap_dma_buf_end_cpu_access,
> +	.vmap = dma_heap_dma_buf_vmap,
> +	.vunmap = dma_heap_dma_buf_vunmap,
> +};
> diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps/heap-helpers.h
> new file mode 100644
> index 000000000000..911c931f7f06
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMABUF Heaps helper code
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#ifndef _HEAP_HELPERS_H
> +#define _HEAP_HELPERS_H
> +
> +#include <linux/dma-heap.h>
> +#include <linux/list.h>
> +
> +/**
> + * struct heap_helper_buffer - helper buffer metadata
> + * @heap:		back pointer to the heap the buffer came from
> + * @dmabuf:		backing dma-buf for this buffer
> + * @size:		size of the buffer
> + * @flags:		buffer specific flags
nit: Are thee dmabuf flags, or dmabuf_heap specific / allocation related flags?
> + * @priv_virt		pointer to heap specific private value
nit: text looks misaligned (or is it my editor?)
> + * @lock		mutext to protect the data in this structure
> + * @vmap_cnt		count of vmap references on the buffer
> + * @vaddr		vmap'ed virtual address
> + * @pagecount		number of pages in the buffer
> + * @pages		list of page pointers
> + * @attachments		list of device attachments
ditto
> + *
> + * @free		heap callback to free the buffer
> + */
> +struct heap_helper_buffer {
/bikeshed/
s/heap_helper_buffer/dma_heap_buffer ?

The "heap helper buffer" doesn't really convey what it is.
> +	struct dma_heap *heap;
> +	struct dma_buf *dmabuf;
> +	size_t size;
> +	unsigned long flags;
> +
> +	void *priv_virt;
> +	struct mutex lock;
> +	int vmap_cnt;
> +	void *vaddr;
> +	pgoff_t pagecount;
> +	struct page **pages;
> +	struct list_head attachments;
> +
> +	void (*free)(struct heap_helper_buffer *buffer);
> +};
> +
> +void init_heap_helper_buffer(struct heap_helper_buffer *buffer,
> +			     void (*free)(struct heap_helper_buffer *));
> +
> +struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buffer,
> +					  int fd_flags);
> +
> +extern const struct dma_buf_ops heap_helper_ops;
> +#endif /* _HEAP_HELPERS_H */
> -- 
> 2.17.1
> 
