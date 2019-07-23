Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF371BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfGWPie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:38:34 -0400
Received: from verein.lst.de ([213.95.11.211]:42777 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfGWPid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:38:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBAB168B02; Tue, 23 Jul 2019 17:38:30 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:38:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size
 call
Message-ID: <20190723153830.GD720@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com> <20190722145509.1284-3-eric.auger@redhat.com> <20190722112704-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722112704-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:33:35AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> > Do not call dma_max_mapping_size for devices that have no DMA
> > mask set, otherwise we can hit a NULL pointer dereference.
> > 
> > This occurs when a virtio-blk-pci device is protected with
> > a virtual IOMMU.
> > 
> > Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> 
> Christoph, I wonder why did you suggest this?
> The connection between dma_mask and dma_max_mapping_size
> is far from obvious.  The documentation doesn't exist.
> Do we really have to teach all users about this hack?
> Why not just make dma_max_mapping_size DTRT?

Because we should not call into dma API functions for devices that
are not DMA capable.
