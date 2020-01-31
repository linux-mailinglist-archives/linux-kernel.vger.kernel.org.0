Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51C314EA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 10:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgAaJzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 04:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgAaJzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:55:40 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDBE214D8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580464539;
        bh=i1Q2HrEqLwmL98c9MGNOn0IlVGiouN5js+O7UuE6uZ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OviUJf/XQPpTumug091IEFOc2iCyQefpCOpXKuhNEdLzK7YW7iu+lpuOubIjOoH8q
         Qh0vKrNFjPjBdLazzvzijNWnXPswq31ObPM5xrgRPfPcL0HR5q0slVvyeBtAafjOSd
         pCyH9qlaRDmQW+TcQro2SG+iReh7PXq4Cmcljcks=
Received: by mail-lj1-f176.google.com with SMTP id v17so6459721ljg.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 01:55:39 -0800 (PST)
X-Gm-Message-State: APjAAAXAV6sbM5rwx7WvIoRvqbNKPQp0wSgLJriabrH9bPJTQm2twXAG
        E/J9psqrq5LobA2T8OHzzbg/m3ZYig1Opa/6MvA=
X-Google-Smtp-Source: APXvYqwC583auHB94JFkCsW1SWveAuKT/DkacVrJO6wUv6tp5QQCiiqLXAqL/scYC2HEBggtEZMQKa91V6W2yf2X2Jc=
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr5258945lji.256.1580464537454;
 Fri, 31 Jan 2020 01:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20200130192024.2516-1-krzk@kernel.org> <CAEbi=3eb+UsNz4V-yCWYn4AB96XiVWTrUBnTNthbJ0xeGWiAEw@mail.gmail.com>
In-Reply-To: <CAEbi=3eb+UsNz4V-yCWYn4AB96XiVWTrUBnTNthbJ0xeGWiAEw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Jan 2020 10:55:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfr=B9-8TZQdBqCpoZCu9HDf4Yv4CBA4VwrDMwt3qe5ew@mail.gmail.com>
Message-ID: <CAJKOXPfr=B9-8TZQdBqCpoZCu9HDf4Yv4CBA4VwrDMwt3qe5ew@mail.gmail.com>
Subject: Re: [PATCH] nds32: configs: Cleanup CONFIG_CROSS_COMPILE
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 at 10:33, Greentime Hu <green.hu@gmail.com> wrote:
>
> Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2020=E5=B9=B41=E6=9C=8831=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=883:20=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> > CONFIG_CROSS_COMPILE support").
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/nds32/configs/defconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfi=
g
> > index 40313a635075..f9a89cf00aa6 100644
> > --- a/arch/nds32/configs/defconfig
> > +++ b/arch/nds32/configs/defconfig
> > @@ -1,4 +1,3 @@
> > -CONFIG_CROSS_COMPILE=3D"nds32le-linux-"
> >  CONFIG_SYSVIPC=3Dy
> >  CONFIG_POSIX_MQUEUE=3Dy
> >  CONFIG_HIGH_RES_TIMERS=3Dy
> > --
> > 2.17.1
> >
> Thank you, Kozlowski.
>
> Let me know if you like to put in your tree or nds32's.
> Acked-by: Greentime Hu <green.hu@gmail.com>

Hi,

Please take it through nds32 tree. Thanks!

Best regards,
Krzysztof
