Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9956918C598
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 04:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCTDJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 23:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgCTDJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:09:49 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD12B2070A;
        Fri, 20 Mar 2020 03:09:46 +0000 (UTC)
Date:   Thu, 19 Mar 2020 23:09:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RFC v2 tip/core/rcu 01/22] sched/core: Add function to
 sample state of locked-down task
Message-ID: <20200319230945.3f4701ed@oasis.local.home>
In-Reply-To: <20200320024943.GA29649@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
        <20200319001100.24917-1-paulmck@kernel.org>
        <20200319132238.75a034c3@gandalf.local.home>
        <20200319173525.GI3199@paulmck-ThinkPad-P72>
        <20200320024943.GA29649@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 19:49:43 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > The current setup is very convenient for the use cases thus far.  It
> > allows the function to say "Yeah, I was called, but I couldn't do
> > anything", thus allowing the caller to make exactly one check to know
> > that corrective action is required.  
> 
> And here is another use case that led me to take this approach.
> The trc_inspect_reader_notrunning() function in the patch below is passed
> to try_invoke_on_locked_down_task() whose caller can continue testing
> just the return value from try_invoke_on_locked_down_task() to work out
> what to do next.
> 
> Thoughts?  Other use cases?

Note, I made this comment before looking at the use cases in the later
patches. I was looking at it for a more generic purpose, but I'm not
sure there is one.

It's fine as is for now.

-- Steve
