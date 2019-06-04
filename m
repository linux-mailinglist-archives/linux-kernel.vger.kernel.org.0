Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EF34B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfFDPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 11:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfFDPBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:01:35 -0400
Received: from oasis.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D372024AE5;
        Tue,  4 Jun 2019 15:01:31 +0000 (UTC)
Date:   Tue, 4 Jun 2019 11:01:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190604110127.60f1a7eb@oasis.local.home>
In-Reply-To: <3a17724b-f903-bc18-1a35-84efd3ea90c9@redhat.com>
References: <cover.1559051152.git.bristot@redhat.com>
        <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
        <20190529083357.GF2623@hirez.programming.kicks-ass.net>
        <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
        <20190531074729.GA153831@google.com>
        <3a17724b-f903-bc18-1a35-84efd3ea90c9@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 12:12:36 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> I discussed this with Steve at the Summit on the Summit (the reason why I did
> not reply this email earlier is because I was in the conf/traveling), and he
> also agrees with peterz, disabling and (mainly) re-enabling IRQs costs too much.
> 
> We need to find another way to resolve this problem (or mitigate the cost).... :-(.
> 
> Ideas?

I thought we talked about using flags in the pc to let us know that we
are about to trace the preemption off?


If an interrupt comes in, we check the flag:

	irq_enter()
		preempt_count_add(HARDIRQ_OFFSET)


Then we can have something like:

preempt_count_add(val) {
	int pc = preempt_count();
	int trace_val = TRACE_FLAG;

	if (val == HARDIRQ_OFFSET && (pc & TRACE_FLAG)) {
		__preempt_count_sub(TRACE_FLAG);
		trace_val |= TRACE_SET;
	}

	__preempt_count_add(val + trace_val);
	if (!pc)
		trace_preempt_disable();
	__preempt_count_sub(trace_val);


And in trace_preempt_enable() we have:

	if ((preempt_count() & TRACE_SET) && in_irq())
		return;

Thus, we wont call the preempt_enable tracing code if we started it due
to an interrupt preempting the process of setting the trace.

Note, I'm writing this while extremely tired (still have yet to get
more than 4 hours of sleep) so it may still have bugs, but you should
get the idea ;-)

-- Steve



