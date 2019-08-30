Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3BA381C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfH3Nxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 09:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfH3Nxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:53:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F25521721;
        Fri, 30 Aug 2019 13:53:51 +0000 (UTC)
Date:   Fri, 30 Aug 2019 09:53:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v8 6/7] iommu/vt-d: Add trace events for device dma
 map/unmap
Message-ID: <20190830095349.1c222240@gandalf.local.home>
In-Reply-To: <20190830071718.16613-7-baolu.lu@linux.intel.com>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
        <20190830071718.16613-7-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 15:17:17 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> This adds trace support for the Intel IOMMU driver. It
> also declares some events which could be used to trace
> the events when an IOVA is being mapped or unmapped in
> a domain.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  drivers/iommu/Makefile             |  1 +
>  drivers/iommu/intel-trace.c        | 14 +++++
>  include/trace/events/intel_iommu.h | 84 ++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 drivers/iommu/intel-trace.c
>  create mode 100644 include/trace/events/intel_iommu.h
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index f13f36ae1af6..bfe27b2755bd 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>  obj-$(CONFIG_DMAR_TABLE) += dmar.o
>  obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
> +obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
>  obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
>  obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
>  obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
> diff --git a/drivers/iommu/intel-trace.c b/drivers/iommu/intel-trace.c
> new file mode 100644
> index 000000000000..bfb6a6e37a88
> --- /dev/null
> +++ b/drivers/iommu/intel-trace.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel IOMMU trace support
> + *
> + * Copyright (C) 2019 Intel Corporation
> + *
> + * Author: Lu Baolu <baolu.lu@linux.intel.com>
> + */
> +
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/intel_iommu.h>
> diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
> new file mode 100644
> index 000000000000..9c28e6cae86f
> --- /dev/null
> +++ b/include/trace/events/intel_iommu.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Intel IOMMU trace support
> + *
> + * Copyright (C) 2019 Intel Corporation
> + *
> + * Author: Lu Baolu <baolu.lu@linux.intel.com>
> + */
> +#ifdef CONFIG_INTEL_IOMMU
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM intel_iommu
> +
> +#if !defined(_TRACE_INTEL_IOMMU_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_INTEL_IOMMU_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/intel-iommu.h>
> +
> +DECLARE_EVENT_CLASS(dma_map,
> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
> +		 size_t size),
> +
> +	TP_ARGS(dev, dev_addr, phys_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(dma_addr_t, dev_addr)
> +		__field(phys_addr_t, phys_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->dev_addr = dev_addr;
> +		__entry->phys_addr = phys_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s dev_addr=0x%llx phys_addr=0x%llx size=%zu",
> +		  __get_str(dev_name),
> +		  (unsigned long long)__entry->dev_addr,
> +		  (unsigned long long)__entry->phys_addr,
> +		  __entry->size)
> +);
> +
> +DEFINE_EVENT(dma_map, bounce_map_single,
> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
> +		 size_t size),
> +	TP_ARGS(dev, dev_addr, phys_addr, size)
> +);

Do you plan on adding more events to these classes? This patch has two
distinct DECLARE_EVENT_CLASS() calls, and each has one DEFINE_EVENT()
for them.

It's fine to do this, but I'm curious to why you did not use
the "TRACE_EVENT()" macro, which basically is just a single
DECLARE_EVENT_CLASS() followed by a single DEFINE_EVENT(). In other
words, you just open coded TRACE_EVENT().

-- Steve

> +
> +DECLARE_EVENT_CLASS(dma_unmap,
> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
> +
> +	TP_ARGS(dev, dev_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(dma_addr_t, dev_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->dev_addr = dev_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
> +		  __get_str(dev_name),
> +		  (unsigned long long)__entry->dev_addr,
> +		  __entry->size)
> +);
> +
> +DEFINE_EVENT(dma_unmap, bounce_unmap_single,
> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
> +	TP_ARGS(dev, dev_addr, size)
> +);
> +
> +#endif /* _TRACE_INTEL_IOMMU_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> +#endif /* CONFIG_INTEL_IOMMU */

