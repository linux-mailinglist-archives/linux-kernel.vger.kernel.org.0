Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF66A84C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfGPMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 08:10:29 -0400
Received: from verein.lst.de ([213.95.11.211]:41209 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPMK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:10:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A83F227A81; Tue, 16 Jul 2019 14:10:26 +0200 (CEST)
Date:   Tue, 16 Jul 2019 14:10:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        pankaj.suryawanshi@einfochips.com, minchan@kernel.org,
        minchan.kim@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: cma_remap when using dma_alloc_attr :-
 DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20190716121026.GB2388@lst.de>
References: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com> <57f8aa35-d460-9933-a547-fbf578ea42d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f8aa35-d460-9933-a547-fbf578ea42d3@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 01:02:19PM +0100, Robin Murphy wrote:
>> Lets say 4k video allocation required 300MB cma memory but not required
>> virtual mapping for all the 300MB, its require only 20MB virtually mapped
>> at some specific use case/point of video, and unmap virtual mapping after
>> uses, at that time this functions will be useful, it works like ioremap()
>> for cma_alloc() using dma apis.
>
> Hmm, is there any significant reason that this case couldn't be handled 
> with just get_vm_area() plus dma_mmap_attrs(). I know it's only *intended* 
> for userspace mappings, but since the basic machinery is there...

Because the dma helper really are a black box abstraction.

That being said DMA_ATTR_NO_KERNEL_MAPPING and DMA_ATTR_NON_CONSISTENT
have been a constant pain in the b**t.  I've been toying with replacing
them with a dma_alloc_pages or similar abstraction that just returns
a struct page that is guaranteed to be dma addressable by the passed
in device.  Then the driver can call dma_map_page / dma_unmap_page /
dma_sync_* on it at well.  This would replace DMA_ATTR_NON_CONSISTENT
with a sensible API, and also DMA_ATTR_NO_KERNEL_MAPPING when called
with PageHighmem, while providing an easy to understand API and
something that can easily be fed into the various page based APIs
in the kernel.

That being said until we get arm moved over the common dma direct
and dma-iommu code, and x86 fully moved over to dma-iommu it just
seems way too much work to even get it into the various architectures
that matter, never mind all the fringe IOMMUs.  So for now I've just
been trying to contain the DMA_ATTR_NON_CONSISTENT and
DMA_ATTR_NO_KERNEL_MAPPING in fewer places while also killing bogus
or pointless users of these APIs.
