Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936905BBA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfGAMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 08:39:58 -0400
Received: from foss.arm.com ([217.140.110.172]:34000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfGAMj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:39:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90907344;
        Mon,  1 Jul 2019 05:39:57 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 043783F246;
        Mon,  1 Jul 2019 05:39:56 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
To:     Joerg Roedel <joro@8bytes.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
 <20190701122158.GE8166@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
Date:   Mon, 1 Jul 2019 13:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701122158.GE8166@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2019 13:21, Joerg Roedel wrote:
> On Fri, Jun 21, 2019 at 09:38:14PM -0700, Nicolin Chen wrote:
>> The max_len is a u32 type variable so the calculation on the
>> left hand of the last if-condition will potentially overflow
>> when a cur_len gets closer to UINT_MAX -- note that there're
>> drivers setting max_seg_size to UINT_MAX:
>>    drivers/dma/dw-edma/dw-edma-core.c:745:
>>      dma_set_max_seg_size(dma->dev, U32_MAX);
>>    drivers/dma/dma-axi-dmac.c:871:
>>      dma_set_max_seg_size(&pdev->dev, UINT_MAX);
>>    drivers/mmc/host/renesas_sdhi_internal_dmac.c:338:
>>      dma_set_max_seg_size(dev, 0xffffffff);
>>    drivers/nvme/host/pci.c:2520:
>>      dma_set_max_seg_size(dev->dev, 0xffffffff);
>>
>> So this patch just casts the cur_len in the calculation to a
>> size_t type to fix the overflow issue, as it's not necessary
>> to change the type of cur_len after all.
>>
>> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> Looks good to me, but I let Robin take a look too before I apply it,
> Robin?
I'll need to take a closer look at how exactly an overflow would happen 
here (just got back off some holiday), but my immediate thought is that 
if this is a real problem, then what about 32-bit builds where size_t 
would still overflow?

Robin.
