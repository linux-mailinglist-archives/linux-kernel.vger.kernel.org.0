Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6FF14EE16
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 14:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAaN7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 08:59:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45276 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgAaN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:59:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00VDxHZ3022821;
        Fri, 31 Jan 2020 07:59:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580479157;
        bh=5lxWpBZ6G8w1tWs1wN9YxQXc/V6PgNi2wuwT6eWlKGQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nDv9VPoNMvUFQB/fhBlINJPFughuTy4qLXzRoy8NKPu5AHZmq9CW/ikGcRnKtAX6i
         +G6WJny+pq7aAR2+pBFgSfN4kfGa5afgJETWWcAWgvIOyEow8EsOOJlBSTZTS1iaWy
         J4cdoC0r1cuxU+OjptsIcZse+VjVOowd+if2GX04=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00VDxHMY041900
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 07:59:17 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 07:59:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 07:59:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VDxEIn021608;
        Fri, 31 Jan 2020 07:59:15 -0600
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when it
 is valid
To:     Christoph Hellwig <hch@lst.de>
CC:     <robh@kernel.org>, <vigneshr@ti.com>, <konrad.wilk@oracle.com>,
        <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <rogerq@ti.com>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
 <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
 <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com>
 <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com>
 <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com> <20200130075332.GA30735@lst.de>
 <b2b1cb21-3aae-2181-fd79-f63701f283c0@ti.com> <20200130164010.GA6472@lst.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <54af6531-705f-a31c-c5b8-479261a5454e@ti.com>
Date:   Fri, 31 Jan 2020 16:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130164010.GA6472@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 30/01/2020 18.40, Christoph Hellwig wrote:
> On Thu, Jan 30, 2020 at 03:04:37PM +0200, Peter Ujfalusi via iommu wrote:
>> On 30/01/2020 9.53, Christoph Hellwig wrote:
>>> [skipping the DT bits, as I'm everything but an expert on that..]
>>>
>>> On Mon, Jan 27, 2020 at 04:00:30PM +0200, Peter Ujfalusi wrote:
>>>> I agree on the phys_to_dma(). It should fail for addresses which does
>>>> not fall into any of the ranges.
>>>> It is just a that we in Linux don't have the concept atm for ranges, we
>>>> have only _one_ range which applies to every memory address.
>>>
>>> what does atm here mean?
>>
>> struct device have only single dma_pfn_offset, one can not have multiple
>> ranges defined. If we have then only the first is taken and the physical
>> address and dma address is discarded, only the dma_pfn_offset is stored
>> and used.
>>
>>> We have needed multi-range support for quite a while, as common broadcom
>>> SOCs do need it.  So patches for that are welcome at least from the
>>> DMA layer perspective (kinda similar to your pseudo code earlier)
>>
>> But do they have dma_pfn_offset != 0?
> 
> Well, with that I mean multiple ranges with different offsets.  Take
> a look at arch/mips/bmips/dma.c:__phys_to_dma() and friends.  This
> is an existing implementation for mips, but there are arm and arm64
> SOCs using the same logic on the market as well, and we'll want to
> support them eventually.

I see. My PoC patch was not too off then ;)
So the plan is to have a generic implementation for all of the
architecture, right?

>> The dma_pfn_offset is _still_ applied to the mask we are trying to set
>> (and validate) via dma-direct.
> 
> And for the general case that is exactly the right thing to do, we
> just need to deal with really odd ZONE_DMA placements like yours.

I'm still not convinced, the point of the DMA mask, at least how I see
it, to check that the dma address can be handled by the device (DMA,
peripheral with built in DMA, etc), it is not against physical address.
Doing phys_to_dma() on the mask from the dma_set_mask() is just wrong.

>>> We'll need to find the minimum change to make it work
>>> for now without switching ops, even if it isn't the correct one, and
>>> then work from there.
>>
>> Sure, but can we fix the regression by reverting to arm_ops for now only
>> if dma_pfn_offset is not 0? It used to work fine in the past at least it
>> appeared to work on K2 platforms.
> 
> But that will cause yet another regression in what we have just fixed
> with using the generic direct ops, at which points it turns into who
> screams louder.

Hehe, I see.
I genuinely curious why k2 platform worked just fine with LPAE (it needs
it), but guys had issues with LPAE on dra7/am5.
The fix for dra7/am5 broke k2.
As far as I can see the main (only) difference is that k2 have
dma_pfn_offset = 0x780000, while dra7/am5 have it 0 (really direct mapping).

> For now I'm tempted to throw something like this in, which is a bit
> of a hack, but actually 100% matches what various architectures have
> historically done:
> 
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 6af7ae83c4ad..6ba9ee6e20bd 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -482,6 +482,9 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  {
>  	u64 min_mask;
>  
> +	if (mask >= DMA_BIT_MASK(32))
> +		return 1;
> +

Right, so skipping phys_to_dma() for the mask and believing that it will
work..

It does: audio and dmatest memcpy tests are just fine with this, MMC
also probed with ADMA enabled.

As far as I can tell it works as well as falling back to the old arm ops
in case of LPAE && dma_pfn_offset != 0

Fwiw:
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Would you be comfortable to send apply this patch to mainline with
Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE
configs")

So it gets picked for stable kernels as well?

>  	if (IS_ENABLED(CONFIG_ZONE_DMA))
>  		min_mask = DMA_BIT_MASK(zone_dma_bits);
>  	else
> 

Thank you,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
