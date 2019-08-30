Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71DA39B4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfH3O7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 10:59:41 -0400
Received: from verein.lst.de ([213.95.11.211]:56266 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfH3O7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:59:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8244E68BFE; Fri, 30 Aug 2019 16:59:35 +0200 (CEST)
Date:   Fri, 30 Aug 2019 16:59:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] vmalloc: lift the arm flag for coherent mappings
 to common code
Message-ID: <20190830145935.GA19838@lst.de>
References: <20190830062924.21714-1-hch@lst.de> <20190830062924.21714-2-hch@lst.de> <20190830092918.GV13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830092918.GV13294@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:29:18AM +0100, Russell King - ARM Linux admin wrote:
> On Fri, Aug 30, 2019 at 08:29:21AM +0200, Christoph Hellwig wrote:
> > The arm architecture had a VM_ARM_DMA_CONSISTENT flag to mark DMA
> > coherent remapping for a while.  Lift this flag to common code so
> > that we can use it generically.  We also check it in the only place
> > VM_USERMAP is directly check so that we can entirely replace that
> > flag as well (although I'm not even sure why we'd want to allow
> > remapping DMA appings, but I'd rather not change behavior).
> 
> Good, because if you did change that behaviour, you'd break almost
> every ARM framebuffer and cripple ARM audio drivers.

How would that break them?  All the usual video and audio drivers that
use dma_alloc_* then use dma_mmap_* which never end up in the only place
that actually checks VM_USERMAP (remap_vmalloc_range_partial) as they
end up in the dma_map_ops mmap methods which contain what is effecitvely
open coded versions of that routine.  There are very few callers of
remap_vmalloc_range_partial / remap_vmalloc_range, and while a few of
those actually are in media drivers and the virtual frame buffer video
driver, none of these seems to be called on dma memory (which would
be a layering violation anyway).
