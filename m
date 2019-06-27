Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220DC58491
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfF0Oe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 10:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfF0Oe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:34:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3653A20828;
        Thu, 27 Jun 2019 14:34:57 +0000 (UTC)
Date:   Thu, 27 Jun 2019 10:34:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627103455.01014276@gandalf.local.home>
In-Reply-To: <20190627142436.GD215968@google.com>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
        <20190626162558.GY26519@linux.ibm.com>
        <20190627142436.GD215968@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 10:24:36 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > What am I missing here?  
> 
> This issue I think is
> 
> (in normal process context)
> spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> 			   // but this was done in normal process context,
> 			   // not from IRQ handler
> rcu_read_lock();
>           <---------- IPI comes in and sets exp_hint

How would an IPI come in here with interrupts disabled?

-- Steve

> rcu_read_unlock()
>    -> rcu_read_unlock_special
>         -> raise_softirq_irqoff
> 	    -> wakeup_softirq  <--- because in_interrupt returns false.  
> 
> I think the issue is in_interrupt() does not know about threaded interrupts.
> If it did, then the ksoftirqd wake up would not happen.
> 
> Did I get something wrong?

