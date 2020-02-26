Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDA417052F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 18:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgBZRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 12:00:46 -0500
Received: from foss.arm.com ([217.140.110.172]:39268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbgBZRAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:00:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7E131B;
        Wed, 26 Feb 2020 09:00:45 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D35A73F881;
        Wed, 26 Feb 2020 09:00:44 -0800 (PST)
Subject: Re: Proper way to check for restricted DMA addressing from device
 driver
To:     Lucas Stach <l.stach@pengutronix.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2608dfa05478d995586c9e477917349dc18618ac.camel@pengutronix.de>
 <bfecf850-5bd7-3092-b9b3-c5721d7a44ee@arm.com>
 <d56cec41874ee69d0f5767b549e9bd6b3003e75a.camel@pengutronix.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5571dfb5-0f07-dbeb-7f15-ce2708874d27@arm.com>
Date:   Wed, 26 Feb 2020 17:00:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d56cec41874ee69d0f5767b549e9bd6b3003e75a.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2020 4:04 pm, Lucas Stach wrote:
> On Mi, 2020-02-26 at 15:51 +0000, Robin Murphy wrote:
>> On 26/02/2020 3:44 pm, Lucas Stach wrote:
>>> Hi all,
>>>
>>> I'm currently struggling with how to properly check for restricted DMA
>>> addressing from a device driver side. The basic issue I'm facing is
>>> that I have a embedded GPU, which isn't able to address all system
>>> memory due to interconnect being restricted to 32bit addressing. The
>>> limits are properly described in the system device-tree and thus
>>> SWIOTLB is working.
>>>
>>> However graphics buffers are large and graphics drivers really like to
>>> keep the dma mapping alive for performance reasons, which means I'm
>>> running out of SWIOTLB space pretty easily, aside from the obvious
>>> performance implications of SWIOTLB.
>>>
>>> As 3 out of the maximum 4GB system memory are located in the DMA32 zone
>>> and thus located in the GPU addressable space, I just want to avoid
>>> allocating graphics buffers outside of the DMA32 zone.
>>>
>>> To add the DMA32 restriction to my drivers allocations, I need a
>>> reliable way from the device driver side to check if the GPU is in such
>>> a restricted system. What I'm currently doing in my WIP patch is this:
>>>
>>>    /*
>>>     * If the GPU is part of a system with only 32bit bus addressing
>>>     * capabilities, request pages for our SHM backend buffers from the
>>>     * DMA32 zone to avoid performance killing SWIOTLB bounce buffering.
>>>     */
>>>    if (*gpu->dev->dma_mask < BIT_ULL(32) && !device_iommu_mapped(gpu->dev))
>>>            priv->shm_gfp_mask |= GFP_DMA32;
>>>
>>> However I'm not sure if there are edge cases where this check would
>>> fool me. Is there any better way to check for DMA addressing
>>> restrictions from the device driver side?
>>
>> dma_addressing_limited()?
> 
> While amdgpu and radeon do seem to use this to trigger DMA32
> allocations, the bool return value doesn't really tell if DMA32 is
> helpful or not. All it tells is that the system has memory outside of
> the device dma addressing capabilities.

If the limit falls somewhere between 32 bits and "everything" then DMA32 
is the best you can do anyway; if it's *less* than 32 bits then you'd be 
into the realm of "serious problems" already. There is a point at which 
it's reasonable to assume you don't have to support contrived 
pathological cases :)
> Is the return value of this function correct if the device is behind a
> IOMMU? While the device might be on a bus that is address limited a
> IOMMU further up the path to memory might allow to address all system
> memory, no?

It should be OK - see the comment in dma_get_required_mask(). Obviously 
it's theoretically possible to integrate a device with 32+ bits of DMA 
capability to an IOMMU input 32+ bits wide, via an interconnect less 
than 32 bits wide, but any designer silly enough to actually do that is 
welcome to have their SoC never supported by Linux.

Robin.
