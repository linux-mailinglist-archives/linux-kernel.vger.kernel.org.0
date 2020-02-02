Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B595D14FE42
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 17:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBBQVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 11:21:45 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33887 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgBBQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 11:21:44 -0500
Received: by mail-vs1-f65.google.com with SMTP id g15so7440797vsf.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z4vFhFVKG0YBD0XPtA9xGNCv/BDXDAEGk9Fr40UlAwQ=;
        b=hBAs0OVt/5C+i6kyW+CHbqpB9gOyPcztzdOGnLqZd5PmvPRtm4vj5Yq14SKZEQH+SY
         7f889N/sdhK7bafCMvpU1y0a0FO8QTk/CF8hVEEynBHPtdRJ8YxBuRvsgDC5E4bNPBBB
         7YHLBYy0Z7P5T2vrz32I0pXDit/bZvnL81pcUQQ9BfR8Sq+QCwTME+Hd298JAY0sQOVo
         pjZnsd8v3sulZFUUy6fQG0YkTsF4Mrp9vxPQH6cTDUZOInl4YSHDJ059G92JX9+KLByv
         Yy2EzaiSbRMTfMIhb+F0ZO5/7+UI/jTPldHzlIhh1+AJuBg+JRj936mzOkLRPv6qsOH3
         sBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z4vFhFVKG0YBD0XPtA9xGNCv/BDXDAEGk9Fr40UlAwQ=;
        b=CWkN0u6axQnllJJ2BgELy1d4JE37puUC7ld6w4Qb7o87nLh2IA8e6b9x/JlROUOTn3
         1nXadQZHHIDubUEIrsWVdgjT0PJgg1y9dRP6+B1SuX4ZfdZUhOoSJUcMaQsyvZvbqiUW
         oXSqAKKOdzz7WNMenKIqkO5PlT5paBd4dF/c3f2tHQnZOaTL/A5jbbyVzTv5GB4OFgTL
         JLY4cUKWm44Yq6MCjWeLF3l+En9/nszb13lqNcR9UmCrcjxhiK1TJr0RUogRc6inCzi5
         wAVq3AI49UWVMGo/AgdEAd6gPf+4LLEiUHrHYIjvHlQ5W21UujP5Ic78P3eeGiJIMFkk
         iN8Q==
X-Gm-Message-State: APjAAAXofS9sROTZy3v/QR1y2LXTpcuuai9ofC9Iruvp/+9ejhXBnVX8
        qxJxL/N002Qw+Gs0UrR0xGcXgfN3L/7pBfvjatdv1g==
X-Google-Smtp-Source: APXvYqx3XNZF2JXa9iGlKzd5VrwmWrEsb5RS4U0pCifaad4M/KM1FTXTr9XHmHL7Tsoi05WpBaJMhegB5m28Ryh/ewg=
X-Received: by 2002:a67:fb14:: with SMTP id d20mr12085906vsr.136.1580660503807;
 Sun, 02 Feb 2020 08:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20200129143757.680-1-gilad@benyossef.com> <20200129143757.680-5-gilad@benyossef.com>
 <CAMuHMdVb_AGa7980fRXaxon=uDojZ1x5d6z-FCJAt5aMEGMcbw@mail.gmail.com>
 <CAOtvUMdUBMkmZ6nzGVxi1W_Y4yFvcd6rfvz6BA63h4eq2QFUdA@mail.gmail.com>
 <CAMuHMdXecd0KAN6B4GWKMp-DsmZVTJqOJfm5CymwwPMwDqG0qA@mail.gmail.com> <CAOtvUMcejz8qLrg8MBxM2DkYSqvfX-yKwK7NujmwD=szystUAQ@mail.gmail.com>
In-Reply-To: <CAOtvUMcejz8qLrg8MBxM2DkYSqvfX-yKwK7NujmwD=szystUAQ@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 2 Feb 2020 18:21:31 +0200
Message-ID: <CAOtvUMeCcoVeG3aqHywyDfn-=KNb-j=ViZ5ieOpB-Q61taFosg@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: ccree - fix AEAD blocksize registration
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 5:32 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote=
:
>
> On Thu, Jan 30, 2020 at 3:19 PM Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> >
> > Hi Gilad,
> >
> > On Thu, Jan 30, 2020 at 12:33 PM Gilad Ben-Yossef <gilad@benyossef.com>=
 wrote:
> > > On Wed, Jan 29, 2020 at 5:17 PM Geert Uytterhoeven <geert@linux-m68k.=
org> wrote:
> > > > On Wed, Jan 29, 2020 at 3:39 PM Gilad Ben-Yossef <gilad@benyossef.c=
om> wrote:
> > > > > Fix an error causing no block sizes to be reported during
> > > > > all AEAD registrations.
> > > > >
> > > > > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > > >
> > > > Thanks, this fixes:
> > > >
> > > >     alg: aead: blocksize for authenc-hmac-sha1-cbc-aes-ccree (0)
> > > > doesn't match generic impl (16)
> > > >     alg: aead: blocksize for authenc-hmac-sha256-cbc-aes-ccree (0)
> > > > doesn't match generic impl (16)
> > > >
> > > > which you may want to mention in the commit description, so
> > > > people who search for the error message will find the fix.
> > > >
> > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > Note that even after applying this series, the kernel still crashes=
 with
> > > >
> > > > kernel BUG at kernel/dma/swiotlb.c:497!
> > > > ....
>
> Thank you!
>
> I've managed to reproduce this here.
> Looking into it now...


OK, found it (I think!). Patch sent.

I don't understand why this and the previous bugs is not causing
problems with other configs (e.g. 32 bit ) but now I have an
environment that triggers them I will add it to the usual tests cycle.

Thanks again!

Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
