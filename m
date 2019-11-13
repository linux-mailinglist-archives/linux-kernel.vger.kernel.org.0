Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E36FBAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 22:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKMVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 16:41:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39127 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:41:44 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iV0OR-0006sP-R1; Wed, 13 Nov 2019 22:41:40 +0100
Date:   Wed, 13 Nov 2019 22:41:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V3 02/20] x86/process: Unify copy_thread_tls()
In-Reply-To: <CAHk-=whNAEuNPU3Oy_-EpjOojpysWcCh4uqDgOt2RjBNx2xBSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911132237410.2507@nanos.tec.linutronix.de>
References: <20191113204240.767922595@linutronix.de> <20191113210103.911310593@linutronix.de> <CAHk-=whNAEuNPU3Oy_-EpjOojpysWcCh4uqDgOt2RjBNx2xBSg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Linus Torvalds wrote:
> On Wed, Nov 13, 2019 at 1:02 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > +int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
> > +                   unsigned long arg, struct task_struct *p, unsigned long tls)
> ...
> > +#ifdef CONFIG_X86_64
> ..
> > +#else
> > +       /* Clear all status flags including IF and set fixed bit. */
> > +       frame->flags = X86_EFLAGS_FIXED;
> > +#endif
> 
> Hmm. The unification I like, but it also shows these differences that
> I don't remember the reason for.
> 
> Remind me why __switch_to_asm() on 32-bit safes eflags, but we don't
> do it on x86-64?
> 
> The comment just talks about callee-saved registers, but flags isn't
> callee-saved, so there's something else going on.
> 
> This patch clearly doesn't change anything, I'm not complaining about
> the patch at all. I'm just wondering about the odd difference that the
> patch exposes.

See commit: 64604d54d311 ("sched/x86_64: Don't save flags on context switch")

We need "only" make objtool support 32bit :)

Thanks,

	tglx
