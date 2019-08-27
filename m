Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5392D9F33C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfH0TW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:22:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0TW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 086DAA53262;
        Tue, 27 Aug 2019 19:22:58 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58D1E5C1D6;
        Tue, 27 Aug 2019 19:22:57 +0000 (UTC)
Date:   Tue, 27 Aug 2019 14:22:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190827192255.wbyn732llzckmqmq@treble>
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble>
 <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 27 Aug 2019 19:22:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:00:52PM +0200, Arnd Bergmann wrote:
> On Tue, Aug 27, 2019 at 5:00 PM Ilie Halip <ilie.halip@gmail.com> wrote:
> >
> > > > $ clang-9 -c  crc32.i  -O2   ; objtool check  crc32.o
> > > > crc32.o: warning: objtool: fn1 uses BP as a scratch register
> >
> > Yes, I see it too. https://godbolt.org/z/N56HW1
> >
> > > Do you still see this warning with -fno-omit-frame-pointer (assuming
> > > clang has that option)?
> >
> > Using this makes the warning go away. Running objtool with --no-fp
> > also gets rid of it.
> 
> I still see the warning after adding back the -fno-omit-frame-pointer
> in my reduced test case:
> 
> $ clang-9 -c  crc32.i -Werror -Wno-address-of-packed-member -Wall
> -Wno-pointer-sign -Wno-unused-value -Wno-constant-logical-operand -O2
> -Wno-unused -fno-omit-frame-pointer
> $ objtool check  crc32.o
> crc32.o: warning: objtool: fn1 uses BP as a scratch register

This warning most likely means that clang is clobbering RBP in leaf
functions.  With -fno-omit-frame-pointer, leaf functions don't need to
set up the frame pointer, but they at least need to leave RBP untouched,
so that an interrupts/exceptions can unwind through the function.

-- 
Josh
