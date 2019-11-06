Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB25FF1C44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfKFRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 12:18:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60980 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732329AbfKFRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:18:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA6HI3Wc000838;
        Wed, 6 Nov 2019 11:18:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573060683;
        bh=EcRltSnNjGkBxvjA5L9hzMCEuCsbKiaLjGExl987Je0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jNy0kVsQqRx5r6VL3gmNqWLtrHrwg/g7DwWrYx3+VZzF4IxnA1TLh0efpMMBbshu0
         8C1FxnlW40jL4YNdEotIzjcl3UUnxPGCCoPSC5Hl6/T2Fo1cNXg0dG/GsmlVL0pEen
         svmkYqMFVACZ+Ck6kdpvRq0q9zZtx4f9Zh/9RbFg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA6HI3DU052782
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 11:18:03 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 11:17:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 11:17:47 -0600
Received: from [10.250.45.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA6HI0LQ051929;
        Wed, 6 Nov 2019 11:18:00 -0600
Subject: Re: [PATCH v15 1/5] dma-buf: Add dma-buf heaps framework
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20191106042252.72452-1-john.stultz@linaro.org>
 <20191106042252.72452-2-john.stultz@linaro.org>
 <7154851c-fc55-e157-5a01-21abdd4a23e6@ti.com>
 <CALAqxLW1vgLCik5WfDN7qkRsO=K9U4otNBp72aOH5UNN1jUgMQ@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <26700d4b-07c6-65b1-9fc6-bb3e239202e5@ti.com>
Date:   Wed, 6 Nov 2019 12:18:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLW1vgLCik5WfDN7qkRsO=K9U4otNBp72aOH5UNN1jUgMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 12:03 PM, John Stultz wrote:
> On Wed, Nov 6, 2019 at 5:52 AM Andrew F. Davis <afd@ti.com> wrote:
>>
>> On 11/5/19 11:22 PM, John Stultz wrote:
>>> +unsigned int dma_heap_ioctl_cmds[] = {
>>> +     DMA_HEAP_IOC_ALLOC,
>>> +};
>>> +
>>> +static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
>>> +                        unsigned long arg)
>>> +{
>>> +     char stack_kdata[128];
>>> +     char *kdata = stack_kdata;
>>> +     unsigned int kcmd;
>>> +     unsigned int in_size, out_size, drv_size, ksize;
>>> +     int nr = _IOC_NR(ucmd);
>>> +     int ret = 0;
>>> +
>>> +     if (nr >= ARRAY_SIZE(dma_heap_ioctl_cmds))
>>> +             return -EINVAL;
>>> +
>>> +     /* Get the kernel ioctl cmd that matches */
>>> +     kcmd = dma_heap_ioctl_cmds[nr];
>>
>>
>> Why do we need this indirection here and all the complexity below? I
>> know DRM ioctl does something like this but it has a massive table,
>> legacy ioctls, driver defined ioctls, etc..
>>
>> I don't expect we will ever need complex handling like this, could we
>> switch back to the more simple handler from v13?
> 
> I agree it does add complexity, but I'm not sure I see how to avoid
> some of this. The logic trying to handle that the user may pass a cmd
> that has the same _IOC_NR() as DMA_HEAP_IOC_ALLOC but not the same
> size. So the simple "switch(cmd) { case DMA_HEAP_IOC_ALLOC:" we had
> before won't work (as the cmd will be a different value).
> 


DMA_HEAP_IOC_ALLOC encodes everything we need, if the size is different
then the switch case will not match. It handled everything we have.


> Thus why I thought the cleanest approach would be to use the
> dma_heap_ioctl_cmds array to convert from whatever the user cmd is to
> the matching kernel cmd value.
> 


There are no kernel or user commands, just commands, they will match or
they are not valid. If someday we some need a variable sized ioctl then
we can deal with that then.

Andrew


> Do you have an alternative suggestion that I'm overlooking?
> 
> thanks
> -john
> 
