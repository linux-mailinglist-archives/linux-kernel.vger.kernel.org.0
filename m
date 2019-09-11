Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F66AFEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfIKOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 10:35:35 -0400
Received: from foss.arm.com ([217.140.110.172]:48602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfIKOfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:35:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0980D1000;
        Wed, 11 Sep 2019 07:35:34 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC9C3F67D;
        Wed, 11 Sep 2019 07:35:30 -0700 (PDT)
Date:   Wed, 11 Sep 2019 15:35:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>, f.fainelli@gmail.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
        phill@raspberrypi.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v5 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
Message-ID: <20190911143527.GB43864@C02TF0J2HF1T.local>
References: <20190909095807.18709-1-nsaenzjulienne@suse.de>
 <20190909095807.18709-4-nsaenzjulienne@suse.de>
 <b0b824bebb9ef13ce746f9914de83126b0386e23.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b824bebb9ef13ce746f9914de83126b0386e23.camel@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:54:38PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2019-09-09 at 11:58 +0200, Nicolas Saenz Julienne wrote:
> >  /*
> > - * Return the maximum physical address for ZONE_DMA32 (DMA_BIT_MASK(32)). It
> > - * currently assumes that for memory starting above 4G, 32-bit devices will
> > - * use a DMA offset.
> > + * Return the maximum physical address for a zone with a given address size
> > + * limit. It currently assumes that for memory starting above 4G, 32-bit
> > + * devices will use a DMA offset.
> >   */
> > -static phys_addr_t __init max_zone_dma32_phys(void)
> > +static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
> >  {
> >         phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
> > -       return min(offset + (1ULL << 32), memblock_end_of_DRAM());
> > +       return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
> >  }
> 
> while testing other code on top of this series on odd arm64 machines I found an
> issue: when memblock_start_of_DRAM() != 0, max_zone_phys() isn't taking into
> account the offset to the beginning of memory. This doesn't matter with
> zone_bits == 32 but it does when zone_bits == 30.

I thought about this but I confused myself and the only case I had in
mind was an AMD Seattle system with RAM starting at 4GB.

What we need from this function is that the lowest naturally aligned
2^30 RAM is covered by ZONE_DMA while the rest to 2^32 are ZONE_DMA32.
This assumed that devices only capable of 30-bit (or 32-bit), have the
top address bits hardwired to be able access the bottom of the memory
(and this would be expressed in DT as the DMA offset).

I guess the fix here is to use GENMASK_ULL(63, zone_bits).

-- 
Catalin
