Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78713B026
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgANQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 11:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANQ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:59:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8522084D;
        Tue, 14 Jan 2020 16:59:08 +0000 (UTC)
Date:   Tue, 14 Jan 2020 11:59:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched/fair: scheduler not running high priority process on idle
 cpu
Message-ID: <20200114115906.22f952ff@gandalf.local.home>
In-Reply-To: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 16:50:43 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> I've a test that uses four RT priority processes to process audio data every 10ms.
> One process wakes up the other three, they all 'beaver away' clearing a queue of
> jobs and the last one to finish sleeps until the next tick.
> Usually this takes about 0.5ms, but sometimes takes over 3ms.
> 
> AFAICT the processes are normally woken on the same cpu they last ran on.
> There seems to be a problem when the selected cpu is running a (low priority)
> process that is looping in kernel [1].
> I'd expect my process to be picked up by one of the idle cpus, but this
> doesn't happen.
> Instead the process sits in state 'waiting' until the active processes sleeps
> (or calls cond_resched()).
> 
> Is this really the expected behaviour?????

It is with CONFIG_PREEMPT_VOLUNTARY. I think you want to recompile your
kernel with CONFIG_PREEMPT. The idea is that the RT task will continue
to run on the CPU it last ran on, and would push off the lower priority
task to the idle CPU. But CONFIG_PREEMPT_VOLUNTARY means that this
will have to wait for the running task to not be in kernel context or
hit a cond_resched() which is the "voluntary" scheduling point.

-- Steve
