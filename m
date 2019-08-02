Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD177F534
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfHBKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 06:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHBKiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:38:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13942086A;
        Fri,  2 Aug 2019 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564742288;
        bh=IYNwTW73rLYyMyjD9BJMjODjl0NeiQXEjNWG7ynwQFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVCPNdH/6+F3JEUwjc5ECdeVvv2rxFW/YIsSdLtdhUSAecBHvE/aZD9g4yMo2gZSj
         2yoBLIUP0QYtsd9bkMqXcwYzxDAGO2T7/GL9cxrLT0Ys0KRqsv6Oult274XWCLaght
         wblNSh7hCme4l3pG2uJghbpPO6jnYgJmHgYdUE7s=
Date:   Fri, 2 Aug 2019 11:38:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190802103803.3qrbhqwxlasojsco@willie-the-truck>
References: <20190801142118.21225-1-hch@lst.de>
 <20190801142118.21225-2-hch@lst.de>
 <20190801162305.3m32chycsdjmdejk@willie-the-truck>
 <20190801163457.GB26588@lst.de>
 <20190801164411.kmsl4japtfkgvzxe@willie-the-truck>
 <20190802081441.GA9725@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802081441.GA9725@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:14:41AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 01, 2019 at 05:44:12PM +0100, Will Deacon wrote:
> > > > Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
> > > > gets involved in the non-coherent case.
> > > 
> > > A better name is welcome.
> > 
> > How about arch_dma_noncoherent_mmap_pgprot() ? Too long?
> 
> Sounds a little long yes.  And doesn't fix the additional problem that
> we don't just it for mmap but also for the in-kernel remapping these
> days.

Hmm. Maybe just arch_dma_noncoherent_pgprot() then.

> > > But my worry is how this interacts with architectures that have an
> > > uncached segment (mips, nios2, microblaze, extensa) where we'd have
> > > the kernel access DMA_ATTR_WRITE_COMBINE mappigns using the uncached
> > > segment, and userspace mmaps using pgprot_writecombine, which could
> > > lead to aliasing issues.  But then again mips already supports
> > > DMA_ATTR_WRITE_COMBINE, so this must be ok somehow.  I guess I'll
> > > need to field that question to the relevant parties.
> > 
> > Or it's always been busted and happens to work out in practice...
> 
> I've sent a ping to the mips folks.  While we'are at it:  arm64
> and arm32 (optionally) map dma coherent allocations as write combine.
> I suspect this hasn't always just been busted but intentional (of course!),
> but is there any chance to get a quote from the arm architecture spec
> on why this is fine as it looks rather confusion?

So this boils down to a terminology mismatch. The Arm architecture doesn't have
anything called "write combine", so in Linux we instead provide what the Arm
architecture calls "Normal non-cacheable" memory for pgprot_writecombine().
Amongst other things, this memory type permits speculation, unaligned accesses
and merging of writes. I found something in the architecture spec about
non-cachable memory, but it's written in Armglish[1].

pgprot_noncached(), on the other hand, provides what the architecture calls
Strongly Ordered or Device-nGnRnE memory. This is intended for mapping MMIO
(i.e. PCI config space) and therefore forbids speculation, preserves access
size, requires strict alignment and also forces write responses to come from
the endpoint.

I think the naming mismatch is historical, but on arm64 we wanted to use the
same names as arm32 so that any drivers using these things directly would get
the same behaviour.

Will

[1]

B2.4.4 Implication of caches for the application programmer

[...]

Data coherency issues

Software can ensure the data coherency of caches in the following ways:

  * By not using the caches in situations where coherency issues can arise.
    This can be achieved by:

    - Using Non-cacheable or, in some cases, Write-Through Cacheable memory.

    - Not enabling caches in the system.

  * By using cache maintenance instructions to manage the coherency issues
    in software.

  * By using hardware coherency mechanisms to ensure the coherency of data
    accesses to memory for cacheable locations by observers within the
    different shareability domains.
