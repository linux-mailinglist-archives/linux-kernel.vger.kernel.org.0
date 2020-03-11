Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD1181D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgCKQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:15:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgCKQPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:15:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0575831B;
        Wed, 11 Mar 2020 09:15:35 -0700 (PDT)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F05E03F6CF;
        Wed, 11 Mar 2020 09:15:33 -0700 (PDT)
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To:     "Artem S. Tashkinov" <aros@gmx.com>, Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
 <20200311154328.GA24044@lst.de> <20200311154718.GB24044@lst.de>
 <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <eadd21f1-c618-9523-fa14-e862dfa256ac@arm.com>
Date:   Wed, 11 Mar 2020 16:15:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2020 4:02 pm, Artem S. Tashkinov wrote:
> On 3/11/20 3:47 PM, Christoph Hellwig wrote:
>> And actually one more idea after looking at what slab interactions
>> could exist.  platform_device_register_full frees the dma_mask
>> unconditionally, even if it didn't allocated it, which might lead
>> to weird memory corruption if we hit the failure path.  So let's try
>> something like this, replacing the earlier patch in that file.
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index b230beb6ccb4..04080a8d94e2 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -632,19 +632,6 @@ struct platform_device 
>> *platform_device_register_full(
>>       pdev->dev.of_node_reused = pdevinfo->of_node_reused;
>>
>>       if (pdevinfo->dma_mask) {
>> -        /*
>> -         * This memory isn't freed when the device is put,
>> -         * I don't have a nice idea for that though.  Conceptually
>> -         * dma_mask in struct device should not be a pointer.
>> -         * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
>> -         */
>> -        pdev->dev.dma_mask =
>> -            kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
>> -        if (!pdev->dev.dma_mask)
>> -            goto err;
>> -
>> -        kmemleak_ignore(pdev->dev.dma_mask);
>> -
>>           *pdev->dev.dma_mask = pdevinfo->dma_mask;
>>           pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
>>       }
>> @@ -670,7 +657,6 @@ struct platform_device 
>> *platform_device_register_full(
>>       if (ret) {
>>   err:
>>           ACPI_COMPANION_SET(&pdev->dev, NULL);
>> -        kfree(pdev->dev.dma_mask);
>>           platform_device_put(pdev);
>>           return ERR_PTR(ret);
>>       }
>>
> 
> With this patch the system works (I haven't created an initrd, so it
> doesn't completely boot and panics on not being able to mount root fs
> but that's expected).

Yup, a few lines earlier in the log you can see the wdat_wdt driver 
failing in platform_device_add(), which since it called into 
platform_device_register_full() with pdevinfo.dma_mask = 0, will have 
unwound into that kfree() of pdev.dma_mask corrupting the heap.

Robin.
