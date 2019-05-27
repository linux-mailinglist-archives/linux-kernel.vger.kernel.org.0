Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1812B1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfE0KKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 06:10:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0KKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rjtcv9CLgR1FWWJCRzKxKTtmNHAMOYpWEqbUfZqa7mM=; b=sfGuFxve3XnCMblp+HqaTLANP
        5i85Ryt/ah4/IReURE2GGmwau0ilfhwb64ZhwKcMeFcIOwlVjqAyZmA8b3HOvWcGb1p7QfXPtSswA
        SvV+mZJeL4qwmPv+zHPSbFJAsTp3X3TOaHi5akujKPz69FOmsjdMTst2Hf4aqrC5vt4gZslie2eiw
        VAe9zChiZ5UOJ6v/cyl9ot4ubXB8O1DUbCnLYLAP61vsN4Fs9d41nMrABQFmongUMXB0Az8UnX1N0
        zyYAiRfYYKwqIsuXdkXw6GROOWe4BKw7xDoWas4d2ZNbDa+O88Oll5mSxKaegVY7VrtlABEyEgzME
        wAGb8vhhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVCZz-0002Bq-9P; Mon, 27 May 2019 10:10:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BD55202BF402; Mon, 27 May 2019 12:10:04 +0200 (CEST)
Date:   Mon, 27 May 2019 12:10:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 03/14 v2] function_graph: Allow multiple users to
 attach to function graph
Message-ID: <20190527101004.GW2623@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
 <20190520142156.992391836@goodmis.org>
 <20190524112608.GJ2589@hirez.programming.kicks-ass.net>
 <20190524081219.25de03f6@gandalf.local.home>
 <20190524122724.GO2623@hirez.programming.kicks-ass.net>
 <20190524085744.71557f32@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524085744.71557f32@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 08:57:44AM -0400, Steven Rostedt wrote:
> On Fri, 24 May 2019 14:27:24 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Believe me, I rather not have that array, but I couldn't come up with a
> > > better solution to handle freeing of fgraph_ops.  
> > 
> > The trivial answer would be to refcount the thing, but can't we make
> > rcu_tasks do this?
> 
> But wouldn't refcounts require atomic operations, something that would
> be excruciatingly slow for something that runs on all functions.

Obviously, which is why I suggested something else :-)

> rcu_tasks doesn't cross voluntary sleeps, which this does.

Sure, but we can 'fix' that, surely. Alternatively we use SRCU, or
something else, a blend between SRCU and percpu-rwsem for example, SRCU
has that annoying smp_mb() on the read side, where percpu-rwsem doesn't
have that.

> > And delay the unreg until all active users are gone -- who gives a crap
> > that can take a while.
> 
> It could literally be forever (well, until the machine reboots). And
> something that could appear to be a memory leak, although a very slow
> one. But probably be hard to have more than the number of tasks on the
> system.

Again, who cares.. ? How often do you have return trace functions that
dissapear, afaict that only happens with modules, and neither
function_graph_trace nor kprobes are modules.

It'll just mean the module unload will be stuck, possibly forever.
That's not something I care about. Also, if we _really_ care, we can
mandate that module users use some sort of ugly trampoline that covers
their asses at the cost of some performance.

Getting rid of that array makes this code far saner (and I suspect
faster too).
