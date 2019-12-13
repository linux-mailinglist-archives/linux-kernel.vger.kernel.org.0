Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8916611DF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 09:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLMIOc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Dec 2019 03:14:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:14:32 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifg5k-0006op-LD; Fri, 13 Dec 2019 09:14:28 +0100
Date:   Fri, 13 Dec 2019 09:14:28 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] sched: migrate_enable: Busy loop until the migration
 request is completed
Message-ID: <20191213081428.mw6bqjg6m7djwhby@linutronix.de>
References: <20191212112717.2tzoqbe3xeknoyvs@linutronix.de>
 <30ab713901ef0e1f23c1ca387373788a4a73639f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <30ab713901ef0e1f23c1ca387373788a4a73639f.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-13 00:44:22 [-0600], Scott Wood wrote:
> > @@ -8239,7 +8239,10 @@ void migrate_enable(void)
> >  		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
> >  				    &arg, &work);
> >  		__schedule(true);
> > -		WARN_ON_ONCE(!arg.done && !work.disabled);
> > +		if (!work.disabled) {
> > +			while (!arg.done)
> > +				cpu_relax();
> > +		}
> 
> We should enable preemption while spinning -- besides the general badness
> of spinning with it disabled, there could be deadlock scenarios if
> multiple CPUs are spinning in such a loop.  Long term maybe have a way to
> dequeue the no-longer-needed work instead of waiting.

Hmm. My plan was to use per-CPU memory and spin before the request is
enqueued if the previous isn't done yet (which should not happen™).
Then we could remove __schedule() here and rely on preempt_enable()
doing that. With that change we wouldn't care about migrate-disable
level vs preempt-disable level and could drop the hacks we have in futex
code for instance (where we have an extra migrate_disable() in advance
so they are later balanced). 

> -Scott

Sebastian
