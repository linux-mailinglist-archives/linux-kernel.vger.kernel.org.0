Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582EC16186C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 18:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgBQRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 12:01:59 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38526 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgBQRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:01:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so16800224qkj.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2TIpHmEKlGFQkRrpzXnSMGV4JAPA9K4ND9/xVlrWjVg=;
        b=Hs8KUB37xVJcCfyJwOgfLgDczjE3Xg5Y7u+Lg0UwQLVDOjio23W3Receyh3RS6/crJ
         m+ogxr9TahQ4JbmXlhgNdKSnuOU0X71zcPkXwWA6waCfCbQczkmKvEaBWR2E01YOb3iw
         Vp2F7Bs3i3INHlxvIFShcR6Jy3+vfeuQ7nXr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2TIpHmEKlGFQkRrpzXnSMGV4JAPA9K4ND9/xVlrWjVg=;
        b=qFpYNI3wcLMlGiUQ05ZGaKrCA6ErHPqpf4n8Bp4Dfjr4ddhEx2Rp1cGGHzytFlRLxG
         ykpfF/uU74JFKCf8aI8N5BKROVmFmtes2Q2ig6jLoP9W0UhQvaxZtZdhxUyUUS7rOIsb
         bK2+O1l9gHIZkzX+pw0t18Gt3a+5lLZ53DI1t1NCDi7sFnCubdIcRW11xZNuWV3zM9ux
         UhdndW8amioaw5V70oTLZWRUx0Cx/LR6aHnJE7YPYC/eICXPPZQYVF7AcT29/Qap9yUR
         6XSmqJZC/XouJOaX0VKl2mXnsl8XYi+skDfXMc+p/FYIFkO1hKV64WXnFm5klEtkCRCC
         sHGA==
X-Gm-Message-State: APjAAAVWLl9xPAUk1ma00Azf/0P1dsc5GwFK2xUovIaaVxZSpoM92CfU
        MsoW21+jREcP2e1LAnKP5D0BaQ==
X-Google-Smtp-Source: APXvYqyygmeXz9VPhSsb7pYE8Zs81TmDJYc3+06+cAz6umD09PnyHv7I++1TUg7vlvMod6zTjHvJfA==
X-Received: by 2002:ae9:e518:: with SMTP id w24mr14684712qkf.236.1581958918070;
        Mon, 17 Feb 2020 09:01:58 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h34sm464577qtc.62.2020.02.17.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:01:57 -0800 (PST)
Date:   Mon, 17 Feb 2020 12:01:57 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 1/4] srcu: Fix __call_srcu()/process_srcu()
 datarace
Message-ID: <20200217170157.GA166797@google.com>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
 <20200215002932.15976-1-paulmck@kernel.org>
 <20200217124231.GS14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217124231.GS14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:42:31PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 14, 2020 at 04:29:29PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The srcu_node structure's ->srcu_gp_seq_needed_exp field is accessed
> > locklessly, so updates must use WRITE_ONCE().  This commit therefore
> > adds the needed WRITE_ONCE() invocations.
> > 
> > This data race was reported by KCSAN.  Not appropriate for backporting
> > due to failure being unlikely.
> 
> This does indeed look like there can be a failure; but this Changelog
> fails to describe an actual problem.

Peter it sounds like you have a failure scenario in mind. Could you describe
more if so?

I am curious if you were thinking of invented-stores issue here.

For educational purposes, I was trying to come up with an example where my
compiler does something bad to code without WRITE_ONCE(). So far I only can
reproduce a write-tearing example when write with an immediate value is split
into 2 writes, like Will mentioned:
http://lore.kernel.org/r/20190821103200.kpufwtviqhpbuv2n@willie-the-truck
But that does not seem to apply to this code.

thanks,

 - Joel


> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 657e6a7..b1edac9 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -550,7 +550,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >  		snp->srcu_have_cbs[idx] = gpseq;
> >  		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
> >  		if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
> > -			snp->srcu_gp_seq_needed_exp = gpseq;
> > +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> >  		mask = snp->srcu_data_have_cbs[idx];
> >  		snp->srcu_data_have_cbs[idx] = 0;
> >  		spin_unlock_irq_rcu_node(snp);
> > @@ -660,7 +660,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >  		if (snp == sdp->mynode)
> >  			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> >  		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
> > -			snp->srcu_gp_seq_needed_exp = s;
> > +			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
> >  		spin_unlock_irqrestore_rcu_node(snp, flags);
> >  	}
> >  
> > -- 
> > 2.9.5
> > 
