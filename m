Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708C415935D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 16:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgBKPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 10:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgBKPkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:40:41 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8224B2051A;
        Tue, 11 Feb 2020 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581435640;
        bh=KoYS0iXj/eJsDEu0+lYjdvr+ZJbWlvwpQUch8opzg+M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rhZlCTXOLT+6WhEa+9VmEwHX4qlMWVNXiC+n8yb6sVMDNfTWBzGLHV0N0rQPB8EBD
         BV13I/1o93QY3+EjCOtIgtc2fsbTGPFIXu/J2dJE/9dszKNFdDohR9F4i15tP+6VXk
         iy5kpfCbGHPJF4pEzGH5+GK4Hkf0aj0bGfRZ12iw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 393F13520CBE; Tue, 11 Feb 2020 07:40:38 -0800 (PST)
Date:   Tue, 11 Feb 2020 07:40:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211154038.GL2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
 <20200211090503.68c0d70f@gandalf.local.home>
 <20200211150615.GK2935@paulmck-ThinkPad-P72>
 <20200211153124.GV14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211153124.GV14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:31:24PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2020 at 07:06:15AM -0800, Paul E. McKenney wrote:
> > And I have to ask...  What happens if we are very early in from-idle
> > NMI entry (or very late in NMI exit), such that both in_nmi() and
> > rcu_is_watching() are returning false?  Or did I miss a turn somewhere?
> 
> We must, by very careful inspection, ensure that doesn't happen.
> 
> No tracing must happen before preempt_count increment / after
> preempt_count decrement. Otherwise we can no longer recover.

I was afraid of that, but agreed.  ;-)

						Thanx, Paul
