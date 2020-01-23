Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D7414731E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAWV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 16:27:18 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40255 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:27:18 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so38778ilo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rlz3hvUu+9u2oNJYG4g2Rw59Iz8hixxTpHD2vCOcLXo=;
        b=PwBvHXWcPbHsFtHuoq3AUL5vFUZnWEbflYLFA0fa+kpnrYlFYyZ0WNPhmm0JH5IX20
         wOJlpK/ta+WU/QC7YYY/nAK98YO4OkEzz+mMqfx2W1MeL5DIBZGjjs2GThFWLbmP4ZXO
         BWndEWvmKE617UUJcuQWCt1gg1wDNoy4ZugQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rlz3hvUu+9u2oNJYG4g2Rw59Iz8hixxTpHD2vCOcLXo=;
        b=H7y0+0+jgHLxp7cLT7toRm+yEi0dmrKaIfgTDQb05lCYmpMemi833jMOOkZbVcoT/D
         QQB1JUDaG9ViGcglDczICJdUcLbPVBO+RxaYBXIOWA6aR4AFpJ+DE9r7TTHoDE9Ue5Uy
         6c8nk3XpR/BOHDbdJPXSporfA7uGL5Lh9uRb5UGd3fODT2wHEB4wkbbeeqet9pjGJBFy
         tT9Sgh8RW/+LmzI15UYtqLqb0YmbH+X98uVQrQBCe9FD/DIEmArItGddcFEB4qI1n78H
         brn6Vh1OslAPVrbsM2D31Tcy7XZ+zdYSyTs5T1d5zsU+ly553TerG9XLMknJ6sQhE29V
         tmfQ==
X-Gm-Message-State: APjAAAXoth0PIlCtxbSUO7qpjZuc1b3Mc4ayc+dBWzog6hKyH4jWYhbS
        QUxMfZS1MTTyaLTNTfTsRFAm1Q==
X-Google-Smtp-Source: APXvYqzlBlohdIzyH1fQ7g2B5f1t9VHWWDYOQC2BgsHZYkufZHxwNvX/yEX1sbKHcfdWI3OzYGhGPQ==
X-Received: by 2002:a05:6e02:cc5:: with SMTP id c5mr249989ilj.47.1579814837406;
        Thu, 23 Jan 2020 13:27:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i11sm701592ion.1.2020.01.23.13.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 13:27:16 -0800 (PST)
Subject: Re: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200114151220.29578-1-skhan@linuxfoundation.org>
 <20200117100829.GE15760@8bytes.org>
 <42c0a806-9947-1401-9754-8aa88bd7062f@amd.com>
 <24a46b0f-33d7-5f94-661a-80f035213892@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d7b8aa31-ded5-082e-0324-91b6277507ba@linuxfoundation.org>
Date:   Thu, 23 Jan 2020 14:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24a46b0f-33d7-5f94-661a-80f035213892@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 8:32 AM, Shuah Khan wrote:
> On 1/20/20 7:10 PM, Suravee Suthikulpanit wrote:
>> On 1/17/2020 5:08 PM, Joerg Roedel wrote:
>>> Adding Suravee, who wrote the IOMMU Perf Counter code.
>>>
>>> On Tue, Jan 14, 2020 at 08:12:20AM -0700, Shuah Khan wrote:
>>>> init_iommu_perf_ctr() clobbers the register when it checks write access
>>>> to IOMMU perf counters and fails to restore when they are writable.
>>>>
>>>> Add save and restore to fix it.
>>>>
>>>> Signed-off-by: Shuah Khan<skhan@linuxfoundation.org>
>>>> ---
>>>>   drivers/iommu/amd_iommu_init.c | 22 ++++++++++++++++------
>>>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>> Suravee, can you please review this patch?
>>>
>>
>> This looks ok. Does this fix certain issues? Or is this just for sanity.
> 
> I didn't notice any problems. Counters aren't writable on my system.
> However, it certainly looks like a bog since registers aren't restored
> like in other places in this file where such checks are done on other
> registers.
> 
> I see 2 banks and 4 counters on my system. Is it sufficient to check
> the first bank and first counter? In other words, if the first one
> isn't writable, are all counters non-writable?
> 
> Should we read the config first and then, try to see if any of the
> counters are writable? I have a patch that does that, I can send it
> out for review.
> 
>>
>> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Joerg,

Please don't pull this in. I introduced a bug in this patch. It always
returns amd_iommu_pc_present false even when it can write to the
counters. My bad.

I will send v2.

thanks,
-- Shuah
