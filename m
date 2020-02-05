Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F0D152459
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 02:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBEBBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 20:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbgBEBBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:01:23 -0500
Received: from oasis.local.home (unknown [213.120.252.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB942085B;
        Wed,  5 Feb 2020 01:01:20 +0000 (UTC)
Date:   Tue, 4 Feb 2020 20:01:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200204200116.479f0c60@oasis.local.home>
In-Reply-To: <20200203163301.GB85781@google.com>
References: <20200201072703.17330-1-frextrite@gmail.com>
        <20200203163301.GB85781@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 11:33:01 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:


> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -950,22 +950,25 @@ extern void __trace_graph_return(struct trace_array *tr,
> >  				 unsigned long flags, int pc);
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > -extern struct ftrace_hash *ftrace_graph_hash;
> > +extern struct ftrace_hash __rcu *ftrace_graph_hash;
> >  extern struct ftrace_hash *ftrace_graph_notrace_hash;
> >  
> >  static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
> >  {
> >  	unsigned long addr = trace->func;
> >  	int ret = 0;
> > +	struct ftrace_hash *hash;
> >  
> >  	preempt_disable_notrace();
> >  
> > -	if (ftrace_hash_empty(ftrace_graph_hash)) {
> > +	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());  
> 
> I think you can use rcu_dereference_sched() here? That way no need to pass
> !preemptible.
> 
> A preempt-disabled section is an RCU "sched flavor" section. Flavors are
> consolidated in the backend, but in the front end the dereference API still
> do have flavors.

Unfortunately, doing it with rcu_dereference_sched() causes a lockdep
splat :-P. This is because ftrace can execute when rcu is not
"watching" and that will trigger a lockdep error. That means, this
origin patch *is* correct. I'm re-applying this one.

-- Steve
