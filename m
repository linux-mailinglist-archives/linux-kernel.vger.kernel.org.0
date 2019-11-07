Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6329EF2ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbfKGJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:38:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKGJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:38:43 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSeFT-0002Kh-NV; Thu, 07 Nov 2019 10:38:39 +0100
Date:   Thu, 7 Nov 2019 10:38:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 02/12] futex: Move futex exit handling into futex code
In-Reply-To: <20191107092441.GC4131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911071038190.4256@nanos.tec.linutronix.de>
References: <20191106215534.241796846@linutronix.de> <20191106224556.049705556@linutronix.de> <20191107092441.GC4131@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> On Wed, Nov 06, 2019 at 10:55:36PM +0100, Thomas Gleixner wrote:
> 
> > -#ifdef CONFIG_FUTEX
> > -	if (unlikely(tsk->robust_list)) {
> > -		exit_robust_list(tsk);
> > -		tsk->robust_list = NULL;
> > -	}
> > -#ifdef CONFIG_COMPAT
> > -	if (unlikely(tsk->compat_robust_list)) {
> > -		compat_exit_robust_list(tsk);
> > -		tsk->compat_robust_list = NULL;
> > -	}
> > -#endif
> > -	if (unlikely(!list_empty(&tsk->pi_state_list)))
> > -		exit_pi_state_list(tsk);
> > -#endif
> 
> > +void futex_mm_release(struct task_struct *tsk)
> > +{
> > +	if (unlikely(tsk->robust_list)) {
> > +		exit_robust_list(tsk);
> > +		tsk->robust_list = NULL;
> > +	}
> > +
> > +	if (IS_ENABLED(CONFIG_COMPAT)) {
> > +		if (unlikely(tsk->compat_robust_list)) {
> > +			compat_exit_robust_list(tsk);
> > +			tsk->compat_robust_list = NULL;
> > +		}
> > +	}
> 
> I suppose it is this substitution that causes the compile error mingo
> found. The problem with IS_ENABLED() is that the whole block still needs
> to compile (before it can be thrown out), and in this case
> tsk->compat_robust_list doesn't exist.

Yeah. Tried to be overly smart :)
