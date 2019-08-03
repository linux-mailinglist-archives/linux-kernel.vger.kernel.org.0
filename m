Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B68049C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 08:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHCGTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 02:19:20 -0400
Received: from verein.lst.de ([213.95.11.211]:58559 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfHCGTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:19:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8283268BFE; Sat,  3 Aug 2019 08:19:16 +0200 (CEST)
Date:   Sat, 3 Aug 2019 08:19:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: please revert "drm/msm: Use the correct dma_sync calls in
 msm_gem"
Message-ID: <20190803061916.GA29348@lst.de>
References: <20190802213756.GA20033@lst.de> <CAJs_Fx45VtKe52eTuAUcqSUTrY=892OwhCZNrLGoQHHBwETCdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs_Fx45VtKe52eTuAUcqSUTrY=892OwhCZNrLGoQHHBwETCdQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:06:10PM -0700, Rob Clark wrote:
> Sorry, this is just a temporary band-aid for v5.3 to get things
> working again.  Yes, I realize it is a complete hack.

My main problem is here that you badly hack a around a problem without
talking to the relevant maintainers, and by abusing even more internal
APIs.  As said get_dma_ops isn't really for driver use (although we
have a few that use it for not quite as bad reason we are trying to get
rid off).  And as also said your abuse of the DMA API will blow up
with dma-debug use quite badly.  You might also corrupt the dma_address
in the scatterlist in ways that aren't intended - as the call to
dma_map_sg will allocate new iova space you are getting different
results from whatever you expect to actually get from your iommu API
usage.  This might or might no matter in the end, but you really should
consult the maintainers first.

> The root problem is that I'm using the DMA API in the first place.  I
> don't actually use the DMA API to map buffers, for various reasons,
> but instead manage the iommu_domain directly.

Yes, and this has been going on for years, without any obvious attempt
to address it at the API level before..

> Because arm/arm64 cache ops are not exported to modules, so currently
> I need to abuse the DMA API for cache operations (really just to clean
> pages if I need to mmap them uncached/writecombine).  Originally I was
> doing that w/ dma_{map,unmap}_sg.  But to avoid debug splats I
> switched that to dma_sync_sg (see
> 0036bc73ccbe7e600a3468bf8e8879b122252274).  But now it seems the
> dma-direct ops are unhappy w/ dma_sync without a dma_map (AFAICT).

Russell has been very strict about not exporting the cache ops, and all
for the right reasons.  Cache maintainance for not dma coherent devices
is hard, and without a proper API that has arch input for even which
calls are used for cache flushing chances of bugs are extremely high.

I see two proper ways out of this mess:  either we actually make msm
use the DMA API, so I'd be curious of what is missing that forces you
to use the low-level iommu API.  Or we need to enhance the iommu API
with a similar ownership concepts as the DMA API.  Which probably is
a good thing even if we move msm over to the DMA API.

> (On some generations of hw, the iommu is attached to the device node
> that maps to the drm device, which is passed to dma_map/dma_sync.  On
> other generations the iommu is attached to a sub-device.  Changing
> this would break dtb compatibility.. so for now I need to handle both
> iommu-ops and direct-ops cases.)

Or you always call call on a struct device that has the iommu, that
is match on the generic, and pick a different device.  That would in
many ways seem preferably over the current hack, even if that also is
just a horribly band-aid.
