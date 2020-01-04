Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097F613028A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 14:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgADNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 08:50:54 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51855 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgADNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 08:50:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TmoWX7W_1578145843;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmoWX7W_1578145843)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jan 2020 21:50:45 +0800
Subject: Re: [PATCH] coccinelle: semantic patch to check for inappropriate
 do_div() calls
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Matthias Maennich <maennich@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
References: <20200104064448.24314-1-wenyang@linux.alibaba.com>
 <alpine.DEB.2.21.2001040759360.2636@hadrien>
 <7d9d8f10-7eb6-ffc3-5084-5ed1a08d4bcb@linux.alibaba.com>
 <alpine.DEB.2.21.2001040951450.2636@hadrien>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <b98d1f9e-a32f-7c85-996c-2c604a014af2@linux.alibaba.com>
Date:   Sat, 4 Jan 2020 21:50:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001040951450.2636@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/4 4:55 下午, Julia Lawall wrote:
> On Sat, 4 Jan 2020, Wen Yang wrote:
> 
>>
>>
>> On 2020/1/4 3:00 下午, Julia Lawall wrote:
>>> On Sat, 4 Jan 2020, Wen Yang wrote:
>>>
>>>> do_div() does a 64-by-32 division.
>>>> When the divisor is unsigned long, u64, or s64,
>>>> do_div() truncates it to 32 bits, this means it
>>>> can test non-zero and be truncated to zero for division.
>>>> This semantic patch is inspired by Mateusz Guzik's patch:
>>>> commit b0ab99e7736a ("sched: Fix possible divide by zero in avg_atom()
>>>> calculation")
>>>>
>>>> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
>>>> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
>>>> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
>>>> Cc: Nicolas Palix <nicolas.palix@imag.fr>
>>>> Cc: Michal Marek <michal.lkml@markovi.net>
>>>> Cc: Matthias Maennich <maennich@google.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: cocci@systeme.lip6.fr
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>    scripts/coccinelle/misc/do_div.cocci | 66
>>>> ++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 66 insertions(+)
>>>>    create mode 100644 scripts/coccinelle/misc/do_div.cocci
>>>>
>>>> diff --git a/scripts/coccinelle/misc/do_div.cocci
>>>> b/scripts/coccinelle/misc/do_div.cocci
>>>> new file mode 100644
>>>> index 0000000..f1b72d1
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/misc/do_div.cocci
>>>> @@ -0,0 +1,66 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/// do_div() does a 64-by-32 division.
>>>> +/// When the divisor is unsigned long, u64, or s64,
>>>> +/// do_div() truncates it to 32 bits, this means it
>>>> +/// can test non-zero and be truncated to zero for division.
>>>> +///
>>>> +//# This makes an effort to find those inappropriate do_div () calls.
>>>> +//
>>>> +// Confidence: Moderate
>>>> +// Copyright: (C) 2020 Wen Yang, Alibaba.
>>>> +// Comments:
>>>> +// Options: --no-includes --include-headers
>>>> +
>>>> +virtual context
>>>> +virtual org
>>>> +virtual report
>>>> +
>>>> +@depends on context@
>>>> +expression f;
>>>> +long l;
>>>> +unsigned long ul;
>>>> +u64 ul64;
>>>> +s64 sl64;
>>>> +
>>>> +@@
>>>> +(
>>>> +* do_div(f, l);
>>>> +|
>>>> +* do_div(f, ul);
>>>> +|
>>>> +* do_div(f, ul64);
>>>> +|
>>>> +* do_div(f, sl64);
>>>> +)
>>>> +
>>>> +@r depends on (org || report)@
>>>> +expression f;
>>>> +long l;
>>>> +unsigned long ul;
>>>> +position p;
>>>> +u64 ul64;
>>>> +s64 sl64;
>>>> +@@
>>>> +(
>>>> +do_div@p(f, l);
>>>> +|
>>>> +do_div@p(f, ul);
>>>> +|
>>>> +do_div@p(f, ul64);
>>>> +|
>>>> +do_div@p(f, sl64);
>>>> +)
>>>> +
>>>> +@script:python depends on org@
>>>> +p << r.p;
>>>> +@@
>>>> +
>>>> +msg="WARNING: WARNING: do_div() does a 64-by-32 division, which may
>>>> truncation the divisor to 32-bit"
>>>> +coccilib.org.print_todo(p[0], msg)
>>>> +
>>>> +@script:python depends on report@
>>>> +p << r.p;
>>>> +@@
>>>> +
>>>> +msg="WARNING: WARNING: do_div() does a 64-by-32 division, which may
>>>> truncation the divisor to 32-bit"
>>>> +coccilib.report.print_report(p[0], msg)
>>>
>>> A few small issues: You have WARNING: twice in each case, and truncation
>>> should be truncate.
>>>
>>
>> Thanks for your comments, we will fix it soon.
>>
>>> Is there any generic strategy for fixing these issues?
>>>
>>
>> We have done some experiments, such as:
>> https://lkml.org/lkml/2020/1/2/1354
> 
> Thanks.  Actually, I would appreciate knowing about such experiments when
> the semantic patch is submitted, since eg in this case I am not really an
> expert in this issue.
> 
>>
>> -	avg = rec->time;
>> -	do_div(avg, rec->counter);
>> +	avg = div64_ul(rec->time, rec->counter);
>>
>> --> Function replacement was performed here,
>>      and simple code cleanup was also performed.
>>
>>
>> -		do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
>> +		stddev = div64_ul(stddev,
>> +				  rec->counter * (rec->counter - 1) * 1000);
>>
>> --> Only the function replacement is performed here (because the variable
>> ‘stddev’ corresponds to a more complicated equation, cleaning it will reduce
>> readability).
> 
> Would it be reasonable to extend the warning to say "consider using
> div64_ul instead"?  Or do you think it is obvious to everyone?
> 

Thank you for your comments.
We plan to modify it as follows:
msg="WARNING: do_div() does a 64-by-32 division, please consider using 
div64_ul, div64_long, div64_u64 or div64_s64 instead."

>> In addition, there are some codes that do not need to be modified:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/can/dev.c#n263
> 
> Would it be worth having a special case for constants and checking whether
> the value is obviously safe and no warning is needed?
>
Thanks.
This is very valuable in reducing false positives, and we'll try to 
implement it.

--
Best Wishes,
Wen

>> So we just print a warning.
>> As for how to fix it, we need to analyze the code carefully.
>>
>> --
>> Best Wishes,
>> Wen
>>
>>
>>
> 
