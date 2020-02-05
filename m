Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B321528FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 11:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgBEKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 05:19:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43684 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:19:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 015AJAWT038813;
        Wed, 5 Feb 2020 04:19:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580897950;
        bh=a4B3Bqd5Pf17C8VTQl7PRrNSGniXRgvhSLeM1x0d+hk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=byogR5Y93N6sxhLZuK2obDyLC3hmzVNNSkPNhl2ry7ZEcrYkt8Hqq8IySduCmkPtB
         ohzI1jKztmbskV4V7+4t9v6xsAEHReAeS1KcuOg+pfCOipcjcKomxqyKJ64H4kQq/o
         E3K6QUFcAKw8gAI++17jnsbO91gCzSVdho02fGa4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 015AJA6F008867;
        Wed, 5 Feb 2020 04:19:10 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 04:19:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 04:19:09 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 015AJ7R3091177;
        Wed, 5 Feb 2020 04:19:07 -0600
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
 <c37b12e4-0e0c-afa2-a8e4-782ccd57542d@ti.com> <20200203170809.GA19293@lst.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <af52fd8e-4991-cbf1-2b55-c2b4496f4703@ti.com>
Date:   Wed, 5 Feb 2020 12:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203170809.GA19293@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2020 19.08, Christoph Hellwig wrote:
> On Fri, Jan 31, 2020 at 04:00:20PM +0200, Peter Ujfalusi wrote:
>> I see. My PoC patch was not too off then ;)
>> So the plan is to have a generic implementation for all of the
>> architecture, right?
> 
> І don't know of a concrete plan, but that's defintively what I'd like
> to see.
> 
>>>> The dma_pfn_offset is _still_ applied to the mask we are trying to set
>>>> (and validate) via dma-direct.
>>>
>>> And for the general case that is exactly the right thing to do, we
>>> just need to deal with really odd ZONE_DMA placements like yours.
>>
>> I'm still not convinced, the point of the DMA mask, at least how I see
>> it, to check that the dma address can be handled by the device (DMA,
>> peripheral with built in DMA, etc), it is not against physical address.
>> Doing phys_to_dma() on the mask from the dma_set_mask() is just wrong.
> 
> We have a translation between the addresses that the device sees, and
> those that the CPU sees.  The device can address N bits of address space
> as seen from the device.  The addresses encoded in max_pfn,
> zone_dma_bits or the harcoded 32 in the zone dma 32 case are CPU address.
> So no, we can't blindly compare those.

Right, thanks for the explanation.

>>> But that will cause yet another regression in what we have just fixed
>>> with using the generic direct ops, at which points it turns into who
>>> screams louder.
>>
>> Hehe, I see.
>> I genuinely curious why k2 platform worked just fine with LPAE (it needs
>> it), but guys had issues with LPAE on dra7/am5.
>> The fix for dra7/am5 broke k2.
>> As far as I can see the main (only) difference is that k2 have
>> dma_pfn_offset = 0x780000, while dra7/am5 have it 0 (really direct mapping).
> 
> How much memory does the platform have?

The boards which is bootable in mainline have maximum of 2G, there might
be custom boards with more RAM, but I'm not aware of them.

> Once you are above 32-bits worth
> of address space devices with a 32-bit DMA mask can't address all the
> memory.  Now if k2 for example only had less than 4G of memory, but at
> addresses over 4G, and the offset compensates for the offset of the DRAM
> it works without bounce buffering and thus didn't need swiotlb.  But any
> platform that has DRAM that is not addressable will need swiotlb.

I see, since we have maximum of 2G, which is mirrored at 0x80000000 for
devices we never needed the assistance from swiotlb for bounce buffering
and that's why the arm ops worked fine.

> 
>>>  	u64 min_mask;
>>>  
>>> +	if (mask >= DMA_BIT_MASK(32))
>>> +		return 1;
>>> +
>>
>> Right, so skipping phys_to_dma() for the mask and believing that it will
>> work..
>>
>> It does: audio and dmatest memcpy tests are just fine with this, MMC
>> also probed with ADMA enabled.
>>
>> As far as I can tell it works as well as falling back to the old arm ops
>> in case of LPAE && dma_pfn_offset != 0
>>
>> Fwiw:
>> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> Would you be comfortable to send this patch for mainline with
>> Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE
>> configs")
> 
> That is the big question.  I don't feel overly comfortable as I've been
> trying to get this right, but so far it seems like the least bad option.
> I'll send out a proper patch with updated comments and will see what
> people think.

I understand and thank you for the patch, it makes k2 platform working
again!

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
