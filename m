Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6083D759A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfGYVbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 17:31:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34877 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfGYVbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:31:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so23890210plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfaBZ71hrJPdlZeMC578OQz4LN6coQODfHCSFL4DY30=;
        b=L1PQzO25HSmegQlGogBRTDRVTJihGQ8nW9Pn1vU/pcEljVrJpCDHdb5G5+wUOZRaji
         zXIIf53eCREsVmf57JKSXVPPLdRqtrwWoKl74voeX8/y2vPEEjikuw990cW8pTWz42n3
         ABhie+Ty3rfGMfWkgYDzV8jMxGv16NOkmEN3RYHdennsIIwff6Z3ZxELWILi6yjguG51
         EDfK+J1awSDH2gdNIicNi7/QO22SW1WjMemBbfQb+Qy6tBUGqaqNEO5LyOMHRj8dwaxK
         OgaNX6VSDa5tUrSrABbZy9yBQmccK4Hs8OK2TQ3ZC78A1yP4XhW9aJYEbXDQnsQXinQb
         Etyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfaBZ71hrJPdlZeMC578OQz4LN6coQODfHCSFL4DY30=;
        b=d8TjaAGTBthAF3HwmHpkML6Dfrh/a2qeQ7zSsgYP51mkjKZ4EGLZi8cn7jb07MD3QT
         8aQfha57RL/oJKjMODaAKVXZhBTEjvIdtcMbUIqkOBMzlc0/t5A/20+GyOc3StZ+LKg2
         nVUcjFqiO1vcwUXSfI3em9A9QavtKWtpGgyTSMTEA+pzRVV3pNFBECCqzxENPKsDkyQj
         ppCYJhgV7PK/IE86VPIlYpk97Wj18doYsEwanVBkpto90Sr1iDWJLR+QAJ13CRMAPHJu
         p6TiqKeqXUGvvTj/MjXGMZWrFk6Wp/qok9cQK9Pxf3nYZOyrIxM67N7SBeiIKRU9pEfL
         CnMQ==
X-Gm-Message-State: APjAAAXjdwLICrXDSjFpksnkIKQKqLLBT38BhejuTSDGLzkSvl6296a2
        N941CvDI2q3bY+SBQizrFnUKJe4Qx86rnEF1DLzsEg==
X-Google-Smtp-Source: APXvYqzjunthGBlYQvAXo+D4K5dU893NIP2cgPdwJ1VeZyB0ObEP3a74b4CPfy0ldYRUMBT3J8r5CPg4PIfODOfyOYc=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr16697787pls.179.1564090262638;
 Thu, 25 Jul 2019 14:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr> <20190709064952.GA40851@archlinux-threadripper>
 <20190719032456.GA14108@archlinux-threadripper> <20190719152303.GA20882@gate.crashing.org>
 <20190719160455.GA12420@archlinux-threadripper> <20190721075846.GA97701@archlinux-threadripper>
 <20190721180150.GN20882@gate.crashing.org> <20190722024140.GA55142@archlinux-threadripper>
 <20190722061940.GZ20882@gate.crashing.org> <CAKwvOd=KRVsFkT8dLFoitky9OF8tKmbn00-OPi6kBygyx4QwHg@mail.gmail.com>
 <20190722175817.GE20882@gate.crashing.org>
In-Reply-To: <20190722175817.GE20882@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Jul 2019 14:30:51 -0700
Message-ID: <CAKwvOdkzBt=tTk+26dp+QsCStMUJ0_v5Mpjy2TOXPw1mu71itg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        James Y Knight <jyknight@google.com>,
        Joel Stanley <joel@jms.id.au>, dja@axtens.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:58 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Jul 22, 2019 at 10:21:07AM -0700, Nick Desaulniers wrote:
> > On Sun, Jul 21, 2019 at 11:19 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > On Sun, Jul 21, 2019 at 07:41:40PM -0700, Nathan Chancellor wrote:
> > > > On Sun, Jul 21, 2019 at 01:01:50PM -0500, Segher Boessenkool wrote:
> > > > > On Sun, Jul 21, 2019 at 12:58:46AM -0700, Nathan Chancellor wrote:
> > > > > > 0000017c clear_user_page:
> > > > > >      17c: 94 21 ff f0                     stwu 1, -16(1)
> > > > > >      180: 38 80 00 80                     li 4, 128
> > > > > >      184: 38 63 ff e0                     addi 3, 3, -32
> > > > > >      188: 7c 89 03 a6                     mtctr 4
> > > > > >      18c: 38 81 00 0f                     addi 4, 1, 15
> > > > > >      190: 8c c3 00 20                     lbzu 6, 32(3)
> > > > > >      194: 98 c1 00 0f                     stb 6, 15(1)
> > > > > >      198: 7c 00 27 ec                     dcbz 0, 4
> > > > > >      19c: 42 00 ff f4                     bdnz .+65524
> > > > >
> > > > > Uh, yeah, well, I have no idea what clang tried here, but that won't
> > > > > work.  It's copying a byte from each target cache line to the stack,
> > > > > and then does clears the cache line containing that byte on the stack.
> > > > >
> > > > > I *guess* this is about "Z" and not about "%y", but you'll have to ask
> > > > > the clang people.
> > > > >
> > > > > Or it may be that they do not treat inline asm operands as lvalues
> > > > > properly?  That rings some bells.  Yeah that looks like it.
> > >
> > > The code is
> > >   __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
> > >
> > > so yeah it looks like clang took that  *(u8 *)addr  as rvalue, and
> > > stored that in stack, and then used *that* as memory.
> >
> > What's the %y modifier supposed to mean here?
>
> It prints a memory address for an indexed operand.
>
> If you write just "%0" it prints addresses that are a single register
> as "0(r3)" instead of "0,r3".  Some instructions do not allow offset
> form.
>
> > addr is in the list of
> > inputs, so what's wrong with using it as an rvalue?
>
> It seems to use *(u8 *)addr as rvalue.  Asm operands are lvalues.  It
> matters a lot for memory operands.

Hmm...not sure that's specified behavior.  Anyways, I've filed:
https://bugs.llvm.org/show_bug.cgi?id=42762
to see if folks more familiar with LLVM's ppc backend have some more thoughts.

I recommend considering reverting commit 6c5875843b87 ("powerpc:
slightly improve cache helpers") until the issue is resolved in clang,
otherwise I'll probably just turn off our CI builds of PPC32 for the
time being.
-- 
Thanks,
~Nick Desaulniers
