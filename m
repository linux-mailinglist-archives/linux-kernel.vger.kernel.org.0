Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09488830BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfHFLdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 07:33:22 -0400
Received: from verein.lst.de ([213.95.11.211]:55706 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfHFLdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:33:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6461227A81; Tue,  6 Aug 2019 13:33:18 +0200 (CEST)
Date:   Tue, 6 Aug 2019 13:33:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190806113318.GA20215@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565082809.2323.24.camel@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:13:29AM +0200, Lucas Stach wrote:
> Hi Christoph,
> 
> I just found a regression where my NVMe device is no longer able to set
> up its HMB.
> 
> After subject commit dma_direct_alloc_pages() is no longer initializing
> dma_handle properly when DMA_ATTR_NO_KERNEL_MAPPING is set, as the
> function is now returning too early.
> 
> Now this could easily be fixed by adding the phy_to_dma translation to
> the NO_KERNEL_MAPPING code path, but I'm not sure how this stuff
> interacts with the memory encryption stuff set up later in the
> function, so I guess this should be looked at by someone with more
> experience with this code than me.

There is not much we can do about the memory encryption case here,
as that requires a kernel address to mark the memory as unencrypted.

So the obvious trivial fix is probably the right one:


diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 59bdceea3737..c49120193309 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -135,6 +135,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		if (!PageHighMem(page))
 			arch_dma_prep_coherent(page, size);
 		/* return the page pointer as the opaque cookie */
+		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 		return page;
 	}
 
