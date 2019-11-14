Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536CFFC0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 08:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNHlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 02:41:08 -0500
Received: from verein.lst.de ([213.95.11.211]:38038 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfKNHlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:41:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EF39468AFE; Thu, 14 Nov 2019 08:41:05 +0100 (CET)
Date:   Thu, 14 Nov 2019 08:41:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: generic DMA bypass flag
Message-ID: <20191114074105.GC26546@lst.de>
References: <20191113133731.20870-1-hch@lst.de> <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:45:15PM +0000, Robin Murphy wrote:
> In all honesty, this seems silly. If we can set a per-device flag to say 
> "oh, bypass these ops and use some other ops instead", then we can just as 
> easily simply give the device the appropriate ops in the first place. 
> Because, y'know, the name of the game is "per-device ops".

Except that we can't do it _that_ easily.  The problem is that for both
the powerpc and intel case the selection is dynamic.  If a device is in
the identify domain with intel-iommu (or the equivalent on powerpc which
doesn't use the normal iommu framework), we still want to use the iommu
to be able to map memory for devices with a too small dma mask using
the iommu instead of using swiotlb bouncing.  So to "just" use the
per-device dma ops we'd need:

  a) a hook in dma_direct_supported to pick another set of ops for
     small dma masks
  b) a hook in the IOMMU ops to propagate to the direct ops for full
     64-bit masks

I looked into that for powerpc a while ago and it wasn't pretty at all.
Compared to that just checking another flag for the DMA direct calls
is relatively clean and trivial as seens in the diffstat for this series
alone.

> I don't see a great benefit to pulling legacy cruft out into common code 
> instead of just working to get rid of it in-place, when said cruft pulls in 
> the opposite direction to where we're taking the common code (i.e. it's 
> inherently based on the premise of global ops).

I'm not sure what legacy cruft it pull in.  I think it actually fits very
much into a mental model of "direct mapping is the default, to be overriden
if needed" which is pretty close to what we have at the moment.  Just
with a slightly more complicated processing of the override.
