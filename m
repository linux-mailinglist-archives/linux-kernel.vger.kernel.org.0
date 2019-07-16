Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E26A2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfGPHPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 03:15:21 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45493 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfGPHPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:15:21 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6G7FBNZ010098
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 16:15:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6G7FBNZ010098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563261313;
        bh=QcVnV9OLob7IvgKHrnhoRO7gO5UasK9/m6KCahUPQwk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PnlxllmeJqxxA6vs4lAjBUgs+Anv5Eb756kryUMe+Wzm6rIjk8nZSInxbfdscQOdG
         as+UaeR/Cz0lQ4tlEB1hHgm1svWpEl/MlJF7F0WgohHeAlb6iX8mhuMnW5X4qOke76
         X+gg+nSWOB0hf5JrJdpHdgXPlmofJrExLOipgLUIQmWjqlzX4b+AEqUiRtDPIRNhDq
         X1CvBKsXsRyHhdg+d/g6+qPQXuBsPBxTI85pxwNvej/0uNDPEsKXXA70sKdlcHjbgh
         ZGbOGqjtual2KueHxPUzSixgn0Q6rXMoOVgWVsvpjc1a9qX+/Ei08llwP74ALYoP+C
         zAMrJLT/W81/w==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id a186so11574943vsd.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 00:15:12 -0700 (PDT)
X-Gm-Message-State: APjAAAXxIZzuzF+p0i7Ddsn1cysYXVcEsbyZHkeiaZGNK7M+1HoG73Dh
        7TTaq42YedrH6NtUx97VvDJZ2vGqi45jUEjGIWk=
X-Google-Smtp-Source: APXvYqyBAqZZbdQlYRd1vuBlPVWO5Kp2SMReNtvXaXAGRBCPnqL3qX+XdDbFkUD6YV7WD97X/AQvx6I32sekRxU8udI=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr18947906vsq.179.1563261310985;
 Tue, 16 Jul 2019 00:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190713032106.8509-1-yamada.masahiro@socionext.com>
 <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org>
 <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
 <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au>
 <20190715072959.GB20882@gate.crashing.org> <CAK7LNATGEK9wxz87J3sTNOYPdtAFXaegQU9EctEBGULQL-ZC4w@mail.gmail.com>
 <20190715181618.GG20882@gate.crashing.org>
In-Reply-To: <20190715181618.GG20882@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 16 Jul 2019 16:14:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfzoHu8VvvdkNnwak5ZuP0zmJdvxMSPYGB2YsoUw59jw@mail.gmail.com>
Message-ID: <CAK7LNAQfzoHu8VvvdkNnwak5ZuP0zmJdvxMSPYGB2YsoUw59jw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
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

On Tue, Jul 16, 2019 at 3:16 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Jul 15, 2019 at 09:03:46PM +0900, Masahiro Yamada wrote:
> > On Mon, Jul 15, 2019 at 4:30 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 05:05:34PM +1000, Michael Ellerman wrote:
> > > > Segher Boessenkool <segher@kernel.crashing.org> writes:
> > > > > Yes, that is why I used the environment variable, all binutils work
> > > > > with that.  There was no --target option in GNU ar before 2.22.
> >
> > I use binutils 2.30
> > It does not understand --target option.
> >
> > $ powerpc-linux-ar --version
> > GNU ar (GNU Binutils) 2.30
> > Copyright (C) 2018 Free Software Foundation, Inc.
> > This program is free software; you may redistribute it under the terms of
> > the GNU General Public License version 3 or (at your option) any later version.
> > This program has absolutely no warranty.
> >
> > If I give --target=elf$(BITS)-$(GNUTARGET) option, I see this:
> > powerpc-linux-ar: -t: No such file or directory
>
> You need to provide a valid command line, like
>
> $ powerpc-linux-ar tv smth.a --target=elf32-powerpc
>
> ar is a bit weird.


Ah, I see!

I had missed the space being required.

Since I cannot test old binutils,
I will leave this to ppc people.






--
Best Regards
Masahiro Yamada
