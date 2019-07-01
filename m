Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDC5C261
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 19:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfGARyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 13:54:50 -0400
Received: from foss.arm.com ([217.140.110.172]:37980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfGARyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:54:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7331228;
        Mon,  1 Jul 2019 10:54:49 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 890D63F703;
        Mon,  1 Jul 2019 10:54:48 -0700 (PDT)
Subject: Re: DMA-API attr - DMA_ATTR_NO_KERNEL_MAPPING
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
References: <CACDBo564RoWpi8y2pOxoddnn0s3f3sA-fmNxpiXuxebV5TFBJA@mail.gmail.com>
 <CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com>
 <20190626175131.GA17250@infradead.org>
 <CACDBo56fNVxVyNEGtKM+2R0X7DyZrrHMQr6Yw4NwJ6USjD5Png@mail.gmail.com>
 <c9fe4253-5698-a226-c643-32a21df8520a@arm.com>
 <CACDBo57CcYQmNrsTdMbax27nbLyeMQu4kfKZOzNczNcnde9g3Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0725b9aa-0523-daef-b4ff-7e2dd910cf3c@arm.com>
Date:   Mon, 1 Jul 2019 18:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACDBo57CcYQmNrsTdMbax27nbLyeMQu4kfKZOzNczNcnde9g3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2019 18:47, Pankaj Suryawanshi wrote:
>> If you want a kernel mapping, *don't* explicitly request not to have a
>> kernel mapping in the first place. It's that simple.
>>
> 
> Do you mean do not use dma-api ? because if i used dma-api it will give you
> mapped virtual address.
> or i have to use directly cma_alloc() in my driver. // if i used this
> approach i need to reserved more vmalloc area.

No, I mean just call dma_alloc_attrs() normally *without* adding the 
DMA_ATTR_NO_KERNEL_MAPPING flag. That flag means "I never ever want to 
make CPU accesses to this buffer from the kernel" - that is clearly not 
the case for your code, so it is utterly nonsensical to still pass the 
flag but try to hack around it later.

Robin.
