Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1E12F2CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgACBy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:54:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgACBy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:54:56 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B2C9AD4C78F1B0342155;
        Fri,  3 Jan 2020 09:54:54 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.196) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 09:54:45 +0800
Subject: Re: [PATCH] sched/debug: Reset watchdog on all CPUs while processing
 sysrq-t
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <huawei.libin@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20191226085224.48942-1-liwei391@huawei.com>
 <20200102144514.646df101@gandalf.local.home>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <2a7a9e51-bb25-3ed1-2643-e293e3ce5188@huawei.com>
Date:   Fri, 3 Jan 2020 09:54:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102144514.646df101@gandalf.local.home>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.196]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
Yes, it can be triggered on the Hi1620 system (128 cores) as follows:
stress-ng -c 50 &
stress-ng -m 50 &
stress-ng -i 20 &
echo 7 > /proc/sys/kernel/printk
echo t > /proc/sysrq-trigger

Then a soft lockup will be reported at migration thread
[39636.303531] watchdog: BUG: soft lockup - CPU#67 stuck for 23s! [migration/67:348]
which is waiting for the CPU handling sysrq-t to process stop_two_cpus.

Thanks,
Wei

On 2020/1/3 3:45, Steven Rostedt wrote:
> On Thu, 26 Dec 2019 16:52:24 +0800
> Wei Li <liwei391@huawei.com> wrote:
> 
>> Lengthy output of sysrq-t may take a lot of time on slow serial console
>> with lots of processes and CPUs.
>>
>> So we need to reset NMI-watchdog to avoid spurious lockup messages, and
>> we also reset softlockup watchdogs on all other CPUs since another CPU
>> might be blocked waiting for us to process an IPI or stop_machine.
> 
> Have you had this triggered?
> 
>>
>> Add to sysrq_sched_debug_show() as what we did in show_state_filter().
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  kernel/sched/debug.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index f7e4579e746c..879d3ccf3806 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -751,9 +751,16 @@ void sysrq_sched_debug_show(void)
>>  	int cpu;
>>  
>>  	sched_debug_header(NULL);
>> -	for_each_online_cpu(cpu)
>> +	for_each_online_cpu(cpu) {
>> +		/*
>> +		 * Need to reset softlockup watchdogs on all CPUs, because
>> +		 * another CPU might be blocked waiting for us to process
>> +		 * an IPI or stop_machine.
>> +		 */
>> +		touch_nmi_watchdog();
>> +		touch_all_softlockup_watchdogs();
> 
> This doesn't seem to hurt to add, thus.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve
> 
>>  		print_cpu(NULL, cpu);
>> -
>> +	}
>>  }
>>  
>>  /*
> 
> 
> .
> 

