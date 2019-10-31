Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C313EB6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 19:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfJaSTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 14:19:17 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37210 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbfJaSTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:19:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TgnZI-G_1572545953;
Received: from 192.168.2.229(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgnZI-G_1572545953)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Nov 2019 02:19:14 +0800
Subject: Re: [PATCH 01/11] rcu: avoid leaking exp_deferred_qs into next GP
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-2-laijs@linux.alibaba.com>
 <20191031134351.GO20975@paulmck-ThinkPad-P72>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <2cf71e70-4cb3-57f8-f542-69ddf04106dd@linux.alibaba.com>
Date:   Fri, 1 Nov 2019 02:19:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191031134351.GO20975@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/31 9:43 下午, Paul E. McKenney wrote:
> On Thu, Oct 31, 2019 at 10:07:56AM +0000, Lai Jiangshan wrote:
>> If exp_deferred_qs is incorrectly set and leaked to the next
>> exp GP, it may cause the next GP to be incorrectly prematurely
>> completed.
> 
> Could you please provide the sequence of events leading to a such a
> failure?

I just felt nervous with "leaking" exp_deferred_qs.
I didn't careful consider the sequence of events.

Now it proves that I must have misunderstood the exp_deferred_qs.
So call "leaking" is wrong concept, preempt_disable()
is considered as rcu_read_lock() and exp_deferred_qs
needs to be set.

Thanks
Lai

============don't need to read:

read_read_lock()
// other cpu start exp GP_A
preempt_schedule() // queue itself
read_read_unlock() //report qs, other cpu is sending ipi to me
preempt_disable
   rcu_exp_handler() interrupt for GP_A and leave a exp_deferred_qs
   // exp GP_A finished
   ---------------above is one possible way to leave a exp_deferred_qs
preempt_enable()
  interrupt before preempt_schedule()
   read_read_lock()
   read_read_unlock()
    NESTED interrupt when nagative rcu_read_lock_nesting
     read_read_lock()
     // other cpu start exp GP_B
     NESTED interrupt for rcu_flavor_sched_clock_irq()
      report exq qs since rcu_read_lock_nesting <0 and \
      exp_deferred_qs is true
     // exp GP_B complete
     read_read_unlock()

This plausible sequence relies on NESTED interrupt too,
and can be avoided by patch2 if NESTED interrupt were allowed.

> 
> Also, did you provoke such a failure in testing?  If so, an upgrade
> to rcutorture would be good, so please tell me what you did to make
> the failure happen.
> 
> I do like the reduction in state space, but I am a bit concerned about
> the potential increase in contention on rnp->lock.  Thoughts?
> 
> 							Thanx, Paul
> 
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   kernel/rcu/tree_exp.h | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>> index a0e1e51c51c2..6dec21909b30 100644
>> --- a/kernel/rcu/tree_exp.h
>> +++ b/kernel/rcu/tree_exp.h
>> @@ -603,6 +603,18 @@ static void rcu_exp_handler(void *unused)
>>   	struct rcu_node *rnp = rdp->mynode;
>>   	struct task_struct *t = current;
>>   
>> +	/*
>> +	 * Note that there is a large group of race conditions that
>> +	 * can have caused this quiescent state to already have been
>> +	 * reported, so we really do need to check ->expmask first.
>> +	 */
>> +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>> +	if (!(rnp->expmask & rdp->grpmask)) {
>> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>> +		return;
>> +	}
>> +	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>> +
>>   	/*
>>   	 * First, the common case of not being in an RCU read-side
>>   	 * critical section.  If also enabled or idle, immediately
>> @@ -628,17 +640,10 @@ static void rcu_exp_handler(void *unused)
>>   	 * a future context switch.  Either way, if the expedited
>>   	 * grace period is still waiting on this CPU, set ->deferred_qs
>>   	 * so that the eventual quiescent state will be reported.
>> -	 * Note that there is a large group of race conditions that
>> -	 * can have caused this quiescent state to already have been
>> -	 * reported, so we really do need to check ->expmask.
>>   	 */
>>   	if (t->rcu_read_lock_nesting > 0) {
>> -		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>> -		if (rnp->expmask & rdp->grpmask) {
>> -			rdp->exp_deferred_qs = true;
>> -			t->rcu_read_unlock_special.b.exp_hint = true;
>> -		}
>> -		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>> +		rdp->exp_deferred_qs = true;
>> +		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
>>   		return;
>>   	}
>>   
>> -- 
>> 2.20.1
>>
