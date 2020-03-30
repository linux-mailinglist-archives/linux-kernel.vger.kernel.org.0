Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4222C198510
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 22:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgC3UDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 16:03:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbgC3UDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=06Xa8ukH5SjQfzHVNdtGhnjdZb7hVhXaCewR363SUwQ=; b=jEduQCv19cJV/HSspQfxd1REcr
        AGf+IzQdBd6ddYbxOkJeFMXlkPv5kCXJ9E8HT2bvX7NlCQWl7j4bwiNn17v1oOQFqG7ipTQgHVP4H
        jy14UaQtWYGwMnoODyg5C+mHoc/S6XaYqOVO25R6s+X1RRieVggsXVJ6lFUIoWbfqFbG9xzHk5sO7
        B1VH+YD7HBszQIUKcAzVaWXVbSJqm6uSMx+wCkbwjgoyZgxmGwtAE3x13UvSKJssUzit5eRbUDr5a
        ZdB+fPOhlxVLUR62J8/mj7Gkk5L2ww3s5hHD60pK/CdP1ksTrT+KI43C8vbBoSj0l8SxxwBWl7iyb
        1ylQeQEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ0cb-00054Y-5G; Mon, 30 Mar 2020 20:02:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3A3F3012D8;
        Mon, 30 Mar 2020 22:02:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AC6C203B878A; Mon, 30 Mar 2020 22:02:54 +0200 (CEST)
Date:   Mon, 30 Mar 2020 22:02:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200330200254.GV20713@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330190205.k5ssixd5hpshpjjq@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:02:05PM -0500, Josh Poimboeuf wrote:
> On Mon, Mar 30, 2020 at 07:02:00PM +0200, Peter Zijlstra wrote:
> > Subject: objtool: Implement RET_TAIL hint
> > 
> > This replaces the SAVE/RESTORE hints with a RET_TAIL hint that applies to:
> > 
> >  - regular RETURN and sibling calls (which are also function exists)
> >    it allows the stack-frame to be off by one word, ie. it allows a
> >    return-tail-call.
> > 
> >  - EXCEPTION_RETURN (a new INSN_type that splits IRET out of
> >    CONTEXT_SWITCH) and here it denotes a return to self by having it
> >    consume arch_exception_frame_size bytes off the stack and continuing.
> > 
> > Apply this hint to ftrace_64.S and sync_core(), the two existing users
> > of the SAVE/RESTORE hints.
> > 
> > For ftrace_64.S we split the return path and make sure the
> > ftrace_epilogue call is seen as a sibling/tail-call turning it into it's
> > own function.
> > 
> > By splitting the return path every instruction has a unique stack setup
> > and ORC can generate correct unwinds (XXX check if/how the ftrace
> > trampolines map into the ORC). Then employ the RET_TAIL hint to the
> > tail-call exit that has the direct-call (orig_eax) return-tail-call on.
> > 
> > For sync_core() annotate the IRET with RET_TAIL to mark it as a
> > control-flow NOP that consumes the exception frame.
> 
> I do like the idea to get rid of SAVE/RESTORE altogether.  And it's nice
> to make that ftrace code unwinder-deterministic.
> 
> However sync_core() and ftrace_regs_caller() are very different from
> each other and I find the RET_TAIL hint usage to be extremely confusing.

I was going with the pattern:

	push target
	ret

which is an indirect tail-call that doesn't need a register. We use it
in various places. We use it here exactly because it preserves all
registers, but we use it in function-graph tracer and retprobes to
insert the return handler. But also in retpoline, because it uses the
return stack predictor, which by happy accident isn't the indirect
branch predictor.

> For example, IRETQ isn't even a tail cail.

It's the same indirect call, except with a bigger frame ;-)

	push # ss
	push # rsp
	push # flags
	push # cs
	push # ip
	iret

> And the need for the hint to come *before* the insn which changes the
> state is different from the other hints.

makes sense to me... but yah.

> And now objtool has to know the arch exception stack size because of a
> single code site.

Agreed.

> And for a proper tail call, the stack should be empty. 

All depends what you call proper :-)

> I don't
> understand the +8 thing in has_modified_stack_frame().

	push target
	ret

means we hit ret with one extra word on the stack.

> It seems
> hard-coded for the weird ftrace case, rather than for tail calls in
> general (which should already work as designed).

Like I said, we have it all over the place, but I suspect they're all
mostly hidden from objtool.

> How about a more general hint like UNWIND_HINT_ADJUST?
> 
> For sync_core(), after the IRETQ:
> 
>   UNWIND_HINT_ADJUST sp_add=40
> 
> And ftrace_regs_caller_ret could have:
> 
>   UNWIND_HINT_ADJUST sp_add=8

I like, I'll make it happen in the morning.
