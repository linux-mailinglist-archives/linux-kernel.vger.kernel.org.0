Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B46CC73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfGRJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:58:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:58:54 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ho3BY-0007Fy-6S; Thu, 18 Jul 2019 11:58:48 +0200
Date:   Thu, 18 Jul 2019 11:58:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     luferry <luferry@163.com>
cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] smp: avoid generic_exec_single cause system
 lockup
In-Reply-To: <5f5fbd7.1073c.16c0446ea63.Coremail.luferry@163.com>
Message-ID: <alpine.DEB.2.21.1907181122240.1984@nanos.tec.linutronix.de>
References: <20190718080308.48381-1-luferry@163.com> <alpine.DEB.2.21.1907181007340.1778@nanos.tec.linutronix.de> <5f5fbd7.1073c.16c0446ea63.Coremail.luferry@163.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019, luferry wrote:
> At 2019-07-18 16:07:58, "Thomas Gleixner" <tglx@linutronix.de> wrote:
> >On Thu, 18 Jul 2019, luferry@163.com wrote:
> >
> >> From: luferry <luferry@163.com>
> >> 
> >> The race can reproduced by sending wait enabled IPI in softirq/irq env
> >
> >Which code path is doing that?
>
> I checked kernel and found no code path can run into this.

For a good reason.

> Actually , i encounter with this problem by my own code.
> I need to do some specific urgent work periodicity and these 
> work may run for quite a while. So i can't disable irq during these work 
> which stops me from using hrtimer to do this. So i did add an extra 
> sofitrq action which may invoke smp_call.

Well, from softirq handling context the only allowed interface is
smp_call_function_single_async().

The code is actually missing a warning to that effect. See below.

Vs. your proposed change. It's broken in various ways and no, we are not
going to support that and definitely we are not going to disable interrupts
around a loop over all cpus in a mask.

Thanks,

	tglx

8<--------------
Subject: smp: Warn on function calls from softirq context
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 18 Jul 2019 11:20:09 +0200

It's clearly documented that smp function calls cannot be invoked from
softirq handling context. Unfortunately nothing enforces that or emits a
warning.

A single function call can be invoked from softirq context only via
smp_call_function_single_async().

Reported-by: luferry <luferry@163.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/smp.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -291,6 +291,15 @@ int smp_call_function_single(int cpu, sm
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress);
 
+	/*
+	 * Can deadlock when the softirq is executed on return from
+	 * interrupt and the interrupt hit between llist_add() and
+	 * arch_send_call_function_single_ipi() because then this
+	 * invocation sees the list non-empty, skips the IPI send
+	 * and waits forever.
+	 */
+	WARN_ON_ONCE(is_serving_softirq() && wait);
+
 	csd = &csd_stack;
 	if (!wait) {
 		csd = this_cpu_ptr(&csd_data);
@@ -416,6 +425,13 @@ void smp_call_function_many(const struct
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
 		     && !oops_in_progress && !early_boot_irqs_disabled);
 
+	/*
+	 * Bottom half handlers are not allowed to call this as they might
+	 * corrupt cfd_data when the interrupt which triggered softirq
+	 * processing hit this function.
+	 */
+	WARN_ON_ONCE(is_serving_softirq());
+
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)


