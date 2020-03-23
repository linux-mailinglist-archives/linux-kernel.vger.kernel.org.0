Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7B18F0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 09:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCWIhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 04:37:09 -0400
Received: from verein.lst.de ([213.95.11.211]:57574 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgCWIhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:37:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 984DB68BEB; Mon, 23 Mar 2020 09:37:05 +0100 (CET)
Date:   Mon, 23 Mar 2020 09:37:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200323083705.GA31245@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:28:34PM +1100, Alexey Kardashevskiy wrote:

[full quote deleted, please follow proper quoting rules]

> > +static bool dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
> > +{
> > +	if (!ops)
> > +		return true;
> > +
> > +	/*
> > +	 * Allows IOMMU drivers to bypass dynamic translations if the DMA mask
> > +	 * is large enough.
> > +	 */
> > +	if (dev->dma_ops_bypass) {
> > +		if (min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit) >=
> > +				dma_direct_get_required_mask(dev))
> > +			return true;
> > +	}
> 
> 
> Why not do this in dma_map_direct() as well?

Mostly beacuse it is a relatively expensive operation, including a
fls64.

> Or simply have just one dma_map_direct()?

What do you mean with that?

> And one more general question - we need a way to use non-direct IOMMU
> for RAM above certain limit.
> 
> Let's say we have a system with:
> 0 .. 0x1.0000.0000
> 0x100.0000.0000 .. 0x101.0000.0000
> 
> 2x4G, each is 1TB aligned. And we can map directly only the first 4GB
> (because of the maximum IOMMU table size) but not the other. And 1:1 on
> that "pseries" is done with offset=0x0800.0000.0000.0000.
> 
> So we want to check every bus address against dev->bus_dma_limit, not
> dev->coherent_dma_mask. In the example above I'd set bus_dma_limit to
> 0x0800.0001.0000.0000 and 1:1 mapping for the second 4GB would not be
> tried. Does this sound reasonable? Thanks,

bus_dma_limit is just another limiting factor applied on top of
coherent_dma_mask or dma_mask respectively.
