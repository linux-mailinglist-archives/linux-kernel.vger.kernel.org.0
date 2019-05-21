Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D3256B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 19:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfEUR1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 13:27:55 -0400
Received: from foss.arm.com ([217.140.101.70]:39342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUR1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:27:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59CE0374;
        Tue, 21 May 2019 10:27:54 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5113F718;
        Tue, 21 May 2019 10:27:51 -0700 (PDT)
Subject: Re: Device obligation to write into a DMA_FROM_DEVICE streaming DMA
 mapping
To:     Horia Geanta <horia.geanta@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR0402MB348537CB86926B3E6D1DBE0A98070@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <584b54f6-bd12-d036-35e6-23eb2dabe811@arm.com>
Date:   Tue, 21 May 2019 18:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB348537CB86926B3E6D1DBE0A98070@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 18:14, Horia Geanta wrote:
> Hi,
> 
> Is it mandatory for a device to write data in an area DMA mapped DMA_FROM_DEVICE?
> Can't the device just "ignore" that mapping - i.e. not write anything - and
> driver should expect original data to be found in that location (since it was
> not touched / written to by the device)?
> [Let's leave cache coherency aside, and consider "original data" to be in RAM.]
> 
> I am asking this since I am seeing what seems to be an inconsistent behavior /
> semantics between cases when swiotlb bouncing is used and when it's not.
> 
> Specifically, the context is:
> 1. driver prepares a scatterlist with several entries and performs a
> dma_map_sg() with direction FROM_DEVICE
> 2. device decides there's no need to write into the buffer pointed by first
> scatterlist entry and skips it (writing into subsequent buffers)
> 3. driver is notified the device finished processing and dma unmaps the scatterlist
> 
> When swiotlb bounce is used, the buffer pointed to by first scatterlist entry is
> corrupted. That's because swiotlb implementation expects the device to write
> something into that buffer, however the device logic is "whatever was previously
> in that buffer should be used" (2. above).
> 
> For FROM_DEVICE direction:
> -swiotlb_tbl_map_single() does not copy data from original location to swiotlb
> 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> 		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
> -swiotlb_tbl_unmap_single() copies data from swiotlb to original location
> 	if (orig_addr != INVALID_PHYS_ADDR &&
> 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
> 		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
> and when device did not write anything (as in current situation), it overwrites
> original data with zeros
> 
> In case swiotlb bounce is not used and device does not write into the
> FROM_DEVICE streaming DMA maping, the original data is available.
> 
> Could you please clarify whether:
> -I am missing something obvious OR
> -the DMA API documentation should be updated - to mandate for device writes into
> FROM_DEVICE mappings) OR
> -the swiotlb implementation should be updated - to copy data from original
> location irrespective of DMA mapping direction?

Hmm, that certainly feels like a bug in SWIOTLB - it seems reasonable in 
principle for a device to only partially update a mapped buffer before a 
sync/unmap, so I'd say it probably should be filling the bounce buffer 
with the original data at the start, regardless of direction.

Robin.
