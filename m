Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524C2158F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 14:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgBKNLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 08:11:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59270 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgBKNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H9mWH9EBWo8G56uksk1V/QpGUCJTJd0A9l8b0DFB9cE=; b=N/Wr7nLCnImSr7kTtQ2oARHaWQ
        6HExFan63tIT5zpyiosx7xPNq9vFSEWvsWk6v0AoKakRnkZsF4G6mofN2e9NHMYa/2Uo4f+QAi3+L
        M3sBi5KliVAhc4NykRmn5/d2Q7mWy+Hdnitatoij0J1Qmnz3hXcB3g1L0U19/ix2uditN/CnYyPD+
        PA+gkb/m5u7gr3UEoqTs9P8PHf5sDMUo18bnxehSN+vWakb5ntzQ4QFlwUpsjr0J7fwTDO7/yPmyt
        zdUd1cf4RkLyCpeSrMBJYpzV/ZHpjWrCtAH88oVMlnu+Eo1mgpsCnUp6cXkyXPNaC2bRZdIjSZY+v
        YJKkfP9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1VJQ-0003no-K0; Tue, 11 Feb 2020 13:10:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FA7330066E;
        Tue, 11 Feb 2020 14:08:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF92E20148940; Tue, 11 Feb 2020 14:10:46 +0100 (CET)
Date:   Tue, 11 Feb 2020 14:10:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200211131046.GR14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
 <20200211125929.GG2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211125929.GG2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:59:29AM -0800, Paul E. McKenney wrote:

> However, a quick grep for NMI_MASK didn't show me the NMI_MASK bit
> getting set.  Help?

| #define nmi_enter()						\
| 	do {							\
| 		arch_nmi_enter();				\
| 		printk_nmi_enter();				\
| 		lockdep_off();					\
| 		ftrace_nmi_enter();				\
| 		BUG_ON(in_nmi());				\
| 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\

		^^^^ right there

| 		rcu_nmi_enter();				\
| 		trace_hardirq_enter();				\
| 	} while (0)
