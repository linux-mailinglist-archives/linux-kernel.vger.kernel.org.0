Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9899315359A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBEQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 11:52:45 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43085 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEQwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:52:45 -0500
Received: by mail-il1-f195.google.com with SMTP id o13so2413750ilg.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kVisYlHjgDUQz0luYS84AW0y0CIaKZqaVDGoqmEU6RU=;
        b=MmkLrMyyfoG1gUTS6tU9ThTU5hElGpTSBw5TLQSunm+iTehLGMOSzK65m7NuWKWFv9
         9BDLpQAHhv46s3uKYsqjlZXYlJDx2FoXPG6pOvTQQDkQfqrVBjq4vpBKmGB0b5k2ODlf
         mq2ysYDet++HKskxbQXDccCD/EdxHQSNAcEebQ73o3DkqP5BrZAb1fWwiImcSR56NAKi
         3YnVwMGdFYib9GUI6YfdsRq3qZjhkcEfcQx9IkZye0tEFjJ2DxtqjmtkfoiAHAogbRWA
         pyPfCctu+VwDTqL1UlF4LzK+9eCNAPAy2vChIAJRL+L9pBZEIm53gZuRzKY2vgfHilPY
         vI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kVisYlHjgDUQz0luYS84AW0y0CIaKZqaVDGoqmEU6RU=;
        b=f73g478QRbgtBavcbZPpFPOHExHVIG0xSx2k06MF0VMpS34/Co/embi+HO6yijqHwv
         /jwMkGkkGD5q+QXJWcKCg2dyyBdwqT5aRszWZmQvy1Ws3QdUfGoorjzm4TqJjNszyaD0
         Tlk89PDAehgUlQr659fbwDVX67J23QVRVmeH4UpzBY9rEVLHT2mj6PQ2Nda8L5+l/WX4
         6ph64pQ8CfekfIGhifpwlM3pcVbJ91qoierl05dWgxaGwTnh5VXqBgT9doTpE5YkSoih
         GhQG1T5l1pI8c7ZDEQNdNmYnWESkXMAhmQU06Amxr6KuCLY6eXFLYOWKqK87AdkDdn07
         WE8g==
X-Gm-Message-State: APjAAAXtsH6J/xSY72DvY8cWAEEBHVTb+CNoctO8/9Gw7xqLxTKmUuJf
        a40yxQw/hwQ4q7y1e1ylEAnB5a3i518=
X-Google-Smtp-Source: APXvYqyjKlq3/gWCB7sCS+DZSxiGGmEJ6N0g9df1NfetAcfyAepGVSobi+rCOfJ4px4cKUlcsRIk0Q==
X-Received: by 2002:a92:d9ce:: with SMTP id n14mr27423896ilq.25.1580921562847;
        Wed, 05 Feb 2020 08:52:42 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q90sm40606ili.27.2020.02.05.08.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 08:52:42 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix mm use with IORING_OP_{READ,WRITE}
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <951bb84c8337aaac7654261a21b03506b2b8a001.1580914723.git.asml.silence@gmail.com>
 <df11c48e-f456-3b64-88d1-6012b1ac2bc8@kernel.dk>
 <d9a15d32-a20b-a20f-9ea4-3ac355c15bb2@gmail.com>
 <c6cc1e97-f306-e3f0-3f7b-9463fdbbc5a5@kernel.dk>
 <d55fd4dc-e7f1-0f06-76bb-0e29c1db4995@kernel.dk>
 <62e33e81-7857-fb5c-92be-6757623a6478@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe6ea91c-ad4a-092f-e98c-6ba233304636@kernel.dk>
Date:   Wed, 5 Feb 2020 09:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <62e33e81-7857-fb5c-92be-6757623a6478@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 9:50 AM, Pavel Begunkov wrote:
> On 05/02/2020 19:16, Jens Axboe wrote:
>> On 2/5/20 9:05 AM, Jens Axboe wrote:
>>> On 2/5/20 9:02 AM, Pavel Begunkov wrote:
>>>> On 05/02/2020 18:54, Jens Axboe wrote:
>>>>> On 2/5/20 8:46 AM, Pavel Begunkov wrote:
>>>>>> IORING_OP_{READ,WRITE} need mm to access user buffers, hence
>>>>>> req->has_user check should go for them as well. Move the corresponding
>>>>>> imports past the check.
>>>>>
>>>>> I'd need to double check, but I think the has_user check should just go.
>>>>> The import checks for access anyway, so we'll -EFAULT there if we
>>>>> somehow messed up and didn't acquire the right mm.
>>>>>
>>>> It'd be even better. I have plans to remove it, but I was thinking from a
>>>> different angle.
>>>
>>> Let me just confirm it in practice, but it should be fine. Then we can just
>>> kill it.
>>
>> OK now I remember - in terms of mm it's fine, we'll do the right thing.
>> But the iov_iter_init() has this gem:
>>
>> 	/* It will get better.  Eventually... */
>> 	if (uaccess_kernel()) {
>> 		i->type = ITER_KVEC | direction;
>> 		i->kvec = (struct kvec *)iov;
>> 	} else {
>> 		i->type = ITER_IOVEC | direction;
>> 		i->iov = iov;
>> 	}
>>
>> which means that if we haven't set USER_DS, then iov_iter_init() will
>> magically set the type to ITER_KVEC which then crashes when the iterator
>> tries to copy.
>>
>> Which is pretty lame. How about a patch that just checks for
>> uaccess_kernel() and -EFAULTs if true for the non-fixed variants where
>> we don't init the iter ourselves? Then we can still kill req->has_user
>> and not have to fill it in.
>>
>>
> On the other hand, we don't send requests async without @mm. So, if we fail them
> whenever can't grab mm, it solves all the problems even without extra checks.
> What do you think?

I agree, the check is/was just there as a safe guard, it's not really
needed.

-- 
Jens Axboe

