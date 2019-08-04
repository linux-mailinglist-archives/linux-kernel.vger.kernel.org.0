Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC980B49
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfHDOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 10:53:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfHDOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 10:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J0f8NcZWBTaPEpxB3Q2uAE6Fl3HGqWPvoXKHoJaYSuE=; b=BQqOEfMDnRDOqdI3zjyJSioLH
        ijupLADuURkUgqwPRHgc9JSsF10z9trwSk1z/n9GIyDi1Rk+ftCOhhGcAMirJTKkw5zsAEMND+vn4
        qCboKxtKd1bFZuinJ8P/5nMFoxFM/rwgwCcECSo95NLCoAawaT+j4jbI4TcTe5hoXiv967vgehmmi
        +/0t1WGUCPuaDR04TOjHfVYe72OATg3E1IqKYi5AZDFfZqDXr7uguqgeQOd8B8bhZrqwxshVHIQTa
        S3C04pY0ZQVuT2pNemVwzDFh020uo7DLTZR69j57/a/J5n2qxmKPZR4teb2i41y5nmjs5pr+KSz5d
        XwEU7RpPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huHsN-0007Ru-Sb; Sun, 04 Aug 2019 14:52:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F1A320274D7B; Sun,  4 Aug 2019 16:52:46 +0200 (CEST)
Date:   Sun, 4 Aug 2019 16:52:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 01/14] rcu/nocb: Atomic ->len field in
 rcu_segcblist structure
Message-ID: <20190804145246.GC2386@hirez.programming.kicks-ass.net>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-1-paulmck@linux.ibm.com>
 <20190804145051.GG2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804145051.GG2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 04:50:51PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 08:14:48AM -0700, Paul E. McKenney wrote:
> > +/*
> > + * Exchange the numeric length of the specified rcu_segcblist structure
> > + * with the specified value.  This can cause the ->len field to disagree
> > + * with the actual number of callbacks on the structure.  This exchange is
> > + * fully ordered with respect to the callers accesses both before and after.
> > + */
> > +long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> > +{
> > +#ifdef CONFIG_RCU_NOCB_CPU
> > +	return atomic_long_xchg(&rsclp->len, v);
> > +#else
> > +	long ret = rsclp->len;
> > +
> > +	smp_mb(); /* Up to the caller! */
> > +	WRITE_ONCE(rsclp->len, v);
> > +	smp_mb(); /* Up to the caller! */
> > +	return ret;
> > +#endif
> > +}
> 
> That one's weird; for matching semantics the load needs to be between
> the memory barriers.

Also, since you WRITE_ONCE() the thing, the load needs to be a
READ_ONCE().
