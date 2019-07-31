Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3B7B83A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 05:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfGaDbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 23:31:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43410 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGaDbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 23:31:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so67929050wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 20:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atyUolA0eJzVAQbGvrRql9UrHUdFF1jgbg7pUV5Ee5k=;
        b=UlKhCE5DTH67YsTqyfTiaKsmJS4WGCz4V8NwIwNoOkZbD6vEDiUjn7xt2+voHYlnAr
         I4+/bAuHDu1tbWYwI1eRPwkKz+QptFylA1Tpct1e0C2/iJSgtYXU3rniwFeeSsdLlGag
         8XjEOhOkXfz1XGFsu+HK5Cn+10fRFPgKpDA/fmjvw+PwvMQtH7ZvvkTXdkXViIFhAKpv
         A/dRpwMICdRjqsWyGmqkS8tbP8AH90uFAiuDMGbZD3ut4/FIOIckS8+7wu7RDIc8smQ2
         gScyIqzfbhj+uagU5x+UfeRG7WmRAC8iqTDOL9gRycGDrLQq28VbYsxuh0ofC+nZIQw2
         xvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atyUolA0eJzVAQbGvrRql9UrHUdFF1jgbg7pUV5Ee5k=;
        b=oheutrj429X6r0mItsaj3l1CKl2ip+CcXRfr2D8XwQxH4t8FiGtfbo89EWA9rjfnoW
         VoEIB8JCRotpopYG8641WnH7z9t0DR4aIffDtRcE9/335iiG4mKrvfs2yWtoiSr3X/9Y
         IZ//drxP/VpDPZWCD4QHwLAbXyAgSBRsDEhmr+s3nCFwBvisWVjyPuBvuU7zO4gci5AS
         WrqyOybHtPJtS3+800sxotCmWMa0/ZPBSfhox3v6HyB9NPjcy40NYRpbJADLN2cvuw0o
         BuVsNfC+3gVPgoX9vtUxYiVh3MASfvlipRbjRPZY4+HPhRvkXo4NAlr1Ric9BM4Ha4Wr
         HyxQ==
X-Gm-Message-State: APjAAAUgjUTAhajHAtR0YiqV33pGz2kh5Rc6gGv/ELVPe/fkf/xTxFwK
        4V1OR4XKfGh0fJhFrMKSRmC7jn/uHsuo9uqo0GeEPw==
X-Google-Smtp-Source: APXvYqzMhgdZXK8upHjBPeiMFif34tHaHGLNz56kjr/qsVHA5wu35rMW0ISbG0qHRbD+PAYsbddI9bA1xBgaBXEB+f0=
X-Received: by 2002:a5d:6389:: with SMTP id p9mr105527750wru.297.1564543859209;
 Tue, 30 Jul 2019 20:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190722071122.22434-1-zhang.lyra@gmail.com> <20190722071419.22535-1-zhang.lyra@gmail.com>
 <CAAfSe-tPVsMjmu0CoUATGRGevCpgqk999-rpfMuXqZ-V9ft7gg@mail.gmail.com> <20190730110204.GB1330@shell.armlinux.org.uk>
In-Reply-To: <20190730110204.GB1330@shell.armlinux.org.uk>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 31 Jul 2019 11:30:22 +0800
Message-ID: <CAAfSe-s=UFMvLfVq1xw1OuAwgdiyg-kcFa6ZyAUkkDLnTVuWmQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: check stmfd instruction using right shift
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lvqiang Huang <lvqiang.huang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 at 19:02, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jul 30, 2019 at 03:18:31PM +0800, Chunyan Zhang wrote:
> > Gentle ping
> >
> > probably this patch was missed or entered into spam?
>
> Please submit it to the patch system, thanks.

Ok, thanks.

>
> >
> > On Mon, 22 Jul 2019 at 15:14, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > >
> > > From: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
> > >
> > > In the commit ef41b5c92498 ("ARM: make kernel oops easier to read"),
> > > -               .word   0xe92d0000 >> 10        @ stmfd sp!, {}
> > > +               .word   0xe92d0000 >> 11        @ stmfd sp!, {}
> > > then the shift need to change to 11.
> > >
> > > Fixes: ef41b5c92498 ("ARM: make kernel oops easier to read")
> > > Signed-off-by: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
> > > Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > > ---
> > >  arch/arm/lib/backtrace.S |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
> > > index 7d7952e..926851b 100644
> > > --- a/arch/arm/lib/backtrace.S
> > > +++ b/arch/arm/lib/backtrace.S
> > > @@ -70,7 +70,7 @@ for_each_frame:       tst     frame, mask             @ Check for address exceptions
> > >
> > >  1003:          ldr     r2, [sv_pc, #-4]        @ if stmfd sp!, {args} exists,
> > >                 ldr     r3, .Ldsi+4             @ adjust saved 'pc' back one
> > > -               teq     r3, r2, lsr #10         @ instruction
> > > +               teq     r3, r2, lsr #11         @ instruction
> > >                 subne   r0, sv_pc, #4           @ allow for mov
> > >                 subeq   r0, sv_pc, #8           @ allow for mov + stmia
> > >
> > > --
> > > 1.7.9.5
> > >
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
