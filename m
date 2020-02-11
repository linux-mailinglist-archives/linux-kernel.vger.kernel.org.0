Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB471158AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 08:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBKH71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 02:59:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbgBKH70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 02:59:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so5069802pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 23:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vgfeWj4AjQyurf0xeK1Z635NiCQf4E21yKLT1OZCOxI=;
        b=ri9VQfWjEpKz6UthsEkXDqvnC/vLM4tNXqWeNUw5XE4gn0yaVJfZkwQx4Sur/04JIb
         dRI4HjhUXnEFs97ZzjuEffQhpy0By2DTATHsRhkAXqVliZZ4fHIwvWPO5TnQeWDUnLZg
         TRdgI1Ei0NaaMFLHz8RAGH1G/K0sLzpTYyeoHEtYXyoujCLG0HHwpVteQX1xyBgglG0+
         mB94kh5J+PtLDyeXSmXcseUkKQaf9div3/bJktotIn/0JC76R+oUZmJMIuHKE35UF3fF
         QxxODrdCPPoiz3b3F+66ptTJbFyHIjbsYgGQ9LW4NL086BNGPr2bgIO54+RBmMXNQJWz
         7MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vgfeWj4AjQyurf0xeK1Z635NiCQf4E21yKLT1OZCOxI=;
        b=tDieHCPPS3QC3zHWM961cu6BU/GZbn5NoNb9o08v8EAfWFpSFNqW028kNqkOSC8GhM
         7pJKQfYd6uFJrknZG3kkcA8Xw9okoW3gg5qWcmEA5P0BFeKAkg+kSq5rxwums0jUboyn
         5GFzOwen5gGJKCbCbsxrQZpvLEa8MP7L81eKb3TvQjooYUOw8O4Uzi0mtcd2siUg87NP
         AonrGynBAn4bHVuE4LxDe2cwVfJHlNx/32oeetiMyse/xK9DwTQIyC6+gau4vXdW65q+
         /9PwquE/RV5yTHNGaFmfoscvbf9nOiF0gGWTsikSyLimCIeFd3YXXu3j75h7wwLkC7t3
         1DQg==
X-Gm-Message-State: APjAAAXnQxV1EBIRoUuJnJl19odXsoWMvieTSjnORn/gc0aaIFW5ahfw
        Ey8MIGgKR0FJIF9loeFxI5tAfg==
X-Google-Smtp-Source: APXvYqxCnM2bUDEVK6wbp7oZd2Lj9/7Nk8QoUV2401OvplRSyHu/dvSNfD4xv8uaAlqj8fId4WKGtQ==
X-Received: by 2002:a63:8743:: with SMTP id i64mr1818578pge.243.1581407966063;
        Mon, 10 Feb 2020 23:59:26 -0800 (PST)
Received: from [10.96.0.154] ([45.135.186.96])
        by smtp.gmail.com with ESMTPSA id s14sm2573821pgv.74.2020.02.10.23.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 23:59:25 -0800 (PST)
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
 <20200210233711.GA1787983@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <837da172-1ec7-d077-bf54-18d620b1d3bb@linaro.org>
Date:   Tue, 11 Feb 2020 15:59:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210233711.GA1787983@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/11 上午7:37, Greg Kroah-Hartman wrote:
> On Wed, Jan 15, 2020 at 10:12:46PM +0800, Zhangfei Gao wrote:
>> From: Kenneth Lee <liguozhu@hisilicon.com>
>>
>> Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
>> provide Shared Virtual Addressing (SVA) between accelerators and processes.
>> So accelerator can access any data structure of the main cpu.
>> This differs from the data sharing between cpu and io device, which share
>> only data content rather than address.
>> Since unified address, hardware and user space of process can share the
>> same virtual address in the communication.
>>
>> Uacce create a chrdev for every registration, the queue is allocated to
>> the process when the chrdev is opened. Then the process can access the
>> hardware resource by interact with the queue file. By mmap the queue
>> file space to user space, the process can directly put requests to the
>> hardware without syscall to the kernel space.
>>
>> The IOMMU core only tracks mm<->device bonds at the moment, because it
>> only needs to handle IOTLB invalidation and PASID table entries. However
>> uacce needs a finer granularity since multiple queues from the same
>> device can be bound to an mm. When the mm exits, all bound queues must
>> be stopped so that the IOMMU can safely clear the PASID table entry and
>> reallocate the PASID.
>>
>> An intermediate struct uacce_mm links uacce devices and queues.
>> Note that an mm may be bound to multiple devices but an uacce_mm
>> structure only ever belongs to a single device, because we don't need
>> anything more complex (if multiple devices are bound to one mm, then
>> we'll create one uacce_mm for each bond).
>>
>>          uacce_device --+-- uacce_mm --+-- uacce_queue
>>                         |              '-- uacce_queue
>>                         |
>>                         '-- uacce_mm --+-- uacce_queue
>>                                        +-- uacce_queue
>>                                        '-- uacce_queue
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
>> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Looks much saner now, thanks for all of the work on this:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Or am I supposed to take this in my tree?  If so, I can, but I need an
> ack for the crypto parts.
>
>
That's Great, thanks Greg.

For the convenience, I rebase the patchset on 5.6-rc1.
Not sure is there any conflict to crypto tree.
How about just pick the uacce part, patch 1 , 2.
We can resend the crypto part to crypto tree.

Thanks

