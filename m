Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9B147991
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 09:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgAXIpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 03:45:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:53033 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAXIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:45:21 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00O8ipf2015536;
        Fri, 24 Jan 2020 02:44:51 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 00O8ioUT015535;
        Fri, 24 Jan 2020 02:44:50 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 24 Jan 2020 02:44:50 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/irq: don't use current_stack_pointer() in check_stack_overflow()
Message-ID: <20200124084450.GS3191@gate.crashing.org>
References: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr> <87d0b9iez3.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0b9iez3.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Jan 24, 2020 at 04:46:24PM +1100, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> >  static inline void check_stack_overflow(void)
> >  {
> >  #ifdef CONFIG_DEBUG_STACKOVERFLOW
> > -	long sp;
> > -
> > -	sp = current_stack_pointer() & (THREAD_SIZE-1);
> > +	register unsigned long r1 asm("r1");
> > +	long sp = r1 & (THREAD_SIZE - 1);
> 
> This appears to work but seems to be "unsupported" by GCC, and clang
> actually complains about it:
> 
>   /linux/arch/powerpc/kernel/irq.c:603:12: error: variable 'r1' is uninitialized when used here [-Werror,-Wuninitialized]
>           long sp = r1 & (THREAD_SIZE - 1);
>                     ^~
> 
> The GCC docs say:
> 
>   The only supported use for this feature is to specify registers for
>   input and output operands when calling Extended asm (see Extended
>   Asm).
> 
> https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Local-Register-Variables.html#Local-Register-Variables

Yes.  Don't use local register variables any other way.  It *will* break.

> If I do this it seems to work, but feels a little dicey:
> 
> 	asm ("" : "=r" (r1));
> 	sp = r1 & (THREAD_SIZE - 1);

The only thing dicey about that is that you are writing to r1.  Heh.
Well that certainly is bad enough, the compiler does not know how to
handle that at all...  Of course you aren't *actually* changing
anything, so it might just work.


Segher
