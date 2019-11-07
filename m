Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6446FF2A51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfKGJNW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Nov 2019 04:13:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733170AbfKGJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:13:22 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iSdqx-0001sC-6P; Thu, 07 Nov 2019 10:13:19 +0100
Date:   Thu, 7 Nov 2019 10:13:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191107091319.6zf5tmdi54amtann@linutronix.de>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-02 13:22:53 [+0200], To linux-kernel@vger.kernel.org wrote:
> This is a revert of commit
>    a4244454df129 ("percpu-refcount: use RCU-sched insted of normal RCU")
> 
> which claims the only reason for using RCU-sched is
>    "rcu_read_[un]lock() … are slightly more expensive than preempt_disable/enable()"
> 
> and
>     "As the RCU critical sections are extremely short, using sched-RCU
>     shouldn't have any latency implications."
> 
> The problem with using RCU-sched here is that it disables preemption and
> the callback must not acquire any sleeping locks like spinlock_t on
> PREEMPT_RT which is the case with some of the users.
> 
> Using rcu_read_lock() on PREEMPTION=n kernels is not any different
> compared to rcu_read_lock_sched(). On PREEMPTION=y kernels there are
> already performance issues due to additional preemption points.
> Looking at the code, the rcu_read_lock() is just an increment and unlock
> is almost just a decrement unless there is something special to do. Both
> are functions while disabling preemption is inlined.
> Doing a small benchmark, the minimal amount of time required was mostly
> the same. The average time required was higher due to the higher MAX
> value (which could be preemption). With DEBUG_PREEMPT=y it is
> rcu_read_lock_sched() that takes a little longer due to the additional
> debug code.
> 
> Convert back to normal RCU.

a gentle ping.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> Benchmark https://breakpoint.cc/percpu_test.patch


Sebastian
