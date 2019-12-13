Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD5411DE18
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 07:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfLMGDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 01:03:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727474AbfLMGDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 01:03:53 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 23126A54932938F9DF43;
        Fri, 13 Dec 2019 14:03:51 +0800 (CST)
Received: from [127.0.0.1] (10.133.229.220) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 14:03:48 +0800
Subject: Re: [PATCH] sched/debug: fix trival print task format
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <linux-kernel@vger.kernel.org>
References: <20191212122244.132751-1-xiexiuqi@huawei.com>
 <20191212093721.1d9a2f7f@gandalf.local.home>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <e7a5b896-4222-5e2e-5479-37c65e5e6b03@huawei.com>
Date:   Fri, 13 Dec 2019 14:03:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191212093721.1d9a2f7f@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.229.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/12/12 22:37, Steven Rostedt wrote:
> On Thu, 12 Dec 2019 20:22:44 +0800
> Xie XiuQi <xiexiuqi@huawei.com> wrote:
> 
>> Ensure levave a whitespace between state and task name.
> 
> "levave"?

Sorry for the typo.

> 
>>
>> w/o patch:
>> runnable tasks:
>>  S           task   PID         tree-key  switches  prio     wait
>> -----------------------------------------------------------------
>>  I    kworker/0:2   656     87693.884557      8255   120
>>  Sirq/10-ACPI:Ged   829         0.000000         3    49
>>  Sirq/11-ACPI:Ged   830         0.000000         3    49
>>  Sirq/50-arm-smmu   945         0.000000         3    49
>>
>> with patch:
>> runnable tasks:
>>  S            task   PID         tree-key  switches  prio     wait
>> ------------------------------------------------------------------
>>  I     kworker/0:2   656     87693.884557      8255   120
>>  S irq/10-ACPI:Ged   829         0.000000         3    49
>>  S irq/11-ACPI:Ged   830         0.000000         3    49
>>  S irq/50-arm-smmu   945         0.000000         3    49
>>
>> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
>> ---
>>  kernel/sched/debug.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index f7e4579e746c..a1b5a4c1213e 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -434,9 +434,9 @@ static void
>>  print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
>>  {
>>  	if (rq->curr == p)
>> -		SEQ_printf(m, ">R");
>> +		SEQ_printf(m, ">R ");
>>  	else
>> -		SEQ_printf(m, " %c", task_state_to_char(p));
>> +		SEQ_printf(m, " %c ", task_state_to_char(p));
>>  
>>  	SEQ_printf(m, "%15s %5d %9Ld.%06ld %9Ld %5d ",
> 
> Wouldn't it be simpler to just add one space to the above?
> 
> 	SEQ_printf(m, " %15s %5d %9Ld.%06ld %9Ld %5d ",
> 
> ?

That true, thanks.

> 
> -- Steve
> 
>>  		p->comm, task_pid_nr(p),
>> @@ -465,10 +465,10 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
>>  
>>  	SEQ_printf(m, "\n");
>>  	SEQ_printf(m, "runnable tasks:\n");
>> -	SEQ_printf(m, " S           task   PID         tree-key  switches  prio"
>> +	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
>>  		   "     wait-time             sum-exec        sum-sleep\n");
>>  	SEQ_printf(m, "-------------------------------------------------------"
>> -		   "----------------------------------------------------\n");
>> +		   "------------------------------------------------------\n");
>>  
>>  	rcu_read_lock();
>>  	for_each_process_thread(g, p) {
> 
> 
> .
> 

