Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F565A8913
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfIDO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 10:58:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbfIDO6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:58:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB0D28;
        Wed,  4 Sep 2019 07:58:03 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2D7E3F59C;
        Wed,  4 Sep 2019 07:58:01 -0700 (PDT)
Date:   Wed, 4 Sep 2019 15:57:59 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jirka =?utf-8?Q?Hladk=C3=BD?= <jhladky@redhat.com>,
        =?utf-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
Message-ID: <20190904145759.xljofuqibwbwxzfx@e107158-lin.cambridge.arm.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com>
 <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com>
 <20190904142017.kz7dj2cc43wvs4ve@e107158-lin.cambridge.arm.com>
 <20190904144159.GE240514@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904144159.GE240514@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/19 10:41, Joel Fernandes wrote:
> On Wed, Sep 04, 2019 at 03:20:17PM +0100, Qais Yousef wrote:
> > On 09/04/19 09:06, Joel Fernandes wrote:
> > > > 
> > > > It is actually true.
> > > >
> > > > But you need to make the distinction between a tracepoint
> > > > and a trace event first.
> > > 
> > > I know this distinction well.
> > > 
> > > > What Valentin is talking about here is the *bare*
> > > > tracepoint without any event associated with them like the one I added to the
> > > > scheduler recently. These ones are not accessible via eBPF, unless something
> > > > has changed since I last tried.
> > > 
> > > Can this tracepoint be registered on with tracepoint_probe_register()?
> > > Quickly looking at these new tracepoint, they can be otherwise how would they
> > > even work right? If so, then eBPF can very well access it. Look at
> > > __bpf_probe_register() and bpf_raw_tracepoint_open() which implement the
> > > BPF_RAW_TRACEPOINT_OPEN.
> > 
> > Humm okay. I tried to use raw tracepoint with bcc but failed to attach. But
> > maybe I missed something on the way it should be used. AFAICT it was missing
> > the bits that I implemented in [1]. Maybe the method you mention is lower level
> > than bcc.
> 
> Oh, Ok. Not sure about BCC. I know that facebook folks are using *existing*
> tracepoints (not trace events) to probe context switches and such (probably
> not through BCC but some other BPF tracing code). Peter had rejected trace
> events they were trying to add IIRC, so they added BPF_RAW_TRACEPOINT_OPEN
> then IIRC.

Looking at the history BPF_RAW_TRACEPOINT_OPEN was added with the support for
RAW_TRACEPOINT c4f6699dfcb8 (bpf: introduce BPF_RAW_TRACEPOINT).

Anyway, if you ever get a chance please try it and let me know. I might have
done something wrong and you're more of a eBPF guru than I am :-)

> 
> > > > The current infrastructure needs to be expanded to allow eBPF to attach these
> > > > bare tracepoints. Something similar to what I have in [1] is needed - but
> > > > instead of creating a new macro it needs to expand the current macro. [2] might
> > > > give full context of when I was trying to come up with alternatives to using
> > > > trace events.
> > > > 
> > > > [1] https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> > > > [2] https://lore.kernel.org/lkml/20190415144945.tumeop4djyj45v6k@e107158-lin.cambridge.arm.com/
> > > 
> > > 
> > > As I was mentioning, tracepoints, not "trace events" can already be opened
> > > directly with BPF. I don't see how these new tracepoints are different.
> > > 
> > > I wonder if this distinction of "tracepoint" being non-ABI can be documented
> > > somewhere. I would be happy to do that if there is a place for the same. I
> > > really want some general "policy" in the kernel on where we draw a line in
> > > the sand with respect to tracepoints and ABI :).
> > > 
> > > For instance, perhaps VFS can also start having non-ABI tracepoints for the
> > > benefit of people tracing the VFS.
> > 
> > Good question. I did consider that but failed to come up with a place. AFAIU
> > the history moved from tracepoints to trace events and now moving back to
> > tracepoints. Something Steve is not very enthusiastic about.
> 
> Yeah this is a bit of a mess. I think for every recent LPC this has come up.
> But the DECLARE_TRACE approach you did is interesting in that it
> reduces/removes the API surface for trace-events at least.

Yes. And you have the flexibility to add more info to the tracepoint without
worrying about breaking current users.

Another nice feat we discovered is that you can create several trace evenets
from the same tracepoint each exposing different set of info. You can achieve
the same with the current trace events if you use tracepoint_probe_register()
of course, but not if you use the macros. The tendency for in-kernel trace
events is to have 1:1 mapping even if the events can be extracted from
a single tracepoint.

--
Qais Yousef
