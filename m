Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526DA17B1A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEWo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgCEWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:44:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C431B206E6;
        Thu,  5 Mar 2020 22:44:24 +0000 (UTC)
Date:   Thu, 5 Mar 2020 17:44:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] exit: Move preemption fixup up, move blocking
 operations down
Message-ID: <20200305174423.7294c48b@gandalf.local.home>
In-Reply-To: <CAG48ez0UGBot8xe10pWW_bFTyFOhmQaMVpBJjEmtfM4CqdcF5w@mail.gmail.com>
References: <20200305220657.46800-1-jannh@google.com>
        <20200305171344.1f35d971@gandalf.local.home>
        <CAG48ez0UGBot8xe10pWW_bFTyFOhmQaMVpBJjEmtfM4CqdcF5w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 23:30:13 +0100
Jann Horn <jannh@google.com> wrote:

> On Thu, Mar 5, 2020 at 11:13 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu,  5 Mar 2020 23:06:57 +0100
> > Jann Horn <jannh@google.com> wrote:
> >  
> > > With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
> > > non-preemptible context look untidy; after the main oops, the kernel prints
> > > a "sleeping function called from invalid context" report because
> > > exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
> > > can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
> > > fixup.
> > >
> > > It looks like the same thing applies to profile_task_exit() and
> > > kcov_task_exit().
> > >
> > > Fix it by moving the preemption fixup up and the calls to
> > > profile_task_exit() and kcov_task_exit() down.  
> [...]
> > > +     if (unlikely(in_atomic())) {
> > > +             pr_info("note: %s[%d] exited with preempt_count %d\n",
> > > +                     current->comm, task_pid_nr(current),
> > > +                     preempt_count());  
> >
> > This should be more than a pr_info. It should also probably state the
> > "Dazed and confused, best to reboot" message.
> >
> > Because if something crashed in a non preempt section, it may likely be
> > holding a lock that it will never release, causing a soon to be deadlock!  
> 
> I didn't write that code, I'm just moving it around. :P But I guess if

Ah, I didn't scroll down enough to see it was just moved.

> you want, I can change it in the same patch... something like this on
> top? Does that look reasonable?

No, an update to the text should be done as a separate patch, as it is a
different type of change.

Thanks,

-- Steve

> 
>         if (unlikely(in_atomic())) {
> -               pr_info("note: %s[%d] exited with preempt_count %d\n",
> +               pr_emerg("note: %s[%d] exited with preempt_count %d,
> system might deadlock, please reboot\n",
>                         current->comm, task_pid_nr(current),
>                         preempt_count());
>                 preempt_count_set(PREEMPT_ENABLED);

