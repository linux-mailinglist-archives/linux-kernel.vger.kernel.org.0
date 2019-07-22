Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5D706A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfGVRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:21:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40567 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfGVRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:21:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so17682499pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHj3tGcPiL8tws64cl/tkaZMAUCPhqkGn8EZKKJS20U=;
        b=FaSizBSw0Ge/cwRKXU0Ppjjo9bhTwKBEw5TZxsXz/qyJe93qVcTDFBQL860oDXR/BS
         2yCBfUFAWqV5wvyZTfJZZoUn5Ys51mNlj/T6SFGtok+DlMTaBIJzt2vfJukK18N0u7Yg
         EWMaRgSQan0ISn0pOywEWJsaeleKB9VEnWEsfOnq3hpILohpzayPuyCjumJdxjOVyi7S
         1QBehw+gqWqQPWz0t6Q6F78N1WpYFEvCHS/jSCq1efGBW51eTXr5zXsWE8Yi4xQDWAA5
         tRrCMy+WjzBInGbRi79tESK3/mw3BvoHv7E2T3z+FAPjgOy5IHx0f5pVJAhv+e+Gz60U
         D9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHj3tGcPiL8tws64cl/tkaZMAUCPhqkGn8EZKKJS20U=;
        b=piaIKDOL0Hmtjzy5HDpL+eQmvnHaQAINnH197jE6ft7J4BeDffUiaFoAH7QGXZ2pZV
         YlT1Sp8OFJ0SwY317IBJZKQ0Ums/rHw3R9QYU1QhpPQnU8QNBXmyGBk1ynhjPj00cOyT
         6GTInO7D/vr+dnVeY1xlyCU7HJzNnVgSY6hteaExqOd5ZIlEzvOMmGU8YIt08qHckY7a
         bZ2ZOFdiKmi6XnQapt6YKaxS0nanWHu4Z6NE7bzStVQmQBeQ8m84fnv7HVzbU7/Vs/Fh
         pP5beQJJHvCGLa8imaU0ikmYjaZNngVFf+yLD7nyiMIuW9RDepVQuukUdorkxoRu30qP
         W78g==
X-Gm-Message-State: APjAAAUHjXSRVOW5mbCEyzkeOFyjQTmScTvZ146tP7SuObpLIr5JZEs5
        Ut+E3sC3zJvt3pm2MzkrjLGjQYDGusHABzDEAVn46w==
X-Google-Smtp-Source: APXvYqwbkDS2DsMH58QOzoQO4Ra4BdOdByCJsymA/G/i1/7Y8LyFyDHySG7VLchNuRBlUiPPtG+v2aT0pFaSXxgJyA0=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr68567574pgs.10.1563816079099;
 Mon, 22 Jul 2019 10:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <45hnfp6SlLz9sP0@ozlabs.org> <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr> <20190709064952.GA40851@archlinux-threadripper>
 <20190719032456.GA14108@archlinux-threadripper> <20190719152303.GA20882@gate.crashing.org>
 <20190719160455.GA12420@archlinux-threadripper> <20190721075846.GA97701@archlinux-threadripper>
 <20190721180150.GN20882@gate.crashing.org> <20190722024140.GA55142@archlinux-threadripper>
 <20190722061940.GZ20882@gate.crashing.org>
In-Reply-To: <20190722061940.GZ20882@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jul 2019 10:21:07 -0700
Message-ID: <CAKwvOd=KRVsFkT8dLFoitky9OF8tKmbn00-OPi6kBygyx4QwHg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 11:19 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sun, Jul 21, 2019 at 07:41:40PM -0700, Nathan Chancellor wrote:
> > Hi Segher,
> >
> > On Sun, Jul 21, 2019 at 01:01:50PM -0500, Segher Boessenkool wrote:
> > > On Sun, Jul 21, 2019 at 12:58:46AM -0700, Nathan Chancellor wrote:
> > > > 0000017c clear_user_page:
> > > >      17c: 94 21 ff f0                     stwu 1, -16(1)
> > > >      180: 38 80 00 80                     li 4, 128
> > > >      184: 38 63 ff e0                     addi 3, 3, -32
> > > >      188: 7c 89 03 a6                     mtctr 4
> > > >      18c: 38 81 00 0f                     addi 4, 1, 15
> > > >      190: 8c c3 00 20                     lbzu 6, 32(3)
> > > >      194: 98 c1 00 0f                     stb 6, 15(1)
> > > >      198: 7c 00 27 ec                     dcbz 0, 4
> > > >      19c: 42 00 ff f4                     bdnz .+65524
> > >
> > > Uh, yeah, well, I have no idea what clang tried here, but that won't
> > > work.  It's copying a byte from each target cache line to the stack,
> > > and then does clears the cache line containing that byte on the stack.
> > >
> > > I *guess* this is about "Z" and not about "%y", but you'll have to ask
> > > the clang people.
> > >
> > > Or it may be that they do not treat inline asm operands as lvalues
> > > properly?  That rings some bells.  Yeah that looks like it.
>
> The code is
>   __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
>
> so yeah it looks like clang took that  *(u8 *)addr  as rvalue, and
> stored that in stack, and then used *that* as memory.

What's the %y modifier supposed to mean here?  addr is in the list of
inputs, so what's wrong with using it as an rvalue?

>
> Maybe clang simply does not not to treat "Z" the same as "m"?  (And "Y"
> and "Q" and "es" and a whole bunch of "w*", what about those?)

-- 
Thanks,
~Nick Desaulniers
