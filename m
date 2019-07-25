Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7815475415
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfGYQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:32:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGYQcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F144A86679;
        Thu, 25 Jul 2019 16:32:20 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EA3E60C05;
        Thu, 25 Jul 2019 16:32:16 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
        m.szyprowski@samsung.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190722145509.1284-1-eric.auger@redhat.com>
 <20190722145509.1284-3-eric.auger@redhat.com>
 <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com> <20190723153851.GE720@lst.de>
 <fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
 <20190725130416.GA4992@lst.de>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <11b7b5e4-2de7-2089-57d2-d0a138f94376@redhat.com>
Date:   Thu, 25 Jul 2019 18:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190725130416.GA4992@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 25 Jul 2019 16:32:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Michael,

On 7/25/19 3:04 PM, Christoph Hellwig wrote:
> On Thu, Jul 25, 2019 at 01:53:49PM +0200, Auger Eric wrote:
>> I am confused: if vring_use_dma_api() returns false if the dma_mask is
>> unset (ie. vring_use_dma_api() returns false), the virtio-blk-pci device
>> will not be able to get translated addresses and won't work properly.
>>
>> The patch above allows the dma api to be used and only influences the
>> max_segment_size and it works properly.
>>
>> So is it normal the dma_mask is unset in my case?
> 
> Its not normal.  I assume you use virtio-nmio?  Due to the mess with
> the dma_mask being a pointer a lot of subsystems forgot to set a dma
> mask up, and oddly enough seem to mostly get away with it.
> 

No the issue is encountered with virtio-blk-pci

I think the problem is virtio_max_dma_size() is called from
virtblk_probe (virtio_blk.c) on the virtio<n> device and not the actual
virtio_pci_device which has a dma_mask set. I don't think the virtio<n>
device ever has a dma_mask set.

We do not hit the guest crash on the virtio-net-pci device as the
virtio-net driver does not call virtio_max_dma_size() on the virtio<n>
device.

Does fd1068e1860e ("virtio-blk: Consider virtio_max_dma_size() for
maximum segment size") call virtio_max_dma_size() on the right device?

Thanks

Eric
