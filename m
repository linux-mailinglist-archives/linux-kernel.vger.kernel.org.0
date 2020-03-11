Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA418150E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgCKJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 05:35:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50522 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCKJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:35:19 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02B9Yu26088449;
        Wed, 11 Mar 2020 18:34:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Wed, 11 Mar 2020 18:34:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02B9YqIZ088382
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Mar 2020 18:34:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
 <0e5ca6ee-d460-db8e-aba2-79aa7a66fad1@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.2003101555050.177273@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7a6170fc-b247-e327-321a-b99fb53f552d@i-love.sakura.ne.jp>
Date:   Wed, 11 Mar 2020 18:34:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003101555050.177273@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/11 7:55, David Rientjes wrote:
> On Wed, 11 Mar 2020, Tetsuo Handa wrote:
> 
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>>  		unsigned long reclaimed;
>>>  		unsigned long scanned;
>>>  
>>> +		cond_resched();
>>> +
>>
>> Is this safe for CONFIG_PREEMPTION case? If current thread has realtime priority,
>> can we guarantee that the OOM victim (well, the OOM reaper kernel thread rather
>> than the OOM victim ?) gets scheduled?
>>
> 
> I think it's the best we can do that immediately solves the issue unless 
> you have another idea in mind?

"schedule_timeout_killable(1) outside of oom_lock" or "the OOM reaper grabs oom_lock
so that allocating threads guarantee that the OOM reaper gets scheduled" or "direct OOM
reaping so that allocating threads guarantee that some memory is reclaimed".

> 
>>>  		switch (mem_cgroup_protected(target_memcg, memcg)) {
>>>  		case MEMCG_PROT_MIN:
>>>  			/*
>>>
>>

