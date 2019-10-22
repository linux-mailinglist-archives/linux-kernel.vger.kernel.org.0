Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B1E0DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfJVVEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 17:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfJVVEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:04:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F13F20B7C;
        Tue, 22 Oct 2019 21:04:32 +0000 (UTC)
Date:   Tue, 22 Oct 2019 17:04:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022170430.6af3b360@gandalf.local.home>
In-Reply-To: <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
        <20191021204310.3c26f730@oasis.local.home>
        <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
        <20191021231630.49805757@oasis.local.home>
        <20191021231904.4b968dc1@oasis.local.home>
        <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
        <20191022071956.07e21543@gandalf.local.home>
        <20191022094455.6a0a1a27@gandalf.local.home>
        <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
        <20191022141021.2c4496c2@gandalf.local.home>
        <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 13:46:23 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Oct 22, 2019 at 02:10:21PM -0400, Steven Rostedt wrote:
> > On Tue, 22 Oct 2019 10:50:56 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >   
> > > > +static void my_hijack_func(unsigned long ip, unsigned long pip,
> > > > +			   struct ftrace_ops *ops, struct pt_regs *regs)    
> > > 
> > > 1.
> > > To pass regs into the callback ftrace_regs_caller() has huge amount
> > > of stores to do. Saving selector registers is not fast. pushf/popf are even slower.
> > > ~200 bytes of stack is being used for save/restore.
> > > This is pure overhead that bpf execution cannot afford.
> > > bpf is different from traditional ftrace and other tracing, since
> > > it's often active 24/7. Every nanosecond counts.  
> > 
> > Live patching is the same as what you have. If not even more critical.
> > 
> > Note, it would be easy to also implement a "just give me IP regs" flag,
> > or have that be the default if IPMODIFY is set and REGS is not.  
> 
> And that will reduce overhead from 20+ regs save/restore into 3-4 ?

Huge difference.

> Say, it's only two regs (rbp and rip). Why bpf side has to pay this runtime
> penalty? I see no good technical reason.

Because we have existing infrastructure, and we don't need to rewrite
the world from scratch. Let's try this out first, and then you show me
how much of an overhead this is to prove that bpf deserves to create a
new infrastructure.

> 
> >   
> > > So for bpf I'm generating assembler trampoline tailored to specific kernel
> > > function that has its fentry nop replaced with a call to that trampoline.
> > > Instead of 20+ register save I save only arguments of that kernel function.
> > > For example the trampoline that attaches to kfree_skb() will save only two registers
> > > (rbp and rdi on x86) and will use 16 bytes of stack.
> > > 
> > > 2.
> > > The common ftrace callback api allows ftrace infra to use generic ftrace_ops_list_func()
> > > that works for all ftracers, but it doesn't scale.  
> > 
> > That only happens if you have more than one callback to a same
> > function. Otherwise you get a dedicated trampoline.  
> 
> That's exactly what I tried to explain below. We have production use case
> with 2 kprobes (backed by ftrace) at the same function.
> fwiw the function is tcp_retransmit_skb.

As I state below, you can merge it into a single ftrace_ops.


> 
> > > We see different teams writing bpf services that attach to the same function.
> > > In addition there are 30+ kprobes active in other places, so for every
> > > fentry the ftrace_ops_list_func() walks long linked list and does hash
> > > lookup for each. That's not efficient and we see this slowdown in practice.
> > > Because of unique trampoline for every kernel function single
> > > generic list caller is not possible.
> > > Instead generated unique trampoline handles all attached bpf program
> > > for this particular kernel function in a sequence of calls.  
> > 
> > Why not have a single ftrace_ops() that calls this utility and do the
> > multiplexing then?  
> 
> because it's not an acceptable overhead.

Prove it! (with the non regs case)

> 
> > > No link lists to walk, no hash tables to lookup.
> > > All overhead is gone.
> > > 
> > > 3.
> > > The existing kprobe bpf progs are using pt_regs to read arguments. Due to  
> > 
> > That was done because kprobes in general work off of int3. And the
> > saving of pt_regs was to reuse the code and allow kprobes to work both
> > with or without a ftrace helper.  
> 
> sure. that makes sense. That's why ftrace-based kprobes are the best
> and fastest kernel infra today for bpf to attach to.
> But after using it all in prod we see that it's too slow for ever growing
> demands which are bpf specific. All the optimizations that went
> into kprobe handling do help. No doubt about that. But here I'm talking
> about removing _all_ overhead. Not just making kprobe 2-3 times faster.

You said yourself that the reg saving overhead is too much. The
pushf/popf is hard too. And I agree that that is unacceptable overhead.
That's why we have two function callers: One with and one without
saving regs. Because I knew that was expensive and we didn't need to
cause everyone to suffer just to have kprobes work with ftrace.

I gave a solution for this. And that is to add another flag to allow
for just the minimum to change the ip. And we can even add another flag
to allow for changing the stack if needed (to emulate a call with the
same parameters).

The world is not just bpf. Does Facebook now own the Linux kernel?

By doing this work, live kernel patching will also benefit. Because it
is also dealing with the unnecessary overhead of saving regs.

And we could possibly even have kprobes benefit from this if a kprobe
doesn't need full regs.

> 
> > > that ugliness all of them are written for single architecture (x86-64).
> > > Porting them to arm64 is not that hard, but porting to 32-bit arch is close
> > > to impossible. With custom generated trampoline we'll have bpf progs that
> > > work as-is on all archs. raw_tracepoint bpf progs already demonstrated
> > > that such portability is possible. This new kprobe++ progs will be similar.
> > > 
> > > 4.
> > > Due to uniqueness of bpf trampoline sharing trampoline between ftracers
> > > and bpf progs is not possible, so users would have to choose whether to
> > > ftrace that particular kernel function or attach bpf to it.
> > > Attach is not going to stomp on each other. I'm reusing ftrace_make_call/nop
> > > approach that checks that its a 'nop' being replaced.  
> > 
> > What about the approach I showed here? Just register a ftrace_ops with
> > ip modify set, and then call you unique trampoline directly.  
> 
> It's 100% unnecessary overhead.

Prove it!

The only benchmarks you are dealing with is using kprobes, which is
known to add added overhead. But you are not even considering to use
something that can handle it without the full regs.

I could probably whip up a POC patch set to get this working in a
day or two.

> 
> > It would keep the modification all in one place instead of having
> > multiple implementations of it. We can make ftrace call your trampoline
> > just like it was called directly, without writing a whole new
> > infrastructure.  
> 
> That is not true at all.
> I haven't posted the code yet, but you're already arguing about
> hypothetical code duplication.
> There is none so far. I'm not reinventing ftrace.
> There will be no FTRACE_OPS_FL_* flags, no ftrace_ops equivalent.
> None of it applies.
> Since Peter is replacing ftrace specific nop->int3->call patching
> with text_poke() I can just use that.


But you said that you can't have this and trace the functions at the
same time. Which also means you can't do live kernel patching on these
functions either.

-- Steve
