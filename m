Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A513C50B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgAOOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:12:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37456 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAOOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:12:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so8276343pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PZek3JGPM1vXB2nTvmi63D8QiO8eK/60hwb1CSbq930=;
        b=mPVqOGeYhibIz9TGnzp4p1VCd9JkC2Rm2C0Xqqm9UHzT+6ttTYLT0iFoV+yYK98/+d
         EGpDbXADOPsqKFki2p0OzWLFtudEI/SDRpUJwrwTGqcPuTHUn9NggrqGXiz2/LK/gmbN
         EmIVATJAxSbIgSHWe0mK/iacaZE6xoF2MNjPLLN984R9BTh0bAgkw3TinfrVOnIU2Chx
         jbCjJx0hPXVPVcczP3EH26HxrdG1DZkIRx+faOrIVzZz1UKdkgFpPpSXgr12FsKWUA2b
         6tiSi+6HwAlpHpco7T4gsLLLtFWFPBqDz6JUdruy8UvrcMZiVNcZg1PyLe6b448TKWR2
         Q/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PZek3JGPM1vXB2nTvmi63D8QiO8eK/60hwb1CSbq930=;
        b=n7J3vBgJOY0BsEOMJ+fO/sUF0oyxJuHI1sjJ9PyzLuxh79XZNMO06mvOvxo2Ep1KMh
         ErO2+v4JOB8oSnZSqyZ+tlHaAx7KK6PzltaCXHFc7pp9pPtRgbTn3Vs+8kWgChxJ7oXO
         PdFNBrhltUAPm3Z1fCijyfD6uEJHCiiLthmyAMfEwpsWAnAXi956CF+N+8s1csbxwVAX
         j6P0Zw7IQsIjF3yFLkNzgiPRl3DuhwQe1DGb8i56tW3qR0FaMnOKe+1kcM0XO3qSZ2ZA
         DXqc7jcfrC3xKo6hU2cTnuc5c1Y1WOvdctEBSt6H8xWt6tE1cxRU2bacFu1OsAyV52Hh
         JNwg==
X-Gm-Message-State: APjAAAUUn6Oejc8cN4zcOxX5nzsQ5aiYft/qVxZ4Y0eZYB8ZthUtpni3
        jONeVWKtAH/d/s1SGCZjNwSUzw==
X-Google-Smtp-Source: APXvYqz+1fhv2oIu7Q5NUTfjg997nHzUmXRYm0zUtyv5oSL0Ta9WdziTT+AWV3WUL5Qiv6W9AEjtdQ==
X-Received: by 2002:a63:201d:: with SMTP id g29mr34399921pgg.427.1579097536592;
        Wed, 15 Jan 2020 06:12:16 -0800 (PST)
Received: from [10.60.0.74] ([104.238.63.136])
        by smtp.gmail.com with ESMTPSA id z30sm20954447pff.131.2020.01.15.06.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 06:12:15 -0800 (PST)
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
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
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
 <20200114145934.GA1960403@kroah.com>
 <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
 <20200115120212.GA3270387@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <750bb4b6-20a9-96b0-5801-5b8bff8cc3b5@linaro.org>
Date:   Wed, 15 Jan 2020 22:11:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200115120212.GA3270387@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/15 下午8:02, Greg Kroah-Hartman wrote:
> On Wed, Jan 15, 2020 at 07:18:34PM +0800, zhangfei wrote:
>> Hi, Greg
>>
>> On 2020/1/14 下午10:59, Greg Kroah-Hartman wrote:
>>> On Mon, Jan 13, 2020 at 11:34:55AM +0800, zhangfei wrote:
>>>> Hi, Greg
>>>>
>>>> Thanks for the review.
>>>>
>>>> On 2020/1/12 上午3:40, Greg Kroah-Hartman wrote:
>>>>> On Sat, Jan 11, 2020 at 10:48:37AM +0800, Zhangfei Gao wrote:
>>>>>> +static int uacce_fops_open(struct inode *inode, struct file *filep)
>>>>>> +{
>>>>>> +	struct uacce_mm *uacce_mm = NULL;
>>>>>> +	struct uacce_device *uacce;
>>>>>> +	struct uacce_queue *q;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	uacce = xa_load(&uacce_xa, iminor(inode));
>>>>>> +	if (!uacce)
>>>>>> +		return -ENODEV;
>>>>>> +
>>>>>> +	if (!try_module_get(uacce->parent->driver->owner))
>>>>>> +		return -ENODEV;
>>>>> Why are you trying to grab the module reference of the parent device?
>>>>> Why is that needed and what is that going to help with here?
>>>>>
>>>>> This shouldn't be needed as the module reference of the owner of the
>>>>> fileops for this module is incremented, and the "parent" module depends
>>>>> on this module, so how could it be unloaded without this code being
>>>>> unloaded?
>>>>>
>>>>> Yes, if you build this code into the kernel and the "parent" driver is a
>>>>> module, then you will not have a reference, but when you remove that
>>>>> parent driver the device will be removed as it has to be unregistered
>>>>> before that parent driver can be removed from the system, right?
>>>>>
>>>>> Or what am I missing here?
>>>> The refcount here is preventing rmmod "parent" module after fd is opened,
>>>> since user driver has mmap kernel memory to user space, like mmio, which may
>>>> still in-use.
>>>>
>>>> With the refcount protection, rmmod "parent" module will fail until
>>>> application free the fd.
>>>> log like: rmmod: ERROR: Module hisi_zip is in use
>>> But if the "parent" module is to be unloaded, it has to unregister the
>>> "child" device and that will call the destructor in here and then you
>>> will tear everything down and all should be good.
>>>
>>> There's no need to "forbid" a module from being unloaded, even if it is
>>> being used.  Look at all networking drivers, they work that way, right?
>> Thanks Greg for the kind suggestion.
>>
>> I still have one uncertainty.
>> Does uacce has to block process continue accessing the mmapped area when
>> remove "parent" module?
>> Uacce can block device access the physical memory when parent module call
>> uacce_remove.
>> But application is still running, and suppose it is not the kernel driver's
>> responsibility to call unmap.
>>
>> I am looking for some examples in kernel,
>> looks vfio does not block process continue accessing when
>> vfio_unregister_iommu_driver either.
>>
>> In my test, application will keep waiting after rmmod parent, until ctrl+c,
>> when unmap is called.
>> During the process, kernel does not report any error.
>>
>> Do you have any advice?
> Is there no way for the kernel to invalidate the memory and tell the
> process to stop?  tty drivers do this for when they are removed from the
> system.
>
> Anyway, this is all very rare, no kernel module is ever unloaded on a
> real system, that is only for when developers are working on them, so
> it's probably not that big of an issue, right?
>
Thanks Greg, will update a new version while ignoring this first.

Thanks

