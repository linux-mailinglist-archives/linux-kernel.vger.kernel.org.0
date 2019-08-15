Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83B8E438
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 06:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfHOEv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 00:51:59 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60229 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfHOEv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:51:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TZWDJRR_1565844709;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TZWDJRR_1565844709)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Aug 2019 12:51:52 +0800
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
 <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
 <20190809180238.GS18351@dhcp22.suse.cz>
 <79c90f6b-fcac-02e1-015a-0eaa4eafdf7d@linux.alibaba.com>
 <fb1f4958-5147-2fab-531f-d234806c2f37@linux.alibaba.com>
 <20190812093430.GD5117@dhcp22.suse.cz>
 <297aefa2-ba64-cb91-d2c8-733054db01a3@linux.alibaba.com>
 <20190814110850.GT17933@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a8005ff4-4749-8c71-ee4e-7ebda5c49de6@linux.alibaba.com>
Date:   Wed, 14 Aug 2019 21:51:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190814110850.GT17933@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/19 4:08 AM, Michal Hocko wrote:
> On Mon 12-08-19 10:00:17, Yang Shi wrote:
>>
>> On 8/12/19 2:34 AM, Michal Hocko wrote:
>>> On Fri 09-08-19 16:54:43, Yang Shi wrote:
>>>> On 8/9/19 11:26 AM, Yang Shi wrote:
>>>>> On 8/9/19 11:02 AM, Michal Hocko wrote:
>>> [...]
>>>>>> I have to study the code some more but is there any reason why those
>>>>>> pages are not accounted as proper THPs anymore? Sure they are partially
>>>>>> unmaped but they are still THPs so why cannot we keep them accounted
>>>>>> like that. Having a new counter to reflect that sounds like papering
>>>>>> over the problem to me. But as I've said I might be missing something
>>>>>> important here.
>>>>> I think we could keep those pages accounted for NR_ANON_THPS since they
>>>>> are still THP although they are unmapped as you mentioned if we just
>>>>> want to fix the improper accounting.
>>>> By double checking what NR_ANON_THPS really means,
>>>> Documentation/filesystems/proc.txt says "Non-file backed huge pages mapped
>>>> into userspace page tables". Then it makes some sense to dec NR_ANON_THPS
>>>> when removing rmap even though they are still THPs.
>>>>
>>>> I don't think we would like to change the definition, if so a new counter
>>>> may make more sense.
>>> Yes, changing NR_ANON_THPS semantic sounds like a bad idea. Let
>>> me try whether I understand the problem. So we have some THP in
>>> limbo waiting for them to be split and unmapped parts to be freed,
>>> right? I can see that page_remove_anon_compound_rmap does correctly
>>> decrement NR_ANON_MAPPED for sub pages that are no longer mapped by
>>> anybody. LRU pages seem to be accounted properly as well.  As you've
>>> said NR_ANON_THPS reflects the number of THPs mapped and that should be
>>> reflecting the reality already IIUC.
>>>
>>> So the only problem seems to be that deferred THP might aggregate a lot
>>> of immediately freeable memory (if none of the subpages are mapped) and
>>> that can confuse MemAvailable because it doesn't know about the fact.
>>> Has an skewed counter resulted in a user observable behavior/failures?
>> No. But the skewed counter may make big difference for a big scale cluster.
>> The MemAvailable is an important factor for cluster scheduler to determine
>> the capacity.
> But MemAvailable is a very rough estimation. Is relying on it really a
> good measure? I mean there is a lot of reclaimable memory that is not
> reflected there (some fs. internal data structures, networking buffers
> etc.)

Yes, I agree there are other freeable objects not accounted into 
MemAvailable. Their size depends on the workload. But, deferred split 
THPs seems more common with the common workloads. A simple run with 
MariaDB test of mmtest shows it could generate over fifteen thousand 
deferred split THPs (accumulated around 30G in one hour run, 75% of 40G 
memory for my VM). So, it may be worth accounting deferred split THPs in 
MemAvailable.

>
> [...]
>
>>> accounting the full THP correct? What if subpages are still mapped?
>> "Deferred split" definitely doesn't mean they are free. When memory pressure
>> is hit, they would be split, then the unmapped normal pages would be freed.
>> So, when calculating MemAvailable, they are not accounted 100%, but like
>> "available += lazyfree - min(lazyfree / 2, wmark_low)", just like how page
>> cache is accounted.
> Then this is even more dubious IMHO.
>
>> We could get more accurate account, i.e. checking each sub page's mapcount
>> when accounting, but it may change before shrinker start scanning. So, just
>> use the ballpark estimation to trade off the complexity for accurate
>> accounting.
> I do not see much point in fixing up one particular counter when there
> is a whole lot that is even not considered. I would rather live with the
> fact that MemAvailable is only very rough estimate then whack a mole on
> any memory consumer that is freeable directly or indirectly via memory
> reclaim. Because this is likely to be always subtly broken and only
> visible under very specific workloads so there is no way to test for it.

I saw Vlastimil suggested KReclaimable, it seems a good fit. If so we 
don't need create a new counter anymore.


