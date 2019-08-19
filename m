Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1C91C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 06:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfHSE0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 00:26:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37354 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSE0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:26:54 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x7J4QTgN021114
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:26:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x7J4QTgN021114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566188790;
        bh=OW1zICb/Mc7eyHaJB7F+0jGSnOYmZvCIzJbFodsGuQ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nxrHN0YsNDaS/A3TzwVTJrjMWHNoxXx9++LRPbmK0e6NmQju51D+ziozFzOerTSHj
         0FDE7Q3U+qGXKj1dy2OoRArV11/pokJT/DDuaRqQ6/uC6GSUYvZ4cIgeWkKRjfoZ/1
         7DQR/dNxYCOoo+1antF+eGJc5hIAyLGd9DRoY/+678+HavcyMMW0xXZin/7ZW+f4RS
         cAaZ7IdufwJP1y9n4xREqic8O41pXY9z+pqWnkulnsfK7r0FZNm6jC0wXSLkiZY/nr
         J03R5JjXKPf01oFqRrNM6takc1awzbDl+zo67p3S9SFmy4SdNUKTVEopvwIa9JxkNY
         DdM/qsZmy8SYQ==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id 82so121147vkf.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:26:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXSZdLnQG3WXzQpi9AZdfnba45OJNe+IqB5VAIRK8klE/PP8f6g
        ZyI9miMHyIxzEMES9wGspxDd1iIdMFDX46wON+c=
X-Google-Smtp-Source: APXvYqyP0Fpi/HcxiJ414/X4VHQkyya1xBYajp/2fXLljetLW55Ed2rsnGbLxediWPOHVe7DHFQxGP0Mc9dQb2Dr/Bk=
X-Received: by 2002:a1f:ee81:: with SMTP id m123mr2220428vkh.74.1566188788852;
 Sun, 18 Aug 2019 21:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190713131642.GU14074@gate.crashing.org> <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
 <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au>
 <20190715072959.GB20882@gate.crashing.org> <87pnma89ak.fsf@concordia.ellerman.id.au>
 <20190717143811.GL20882@gate.crashing.org> <CAK7LNATesRrJFGZQOkTY+PL7FNyub5FJ0N6NF4s6icdXdPNr+Q@mail.gmail.com>
 <20190717164628.GN20882@gate.crashing.org> <CAK7LNAR7jkq1fAi_=xgsANCkgP2AAej9Yv7RZB3B_cpD7C_71Q@mail.gmail.com>
 <20190718204631.GV20882@gate.crashing.org> <87blxq8zhf.fsf@concordia.ellerman.id.au>
In-Reply-To: <87blxq8zhf.fsf@concordia.ellerman.id.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Aug 2019 13:25:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATgOMhr6Fw-ge_ph4Hq-SGuvGTYHDcjd7e4+eb5_Ebw3A@mail.gmail.com>
Message-ID: <CAK7LNATgOMhr6Fw-ge_ph4Hq-SGuvGTYHDcjd7e4+eb5_Ebw3A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 19, 2019 at 12:43 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Thu, Jul 18, 2019 at 11:19:58AM +0900, Masahiro Yamada wrote:
> >> On Thu, Jul 18, 2019 at 1:46 AM Segher Boessenkool
> >> <segher@kernel.crashing.org> wrote:
> >> Kbuild always uses thin archives as far as vmlinux is concerned.
> >>
> >> But, there are some other call-sites.
> >>
> >> masahiro@pug:~/ref/linux$ git grep  '$(AR)' -- :^Documentation :^tools
> >> arch/powerpc/boot/Makefile:    BOOTAR := $(AR)
> >> arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBC_A) $(notdir $@) > $@
> >> arch/unicore32/lib/Makefile:    $(Q)$(AR) p $(GNU_LIBGCC_A) $(notdir $@) > $@
> >> lib/raid6/test/Makefile:         $(AR) cq $@ $^
> >> scripts/Kbuild.include:ar-option = $(call try-run, $(AR) rc$(1)
> >> "$$TMP",$(1),$(2))
> >> scripts/Makefile.build:      cmd_ar_builtin = rm -f $@; $(AR)
> >> rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> >> scripts/Makefile.lib:      cmd_ar = rm -f $@; $(AR)
> >> rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
> >>
> >> Probably, you are interested in arch/powerpc/boot/Makefile.
> >
> > That one seems fine actually.  The raid6 one I don't know.
> >
> >
> > My original commit message was
> >
> >     Without this, some versions of GNU ar fail to create
> >     an archive index if the object files it is packing
> >     together are of a different object format than ar's
> >     default format (for example, binutils compiled to
> >     default to 64-bit, with 32-bit objects).
> >
> > but I cannot reproduce the problem anymore.  Shortly after my patch the
> > thin archive code happened to binutils, and that overhauled some other
> > things, which might have fixed it already?
> >
> >> > Yes, I know.  This isn't about built-in.[oa], it is about *other*
> >> > archives we at least *used to* create.  If we *know* we do not anymore,
> >> > then this workaround can of course be removed (and good riddance).
> >>
> >> If it is not about built-in.[oa],
> >> which archive are you talking about?
> >>
> >> Can you pin-point the one?
> >
> > No, not anymore.  Lost in the mists of time, I guess?  I think we'll
> > just have to file it as "it seems to work fine now".
>
> Yeah I think so. If someone finds a case it breaks we can fix it then.
>
> > Thank you (and everyone else) for the time looking at this!
>
> Likewise.
>
> cheers


So, we agreed to apply this patch, right?

Please let me know if there is some improvement that should be get done.


-- 
Best Regards
Masahiro Yamada
