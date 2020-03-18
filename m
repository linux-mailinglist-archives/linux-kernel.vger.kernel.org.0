Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7E189375
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 02:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCRBJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 21:09:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgCRBJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:09:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F08B0236845E1D675B1F;
        Wed, 18 Mar 2020 09:09:18 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 18 Mar 2020
 09:09:14 +0800
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
To:     Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     NeilBrown <neilb@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20200308140314.GQ5972@shao2-debian>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name>
 <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name>
 <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
 <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
 <877dznu0pk.fsf@notabene.neil.brown.name>
 <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
 <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
 <87pndcsxc6.fsf@notabene.neil.brown.name>
 <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
 <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
 <7c8d3752-6573-ab83-d0af-f3dd4fc373f5@huawei.com>
 <6df79609-90eb-2f59-7e86-3532ac309a7a@huawei.com>
 <61d6b91e9387969f5dfaba192aee366cc9b310f0.camel@kernel.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <79d65a56-5281-502f-8d8f-568e082cacf4@huawei.com>
Date:   Wed, 18 Mar 2020 09:09:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <61d6b91e9387969f5dfaba192aee366cc9b310f0.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/18 0:07, Jeff Layton wrote:
> On Tue, 2020-03-17 at 22:05 +0800, yangerkun wrote:
>>
>> On 2020/3/17 9:41, yangerkun wrote:
>>>
>>> On 2020/3/17 1:26, Linus Torvalds wrote:
>>>> On Mon, Mar 16, 2020 at 4:07 AM Jeff Layton <jlayton@kernel.org> wrote:
>>>>>
>>>>> +       /*
>>>>> +        * If fl_blocker is NULL, it won't be set again as this
>>>>> thread "owns"
>>>>> +        * the lock and is the only one that might try to claim the
>>>>> lock.
>>>>> +        * Because fl_blocker is explicitly set last during a delete,
>>>>> it's
>>>>> +        * safe to locklessly test to see if it's NULL. If it is,
>>>>> then we know
>>>>> +        * that no new locks can be inserted into its
>>>>> fl_blocked_requests list,
>>>>> +        * and we can therefore avoid doing anything further as long
>>>>> as that
>>>>> +        * list is empty.
>>>>> +        */
>>>>> +       if (!smp_load_acquire(&waiter->fl_blocker) &&
>>>>> +           list_empty(&waiter->fl_blocked_requests))
>>>>> +               return status;
>>>>
>>>> Ack. This looks sane to me now.
>>>>
>>>> yangerkun - how did you find the original problem?\
>>>
>>> While try to fix CVE-2019-19769, add some log in __locks_wake_up_blocks
>>> help me to rebuild the problem soon. This help me to discern the problem
>>> soon.
>>>
>>>> Would you mind using whatever stress test that caused commit
>>>> 6d390e4b5d48 ("locks: fix a potential use-after-free problem when
>>>> wakeup a waiter") with this patch? And if you did it analytically,
>>>> you're a champ and should look at this patch too!
>>>
>>> I will try to understand this patch, and if it's looks good to me, will
>>> do the performance test!
>>
>> This patch looks good to me, with this patch, the bug '6d390e4b5d48
>> ("locks: fix a potential use-after-free problem when wakeup a waiter")'
>> describes won't happen again. Actually, I find that syzkaller has report
>> this bug before[1], and the log of it can help us to reproduce it with
>> some latency in __locks_wake_up_blocks!
>>
>> Also, some ltp testcases describes in [2] pass too with the patch!
>>
>> For performance test, I have try to understand will-it-scale/lkp, but it
>> seem a little complex to me, and may need some more time. So, Rong Chen,
>> can you help to do this? Or the results may come a little later...
>>
>> Thanks,
>> ----
>> [1] https://syzkaller.appspot.com/bug?extid=922689db06e57b69c240
>> [2] https://lkml.org/lkml/2020/3/11/578
> 
> Thanks yangerkun. Let me know if you want to add your Reviewed-by tag.

Yeah, you can add:

Reviewed-by: yangerkun <yangerkun@huawei.com>

> 
> Cheers,
> 

