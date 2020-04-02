Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61C19BB97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 08:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgDBGS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 02:18:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40290 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:18:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id y25so2372685qtv.7;
        Wed, 01 Apr 2020 23:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cV2YJUSGiYhirlg/uube1HpzHXA1hdUUTg03rjPXzhU=;
        b=CufHI3iEU2muaQr5R8dRuq7iCjaUo5TKaF1X0hBzOhMujV6NF4Y7C/zLLsfPoxK2nz
         rWAGR9pttYt4OS2ptAOdfyfQV3Ez/pb26trux6nPXt1LrWdTofhaYzpJVNahtCF+2HF1
         VA3YECrvMceSITpYL/WQ+lZPuGMn9oSe+9N40ljCrS7iTQ6gEsdMAfYl/sbgaWGAZuek
         RYnePZ+lxaucLpMkeklNkd6TYnOByY6jd+uhJpuVCga5vmS54ZkLSNGRqpuzupIgbA5x
         E+GE/IpWM+bJSXVZ4sfgAgeMU/tPGSGVcm6xCmZ7Pipf+DqL16F8GhOUykLSP0Zbbk/G
         WNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cV2YJUSGiYhirlg/uube1HpzHXA1hdUUTg03rjPXzhU=;
        b=l145FeMTHLtVbOuXucIx1mhCj6ljKjDomXpPji42T9kJkpFX74OxAW00Ea74ZGGgvN
         NV9tKEH1fz7GGc9KIsxP9cpPCYOCaxTR5h5A/UdbPVrb93g620SeWoKppASrQO2uvJ6L
         OOs5PPoV68gpE5FTBFZEA2sgz5juq9vLNI5zr7oPFCyaZskHcoPxSbKDGsuj/rPyYTaJ
         p6Zll0PCwGpHrkVC5ORYyZJ3R/DOuVMc3uZtfd07pdhYt93MC/I5kCUgdcI4OgETzKwX
         kHHNtC8yCGlkWxJJJUF7aLSy5thHlzKa+3kVgSL7WZ2cd2RQlwN2729thcrgtcHUhHB5
         xnAg==
X-Gm-Message-State: AGi0PuZrtOG3BqHHEu0KJMfMlZYl7kt9NTL4FinROex2e6oqUeOz2bUO
        16PrupjdGroi0tmSwT6+XkTmMwai3wOhsiO9zrc=
X-Google-Smtp-Source: APiQypL7sbH9klF+FlPxJEnjasMU4y+phrgXAF1Edoy5vXn5ogJpADPAhfAhA15O4BFZ6/PMgFphqicTiipdEmCS3XE=
X-Received: by 2002:ac8:6f46:: with SMTP id n6mr1362709qtv.119.1585808304169;
 Wed, 01 Apr 2020 23:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200317101947.27250-1-igor.opaniuk@gmail.com> <20200330204604.GA11575@bogus>
In-Reply-To: <20200330204604.GA11575@bogus>
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
Date:   Thu, 2 Apr 2020 09:18:13 +0300
Message-ID: <CAByghJZHvx_k==tcC+CoVk1NF7rnrMOTa3B8VF5SuRCa=d8-zw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] ARM: dts: imx6: Dual license adding MIT
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Mar 30, 2020 at 11:46 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Mar 17, 2020 at 12:19:43PM +0200, Igor Opaniuk wrote:
> > From: Igor Opaniuk <igor.opaniuk@toradex.com>
> >
> > Dual license files adding MIT license, which will permit to re-use
> > device trees in other non-GPL OSS projects.
>
> Are you the only author on these files? If not, you don't have rights to
> do this.

I'm not (obviously), this is why:
1. Patch series has RFC tag.
2. All stakeholders (including authors) are in CC list

>
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> > ---
> >
> >  arch/arm/boot/dts/imx6dl-pinfunc.h | 2 +-
> >  arch/arm/boot/dts/imx6dl.dtsi      | 2 +-
> >  arch/arm/boot/dts/imx6qdl.dtsi     | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx=
6dl-pinfunc.h
> > index 9d88d09f9bf6..960d300ea9ba 100644
> > --- a/arch/arm/boot/dts/imx6dl-pinfunc.h
> > +++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
> > @@ -1,4 +1,4 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> >  /*
> >   * Copyright 2013 Freescale Semiconductor, Inc.
> >   */
> > diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.d=
tsi
> > index 008312ee0c31..77e946b3d012 100644
> > --- a/arch/arm/boot/dts/imx6dl.dtsi
> > +++ b/arch/arm/boot/dts/imx6dl.dtsi
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> >  //
> >  // Copyright 2013 Freescale Semiconductor, Inc.
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl=
.dtsi
> > index e6b4b8525f98..75d746952932 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> >  //
> >  // Copyright 2011 Freescale Semiconductor, Inc.
> >  // Copyright 2011 Linaro Ltd.
> > --
> > 2.17.1
> >



--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+380 (93) 836 40 67
http://ua.linkedin.com/in/iopaniuk
