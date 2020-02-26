Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BA717057A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 18:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBZRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 12:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbgBZRFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:05:37 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A9F2467F;
        Wed, 26 Feb 2020 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582736737;
        bh=gp7rt0swzmkwBxsp/s8luVlqOPQiL0kUz3kCiX51OH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVDa7A3zUwKqkzrlmofusxPaCbBRxpcMUgH8PLkkkaksvdDhMXmNMc3PMjCiXbmXj
         aiskMinuhgWX38059o3YO4Nj4rfVhdmB9mrkPemUVWKCcEuINAtVs/E258gh+HaU6Z
         sqhWsMD5uIvtTczTVkPC9UfL2u5gyfEPovQu/wQ0=
Date:   Wed, 26 Feb 2020 18:05:34 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C
 for simple idtentries
Message-ID: <20200226170534.GA6075@lenoir>
References: <20200225223321.231477305@linutronix.de>
 <20200225224145.444611199@linutronix.de>
 <20200226080538.GO18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226080538.GO18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:05:38AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 25, 2020 at 11:33:34PM +0100, Thomas Gleixner wrote:
> 
> > --- a/arch/x86/include/asm/idtentry.h
> > +++ b/arch/x86/include/asm/idtentry.h
> > @@ -7,14 +7,31 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > +#ifdef CONFIG_CONTEXT_TRACKING
> > +static __always_inline void enter_from_user_context(void)
> > +{
> > +	CT_WARN_ON(ct_state() != CONTEXT_USER);
> > +	user_exit_irqoff();
> > +}
> > +#else
> > +static __always_inline void enter_from_user_context(void) { }
> > +#endif
> > +
> >  /**
> >   * idtentry_enter - Handle state tracking on idtentry
> >   * @regs:	Pointer to pt_regs of interrupted context
> >   *
> > - * Place holder for now.
> > + * Invokes:
> > + *  - The hardirq tracer to keep the state consistent as low level ASM
> > + *    entry disabled interrupts.
> > + *
> > + *  - Context tracking if the exception hit user mode
> >   */
> >  static __always_inline void idtentry_enter(struct pt_regs *regs)
> >  {
> > +	trace_hardirqs_off();
> > +	if (user_mode(regs))
> > +		enter_from_user_context();
> >  }
> 
> So:
> 
> 	asm_exc_int3
> 	  exc_int3
> 	    idtentry_enter()
> 	      enter_from_user_context
> 	        if (context_tracking_enabled())
> 
> 	    poke_int3_handler();
> 
> Is, AFAICT, completely buggered.
> 
> You can't have a static_branch before the poke_int3_handler that deals
> with text_poke.

#BP is treated like an NMI in your patchset IIRC?
In that case and since that implies we can't schedule, we can remove
the call to context tracking there once we have nmi_enter()/nmi_exit()
called unconditionally.
