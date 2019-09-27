Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10594C0D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfI0VVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 17:21:08 -0400
Received: from verein.lst.de ([213.95.11.211]:47777 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfI0VVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:21:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 569A468B05; Fri, 27 Sep 2019 23:21:04 +0200 (CEST)
Date:   Fri, 27 Sep 2019 23:21:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        iommu@lists.linux-foundation.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch
 customizable
Message-ID: <20190927212104.GC16819@lst.de>
References: <20190923123418.22695-1-pasic@linux.ibm.com> <20190923123418.22695-2-pasic@linux.ibm.com> <20190923152117.GA2767@lst.de> <20190926143745.68bdd082.pasic@linux.ibm.com> <6c62da57-c94c-8078-957c-b6832ed7fd1b@arm.com> <20190927023314.3e5c8324.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927023314.3e5c8324.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 02:33:14AM +0200, Halil Pasic wrote:
> Thank you for your feedback. Just to be sure we are on the same pager, I
> read commit a0be1db4304f like this:
> 1) virtio_pci_legacy needs to allocate the virtqueues so that the base
> address fits 44 bits
> 2) if 64 bit dma is possible they set coherent_dma_mask to
>   DMA_BIT_MASK(44) and dma_mask to DMA_BIT_MASK(64)
> 3) since the queues get allocated with coherent allocations 1) is
> satisfied
> 4) when the streaming mappings see a buffer that is beyond
>   DMA_BIT_MASK(44) then it has to treat it as not coherent memory
>   and do the syncing magic (which isn't actually required, just
>   a side effect of the workaround.

1-3 is correct, 4 is not.  The coherent mask is a little misnamed and
doesn't have to anything with coherency.  It is the mask for DMA
allocations, while the dma mask is for streaming mappings.

> I've already implemented a patch (see after the scissors line) that
> takes a similar route as commit a0be1db4304f, but I consider that a
> workaround at best. But if that is what the community wants... I have to
> get the job done one way or the other.

That patch (minus the comments about being a workaround) is what you
should have done from the beginning.
