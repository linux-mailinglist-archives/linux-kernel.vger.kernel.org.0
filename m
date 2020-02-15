Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CFD15FC7F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 04:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBODrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 22:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbgBODrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 22:47:47 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C602083B;
        Sat, 15 Feb 2020 03:47:45 +0000 (UTC)
Date:   Fri, 14 Feb 2020 22:47:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 06/30] rcu: Add WRITE_ONCE to rcu_node
 ->exp_seq_rq store
Message-ID: <20200214224743.280772a7@oasis.local.home>
In-Reply-To: <20200214235607.13749-6-paulmck@kernel.org>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
        <20200214235607.13749-6-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 15:55:43 -0800
paulmck@kernel.org wrote:

> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The rcu_node structure's ->exp_seq_rq field is read locklessly, so
> this commit adds the WRITE_ONCE() to a load in order to provide proper
> documentation and READ_ONCE()/WRITE_ONCE() pairing.
> 
> This data race was reported by KCSAN.  Not appropriate for backporting
> due to failure being unlikely.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tree_exp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index d7e0484..85b009e 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -314,7 +314,7 @@ static bool exp_funnel_lock(unsigned long s)
>  				   sync_exp_work_done(s));
>  			return true;
>  		}
> -		rnp->exp_seq_rq = s; /* Followers can wait on us. */
> +		WRITE_ONCE(rnp->exp_seq_rq, s); /* Followers can wait on us. */

Didn't Linus say this is basically bogus?

Perhaps just using it as documenting that it's read locklessly, but is
it really needed?

-- Steve



>  		spin_unlock(&rnp->exp_lock);
>  		trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
>  					  rnp->grplo, rnp->grphi, TPS("nxtlvl"));

