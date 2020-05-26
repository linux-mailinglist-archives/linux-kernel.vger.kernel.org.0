Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3C719891C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgCaA5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:57:00 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48100 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgCaA5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:57:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tu66d.0_1585616216;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tu66d.0_1585616216)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Mar 2020 08:56:57 +0800
Subject: Re: [RFC PATCH v1 29/50] fs/ocfs2/journal: Use prandom_u32() and not
 /dev/random for timeout
To:     George Spelvin <lkml@SDF.ORG>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
References: <202003281643.02SGhIOY022599@sdf.org>
 <016c2bdc-68eb-245f-2292-d00d0d8e45a5@linux.alibaba.com>
 <20200330163412.GA2459@SDF.ORG>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <5b3a28ea-8d3f-2726-2daa-55c7af4a5d00@linux.alibaba.com>
Date:   Tue, 31 Mar 2020 08:56:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330163412.GA2459@SDF.ORG>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/31 00:34, George Spelvin wrote:
> On Mon, Mar 30, 2020 at 08:09:33PM +0800, Joseph Qi wrote:
>> Sorry for the late reply since I might miss this mail.
> 
> You're hardly late; I expect replies to dribble in for a week.
> 
>> On 2019/3/21 11:07, George Spelvin wrote:
>>> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
>>> index 68ba354cf3610..939a12e57fa8b 100644
>>> --- a/fs/ocfs2/journal.c
>>> +++ b/fs/ocfs2/journal.c
>>> @@ -1884,11 +1884,8 @@ int ocfs2_mark_dead_nodes(struct ocfs2_super *osb)
>>>   */
>>>  static inline unsigned long ocfs2_orphan_scan_timeout(void)
>>>  {
>>> -	unsigned long time;
>>> -
>>> -	get_random_bytes(&time, sizeof(time));
>>> -	time = ORPHAN_SCAN_SCHEDULE_TIMEOUT + (time % 5000);
>>> -	return msecs_to_jiffies(time);
>>> +	return msecs_to_jiffies(ORPHAN_SCAN_SCHEDULE_TIMEOUT) +
>>> +		prandom_u32_max(5 * HZ);
>>
>> Seems better include the prandom_u32_max() into msecs_to_jiffies()?
> 
> What I'm trying to take advantage of here is constant propagation.
> 
> msecs_to_jiffies is zero cost (it's evaluated entirely at compile 
> time) if its argument is a compile-time constant.  It's a function call
> and a few instructions if its argument is variable.
> 
> msecs_to_jiffies(ORPHAN_SCAN_SCHEDULE_TIMEOUT + prandom_u32_max(5000))
> would be forced to use the expensive version.
> 
> The compiler does't know, but *I* know, that msecs_to_jiffies() is a 
> linear function, and prandom_u32_max() is a sort-of linear function.
> 
> (It's a linear function for a given PRNG starting state, so each 
> individual call is linear, but multiple calls mess things up.)
> 
> Modulo a bit of rounding, we have:
> 
> msecs_to_jiffies(a + b) = msecs_to_jiffies(a) + msecs_to_jiffies(b)
> msecs_to_jiffies(a) * b = msecs_to_jiffies(a * b)
> prandom_u32_max(a) * b = prandom_u32_max(a * b)
> prandom_u32_max(msecs_to_jiffies(a)) = msecs_to_jiffies(prandom_u32_max(a))
> 
> By doing the addition in jiffies rather than milliseconds, we get the 
> cheap code.  It's not a huge big deal, but it's definitely smaller and 
> faster.
> 
> Admittedly, I happen to be using HZ = 300, which requires a multiply to 
> convert, and makes the resultant random numbers slightly non-uniform.  
> The default HZ = 250 makes it just a divide by 4, which is pretty simple.
> 
> (When HZ = 300, you get 1..3 ms -> 1 jiffy, 4..6 ms -> 2 jiffies, and
> 7..10 ms -> 3 jiffies.  Multiples of 3 are 33% more likely to be chosen.)
> 
> It just seems silly and wasteful to pick a random number between 0 and 
> 4999 (plus 30000), only to convert it to a random number between 0 and 
> 1249 (plus 7500).
> 
> And if HZ = 2000 ever happens, the timeout won't be artificially limited
> to integer milliseconds.
> 

Thanks for the detail explanation.
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
