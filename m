Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B26D5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbfGRUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 16:46:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:34474 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRUq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:46:57 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6IKkXQ7011057;
        Thu, 18 Jul 2019 15:46:33 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6IKkVH0011056;
        Thu, 18 Jul 2019 15:46:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 18 Jul 2019 15:46:31 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
Message-ID: <20190718204631.GV20882@gate.crashing.org>
References: <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com> <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au> <20190715072959.GB20882@gate.crashing.org> <87pnma89ak.fsf@concordia.ellerman.id.au> <20190717143811.GL20882@gate.crashing.org> <CAK7LNATesRrJFGZQOkTY+PL7FNyub5FJ0N6NF4s6icdXdPNr+Q@mail.gmail.com> <20190717164628.GN20882@gate.crashing.org> <CAK7LNAR7jkq1fAi_=xgsANCkgP2AAej9Yv7RZB3B_cpD7C_71Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR7jkq1fAi_=xgsANCkgP2AAej9Yv7RZB3B_cpD7C_71Q@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Jul 18, 2019 at 11:19:58AM +0900, Masahiro Yamada wrote:
> On Thu, Jul 18, 2019 at 1:46 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> Kbuild always uses thin archives as far as vmlinux is concerned.
> 
> But, there are some other call-sites.
> 
> masahiro@pug:~/ref/linux$ git grep  '$(AR)' -- :^Documentation :^tools
> arch/powerpc/boot/Makefile:    BOOTAR := $(AR)
> arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBC_A) $(notdir $@) > $@
> arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBGCC_A) $(notdir $@) > $@
> lib/raid6/test/Makefile:         $(AR) cq $@ $^
> scripts/Kbuild.include:ar-option = $(call try-run, $(AR) rc$(1)
> "$$TMP",$(1),$(2))
> scripts/Makefile.build:      cmd_ar_builtin = rm -f $@; $(AR)
> rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> scripts/Makefile.lib:      cmd_ar = rm -f $@; $(AR)
> rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> 
> Probably, you are interested in arch/powerpc/boot/Makefile.

That one seems fine actually.  The raid6 one I don't know.


My original commit message was

    Without this, some versions of GNU ar fail to create
    an archive index if the object files it is packing
    together are of a different object format than ar's
    default format (for example, binutils compiled to
    default to 64-bit, with 32-bit objects).

but I cannot reproduce the problem anymore.  Shortly after my patch the
thin archive code happened to binutils, and that overhauled some other
things, which might have fixed it already?

> > Yes, I know.  This isn't about built-in.[oa], it is about *other*
> > archives we at least *used to* create.  If we *know* we do not anymore,
> > then this workaround can of course be removed (and good riddance).
> 
> If it is not about built-in.[oa],
> which archive are you talking about?
> 
> Can you pin-point the one?

No, not anymore.  Lost in the mists of time, I guess?  I think we'll
just have to file it as "it seems to work fine now".

Thank you (and everyone else) for the time looking at this!


Segher
