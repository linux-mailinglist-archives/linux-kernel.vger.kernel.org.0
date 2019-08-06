Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB598338D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbfHFOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 10:07:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46399 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfHFOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:07:03 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hv07A-00031G-2a; Tue, 06 Aug 2019 16:07:00 +0200
Message-ID: <1565100418.2323.32.camel@pengutronix.de>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christoph Hellwig <hch@lst.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Date:   Tue, 06 Aug 2019 16:06:58 +0200
In-Reply-To: <20190806140408.GA22902@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de>
         <20190806113318.GA20215@lst.de>
         <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
         <20190806140408.GA22902@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 06.08.2019, 16:04 +0200 schrieb Christoph Hellwig:
> Ok, does this work?
> 
> --
> From 34d35f335a98f515f2516b515051e12eae744c8d Mon Sep 17 00:00:00 2001
> > From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 6 Aug 2019 14:33:23 +0300
> Subject: dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
> 
> The new DMA_ATTR_NO_KERNEL_MAPPING needs to actually assign
> a dma_addr to work.  Also skip it if the architecture needs
> forced decryption handling, as that needs a kernel virtual
> address.
> 
> Fixes: d98849aff879 (dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code)
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 59bdceea3737..b01064d884f2 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -130,11 +130,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
> >  	if (!page)
> >  		return NULL;
>  
> > -	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
> > +	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> +	    !force_dma_unencrypted(dev)) {

dma_direct_free_pages() then needs the same check, as otherwise the cpu
address is treated as a cookie instead of a real address and the
encryption needs to be re-enabled.

Regards,
Lucas

>  		/* remove any dirty cache lines on the kernel alias */
> >  		if (!PageHighMem(page))
> >  			arch_dma_prep_coherent(page, size);
> >  		/* return the page pointer as the opaque cookie */
> > +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> >  		return page;
> >  	}
>  
