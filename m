Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17AE614EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 14:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfGGMjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jul 2019 08:39:11 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23956 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGGMjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 08:39:11 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x67CcrMb006529;
        Sun, 7 Jul 2019 21:38:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x67CcrMb006529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562503134;
        bh=nrjqtdWdKb0YLVBdENA2teXagV7cGddSi8G95bRLscQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BiKpB7J5guJX5/CaJ/CbFoeiUw3+khQRO4J3pOIoiTgpF5vFS6w0QUBrohHHdEiZw
         xMynpNvLy89WJqBQxCMATaulMcBu+6OfJPk42IbjjFMv8gkmboT1cqR2vgfKupqtFh
         n8JYKAf+9D2l0+Xqeq06N87CfLCmbbZ3E12GVUTfTcybzpdQy0RriWR68NbYvulvpH
         QcuKN4SHY95sVr7jUVKz1qbBdFigC9B68ZvkEhCw5hnuRkoE2zTLlp6LHGtIexF5jq
         PE5xhE90rB/PC6rQVndhnMpxuGiyVP65yjNYh2Fyyx3FeluoOu6EK3XbrLpDT/l3+j
         f2NpIMOl9JJVA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id o19so3865350uap.13;
        Sun, 07 Jul 2019 05:38:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXg7BnNo6RCtG8RsQGWsHYDl0KxQQlxbysFxeixv/Co7Xf9Uxrx
        uUBptMmiurwXT5rK25o+r+d4Jv7XmV6zUGMxm0s=
X-Google-Smtp-Source: APXvYqy+su+SSqSwTlKPdJzW478US2CzEGH5+iDXkwg6uKSJwTmNd+jUZi0lJI3seXTNN+i5ii+Piloj6ymqN1HNcnQ=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr7134067uaf.95.1562503133020;
 Sun, 07 Jul 2019 05:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907061538580.2523@hadrien> <de953581-7ae6-952c-3922-3d5b25f48e17@web.de>
In-Reply-To: <de953581-7ae6-952c-3922-3d5b25f48e17@web.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Jul 2019 21:38:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0kxA53k894sfRXOjcbyjj_mmY60JbKy5Lhi2qHJcC9g@mail.gmail.com>
Message-ID: <CAK7LNAT0kxA53k894sfRXOjcbyjj_mmY60JbKy5Lhi2qHJcC9g@mail.gmail.com>
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Palix <nicolas.palix@imag.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 7, 2019 at 6:56 PM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> >> I will apply with Julia's Signed-off-by instead of Acked-by.
>
> >> I will also add SPDX tag.
>
> >>
>
> >> Is this OK?
>
>
> >
> > Yes, thanks.
>
>
> Will the clarification for following implementation details get any more
> software development attention?
> https://systeme.lip6.fr/pipermail/cocci/2019-June/005975.html
> https://lore.kernel.org/lkml/7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de/
>
> * The flag =E2=80=9CIORESOURCE_MEM=E2=80=9D
>
> * Exclusion of variable assignments by SmPL when constraints


OK, for this refactoring to happen,
the second argument should be IORESOURCE_MEM
instead of generic 'arg2'.

Himanshu,
Will you send v2?



--=20
Best Regards
Masahiro Yamada
