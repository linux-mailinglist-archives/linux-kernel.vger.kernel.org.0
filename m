Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0718BFB2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 15:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfKMOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 09:45:19 -0500
Received: from foss.arm.com ([217.140.110.172]:53702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfKMOpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:45:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 367C87A7;
        Wed, 13 Nov 2019 06:45:18 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CEA63F6C4;
        Wed, 13 Nov 2019 06:45:17 -0800 (PST)
Subject: Re: generic DMA bypass flag
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20191113133731.20870-1-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
Date:   Wed, 13 Nov 2019 14:45:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113133731.20870-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2019 1:37 pm, Christoph Hellwig wrote:
> Hi all,
> 
> I've recently beeing chatting with Lu about using dma-iommu and
> per-device DMA ops in the intel IOMMU driver, and one missing feature
> in dma-iommu is a bypass mode where the direct mapping is used even
> when an iommu is attached to improve performance.  The powerpc
> code already has a similar mode, so I'd like to move it to the core
> DMA mapping code.  As part of that I noticed that the current
> powerpc code has a little bug in that it used the wrong check in the
> dma_sync_* routines to see if the direct mapping code is used.

In all honesty, this seems silly. If we can set a per-device flag to say 
"oh, bypass these ops and use some other ops instead", then we can just 
as easily simply give the device the appropriate ops in the first place. 
Because, y'know, the name of the game is "per-device ops".

> These two patches just add the generic code and move powerpc over,
> the intel IOMMU bits will require a separate discussion.

The ops need to match the default domain type, so the hard part of the 
problem is choosing when and if to switch that (particularly fun if 
there are multiple devices in the IOMMU group). Flipping between 
iommu-dma and dma-direct at that point will be trivial.

I don't see a great benefit to pulling legacy cruft out into common code 
instead of just working to get rid of it in-place, when said cruft pulls 
in the opposite direction to where we're taking the common code (i.e. 
it's inherently based on the premise of global ops).

Robin.

> The x86 AMD Gart code also has a bypass mode, but it is a lot
> strange, so I'm not going to touch it for now.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
