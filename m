Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314B913891F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 01:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbgAMAyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 19:54:06 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:23108 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387502AbgAMAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 19:54:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TnVzo8d_1578876843;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TnVzo8d_1578876843)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jan 2020 08:54:03 +0800
Subject: Re: [PATCH RESEND] mm: fix tick_sched timer blocked by
 pgdat_resize_lock
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200110082510.172517-2-shile.zhang@linux.alibaba.com>
 <20200110093053.34777-1-shile.zhang@linux.alibaba.com>
 <1ee6088c-9e72-8824-3a9a-fc099d196faf@virtuozzo.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <c7ac0338-78a6-2ae3-465c-2d6371d96a72@linux.alibaba.com>
Date:   Mon, 13 Jan 2020 08:54:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1ee6088c-9e72-8824-3a9a-fc099d196faf@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/10 19:42, Kirill Tkhai wrote:
> On 10.01.2020 12:30, Shile Zhang wrote:
>> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdat_resize_lock'
>> will be called inside 'pgdatinit' kthread to initialise the deferred
>> pages with local interrupts disabled. Which is introduced by
>> commit 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred
>> pages").
>>
>> But 'pgdatinit' kthread is possible be pined on the boot CPU (CPU#0 by
>> default), especially in small system with NRCPUS <= 2. In this case, the
>> interrupts are disabled on boot CPU during memory initialising, which
>> caused the tick_sched timer be blocked, leading to wall clock stuck.
>>
>> Fixes: commit 3a2d7fa8a3d5 ("mm: disable interrupts while initializing
>> deferred pages")
>>
>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>> ---
>>   include/linux/memory_hotplug.h | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index ba0dca6aac6e..be69a6dc4fee 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -6,6 +6,8 @@
>>   #include <linux/spinlock.h>
>>   #include <linux/notifier.h>
>>   #include <linux/bug.h>
>> +#include <linux/sched.h>
>> +#include <linux/smp.h>
>>   
>>   struct page;
>>   struct zone;
>> @@ -282,12 +284,22 @@ static inline bool movable_node_is_enabled(void)
>>   static inline
>>   void pgdat_resize_lock(struct pglist_data *pgdat, unsigned long *flags)
>>   {
>> -	spin_lock_irqsave(&pgdat->node_size_lock, *flags);
>> +	/*
>> +	 * Disable local interrupts on boot CPU will stop the tick_sched
>> +	 * timer, which will block jiffies(wall clock) update.
>> +	 */
>> +	if (current->cpu != get_boot_cpu_id())
>> +		spin_lock_irqsave(&pgdat->node_size_lock, *flags);
>> +	else
>> +		spin_lock(&pgdat->node_size_lock);
>>   }
>>   static inline
>>   void pgdat_resize_unlock(struct pglist_data *pgdat, unsigned long *flags)
>>   {
>> -	spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
>> +	if (current->cpu != get_boot_cpu_id())
>> +		spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
>> +	else
>> +		spin_unlock(&pgdat->node_size_lock);
>>   }
>>   static inline
>>   void pgdat_resize_init(struct pglist_data *pgdat)
> 1)Linux kernel is *preemptible*. Kernel with CONFIG_PREEMPT_RT option even may preempt
> *kernel* code in the middle of function. When you are executing a code containing
> pgdat_resize_lock() and pgdat_resize_unlock(), the process may migrate to another cpu
> between them.
>
> bool cpu               another cpu
> ----------------------------------
> pgdat_resize_lock()
>    spin_lock()
>    --> migrate to another cpu
>                        pgdat_resize_unlock()
>                        spin_unlock_irqrestore(<uninitialized flags>)
>
> (Yes, in case of CONFIG_PREEMPT_RT, process is preemptible even after spin_lock() call).
>
> This looks like a bad helpers, and we should not introduce such the design.

Hi Kirill,

Thanks for your comments!
Sorry for I'm not very clear about this lock/unlock, but I encountered 
this issue
with "CONFIG_PREEMPT is not set".
> 2)I think there is no the problem this patch solves. Do we really this statistics?
> Can't we simple remove print message from deferred_init_memmap() and solve this?

Sorry for I've not put this issue very clearly. It's *not* just one 
statistics log
with wrong time calculate, but the wall clock is stuck.
So the 'systemd-analyze' command also give a wrong time as I mentioned 
in the cover
letter. I don't think is OK just remove the log, it cannot solve the 
wall clock latency.
> Also, you may try to check that sched_clock() gives better results with interrupts
> disabled (on x86 it uses rdtsc, when it's possible. But it also may fallback to
> jiffies-based clock in some hardware cases, and they also won't go with interrupts
> disabled).
>
> Kirill

