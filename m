Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C698ECFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbfHONf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 09:35:59 -0400
Received: from verein.lst.de ([213.95.11.211]:46778 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbfHONf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:35:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A750A68AFE; Thu, 15 Aug 2019 15:35:54 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:35:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, bskeggs@redhat.com,
        airlied@linux.ie, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
 nouveau ?
Message-ID: <20190815133554.GE12036@lst.de>
References: <20190814145033.GA11190@Red> <20190814174927.GT7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814174927.GT7444@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 07:49:27PM +0200, Daniel Vetter wrote:
> On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > Since lot of release (at least since 4.19), I hit the following error message:
> > DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> > 
> > After hitting that, I try to check who is creating so many DMA mapping and see:
> > cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
> >       6 ahci
> >     257 e1000e
> >       6 ehci-pci
> >    5891 nouveau
> >      24 uhci_hcd
> > 
> > Does nouveau having this high number of DMA mapping is normal ?
> 
> Yeah seems perfectly fine for a gpu.

That is a lot and apparently overwhelm the dma-debug tracking.  Robin
rewrote this code in Linux 4.21 to work a little better, so I'm curious
why this might have changes in 4.19, as dma-debug did not change at
all there.
