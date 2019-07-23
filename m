Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2939571BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfGWPix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:38:53 -0400
Received: from verein.lst.de ([213.95.11.211]:42780 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfGWPix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:38:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 93A4868B02; Tue, 23 Jul 2019 17:38:51 +0200 (CEST)
Date:   Tue, 23 Jul 2019 17:38:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        hch@lst.de, m.szyprowski@samsung.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size
 call
Message-ID: <20190723153851.GE720@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com> <20190722145509.1284-3-eric.auger@redhat.com> <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:36:09PM +0100, Robin Murphy wrote:
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index c8be1c4f5b55..37c143971211 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
>>   {
>>   	size_t max_segment_size = SIZE_MAX;
>>   -	if (vring_use_dma_api(vdev))
>> +	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)
>
> Hmm, might it make sense to roll that check up into vring_use_dma_api() 
> itself? After all, if the device has no mask then it's likely that other 
> DMA API ops wouldn't really work as expected either.

Makes sense to me.
