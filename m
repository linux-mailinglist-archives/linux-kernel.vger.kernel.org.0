Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425B8A8D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfIDRMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 13:12:55 -0400
Received: from mail.efficios.com ([167.114.142.138]:60336 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731518AbfIDRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:12:55 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C35E831D09C;
        Wed,  4 Sep 2019 13:12:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id vdmwHlUiiGt4; Wed,  4 Sep 2019 13:12:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5748D31D099;
        Wed,  4 Sep 2019 13:12:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5748D31D099
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567617173;
        bh=kcG462PyHXqS854dPeQ3quTPrE/7UNE0b+oaHKrpb2g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Exm9S7ziVewo02bXdAynlISvE2ZRKczR/XHUqd+jVXJQ9StsmoizWxOxpAs8Juqa6
         S2dGk5Q6cKq5Uga34tyPoDCQWuekNfLUguY6HXmwDqhjgGySd8HbcJExDjTHWEy4vS
         AAnAIVWEicn6NBJ5zEyYaTUZ8wEPWBOx4P9Tt5m8wnWbEILB+Dfvl1E5g7RUSK/OMg
         uLzeo7DJSan9wJL1Cnm55UKvKE4Rnm73vAeCINIvruKBEjEYD69PA0FngmNdmEFrYK
         FvQthv5uiHRS85zotqfH3VSIqrTy3Ivrec3XUxFFpb4sCwUYwlrJVdplpl6OxhZoXL
         36LO97NEV05pQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id xf3LiKR8Hi1y; Wed,  4 Sep 2019 13:12:53 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3BDD631D090;
        Wed,  4 Sep 2019 13:12:53 -0400 (EDT)
Date:   Wed, 4 Sep 2019 13:12:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck <paulmck@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <1825272223.1740.1567617173011.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190904160953.GU2332@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190903202434.GX2349@hirez.programming.kicks-ass.net> <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com> <1604807537.1565.1567610340030.JavaMail.zimbra@efficios.com> <20190904160953.GU2332@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: VyhW5+e6fYeELkwTGRO1n0cZQsY5CA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 4, 2019, at 12:09 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Sep 04, 2019 at 11:19:00AM -0400, Mathieu Desnoyers wrote:
>> ----- On Sep 3, 2019, at 4:36 PM, Linus Torvalds torvalds@linux-foundation.org
>> wrote:
> 
>> > I wonder if the easiest model might be to just use a percpu variable
>> > instead for the membarrier stuff? It's not like it has to be in
>> > 'struct task_struct' at all, I think. We only care about the current
>> > runqueues, and those are percpu anyway.
>> 
>> One issue here is that membarrier iterates over all runqueues without
>> grabbing any runqueue lock. If we copy that state from mm to rq on
>> sched switch prepare, we would need to ensure we have the proper
>> memory barriers between:
>> 
>> prior user-space memory accesses  /  setting the runqueue membarrier state
>> 
>> and
>> 
>> setting the runqueue membarrier state / following user-space memory accesses
>> 
>> Copying the membarrier state into the task struct leverages the fact that
>> we have documented and guaranteed those barriers around the rq->curr update
>> in the scheduler.
> 
> Should be the same as the barriers we already rely on for rq->curr, no?
> That is, if we put this before switch_mm() then we have
> smp_mb__after_spinlock() and switch_mm() itself.

Yes, I think we can piggy-back on the already documented barriers documented around
rq->curr store.

> Also, if we place mm->membarrier_state in the same cacheline as mm->pgd
> (which switch_mm() is bound to load) then we should be fine, I think.

Yes, if we make sure membarrier_prepare_task_switch only updates the
rq->membarrier_state if prev->mm != next->mm, we should be able to avoid
loading next->mm->membarrier_state when switch_mm() is not invoked.

I'll prepare RFC patch implementing this approach.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
