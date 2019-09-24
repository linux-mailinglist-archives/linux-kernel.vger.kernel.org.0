Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D91BCC11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 18:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439147AbfIXQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 12:05:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438777AbfIXQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:05:58 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCnK6-0006K0-L0; Tue, 24 Sep 2019 18:05:54 +0200
Date:   Tue, 24 Sep 2019 18:05:54 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
Message-ID: <20190924160554.5esplbmnzm4q4tew@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-4-swood@redhat.com>
 <20190917075943.qsaakyent4dxjkq4@linutronix.de>
 <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
 <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
 <20190923175233.yub32stn3xcwkaml@linutronix.de>
 <20190924112155.rxeyksetgqmer3pg@linutronix.de>
 <55dc19fcc44b2e658b71f68206306c8310335564.camel@redhat.com>
 <20190924152514.enzeuoo5a6o3mgqu@linutronix.de>
 <1a2234884e55e5ee6df5f32f828a99c1b248933f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a2234884e55e5ee6df5f32f828a99c1b248933f.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-24 10:47:36 [-0500], Scott Wood wrote:
> When the stop machine finishes it will do a wake_up_process() via
> complete().  Since this does not pass WF_LOCK_SLEEPER, saved_state will be
> cleared, and you'll have TASK_RUNNING when you get to other_func() and
> schedule(), regardless of whether CPU1 sends wake_up() -- so this change
> doesn't actually accomplish anything.

True, I completely missed that part.

> While as noted in the other thread I don't think these spurious wakeups are
> a huge problem, we could avoid them by doing stop_one_cpu_nowait() and then
> schedule() without messing with task state.  Since we're stopping our own
> cpu, it should be guaranteed that the stopper has finished by the time we
> exit schedule().

I remember loosing a state can be a problem. Lets say it is not "just"
TASK_UNINTERRUPTIBLE -> TASK_RUNNING which sounds harmless but it is
__TASK_TRACED and you lose it as part of unlocking siglock.

> -Scott

Sebastian
