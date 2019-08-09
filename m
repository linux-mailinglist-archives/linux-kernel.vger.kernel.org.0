Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAB88570
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 00:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfHIWBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 18:01:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:43934 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIWBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:01:50 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x79M0hxV029775;
        Fri, 9 Aug 2019 17:00:43 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x79M0gEs029774;
        Fri, 9 Aug 2019 17:00:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 9 Aug 2019 17:00:41 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kbuild test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
Message-ID: <20190809220041.GO31406@gate.crashing.org>
References: <87h873zs88.fsf@concordia.ellerman.id.au> <20190809182106.62130-1-ndesaulniers@google.com> <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com> <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:03:01PM +0200, Christophe Leroy wrote:
> Arnd Bergmann <arnd@arndb.de> a écrit :
> 
> >On Fri, Aug 9, 2019 at 8:21 PM 'Nick Desaulniers' via Clang Built
> >Linux <clang-built-linux@googlegroups.com> wrote:
> >
> >> static inline void dcbz(void *addr)
> >> {
> >>-       __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
> >>+       __asm__ __volatile__ ("dcbz %y0" : "=Z"(*(u8 *)addr) :: "memory");
> >> }
> >>
> >> static inline void dcbi(void *addr)
> >> {
> >>-       __asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
> >>+       __asm__ __volatile__ ("dcbi %y0" : "=Z"(*(u8 *)addr) :: "memory");
> >> }
> >
> >I think the result of the discussion was that an output argument only 
> >kind-of
> >makes sense for dcbz, but for the others it's really an input, and clang is
> >wrong in the way it handles the "Z" constraint by making a copy, which it
> >doesn't do for "m".
> >
> >I'm not sure whether it's correct to use "m" instead of "Z" here, which
> >would be a better workaround if that works. More importantly though,
> >clang really needs to be fixed to handle "Z" correctly.
> 
> As the benefit is null, I think the best is probably to reverse my  
> original commit until at least CLang is fixed, as initialy suggested  
> by mpe

And what about the other uses of "Z"?


Also, if you use C routines (instead of assembler code) for the basic
"clear a block" and the like routines, as there have been patches for
recently, the benefit is not zero.


Segher
