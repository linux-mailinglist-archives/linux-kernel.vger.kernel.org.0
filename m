Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2478E4103
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 03:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbfJYBZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 21:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388701AbfJYBZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:25:56 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916E021D71;
        Fri, 25 Oct 2019 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571966756;
        bh=ve6VuYj5fDUJcAsaXlTBkWDVM+Rgj3v6t2W+NC8oL00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce2sQCgteWnadCUwG6tR4FF4Mhq9Y0XqyLB4h3wqAOFIH0z022oWyjkBK+N+4Ho6R
         Kn2kwK2xLuE4NLSSFq19PaVHJTpZJBMmyv47Byg9b3sGbcrp4toJl5NofO16iBGtfL
         BqQ0+mYsD8YYBiRPe+8Vewjcw5gyh1uCnqRlv1LU=
Date:   Fri, 25 Oct 2019 03:25:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/14] sched/kcpustat: Introduce vtime-aware kcpustat
 accessor for CPUTIME_SYSTEM
Message-ID: <20191025012552.GA18217@lenoir>
References: <20191016025700.31277-1-frederic@kernel.org>
 <20191016025700.31277-12-frederic@kernel.org>
 <20191024115034.GA4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024115034.GA4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 01:50:34PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 16, 2019 at 04:56:57AM +0200, Frederic Weisbecker wrote:
> 
> > +static int kcpustat_field_vtime(u64 *cpustat,
> > +				struct vtime *vtime,
> > +				enum cpu_usage_stat usage,
> > +				int cpu, u64 *val)
> > +{
> > +	unsigned int seq;
> > +	int err;
> > +
> > +	do {
> > +		seq = read_seqcount_begin(&vtime->seqcount);
> > +
> > +		/*
> > +		 * We raced against context switch, fetch the
> > +		 * kcpustat task again.
> > +		 */
> > +		if (vtime->cpu != cpu && vtime->cpu != -1) {
> > +			err = -EAGAIN;
> > +			continue;
> 
> Did that want to be break?
> 
> > +		}
> > +
> > +		/*
> > +		 * Two possible things here:
> > +		 * 1) We are seeing the scheduling out task (prev) or any past one.
> > +		 * 2) We are seeing the scheduling in task (next) but it hasn't
> > +		 *    passed though vtime_task_switch() yet so the pending
> > +		 *    cputime of the prev task may not be flushed yet.
> > +		 *
> > +		 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
> > +		 */
> > +		if (vtime->state == VTIME_INACTIVE) {
> > +			err = -EAGAIN;
> > +			continue;
> 
> Idem.

Well, both were meant to be continue. Which means do the same as
break but just in case we raced with the updater, try again with
the same task.

Now as we are checking again, we may as well reload the task indeed
so I'll turn those into break.

> 
> If so, you can do return -EAGAIN here, and return 0 at the end and get
> rid of err.
> 
> Also, if you're spin-waiting here, there should probably be a
> cpu_relax() before the return -EAGAIN.
> 
> And in case that is so, you probably want the rcu_read_lock() section
> below _inside_ the do{}while loop, such that the RCU section doesn't
> cover the entire spin-wait.

Good point!

> > +
> > +	do {
> > +		struct rq *rq = cpu_rq(cpu);
> > +		struct task_struct *curr;
> > +		struct vtime *vtime;
> > +
> > +		curr = rcu_dereference(rq->curr);
> 
> This is indeed safe now (relies on commit
> 
>   5311a98fef7d ("tasks, sched/core: RCUify the assignment of rq->curr")

Yeah and that has simplified the patchset a lot.

Thanks!
