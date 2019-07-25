Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8174EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfGYNEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:04:21 -0400
Received: from verein.lst.de ([213.95.11.211]:35198 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfGYNEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:04:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 557F068B02; Thu, 25 Jul 2019 15:04:16 +0200 (CEST)
Date:   Thu, 25 Jul 2019 15:04:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
        m.szyprowski@samsung.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size
 call
Message-ID: <20190725130416.GA4992@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com> <20190722145509.1284-3-eric.auger@redhat.com> <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com> <20190723153851.GE720@lst.de> <fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0fbad5-9b44-d937-e0fd-65fb20c90666@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:53:49PM +0200, Auger Eric wrote:
> I am confused: if vring_use_dma_api() returns false if the dma_mask is
> unset (ie. vring_use_dma_api() returns false), the virtio-blk-pci device
> will not be able to get translated addresses and won't work properly.
> 
> The patch above allows the dma api to be used and only influences the
> max_segment_size and it works properly.
> 
> So is it normal the dma_mask is unset in my case?

Its not normal.  I assume you use virtio-nmio?  Due to the mess with
the dma_mask being a pointer a lot of subsystems forgot to set a dma
mask up, and oddly enough seem to mostly get away with it.
