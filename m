Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70277E048
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfHAQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 12:35:03 -0400
Received: from verein.lst.de ([213.95.11.211]:44897 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:35:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7B8E68B20; Thu,  1 Aug 2019 18:34:57 +0200 (CEST)
Date:   Thu, 1 Aug 2019 18:34:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190801163457.GB26588@lst.de>
References: <20190801142118.21225-1-hch@lst.de> <20190801142118.21225-2-hch@lst.de> <20190801162305.3m32chycsdjmdejk@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801162305.3m32chycsdjmdejk@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 05:23:06PM +0100, Will Deacon wrote:
> > -	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> > -		return pgprot_writecombine(prot);
> > -	return prot;
> > +	return pgprot_writecombine(prot);
> >  }
> 
> Seems like a sensible cleanup to me:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
> gets involved in the non-coherent case.

A better name is welcome.  My other idea would be to just remove it
entirely and do something like:

#ifndef pgprot_dmacoherent
#define pgprot_dmacoherent pgprot_noncached
#endif

pgprot_t dma_mmap_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
{
	if (dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_NON_CONSISTENT))
		return prot;
#ifdef pgprot_writecombine
	if (attrs & DMA_ATTR_WRITE_COMBINE)
		return pgprot_writecombine(prot);
#endif
	return pgprot_dmacoherent(prot);
}

But my worry is how this interacts with architectures that have an
uncached segment (mips, nios2, microblaze, extensa) where we'd have
the kernel access DMA_ATTR_WRITE_COMBINE mappigns using the uncached
segment, and userspace mmaps using pgprot_writecombine, which could
lead to aliasing issues.  But then again mips already supports
DMA_ATTR_WRITE_COMBINE, so this must be ok somehow.  I guess I'll
need to field that question to the relevant parties.
