Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D176174EE7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCASUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 13:20:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgCASUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:20:41 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B77246CD;
        Sun,  1 Mar 2020 18:20:40 +0000 (UTC)
Date:   Sun, 1 Mar 2020 13:20:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
Message-ID: <20200301132038.7f0def72@oasis.local.home>
In-Reply-To: <87d09wf6dw.fsf@nanos.tec.linutronix.de>
References: <87imjofkhx.fsf@nanos.tec.linutronix.de>
        <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net>
        <87d09wf6dw.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Mar 2020 16:21:15 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Andy Lutomirski <luto@amacapital.net> writes:
> >> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
> >> except trace_hardirq_off/on() as those trace functions do not allow to
> >> attach anything AFAICT.  
> >
> > Can you point to whatever makes those particular functions special?  I
> > failed to follow the macro maze.  
> 
> Those are not tracepoints and not going through the macro maze. See
> kernel/trace/trace_preemptirq.c

For the latency tracing, they do call into the tracing infrastructure,
not just lockdep. And Joel Fernandez did try to make these into trace
events as well.

-- Steve
