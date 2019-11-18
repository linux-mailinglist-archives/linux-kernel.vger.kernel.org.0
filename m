Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5210095D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 17:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKRQlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 11:41:49 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:58218
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbfKRQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574095307;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=8hy6znYQnmSnTEQhaQWWtLA9sZ79yi4p0EWCE6HT1I8=;
        b=NwiYmBzpKhYCiLFTxdjpb8yZv8Qo6aFMouU2pleNRYHvavtJTgABpK4BXFyHVzvQ
        hM0qZLLDNnoFjvjknosukJhLpFemQFvYS8I9OLbWY0qySqDieZ+oswyUBZJLeXqZN8x
        FBtfk1Vb6pvU7hQ1rHjIEKg7+JThbdcvMxJBnzCA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574095307;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=8hy6znYQnmSnTEQhaQWWtLA9sZ79yi4p0EWCE6HT1I8=;
        b=PLbJb2IjtAQak791ApFeW6Dy02hFS0mnbNl+c196H/oqYJYQZj3YVcQlYv95bnXT
        g2JbnwqQvR4x4uiBDkKuZxw6/mm1gUgM4sr/c07TnCzmd+cVLPtNVxMyzaWqQQdwhHY
        BJFA0IL0o754Rku3dXt4+NHmIlTSpr12ABTXwhWU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86F66C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: Fix missed wakeup of exp_wq waiters
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, joel@joelfernandes.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        pkondeti@codeaurora.org, prsood@codeaurora.org,
        gkohli@codeaurora.org
References: <1573838894-23027-1-git-send-email-neeraju@codeaurora.org>
 <20191117213624.GB2889@paulmck-ThinkPad-P72>
 <0101016e7dd7b824-50600058-ab5e-44d8-8d24-94cf095f1783-000000@us-west-2.amazonses.com>
 <20191118150856.GN2889@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <0101016e7f6441dc-8b48f47b-1771-4616-a198-6aeda4030807-000000@us-west-2.amazonses.com>
Date:   Mon, 18 Nov 2019 16:41:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191118150856.GN2889@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2019.11.18-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


On 11/18/2019 8:38 PM, Paul E. McKenney wrote:
> On Mon, Nov 18, 2019 at 09:28:39AM +0000, Neeraj Upadhyay wrote:
>> Hi Paul,
>>
>> On 11/18/2019 3:06 AM, Paul E. McKenney wrote:
>>> On Fri, Nov 15, 2019 at 10:58:14PM +0530, Neeraj Upadhyay wrote:
>>>> For the tasks waiting in exp_wq inside exp_funnel_lock(),
>>>> there is a chance that they might be indefinitely blocked
>>>> in below scenario:
>>>>
>>>> 1. There is a task waiting on exp sequence 0b'100' inside
>>>>      exp_funnel_lock().
>>>>
>>>>      _synchronize_rcu_expedited()
>>>
>>> This symbol went away a few versions back, but let's see how this
>>> plays out in current -rcu.
>>>
>>
>> Sorry; for us this problem is observed on 4.19 stable version; I had
>> checked against the -rcu code, and the relevant portions were present
>> there.
>>
>>>>        s = 0b'100
>>>>        exp_funnel_lock()
>>>>          wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]
>>>
>>> All of the above could still happen if the expedited grace
>>> period number was zero (or a bit less) when that task invoked
>>
>> Yes
>>
>>> synchronize_rcu_expedited().  What is the relation, if any,
>>> between this task and "task1" below?  Seems like you want them to
>>> be different tasks.
>>>
>>
>> This task is the one which is waiting for the expedited sequence, which
>> "task1" completes ("task1" holds the exp_mutex for it). "task1" would
>> wake up this task, on exp GP completion.
>>
>>> Does this task actually block, or is it just getting ready
>>> to block?  Seems like you need it to have actually blocked.
>>>
>>
>> Yes, it actually blocked in wait queue.
>>
>>>> 2. The Exp GP completes and task (task1) holding exp_mutex queues
>>>>      worker and schedules out.
>>>
>>> "The Exp GP" being the one that was initiated when the .expedited_sequence
>>> counter was zero, correct?  (Looks that way below.)
>>>
>> Yes, correct.
>>
>>>>      _synchronize_rcu_expedited()
>>>>        s = 0b'100
>>>>        queue_work(rcu_gp_wq, &rew.rew_work)
>>>>          wake_up_worker()
>>>>            schedule()
>>>>
>>>> 3. kworker A picks up the queued work and completes the exp gp
>>>>      sequence.
>>>>
>>>>      rcu_exp_wait_wake()
>>>>        rcu_exp_wait_wake()
>>>>          rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
>>>>                                  // to 0b'100'
>>>>
>>>> 4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
>>>>      and releases exp_mutex.
>>>>
>>>>      wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>>>>        sync_exp_work_done(rsp, s));
>>>>      mutex_unlock(&rsp->exp_mutex);
>>>
>>> So task1 is the one that initiated the expedited grace period that
>>> started when .expedited_sequence was zero, right?
>>>
>>
>> Yes, right.
>>
>>>> 5. Next exp GP completes, and sequence number is incremented:
>>>>
>>>>      rcu_exp_wait_wake()
>>>>        rcu_exp_wait_wake()
>>>>          rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'
>>>>
>>>> 6. As kworker A uses current expedited_sequence, it wakes up workers
>>>>      from wrong wait queue index - it should have worken wait queue
>>>>      corresponding to 0b'100' sequence, but wakes up the ones for
>>>>      0b'200' sequence. This results in task at step 1 indefinitely blocked.
>>>>
>>>>      rcu_exp_wait_wake()
>>>>        wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
>>>
>>> So the issue is that the next expedited RCU grace period might
>>> have completed before the completion of the wakeups for the previous
>>> expedited RCU grace period, correct?  Then expedited grace periods have
>>
>> Yes. Actually from the ftraces, I saw that next expedited RCU grace
>> period completed while kworker A was in D state, while waiting for
>> exp_wake_mutex. This led to kworker A using sequence 2 (instead of 1) for
>> its wake_up_all() call; so, task (point 1) was never woken up, as it was
>> waiting on wq index 1.
>>
>>> to have stopped to prevent any future wakeup from happening, correct?
>>> (Which would make it harder for rcutorture to trigger this, though it
>>> really does have code that attempts to trigger this sort of thing.)
>>>
>>> Is this theoretical in nature, or have you actually triggered it?
>>> If actually triggered, what did you do to make this happen?
>>
>> This issue, we had seen previously - 1 instance in May 2018 (on 4.9 kernel),
>> another instance in Nov 2018 (on 4.14 kernel), in our customer reported
>> issues. Both instances were in downstream drivers and we didn't have RCU
>> traces. Now 2 days back, it was reported on 4.19 kernel, with RCU traces
>> enabled, where it was observed in suspend scenario, where we are observing
>> "DPM device timeout" [1], as scsi device is stuck in
>> _synchronize_rcu_expedited().
>>
>> schedule+0x70/0x90
>> _synchronize_rcu_expedited+0x590/0x5f8
>> synchronize_rcu+0x50/0xa0
>> scsi_device_quiesce+0x50/0x120
>> scsi_bus_suspend+0x70/0xe8
>> dpm_run_callback+0x148/0x388
>> __device_suspend+0x430/0x8a8
>>
>> [1]
>> https://github.com/torvalds/linux/blob/master/drivers/base/power/main.c#L489
>>
>>> What have you done to test the change?
>>>
>>
>> I have given this for testing; will share the results . Current analysis
>> and patch is based on going through ftrace and code review.
> 
> OK, very good.  Please include the failure information in the changelog
> of the next version of this patch.
> 
> I prefer your original patch, that just uses "s", over the one below
> that moves the rcu_exp_gp_seq_end().  The big advantage of your original
> patch is that it allow more concurrency between a consecutive pair of
> expedited RCU grace periods.  Plus it would not be easy to convince
> myself that moving rcu_exp_gp_seq_end() down is safe, so your original
> is also conceptually simpler with a more manageable state space.
> 
> Please also add the WARN_ON(), though at first glance your change seems
> to have lost the wakeup.  (But it is early, so maybe it is just that I
> am not yet fully awake.)

My bad, I posted incomplete diff in previous mail:

  static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
  {
  	struct rcu_node *rnp;
+	unsigned long exp_low;
+	unsigned long s_low = rcu_seq_ctr(s) & 0x3;

  	synchronize_sched_expedited_wait(rsp);
  	rcu_exp_gp_seq_end(rsp);
@@ -613,7 +615,9 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp, 
unsigned long s)
  			spin_unlock(&rnp->exp_lock);
  		}
  		smp_mb(); /* All above changes before wakeup. */
-		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
+		exp_low = rcu_seq_ctr(rsp->expedited_sequence) & 0x3;
+		WARN_ON(s_low != exp_low);
+		wake_up_all(&rnp->exp_wq[exp_low]);
  	}


Thanks
Neeraj

> 
> 							Thanx, Paul
> 
>> I was thinking of another way of addressing this problem: Doing exp seq end
>> inside exp_wake_mutex. This will also ensure that, if we extend the current
>> scenario and there are multiple expedited GP sequence, which have completed,
>> before exp_wake_mutex is held, we need to preserve the requirement of 3 wq
>> entries [2].
>>
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst?h=dev
>>
>>
>> @@ -595,8 +595,6 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp,
>> unsigned long s)
>>          struct rcu_node *rnp;
>>
>>          synchronize_sched_expedited_wait(rsp);
>> -       rcu_exp_gp_seq_end(rsp);
>> -       trace_rcu_exp_grace_period(rsp->name, s, TPS("end"));
>>
>>          /*
>>           * Switch over to wakeup mode, allowing the next GP, but -only- the
>> @@ -604,6 +602,9 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp,
>> unsigned long s)
>>           */
>>          mutex_lock(&rsp->exp_wake_mutex);
>>
>> +       rcu_exp_gp_seq_end(rsp);
>> +       trace_rcu_exp_grace_period(rsp->name, s, TPS("end"));
>> +
>>
>>
>>
>>> (Using a WARN_ON() to check for the lower bits of the counter portion
>>> of rcu_state.expedited_sequence differing from the same bits of s
>>> would be one way to detect this problem.)
>>>
>>> 							Thanx, Paul
>>>
>>
>> I have also given the patch for this, for testing:
>>
>>   static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
>>   {
>>          struct rcu_node *rnp;
>> +       unsigned long exp_low;
>> +       unsigned long s_low = rcu_seq_ctr(s) & 0x3;
>>
>>          synchronize_sched_expedited_wait(rsp);
>>          rcu_exp_gp_seq_end(rsp);
>> @@ -613,7 +615,9 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp,
>> unsigned long s)
>>                          spin_unlock(&rnp->exp_lock);
>>                  }
>>                  smp_mb(); /* All above changes before wakeup. */
>> - wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
>> +               exp_low = rcu_seq_ctr(rsp->expedited_sequence) & 0x3;
>> +               WARN_ON(s_low != exp_low);
>> +
>>
>> Thanks
>> Neeraj
>>
>>>> Fix this by using the correct sequence number for wake_up_all() inside
>>>> rcu_exp_wait_wake().
>>>>
>>>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>> ---
>>>>    kernel/rcu/tree_exp.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>>> index e4b77d3..28979d3 100644
>>>> --- a/kernel/rcu/tree_exp.h
>>>> +++ b/kernel/rcu/tree_exp.h
>>>> @@ -557,7 +557,7 @@ static void rcu_exp_wait_wake(unsigned long s)
>>>>    			spin_unlock(&rnp->exp_lock);
>>>>    		}
>>>>    		smp_mb(); /* All above changes before wakeup. */
>>>> -		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
>>>> +		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
>>>>    	}
>>>>    	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
>>>>    	mutex_unlock(&rcu_state.exp_wake_mutex);
>>>> -- 
>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>>> member of the Code Aurora Forum, hosted by The Linux Foundation
>>>>
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>> the Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
