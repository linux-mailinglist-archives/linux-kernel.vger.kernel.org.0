Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8618B01F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 10:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCSJZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 05:25:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60077 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:25:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jErQq-0004NV-Su; Thu, 19 Mar 2020 10:25:40 +0100
Date:   Thu, 19 Mar 2020 10:25:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-rt-users@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: RCU use of swait
Message-ID: <20200319092540.gpgzx2qao3r4okql@linutronix.de>
References: <20200305003526.GA20601@paulmck-ThinkPad-P72>
 <20200305081135.yg7wryd3hrqzocrm@linutronix.de>
 <CAEXW_YSiKrT50mTR1a4tB5x_jQzZKnuAo6JY-Vc5w7r=XLv+OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEXW_YSiKrT50mTR1a4tB5x_jQzZKnuAo6JY-Vc5w7r=XLv+OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 20:47:18 [-0400], Joel Fernandes wrote:
> In RCU, there are some truly-atomic code sections containing an
> swake_upXX() call, which would be considered atomic also on
> PREEMPT_RT, one example is:
> 
> rcu_core() contains an local_irq_{save,restore}() section.
> 
>         /* No grace period and unregistered callbacks? */
>         if (!rcu_gp_in_progress() &&
>             rcu_segcblist_is_enabled(&rdp->cblist) && !offloaded) {
>                 local_irq_save(flags);
>                 if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>                         rcu_accelerate_cbs_unlocked(rnp, rdp);
>                 local_irq_restore(flags);
>         }
> 
> And rcu_accelerate_cbs_unlocked(rnp, rdp) calls rcu_gp_kthread_wake()
> which does an swake_up_one(), so I think we will have to leave it as
> swake_up() the way it is.

There is also this:
irq_exit()
 rcu_irq_exit()
  rcu_nmi_exit_common(true);
   rcu_prepare_for_idle()
    if (rcu_segcblist_pend_cbs(&rdp->cblist))
      rcu_gp_kthread_wake()
       swake_up_one(&rcu_state.gp_wq);

So I *think* this is another one.

> thanks,
> 
>  - Joel

Sebastian
