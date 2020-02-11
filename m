Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F3C159197
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgBKOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 09:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgBKOKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:10:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA16620675;
        Tue, 11 Feb 2020 14:10:14 +0000 (UTC)
Date:   Tue, 11 Feb 2020 09:10:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211091013.0eec4cda@gandalf.local.home>
In-Reply-To: <20200211120015.GL14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
        <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
        <20200211120015.GL14914@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 13:00:15 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> As per nmi_enter() calling rcu_nmi_enter() I've always assumed that NMIs
> are fully covered by RCU.
> 
> If this isn't so, RCU it terminally broken :-)

Most of the time it is. But for tracing that injects callbacks at
arbitrary points of code, it can break. I've always said that tracing
is a more sensitive context than NMI itself. The reason NMIs are
sensitive is because they can happen pretty much anywhere. But tracing
can happen also in the context switch that enters NMI.

This is why function tracing does the "rude" RCU flavor (yes Paul, I'd
love you to add that flavor!), that performs a schedule_on_each_cpu()
before freeing anything. Because it traces when RCU is not watching.

But RCU really shouldn't have to bend over backward for tracing, as
tracing is the exception and not the norm.

-- Steve
