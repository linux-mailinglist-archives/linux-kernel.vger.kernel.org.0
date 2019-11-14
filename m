Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60962FC9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 16:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKNPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 10:19:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44193 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:19:31 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so7151196ioo.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDdQmYavPXfwAMVihcceAngcVZVudc5stPylZ/TzqA4=;
        b=KW8h3Za2bC42GqVYn+81yUge003EoXRT6bhf3lE2zZrul4V+Gkvzwr017Ci3NlD1CT
         iCxfP5AZIwtMZ2dyTQwlJhi2TMfa9d9FQMfXg+3JCOXBbQKWSX3NoKh6yQxVi+LQyqQU
         T2N39MKmqmYxrPGzwUHe2g1dS+xzYRd6HI3TZpRz93G9TLB+dZMcdZNJ48JgOGhCDVMd
         8sJc/8StxjsboVRGCFYQgTnqg9KrhjhZaqBUXYC5LnCkAncavzLwdq1z/1OxE0YkmFb3
         cdFL1kIaLDqTkiDk9aShO5sZHdEGjwb9lm3oXOxpefxZw+uxHKRopTRM9TpIVNXVibuV
         DdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDdQmYavPXfwAMVihcceAngcVZVudc5stPylZ/TzqA4=;
        b=NhDiObnS9o/3sk6rzsJlODB4kdzNoDwF3ziNNCNUd6gn9dosLHQRXaA4STbNut1EPg
         xiOemXlHWTGZFlDzY/XViRb5/hKjZCUJTK9foX9tdfB9pD1o0YQBimjMnizK3UrAUXnT
         kiZohvCGaxiEds2MuZR1Hc+wuDspdsnnRPwcNIwkf2HD0tfWS6kMU9AlzMGAS5FEIn2i
         oyxKD0Zm9rKVskn0RKwh8vN102/2NcqS8lzJtpJOGScv+w7s7kq/XXylQJEo0wl5Bb5m
         jlsmlvhL9XbiZk8Dv+sr5SynIxyC2DuJ5n15UOtdQP3vM05VfwT2c5Lqulz9KyKyOknO
         uCqw==
X-Gm-Message-State: APjAAAVmq6KHFPv+ZS5wzz4Dn8C0H5na8cU5x8dHYkEzidO9TVZSaozd
        wAenSRPwgas0amBaJsIkv47B8A==
X-Google-Smtp-Source: APXvYqwOocapzh/vXy7B7ZyJ8zCjfx/xWNzIdTKhoK/SsGvYxKriRPokthX4D8cafUhLCmR42mesbQ==
X-Received: by 2002:a6b:7f43:: with SMTP id m3mr9135039ioq.72.1573744768914;
        Thu, 14 Nov 2019 07:19:28 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm531229iof.61.2019.11.14.07.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:19:28 -0800 (PST)
Subject: Re: [PATCH BUGFIX V2 0/1] block, bfq: deschedule empty bfq_queues not
 referred by any process
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com
References: <20191114093311.47877-1-paolo.valente@linaro.org>
 <0cb0a853-e036-9884-5681-f4617de5c662@kernel.dk>
 <A2E68F00-EFEA-428E-A6C1-267E57450FF6@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc6d7197-2021-f86a-440a-c1d9c11ce191@kernel.dk>
Date:   Thu, 14 Nov 2019 08:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <A2E68F00-EFEA-428E-A6C1-267E57450FF6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 8:14 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 14 nov 2019, alle ore 15:02, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> On 11/14/19 2:33 AM, Paolo Valente wrote:
>>> Hi Jens,
>>> change from V1: added check to correctly work only on bfq-queues
>>> scheduled for service, and not on in-service bfq-queues (it makes no
>>> sense, and it creates inconsistencies, to deschedule an in-service
>>> bfq-queue).
>>>
>>> Differently from V1, which was still under test when I submitted it,
>>> this version has already been tested, by those who reported V1's
>>> failures.
>>
>> I'm a bit miffed that you'd send out a patch for an issue, this late
>> in the cycle, and then it not being tested at all. That's not very
>> confidence inspiring. I have applied this one, just letting you know
>> that that is not acceptable at all.
>>
> 
> I'm sorry for irritating you.  Yet I don't fully get your point.  I
> have sent this fix now, simply because this bug was found ten days
> ago, and I've tried to fix it as soon as possible.  I did test my
> patch before sending it.  As for public testing, how could Oleksandr
> or any other user/dev have had a chance to test this patch if I had
> not submitted it here?

If that's the case, then make it clear that you don't expect it to
be merged right now. As it stands, when you sent it out, all I know is
that it's an issue that's crashing current kernels, and we're winding
down this release. Hence there's a sense of urgency there, as we
could be releasing this kernel as soon as this weekend.

If you have a potential fix, but it isn't tested yet, then make that
clear by submitting it as an RFC. You'd say something like:

"This is a potential fix for X/Y/Z, let's wait for the original reporters
to verify this before including it."

And make that clear with RFC in the subject line. Your patch had none
of that, in fact it said:

[PATCH BUGFIX]

and the commit message had no references to this needing any further
testing.

-- 
Jens Axboe

