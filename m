Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB03105044
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKUKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 05:16:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:34826 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfKUKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:16:24 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xALAFrfK013183;
        Thu, 21 Nov 2019 04:15:53 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id xALAFq0D013181;
        Thu, 21 Nov 2019 04:15:52 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 21 Nov 2019 04:15:52 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and call_do_softirq()
Message-ID: <20191121101552.GR16031@gate.crashing.org>
References: <f12fb9a6cc52d83ee9ddf15a36ee12ac77e6379f.1570684298.git.christophe.leroy@c-s.fr> <5ca6639b7c1c21ee4b4138b7cfb31d6245c4195c.1570684298.git.christophe.leroy@c-s.fr> <877e3tbvsa.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e3tbvsa.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 05:14:45PM +1100, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> That breaks 64-bit with GCC9:
> 
>   arch/powerpc/kernel/irq.c: In function 'do_IRQ':
>   arch/powerpc/kernel/irq.c:650:2: error: PIC register clobbered by 'r2' in 'asm'
>     650 |  asm volatile(
>         |  ^~~
>   arch/powerpc/kernel/irq.c: In function 'do_softirq_own_stack':
>   arch/powerpc/kernel/irq.c:711:2: error: PIC register clobbered by 'r2' in 'asm'
>     711 |  asm volatile(
>         |  ^~~
> 
> 
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index 04204be49577..d62fe18405a0 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -642,6 +642,22 @@ void __do_irq(struct pt_regs *regs)
> >  	irq_exit();
> >  }
> >  
> > +static inline void call_do_irq(struct pt_regs *regs, void *sp)
> > +{
> > +	register unsigned long r3 asm("r3") = (unsigned long)regs;
> > +
> > +	/* Temporarily switch r1 to sp, call __do_irq() then restore r1 */
> > +	asm volatile(
> > +		"	"PPC_STLU"	1, %2(%1);\n"
> > +		"	mr		1, %1;\n"
> > +		"	bl		%3;\n"
> > +		"	"PPC_LL"	1, 0(1);\n" :
> > +		"+r"(r3) :
> > +		"b"(sp), "i"(THREAD_SIZE - STACK_FRAME_OVERHEAD), "i"(__do_irq) :
> > +		"lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7",
> > +		"r0", "r2", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
> > +}
> 
> If we add a nop after the bl, so the linker could insert a TOC restore,
> then I don't think there's any circumstance under which we expect this
> to actually clobber r2, is there?

That is mostly correct.

If call_do_irq was a no-inline function, there would not be problems.

What TOC does __do_irq require in r2 on entry, and what will be there
when it returns?


Segher
