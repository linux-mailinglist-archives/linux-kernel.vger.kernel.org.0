Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB5D654A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 12:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfGKKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 06:44:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45791 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727865AbfGKKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:44:28 -0400
X-UUID: f1369d86e92741d4a99963416bfb7caf-20190711
X-UUID: f1369d86e92741d4a99963416bfb7caf-20190711
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 366328366; Thu, 11 Jul 2019 18:44:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Jul 2019 18:44:21 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Jul 2019 18:44:21 +0800
Message-ID: <1562841861.9534.2.camel@mtkswgap22>
Subject: Re: [PATCH] kernel/dma: export dma_alloc_from_contiguous to modules
From:   Miles Chen <miles.chen@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>
Date:   Thu, 11 Jul 2019 18:44:21 +0800
In-Reply-To: <7d14b94f-454f-d512-bc8f-589f71bc07ea@arm.com>
References: <20190711053343.28873-1-miles.chen@mediatek.com>
         <7d14b94f-454f-d512-bc8f-589f71bc07ea@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 09:50 +0100, Robin Murphy wrote:
> On 11/07/2019 06:33, miles.chen@mediatek.com wrote:
> > From: Miles Chen <miles.chen@mediatek.com>
> > 
> > This change exports dma_alloc_from_contiguous and
> > dma_release_from_contiguous to modules.
> > 
> > Currently, we can add a reserve a memory node in dts files, make
> > it a CMA memory by setting compatible = "shared-dma-pool",
> > and setup the dev->cma_area by using of_reserved_mem_device_init_by_idx().
> > 
> > Export dma_alloc_from_contiguous and dma_release_from_contiguous, so we
> > can allocate/free from/to dev->cma_area in kernel modules.
> 
> As far as I understand, this was never intended for drivers to call 
> directly. If a device has its own private CMA area, then regular 
> dma_alloc_attrs() should allocate from that automatically; if that's not 
> happening already, then there's a bug somewhere.
> 
> Robin.

Thanks for your comment. 
After using dma_direct_ops, dma_alloc_attrs() works fine now.

Miles

> 
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >   kernel/dma/contiguous.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index b2a87905846d..d5920bdedc77 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -197,6 +197,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
> >   
> >   	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
> >   }
> > +EXPORT_SYMBOL_GPL(dma_alloc_from_contiguous);
> >   
> >   /**
> >    * dma_release_from_contiguous() - release allocated pages
> > @@ -213,6 +214,7 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
> >   {
> >   	return cma_release(dev_get_cma_area(dev), pages, count);
> >   }
> > +EXPORT_SYMBOL_GPL(dma_release_from_contiguous);
> >   
> >   /*
> >    * Support for reserved memory regions defined in device tree
> > 


