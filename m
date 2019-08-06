Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69F283370
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfHFOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 10:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHFOAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:00:19 -0400
Received: from home.goodmis.org (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D691220C01;
        Tue,  6 Aug 2019 14:00:17 +0000 (UTC)
Date:   Tue, 6 Aug 2019 09:59:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Garnier <thgarnie@chromium.org>,
        kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        keescook@chromium.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/11] x86/entry/64: Adapt assembly for PIE support
Message-ID: <20190806135942.xnuovr4vbanbxneb@home.goodmis.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-5-thgarnie@chromium.org>
 <20190805172854.GF18785@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805172854.GF18785@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 07:28:54PM +0200, Borislav Petkov wrote:
> >  1:
> > @@ -1571,7 +1572,8 @@ nested_nmi:
> >  	pushq	%rdx
> >  	pushfq
> >  	pushq	$__KERNEL_CS
> > -	pushq	$repeat_nmi
> > +	leaq	repeat_nmi(%rip), %rdx
> > +	pushq	%rdx
> >  
> >  	/* Put stack back */
> >  	addq	$(6*8), %rsp
> > @@ -1610,7 +1612,11 @@ first_nmi:
> >  	addq	$8, (%rsp)	/* Fix up RSP */
> >  	pushfq			/* RFLAGS */
> >  	pushq	$__KERNEL_CS	/* CS */
> > -	pushq	$1f		/* RIP */
> > +	pushq	$0		/* Future return address */
> > +	pushq	%rax		/* Save RAX */
> > +	leaq	1f(%rip), %rax	/* RIP */
> > +	movq    %rax, 8(%rsp)   /* Put 1f on return address */
> > +	popq	%rax		/* Restore RAX */
> 
> Can't you just use a callee-clobbered reg here instead of preserving
> %rax?

As Peter stated later in this thread, we only have the IRQ stack frame saved
here, because we just took an NMI, and this is the logic to determine if it
was a nested NMI or not (where we have to be *very* careful about touching the
stack!)

That said, the code modified here is to test the NMI nesting logic (only
enabled with CONFIG_DEBUG_ENTRY), and what it is doing is re-enabling NMIs
before calling the first NMI handler, to help trigger nested NMIs without the
need of a break point or page fault (iret enables NMIs again).

This code is in the path of the "first nmi" (we confirmed that this is not
nested), which means that it should be safe to push onto the stack.

Yes, we need to save and restore whatever reg we used. The only comment I
would make is to use %rdx instead of %rax as that has been our "scratch"
register used before saving pt_regs. Just to be consistent.

-- Steve


