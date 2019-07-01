Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481045B8EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 12:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfGAKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 06:24:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:24:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hhtUI-0002kx-SR; Mon, 01 Jul 2019 12:24:43 +0200
Date:   Mon, 1 Jul 2019 12:24:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190701102442.35grdpcsbrwyyaco@linutronix.de>
References: <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <20190628155404.GV26519@linux.ibm.com>
 <20190628160408.GH32547@worktop.programming.kicks-ass.net>
 <20190628172056.GW26519@linux.ibm.com>
 <20190701094215.GR3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701094215.GR3402@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-01 11:42:15 [+0200], Peter Zijlstra wrote:
> I'm not sure if smp_send_reschedule() can be used as self-IPI, some
> hardware doesn't particularly like that IIRC. That is, hardware might
> only have interfaces to IPI _other_ CPUs, but not self.
> 
> The normal scheduler code takes care to not call smp_send_reschedule()
> to self.

and irq_work:
  471ba0e686cb1 ("irq_work: Do not raise an IPI when queueing work on the local CPU")

Sebastian
