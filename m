Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFE149AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 14:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgAZNiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 08:38:17 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46208 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAZNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 08:38:17 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so4040234vso.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 05:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eLMDTU2DdPGk8XS1y0kzPwySf3dVWxuBK+qfT4vpSQ=;
        b=ZfbIppOEH4vp7GQxcacxvAI6ZWnd5bWP/Y1usgF7+j7P3djAoJVN3DFHhU6b0Cy7x9
         tkYech8F7MjSaGpfn0QtHmNSXXWQCZFDZhVwEaG2e4866Wb2WJT7sY0v0JW1AMMtYcRf
         KiyYsJ8Vpm550nzQvV0TUE59Y5NmfG1VeD9qTxpCCKWOGEJMyt6+kuFqu6pRsI80zBZT
         62jaQCatKaOIVkoi56/eoNkGf9wEEaXqjBpI/21z+h2uDYGh27c8BqXmmBttmk81WzGh
         qtn82rqeiA1fWlUbi/vmcCTdLIdmdXUU9t0erzkAFUagiqte4werw9jxgRAOdQNngazj
         7aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eLMDTU2DdPGk8XS1y0kzPwySf3dVWxuBK+qfT4vpSQ=;
        b=qLH86CXbXWpYCdCK1jKXp5D8Lu7KECO13k2tzgc55WtHYyazGGyMDyi8ZShRxiOuPU
         Nmd7WWv7LbhUcKG+/iVEbmssSfF19OtL8GbboMkXj++zuf+rJ8ZIXaXMLzTpqyPDWPuH
         lcdkX0MM2xvzb7IvogTPCLhAtcvAjo/7NV+7hLPJmB/PbicUm9pYa/aMncTjIglEz4Jr
         IETaWgvPZIbu8KKikUQihf16GT5oEljc8B11NoR3VmcBgPqgJSsMzlSPqpcOo7aahdgp
         yGMFfWtT1ccAZennS30Q3l88P97btYxDgFjOWWyFlUThJLAzGsN1oeFHJV67oJUZz6eH
         1Lvg==
X-Gm-Message-State: APjAAAWW/TA0Qw0JhP6osBK1GslUzmbjw4YcQ+dEg/KGSKN8gH6a5qM9
        84LlKxxF+7UlsBTWUIMR+WYgLFh4cVPfqJzCYYCMNw==
X-Google-Smtp-Source: APXvYqxCLVwdM6QGTW5YuhwV9kE24mCL6yHpg7HZWYSJclmgOh0uuc01QoCyluUbrVBnU4Q1bUfbupQ6hjJfS8bkKbQ=
X-Received: by 2002:a67:fb14:: with SMTP id d20mr7020032vsr.136.1580045896049;
 Sun, 26 Jan 2020 05:38:16 -0800 (PST)
MIME-Version: 1.0
References: <20200116101447.20374-1-gilad@benyossef.com> <CAMuHMdUhR83SZyWX9Du9d3Sp4A48x_msKaOHGsa88EQKStEDQg@mail.gmail.com>
 <CAOtvUMfDnoFu8V7sYvhgsstX6fuUk3foq+9FJ6SbUKEFnq-zMw@mail.gmail.com>
 <CAMuHMdUZbbNX-vsa4TmU7DNKAz2Qo3SR1pHXDOsO4Rh5G8ygZw@mail.gmail.com>
 <CAOtvUMdCm8LTfVOgrkGAa5ig6dodyd7QwcEvHz-TnvkMfnhDZA@mail.gmail.com> <CAMuHMdVPQsb=NrQ=N+S1TrD_CuJ=hnaYS+OLE9SnyWy43dC3GQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVPQsb=NrQ=N+S1TrD_CuJ=hnaYS+OLE9SnyWy43dC3GQ@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 26 Jan 2020 15:37:58 +0200
Message-ID: <CAOtvUMeiaFzL1E49Vy5+MY96_g=91eW3AnkDG1+1ZRoTekJYew@mail.gmail.com>
Subject: Re: [PATCH 00/11] crypto: ccree - fixes and cleanups
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 10:09 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Gilad,
>
> On Thu, Jan 23, 2020 at 7:19 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > On Thu, Jan 23, 2020 at 5:46 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Jan 23, 2020 at 12:44 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > > > On Wed, Jan 22, 2020 at 6:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Thu, Jan 16, 2020 at 11:25 AM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > > > > > A bunch of fixes and code cleanups for the ccree driver
> > > > >
> > > > > Thank you!
> > > > >
> > > > > I wanted to give this a try, but it looks like CCREE is no longer working
> > > > > on R-Car H3, both with/without this series.
> > > > >
> > > > > E.g. with renesas-devel[*] and renesas_defconfig +
> > > > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n, I get the following crash:
> > > >
> > > > Thank you for the bug report Geert!
> > > >
> > > > My R-Car board is on loan at the moment to another project. I didn't
> > > > see this on our internal test board.
> > > > I will track down my R-Car board and reproduce this - hopefully
> > > > beginning of next week and will get back to you.
> > >
> > > In the mean time, I've bisected this failure to commit cdfee5623290bc89
> > > ("driver core: initialize a default DMA mask for platform device").
> > > However, this looks like a red herring, and seems to be only an exposer
> > > of an underlying problem.
> >
> > Thank you for continue digging into this.
> >
> > > What's happening is that cc_map_aead_request() receives a request with
> > > cryptlen = 0.  Due to DRV_CRYPTO_DIRECTION_ENCRYPT, the length to map is
> > > increased by 8.  This seems to works fine if there is sufficient space
> > > in the request's scatterlist.  However, if the scatterlist has only a
> > > single entry of size zero, cc_map_sg() tries to map a zero-length DMA
> > > buffer, and the BUG)() is triggered.
> > >
> >
> > OK, this does rings a bell - can you verify please if
> > CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is enabled and if it does can you
> > see if it happens if it is turned off?
>
> No, I didn't have that option enabled.

OK, I still did not get reunited with my R-Cat board, but I think I
have a direction.

I'm about to send an RFC patch which while  probably does not address
the root cause
will stop the crash if the issue is what I think it is and so will let
me know what you are
seeing is what I think you are seeing.

I'd be delighted if you can give it a spin...

Thanks,
Gilad
