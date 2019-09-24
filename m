Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC6BCB44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbfIXPZU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Sep 2019 11:25:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34624 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfIXPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:25:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCmgk-00055P-JX; Tue, 24 Sep 2019 17:25:14 +0200
Date:   Tue, 24 Sep 2019 17:25:14 +0200
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
Message-ID: <20190924152514.enzeuoo5a6o3mgqu@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-4-swood@redhat.com>
 <20190917075943.qsaakyent4dxjkq4@linutronix.de>
 <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
 <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
 <20190923175233.yub32stn3xcwkaml@linutronix.de>
 <20190924112155.rxeyksetgqmer3pg@linutronix.de>
 <55dc19fcc44b2e658b71f68206306c8310335564.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <55dc19fcc44b2e658b71f68206306c8310335564.camel@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-24 08:53:43 [-0500], Scott Wood wrote:
> As I pointed out in the "[PATCH RT 6/8] sched: migrate_enable: Set state to
> TASK_RUNNING" discussion, we can get here inside the rtmutex code (e.g. from
> debug_rt_mutex_print_deadlock) where saved_state is already holding
> something -- plus, the waker won't have WF_LOCK_SLEEPER and therefore
> saved_state will get cleared anyway.

So let me drop the saved_state pieces and get back to it once I get to
the other thread (which you replied and I didn't realised until now).

Regarding the WF_LOCK_SLEEPER part. I think this works as expected.
Imagine:

CPU0						CPU1
spin_lock();
set_current_state(TASK_UNINTERRUPTIBLE);
…
spin_unlock()
 -> migrate_enable();
   -> stop_one_cpu();				<-- A)
other_func();					<-- B)
schedule();

So. With only CPU0 we enter schedule() with TASK_UNINTERRUPTIBLE because
the state gets preserved with the change I added (which is expected).
If CPU1 sends a wake_up() at A) then the saved_state gets overwritten
and we enter schedule() with TASK_RUNNING. Same happens if it is sent at
B) point which is outside of any migrate/spin lock related code. 

Was this clear or did I miss the point?

> -Scott

Sebastian
