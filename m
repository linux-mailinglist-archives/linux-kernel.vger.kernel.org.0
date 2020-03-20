Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CD18C8C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 09:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCTIMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 04:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgCTIL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:11:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468DE20774;
        Fri, 20 Mar 2020 08:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584691918;
        bh=lYc2Gm2VkbImFr4gBOIFJvxM7EhVPBHGTcj7FeKzS3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDdlrKgENirCgu2oVJbm3EfDyiAqIKWPPWznYZ5hjgLwHgatWQH7p6GHldNSPfvKg
         gqbwJ09k6MWB+cuvPXbAb6dVyg7fB4lnu2iE6zFKlFqO1CUoGqaZaqdCOuoyrlmMd6
         8JPj3aou7wa+X+ia7atNIsY7WmInYlssSUNs0oVs=
Date:   Fri, 20 Mar 2020 08:11:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arm64: alternative: fix build with clang integrated
 assembler
Message-ID: <20200320081153.GB2549@willie-the-truck>
References: <20200319214530.2046-1-ilie.halip@gmail.com>
 <CAKwvOdneL8F_ZHBAzyb+VoJ+Z1FZp0VW8asGTu=g39TrouqAgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdneL8F_ZHBAzyb+VoJ+Z1FZp0VW8asGTu=g39TrouqAgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 04:43:56PM -0700, Nick Desaulniers wrote:
> On Thu, Mar 19, 2020 at 2:45 PM Ilie Halip <ilie.halip@gmail.com> wrote:
> >
> > Building an arm64 defconfig with clang's integrated assembler, this error
> > occurs:
> >     <instantiation>:2:2: error: unrecognized instruction mnemonic
> >      _ASM_EXTABLE 9999b, 9f
> >      ^
> >     arch/arm64/mm/cache.S:50:1: note: while in macro instantiation
> >     user_alt 9f, "dc cvau, x4", "dc civac, x4", 0
> >     ^
> >
> > While GNU as seems fine with case-sensitive macro instantiations, clang
> > doesn't, so use the actual macro name (_asm_extable) as in the rest of
> > the file.
> >
> > Also checked that the generated assembly matches the GCC output.
> >
> > Fixes: 290622efc76e ("arm64: fix "dc cvau" cache operation on errata-affected core")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/924
> > Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> > ---
> >  arch/arm64/include/asm/alternative.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> > index 324e7d5ab37e..5e5dc05d63a0 100644
> > --- a/arch/arm64/include/asm/alternative.h
> > +++ b/arch/arm64/include/asm/alternative.h
> > @@ -221,7 +221,7 @@ alternative_endif
> >
> >  .macro user_alt, label, oldinstr, newinstr, cond
> >  9999:  alternative_insn "\oldinstr", "\newinstr", \cond
> > -       _ASM_EXTABLE 9999b, \label
> > +       _asm_extable 9999b, \label
> >  .endm
> 
> Testing a -next defconfig build, if I apply this, apply fixes for
> https://github.com/ClangBuiltLinux/linux/issues/913, then disable
> CONFIG_KVM, I can assemble (with Clang's integrated assembler) and
> boot an aarch64 kernel.  I think that's a first for Clang.  Wow.
> 
> For CONFIG_KVM, I see:
> arch/arm64/kvm/hyp/entry.S:112:87: error: too many positional arguments
>  alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) |
> ((!!1) << 8)), 4, 1
> 
>                ^
> which also uses `alternative_insn`, but not `user_alt`, so another bug
> for us to look into, filed:
> https://github.com/ClangBuiltLinux/linux/issues/939
> 
> Looks like `_asm_extable` itself is a macro, defined in
> arch/arm64/include/asm/assembler.h on line 125.  It's probably easy to
> fix this in clang, but from a consistency with the rest of the file
> (arch/arm64/include/asm/alternative.h) this patch should be accepted.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks, I'll pick this up as a fix.

Will
