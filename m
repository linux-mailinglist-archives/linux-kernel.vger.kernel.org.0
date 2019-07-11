Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03C65445
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfGKKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 06:03:36 -0400
Received: from verein.lst.de ([213.95.11.211]:56801 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfGKKDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:03:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3471C68B05; Thu, 11 Jul 2019 12:03:33 +0200 (CEST)
Date:   Thu, 11 Jul 2019 12:03:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     miles.chen@mediatek.com, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] kernel/dma: export dma_alloc_from_contiguous to modules
Message-ID: <20190711100332.GA5853@lst.de>
References: <20190711053343.28873-1-miles.chen@mediatek.com> <7d14b94f-454f-d512-bc8f-589f71bc07ea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d14b94f-454f-d512-bc8f-589f71bc07ea@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 09:50:58AM +0100, Robin Murphy wrote:
> On 11/07/2019 06:33, miles.chen@mediatek.com wrote:
>> From: Miles Chen <miles.chen@mediatek.com>
>>
>> This change exports dma_alloc_from_contiguous and
>> dma_release_from_contiguous to modules.
>>
>> Currently, we can add a reserve a memory node in dts files, make
>> it a CMA memory by setting compatible = "shared-dma-pool",
>> and setup the dev->cma_area by using of_reserved_mem_device_init_by_idx().
>>
>> Export dma_alloc_from_contiguous and dma_release_from_contiguous, so we
>> can allocate/free from/to dev->cma_area in kernel modules.
>
> As far as I understand, this was never intended for drivers to call 
> directly. If a device has its own private CMA area, then regular 
> dma_alloc_attrs() should allocate from that automatically; if that's not 
> happening already, then there's a bug somewhere.

Agreed.
