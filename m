Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 231B329723
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbfEXL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 07:26:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48782 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390699AbfEXL0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=urZSc9PtRmTIXnZlQzXLqeUysj9C2lLQGdh2OmGehcc=; b=KgOptn20NIjdi6wcMIC0AJ4vC
        fMk+tfJYcfwJKyyPzZ35GT0UJfB81UZfuoq+HySz9B0DiqHOX/glmMtM9E5kLiIsHL7XX90SJm0EE
        axk0OtfvO/SE2jEgtsGB80PZvzQ8c/RPa/lU/4wJRTe1DUdV6higzq4+mcmC4q4Pt20eDYX6Ydjs6
        ASA6Ichx0tm/Hv9mupqM+TBAdmYTE97RYU9C1M9czhUeZZ21QTbjZ2kEUbEmrp40//nqsDQQWSpag
        JzTeIMl/JotbqqmE9WpMDfp0E2xK+nLZR9gOfKGgzuTVaHuFchO/bk1ygiVLA0UPwXbsOPTxkDG6q
        l9An+hpWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hU8Kw-0008Ci-8V; Fri, 24 May 2019 11:26:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B53F20277364; Fri, 24 May 2019 13:26:09 +0200 (CEST)
Date:   Fri, 24 May 2019 13:26:08 +0200
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
Message-ID: <20190524112608.GJ2589@hirez.programming.kicks-ass.net>
References: <20190520142001.270067280@goodmis.org>
 <20190520142156.992391836@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520142156.992391836@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:20:04AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Allow for multiple users to attach to function graph tracer at the same
> time. Only 16 simultaneous users can attach to the tracer. This is because
> there's an array that stores the pointers to the attached fgraph_ops. When a
> a function being traced is entered, each of the ftrace_ops entryfunc is
> called and if it returns non zero, its index into the array will be added to
> the shadow stack.
> 
> On exit of the function being traced, the shadow stack will contain the
> indexes of the ftrace_ops on the array that want their retfunc to be called.
> 
> Because a function may sleep for a long time (if a task sleeps itself), the
> return of the function may be literally days later. If the ftrace_ops is
> removed, its place on the array is replaced with a ftrace_ops that contains
> the stub functions and that will be called when the function finally
> returns.

But but but but.. why not add all the required bits to the shadow stack
in the first place and do away with the array entirely?

So on ret, just keep POP'ing until either the stack is empty or the
entry is for another function.


