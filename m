Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F52AFB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfIKLmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 07:42:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32823 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfIKLmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:42:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so24832765qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8+OX84D3OD8DVrZ9a7q2Ku1fRaie55mt1/8kXZjuUUE=;
        b=dcdd0RrZs3IuwCK0B9ztsaOEdtmef6QmlZkSJ4i9ttAnUde5fq6unM5o543/4nHt2b
         lSv1MI5CZUboFhMcEpVXc/wEmeP3GsK+whAWjMRvGYn4RKo8giZxaJuNDe/DBxYE/7Vr
         MMU6YZVXjFAEDCqr4Ay0EL2G4fDuwwYW/2jSnL8wZXaIokLsM5FNw2oVUASBCSlZ2aeU
         szi7kG67/hbyDHIGyGyC19oC3r/xUtSSVzVg8/yvAYoauf05JJr0eu4hNlW51dzaJjfM
         Tfgee44HF/AYXXt3SluHMBOgH7+gfn5ZHMR8JopogHm9LUf73hHJ+zgK5hZNUkT0Gfpq
         /+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8+OX84D3OD8DVrZ9a7q2Ku1fRaie55mt1/8kXZjuUUE=;
        b=HENTsbJj02ZDhF2sKeJV93t5ZD/qQi1xJBqXk3h74c1tgKEto5M3NHbH/VkeVW2qEv
         iOPIITPCPpihtQNRQEUamGGpZVpptugbjNA9tDU4WOKGWAZWeFh9xendgQ8e7F+wWHdi
         +KfgxNZsMUDXCeadXTFmRZUMWCcdqksv/wxbWG+88Q5DqPWLAD8fUI/A1VqX1oWTaYrw
         Kb5yDFjMW+qP1xEaXbjZt7p+4s74zASg4/DmgKpnrS4bCaSBPR4ZPnf0EMiUTZUmv0ZO
         JTM0UUCnmwEy/pLx6/t9KHEqdrViKV85+OSXJNx7C1Rhhb2/SykBxJfRN8yzQUR+UnaV
         M8oQ==
X-Gm-Message-State: APjAAAVgNGWppy/4cK0BYSHrag4E70Rr3YHVQksULwogSiZl+wjA/62l
        2xw32N98s3qCPrl2AWOeQxEWtaqnLhlEfPE72pw=
X-Google-Smtp-Source: APXvYqwRIeQKQzY3Fp+rsnAuzP7HMudQTmIIvcqXrDAlGm5cZTe0O/lVFaVD2m63xyjJkWChI6g1pX9rKql+XrE3az4=
X-Received: by 2002:ac8:51c4:: with SMTP id d4mr35213431qtn.17.1568202171389;
 Wed, 11 Sep 2019 04:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190911045408.GA62424@LGEARND20B15> <20190911094031.GU13294@shell.armlinux.org.uk>
In-Reply-To: <20190911094031.GU13294@shell.armlinux.org.uk>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Wed, 11 Sep 2019 20:42:47 +0900
Message-ID: <CADLLry7XKojSy5gaWBd0pkp5OVNrt-xysiHf69tEUPjHOS8kxA@mail.gmail.com>
Subject: Re: [PATCH] ARM: module: Drop 'rel->r_offset < 0' always false statement
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     allison@lohutok.net, info@metux.net,
        matthias.schiffer@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=EB=85=84 9=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:40, R=
ussell King - ARM Linux admin
<linux@armlinux.org.uk>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Sep 11, 2019 at 01:54:08PM +0900, Austin Kim wrote:
> > Since rel->r_offset is declared as Elf32_Addr,
> > this value is always non-negative.
> > typedef struct elf32_rel {
> >         Elf32_Addr    r_offset;
> >           Elf32_Word  r_info;
> > } Elf32_Rel;
> >
> > typedef __u32 Elf32_Addr;
> > typedef unsigned int __u32;
> >
> > Drop 'rel->r_offset < 0' statement which is always false.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > ---
> >  arch/arm/kernel/module.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> > index deef17f..0921ce7 100644
> > --- a/arch/arm/kernel/module.c
> > +++ b/arch/arm/kernel/module.c
> > @@ -92,7 +92,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strta=
b, unsigned int symindex,
> >               sym =3D ((Elf32_Sym *)symsec->sh_addr) + offset;
> >               symname =3D strtab + sym->st_name;
> >
> > -             if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size =
- sizeof(u32)) {
> > +             if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
> >                       pr_err("%s: section %u reloc %u sym '%s': out of =
bounds relocation, offset %d size %u\n",
>
> Also change %d to %u here.

Let me resend the patch with the change(%d to %u).

Thanks,
Austin Kim

>
> >                              module->name, relindex, i, symname,
> >                              rel->r_offset, dstsec->sh_size);
> > --
> > 2.6.2
> >
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbp=
s up
> According to speedtest.net: 11.9Mbps down 500kbps up
