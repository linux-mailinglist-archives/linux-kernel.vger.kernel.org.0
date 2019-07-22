Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE23703D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 17:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfGVPdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 11:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfGVPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60CEE307D915;
        Mon, 22 Jul 2019 15:33:50 +0000 (UTC)
Received: from redhat.com (ovpn-124-54.rdu2.redhat.com [10.10.124.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id 786F95D968;
        Mon, 22 Jul 2019 15:33:44 +0000 (UTC)
Date:   Mon, 22 Jul 2019 11:33:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Message-ID: <20190722112704-mutt-send-email-mst@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
 <20190722145509.1284-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722145509.1284-3-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 22 Jul 2019 15:33:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> Do not call dma_max_mapping_size for devices that have no DMA
> mask set, otherwise we can hit a NULL pointer dereference.
> 
> This occurs when a virtio-blk-pci device is protected with
> a virtual IOMMU.
> 
> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>

Christoph, I wonder why did you suggest this?
The connection between dma_mask and dma_max_mapping_size
is far from obvious.  The documentation doesn't exist.
Do we really have to teach all users about this hack?
Why not just make dma_max_mapping_size DTRT?

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c8be1c4f5b55..37c143971211 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
>  {
>  	size_t max_segment_size = SIZE_MAX;
>  
> -	if (vring_use_dma_api(vdev))
> +	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)
>  		max_segment_size = dma_max_mapping_size(&vdev->dev);
>  
>  	return max_segment_size;
> -- 
> 2.20.1
