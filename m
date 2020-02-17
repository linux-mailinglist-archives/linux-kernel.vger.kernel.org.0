Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A068A1619AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 19:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgBQSXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 13:23:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37290 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgBQSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:23:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id c188so17055228qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ExlmS46njhcTqc8w4ZPFnB+kDMjqLTpYWtRZo+ff53M=;
        b=PRtK00E85kSVbIJnsQF0DrM1hy3gJqz3BnRu9yXXLT6nVT1rW2WLw2Yb4a/KjGGhnt
         25kXFoLmkThV/euFkYtXJsdp2OiBc+qYySLWUnzf55BXHNiHo9mfgdT6GN9/PdXwU5wN
         GvzESJ97ZazM5EQbwgMHzHdigTVUbqA7A/8TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ExlmS46njhcTqc8w4ZPFnB+kDMjqLTpYWtRZo+ff53M=;
        b=Wq62u3dQXH1gq+ww90UX3180z9RYfP8SuO+onUmo6vEZpXsq/04Xr1CchUO/9tA+Qp
         zg+mnLs8WIc7Soq064sVRAAUgO6LVY/S8spVk4QQAid8DH2dnGRYVKBfApOu+3cLJQem
         B0m91cp5AVumdvkBX2UozB0eJPYCH6S3fUh2a5uty5vHhZVRq3h/xJy+bhH0oEUYt5Nz
         K2amsqp2KpdkVc6uqs48kjUMJxLAleAq1sd7Ra08ZuPWvJEsWuNVjosbmeQKaMxvDpgn
         o70ei93itQhUkpe8cZbdwz2r8PtZzdfb5TYecUblCrx9WOklS8ry+6zQqgU62nxYWOEx
         tcxw==
X-Gm-Message-State: APjAAAVnUjcTABkTpmcEuVlds9my+HqXPBgbfz+hTlrB7qBHc1/f2+Y0
        xuhDFnJgmDivNbFVVlLzY2nfIQ==
X-Google-Smtp-Source: APXvYqzcReuQJC8MlMnkzQWKu9Og1hzOuQP9u1WS/LcLFPGJihFE/W2h588XoFzChVf3l4AKdwO7dQ==
X-Received: by 2002:ae9:f205:: with SMTP id m5mr15779969qkg.152.1581963783082;
        Mon, 17 Feb 2020 10:23:03 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u12sm587641qtj.84.2020.02.17.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 10:23:02 -0800 (PST)
Date:   Mon, 17 Feb 2020 13:23:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, elver@google.com
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200217182302.GD112239@google.com>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
 <20200215002520.15746-1-paulmck@kernel.org>
 <20200217123851.GR14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217123851.GR14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:38:51PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 14, 2020 at 04:25:18PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
> > by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
> > applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
> > single potential store outside of rcu_tasks_kthread.
> > 
> > This data race was reported by KCSAN.  Not appropriate for backporting
> > due to failure being unlikely.
> 
> What failure is possible here? AFAICT this is (again) one of them
> load-complare-against-constant-discard patterns that are impossible to
> mess up.

You mean that because we are only testing for NULL, so load/store tearing of
rcu_tasks_cbs_head is not an issue right?

I agree. Even with invented stores, worst case we have a false-wakeup and go
right back to sleep. Or, we read a partial rcu_tasks_cbs_head, and then go
acquire the lock and read the whole thing correctly under lock.

I wonder if we can teach KCSAN to actually ignore this kind of situation so
we don't need to employ READ_ONCE() for no reason. Basically ask it to not
bother if the read was only NULL-testing. +Marco since it is KCSAN related.

thanks,

 - Joel


> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/update.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 6c4b862..a27df76 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -528,7 +528,7 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
> >  	rhp->func = func;
> >  	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
> >  	needwake = !rcu_tasks_cbs_head;
> > -	*rcu_tasks_cbs_tail = rhp;
> > +	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
> >  	rcu_tasks_cbs_tail = &rhp->next;
> >  	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
> >  	/* We can't create the thread unless interrupts are enabled. */
> > @@ -658,7 +658,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> >  		/* If there were none, wait a bit and start over. */
> >  		if (!list) {
> >  			wait_event_interruptible(rcu_tasks_cbs_wq,
> > -						 rcu_tasks_cbs_head);
> > +						 READ_ONCE(rcu_tasks_cbs_head));
> >  			if (!rcu_tasks_cbs_head) {
> >  				WARN_ON(signal_pending(current));
> >  				schedule_timeout_interruptible(HZ/10);
> > -- 
> > 2.9.5
> > 
