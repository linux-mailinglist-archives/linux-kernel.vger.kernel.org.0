Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5EA14AA9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 20:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgA0TjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 14:39:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35222 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0TjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:39:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so4125086plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 11:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wL2DenFfwzv9tqkfb30dy8DecNCbnJ/iC87Go+JzFAU=;
        b=n+i4eARyp6P1blXQKgGthk/op91I5jEIqD70kjMWtL8I8xSp5Srze+JqYP4l1vvsJv
         T96vdJgh+X8l56q7YEnMmDKi0YN0nl91qZDKjNMApbhYe1fE/+bOi9NExowCdOewn2GM
         dunbjrrfJqY1P5hdNfagzU5UNHh4R6VjwUR0xIDrw8o600VQOpmXmwpUCJ2YsK1mTCLZ
         HzqNHWTzwQ961Ngu/XR0j3bWoQx26JzdAzT42CO6WF1Et7WGYT/zE6MYxUvRv+KOrD69
         mt1L0oQ1ZQxU4nNLOS3Kda1yFKlHWN225HoF0A0XYNW5D3GYGVxpzTHqsGESdiRm2yTw
         L3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wL2DenFfwzv9tqkfb30dy8DecNCbnJ/iC87Go+JzFAU=;
        b=a+0r8w6YnBeLlKmJ0Q6MSNZARreQRE885lHooOsSIYMHV+Jf0FTgjLH2CEQOrX0elI
         CWeEjgwslHt4JhBtg5vxKbz1SvWZrpPeroLrTAhqw64RDTJWWnPIF8FCjHfwPpbh7G1b
         6MGSxceEh3TFHduNuvxB6Q9ZADOthC4sFn9T9hh++qkIsiYFQonv7JVnqaAFVMN9TQE4
         3aT0z22+juWOm+lLnjdwKoKx46C054Fmjg3W+eqkfYcguhYsDtfuNcm+Emm4GuCofoCG
         o7VS584MVd82kWOPb5xJxNkcoia+8Qug7r+YtK4/gg1sdJFG3c1Mqj6M0bUwdfIO2V4I
         VCoQ==
X-Gm-Message-State: APjAAAVjAKfvq/HGjrxNjer9XFkr6XeKH3PKtlW7bXZ7rWGOpALtkxt7
        LVgyLerwW0rHaxYWXb/fr1LzCg==
X-Google-Smtp-Source: APXvYqy7lgOUREckJf6S0ITGjHdH0mKxqYkv2EVTbTDR3MuuG718x6vgdL/bpge1IMTdbctl0JI0Gg==
X-Received: by 2002:a17:90a:ead3:: with SMTP id ev19mr286376pjb.80.1580153946321;
        Mon, 27 Jan 2020 11:39:06 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1133::11c2? ([2620:10d:c090:180::dec1])
        by smtp.gmail.com with ESMTPSA id b24sm16548399pfo.55.2020.01.27.11.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 11:39:05 -0800 (PST)
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Stefan Bader <stefan.bader@canonical.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Tyler Hicks <tyler.hicks@canonical.com>,
        Alasdair Kergon <agk@redhat.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
 <20200123103541.GA28102@redhat.com> <20200123172816.GA31063@redhat.com>
 <81055166-37fb-ad65-6a53-11c22c626ab1@kernel.dk>
 <20200127193225.GA5065@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <988c930f-b4ee-6387-e1b4-6bfe7af9bcaf@kernel.dk>
Date:   Mon, 27 Jan 2020 12:39:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127193225.GA5065@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/20 12:32 PM, Mike Snitzer wrote:
> On Thu, Jan 23 2020 at  1:52pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 1/23/20 10:28 AM, Mike Snitzer wrote:
>>> On Thu, Jan 23 2020 at  5:35am -0500,
>>> Mike Snitzer <snitzer@redhat.com> wrote:
>>>
>>>> On Thu, Jan 23 2020 at  4:17am -0500,
>>>> Stefan Bader <stefan.bader@canonical.com> wrote:
>>>>
>>>>> When device-mapper adapted for multi-queue functionality, they
>>>>> also re-organized the way the make-request function was set.
>>>>> Before, this happened when the device-mapper logical device was
>>>>> created. Now it is done once the mapping table gets loaded the
>>>>> first time (this also decides whether the block device is request
>>>>> or bio based).
>>>>>
>>>>> However in generic_make_request(), the request function gets used
>>>>> without further checks and this happens if one tries to mount such
>>>>> a partially set up device.
>>>>>
>>>>> This can easily be reproduced with the following steps:
>>>>>  - dmsetup create -n test
>>>>>  - mount /dev/dm-<#> /mnt
>>>>>
>>>>> This maybe is something which also should be fixed up in device-
>>>>> mapper.
>>>>
>>>> I'll look closer at other options.
>>>>
>>>>> But given there is already a check for an unset queue
>>>>> pointer and potentially there could be other drivers which do or
>>>>> might do the same, it sounds like a good move to add another check
>>>>> to generic_make_request_checks() and to bail out if the request
>>>>> function has not been set, yet.
>>>>>
>>>>> BugLink: https://bugs.launchpad.net/bugs/1860231
>>>>
>>>> >From that bug;
>>>> "The currently proposed fix introduces no chance of stability
>>>> regressions. There is a chance of a very small performance regression
>>>> since an additional pointer comparison is performed on each block layer
>>>> request but this is unlikely to be noticeable."
>>>>
>>>> This captures my immediate concern: slowing down everyone for this DM
>>>> edge-case isn't desirable.
>>>
>>> SO I had a look and there isn't anything easier than adding the proposed
>>> NULL check in generic_make_request_checks().  Given the many
>>> conditionals in that  function.. what's one more? ;)
>>>
>>> I looked at marking the queue frozen to prevent IO via
>>> blk_queue_enter()'s existing cheeck -- but that quickly felt like an
>>> abuse, especially in that there isn't a queue unfreeze for bio-based.
>>>
>>> Jens, I'll defer to you to judge this patch further.  If you're OK with
>>> it: cool.  If not, I'm open to suggestions for how to proceed.  
>>>
>>
>> It does kinda suck... The generic_make_request_checks() is a mess, and
>> this doesn't make it any better. Any reason why we can't solve this
>> two step setup in a clean fashion instead of patching around it like
>> this? Feels like a pretty bad hack, tbh.
> 
> I just staged the following DM fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.6&id=28a101d6b344f5a38d482a686d18b1205bc92333

I like that a lot more than the NULL check in the core.

-- 
Jens Axboe

