Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81AB5FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 11:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfIRJCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 05:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfIRJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:02:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7842820640;
        Wed, 18 Sep 2019 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568797366;
        bh=lwmhaKk2DoGcG7qzZtBauVEYaJWZpkGPIgrTEbpVuHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2YY6sB07c+zPpM3Ky3Ceb7ZrPsrPh6bkuh5bowYMqToN8uhTjr/3QNmPYvYtIS57O
         fRtbK2HpOaY/qgA5TFGRP5mokdfIaJ3jJJr29UIbtWcGjURXb4gkKfofYo5gtPZTO8
         U5ssMpNg7yE2zY4VNZvOgun7tkA9t3Ep9oLe9GB4=
Date:   Wed, 18 Sep 2019 10:02:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190918090240.5cc3rfcuenefisgr@willie-the-truck>
References: <20190910115643.391995-1-arnd@arndb.de>
 <20190917203425.GA31423@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917203425.GA31423@archlinux-threadripper>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 01:34:25PM -0700, Nathan Chancellor wrote:
> On Tue, Sep 10, 2019 at 01:56:22PM +0200, Arnd Bergmann wrote:
> > On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> > when CONFIG_OPTIMIZE_INLINING is set.
> > Clang then fails a compile-time assertion, because it cannot tell at
> > compile time what the size of the argument is:
> > 
> > mm/memcontrol.o: In function `__cmpxchg_mb':
> > memcontrol.c:(.text+0x1a4c): undefined reference to `__compiletime_assert_175'
> > memcontrol.c:(.text+0x1a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__compiletime_assert_175'
> > 
> > Mark all of the cmpxchg() style functions as __always_inline to
> > ensure that the compiler can see the result.
> > 
> > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/648
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > Tested-by: Andrew Murray <andrew.murray@arm.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: skip unneeded changes, as suggested by Andrew Murray
> > ---
> >  arch/arm64/include/asm/cmpxchg.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > index a1398f2f9994..f9bef42c1411 100644
> > --- a/arch/arm64/include/asm/cmpxchg.h
> > +++ b/arch/arm64/include/asm/cmpxchg.h
> > @@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
> >  #undef __XCHG_CASE
> >  
> >  #define __XCHG_GEN(sfx)							\
> > -static inline unsigned long __xchg##sfx(unsigned long x,		\
> > +static __always_inline  unsigned long __xchg##sfx(unsigned long x,	\
> >  					volatile void *ptr,		\
> >  					int size)			\
> >  {									\
> > @@ -148,7 +148,7 @@ __CMPXCHG_DBL(_mb)
> >  #undef __CMPXCHG_DBL
> >  
> >  #define __CMPXCHG_GEN(sfx)						\
> > -static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
> > +static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
> >  					   unsigned long old,		\
> >  					   unsigned long new,		\
> >  					   int size)			\
> > @@ -255,7 +255,7 @@ __CMPWAIT_CASE( ,  , 64);
> >  #undef __CMPWAIT_CASE
> >  
> >  #define __CMPWAIT_GEN(sfx)						\
> > -static inline void __cmpwait##sfx(volatile void *ptr,			\
> > +static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
> >  				  unsigned long val,			\
> >  				  int size)				\
> >  {									\
> > -- 
> > 2.20.0
> > 
> 
> Looks like the arm64 pull request happened without this patch so clang
> all{mod,yes}config builds are broken. Did the maintainers have any
> further comments on it or could this make it in with the next one?

Fear not! I plan to send this with some other fixes we've got for -rc1.
I just to get my CI scripts going again (new machine), but that shouldn't
take long.

Will
