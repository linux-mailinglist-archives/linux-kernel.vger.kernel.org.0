Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF11CE7E59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 03:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfJ2CCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 22:02:41 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51077 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728242AbfJ2CCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 22:02:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgaVt6a_1572314557;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TgaVt6a_1572314557)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Oct 2019 10:02:38 +0800
Subject: Re: [PATCH] sched/numa: advanced per-cgroup numa statistic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <46b0fd25-7b73-aa80-372a-9fcd025154cb@linux.alibaba.com>
 <20191028130222.GM4131@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <2b692012-50b5-20f1-b656-fd72a12c1d1a@linux.alibaba.com>
Date:   Tue, 29 Oct 2019 10:02:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028130222.GM4131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/28 下午9:02, Peter Zijlstra wrote:
[snip]
>> +	tg = task_group(p);
>> +	while (tg) {
>> +		/* skip account when there are no faults records */
>> +		if (idx != -1)
>> +			this_cpu_inc(tg->numa_stat->locality[idx]);
>> +
>> +		this_cpu_inc(tg->numa_stat->jiffies);
>> +
>> +		tg = tg->parent;
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
> 
> Thing is, we already have a cgroup hierarchy walk in the tick; see
> task_tick_fair().
> 
> On top of that, you're walking an entirely different set of pointers,
> instead of cfs_rq, you're walking tg->parent, which pretty much
> guarantees you're adding even more cache misses.
> 
> How about you stick those numa_stats in cfs_rq (with cacheline
> alignment) and see if you can frob your update loop into the cgroup walk
> we already do.

Thanks for the reply :-)

The hierarchy walk here you mean is the loop of entity_tick(), correct?

Should working if we introduce the per-cfs_rq numa_stat accounting and
do update there, I'll try to reform the implementation in next version.

Regards,
Michael Wang

> 
