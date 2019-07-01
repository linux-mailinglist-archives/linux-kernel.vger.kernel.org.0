Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A981148E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfFQT07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:26:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfFQT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tTa6YLg6Fw8pyO+p/GpITBEPaY2o10TxNKbfMEC5jGQ=; b=IbzbYZzlV6AJRQPzQc3Eo34AEp
        esr+xNKMcFGEUw+XaszOj/VQ8JCkicLwy1U1RvfaJlaU5kf7/TQaZv0a4r/We2Nv/mIlz9XDb3p7L
        XjO7laBbjM6tq84Fs9Kw3tz/slUsLfKisuP4h7sGRRkPATlNNCnDoJWTak7gImHYtVRHxSNf0qA3S
        szFohYlOFNhxSpiqa4ULIJRwJtJgIpLgEY2vebhWNJKfFrYPAXOKTXZd0o3gmaTowGUXsMmGYPXZG
        /devuciK1QPb+7Fab78TP1/57fgaCU0+UdN4dkJpFKk049Uz03/FulFPtrrLM2m77HMp4qL4SZ04D
        ahyuwcXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcxGh-0002pp-JK; Mon, 17 Jun 2019 19:26:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5377B201F4619; Mon, 17 Jun 2019 21:26:12 +0200 (CEST)
Date:   Mon, 17 Jun 2019 21:26:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190617192612.GD3419@hirez.programming.kicks-ass.net>
References: <20190605131945.005681046@infradead.org>
 <20190608004708.7646b287151cf613838ce05f@kernel.org>
 <20190607173427.GK3436@hirez.programming.kicks-ass.net>
 <3DA961AB-950B-4886-9656-C0D268D521F1@amacapital.net>
 <20190611080307.GN3436@hirez.programming.kicks-ass.net>
 <20190611112254.576226fe@gandalf.local.home>
 <20190611155537.GB3436@hirez.programming.kicks-ass.net>
 <D9439F7B-3384-4BD5-B3BA-13EE52FEC15E@vmware.com>
 <20190617144213.GE3436@hirez.programming.kicks-ass.net>
 <CALCETrW7u0HFzWvULou5pKDW1=MsPg9pGFqFnOEiHxpniy8S8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrW7u0HFzWvULou5pKDW1=MsPg9pGFqFnOEiHxpniy8S8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:25:27AM -0700, Andy Lutomirski wrote:
> On Mon, Jun 17, 2019 at 7:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jun 12, 2019 at 07:44:12PM +0000, Nadav Amit wrote:
> >
> > > I have run into similar problems before.
> > >
> > > I had two problematic scenarios. In the first case, I had a “call” in the
> > > middle of the patched code-block, but this call was always followed by a
> > > “jump” to the end of the potentially patched code-block, so I did not have
> > > the problem.
> > >
> > > In the second case, I had an indirect call (which is shorter than a direct
> >
> > Longer, 6 bytes vs 5 if I'm not mistaken.
> >
> > > call) being patched into a direct call. In this case, I preceded the
> > > indirect call with NOPs so indeed the indirect call was at the end of the
> > > patched block.
> > >
> > > In certain cases, if a shorter instruction should be potentially patched
> > > into a longer one, the shorter one can be preceded by some prefixes. If
> > > there are multiple REX prefixes, for instance, the CPU only uses the last
> > > one, IIRC. This can allow to avoid synchronize_sched() when patching a
> > > single instruction into another instruction with a different length.
> > >
> > > Not sure how helpful this information is, but sharing - just in case.
> >
> > I think we can patch multiple instructions provided:
> >
> >  - all but one instruction are a NOP,
> >  - there are no branch targets inside the range.
> >
> > By poking INT3 at every instruction in the range and then doing the
> > machine wide IPI+SYNC, we'll trap every CPU that is in-side the range.
> 
> How do you know you'll trap them?  You need to IPI, serialize, and get
> them to execute an instruction.  If the CPU is in an interrupt and RIP
> just happens to be pointed to the INT3, you need them to execute a
> whole lot more than just one instruction.

Argh, yes, I'm an idiot.
