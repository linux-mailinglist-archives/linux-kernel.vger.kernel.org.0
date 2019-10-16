Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051B5D8AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391602AbfJPIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:25:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35203 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfJPIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:25:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so16713404lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xo35Bg7+wZLq9WAYiOuUcTZRMp2CbtvKNgMqelyARTU=;
        b=eFXeazm0o1tL5yIT8cIoz4Wk8anNWAsBOAqZuTJLrcmF2+ZuFXcPF5UVUCWL7aIqil
         IPv3kOP6K1GOt7SHle1XCTL3se7HLV7MPcGNg3WcrI60YQPfUEAm9aUokJNKOpR2EbAA
         e78DxjS58Ht4pQMlOpK4jhBzKtIqSy4nCyWtSESafH71SkFiMrXk5gnX5z+kGwZe4s+D
         y2VQBtcVTbKENFN9vL8/vc6TXOxscGJmF/Jq1j1cum1G2Fb3HvotNml0i/JH6jiGyldY
         NROzHm86nPDDviCEMqX2kExhGpQbdpmN4YLu0WJPUUraOjC0mX+NYkDkyo+WQAtLFgIE
         8RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xo35Bg7+wZLq9WAYiOuUcTZRMp2CbtvKNgMqelyARTU=;
        b=QJmMci+t1zTRMxm2vPfr407/xgwcmDgjythLN1j9ijPvYqxIXQVxNCHPL/FZUBMzwA
         Z7ho9SCiU7iIx80Ex+mpEeE3V1GB64YU+U9uBXfGt+pNBrTC8Y5keVp9LG1qvfXy238K
         V0QL2CQYqakI1y8Xmx6GyU28F+V248AmVYyW5W55mQueQW0AoejeXS5Nzo/vPpkhoMqU
         VUjbcaoHpMQBP2gJ/F3lCg0tL0t0rUw39xshPixPgRdIbHk+hpbfAsr8kaWin2XXURsL
         m+CcClyD0/CNeM7X78flhRWfTLri5VVNq0t1Xy3rIxSiu+GM1BICkVMYYsUxoEljJ0aX
         xxHw==
X-Gm-Message-State: APjAAAXdyoekH1LuJOedcZ+ymuf3Yy0guEKIxH9YJhyTofn3z44/RO/c
        rGrTsnNtjbPKeHWsYv+IPxxvsD/ze/p9VSe3EJA=
X-Google-Smtp-Source: APXvYqztWV5plJBF/+oigJru3O+68vfnDX1Uj5DGkapsvD7/tG4QkaKTaiMATHeFnEyKvPu9+4MV2xK2aaXCm/MiANI=
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr24108061lfc.34.1571214340972;
 Wed, 16 Oct 2019 01:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191016070740.121435-1-codekipper@gmail.com> <20191016070740.121435-3-codekipper@gmail.com>
 <20191016080653.3seixioa2xiaobd7@gilmour>
In-Reply-To: <20191016080653.3seixioa2xiaobd7@gilmour>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 16 Oct 2019 10:25:29 +0200
Message-ID: <CAEKpxBmuYe-kHpa4cvo6iabTM_qNro2hXVAkjioBZFt9N4pHdA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] ASoC: sun4i-i2s: Add functions for RX and TX
 channel offsets
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 10:06, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Wed, Oct 16, 2019 at 09:07:35AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Newer SoCs like the H6 have the channel offset bits in a different
> > position to what is on the H3. As we will eventually add multi-
> > channel support then create function calls as opposed to regmap
> > fields to add support for different devices.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 31 +++++++++++++++++++++++++------
> >  1 file changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index f1a80973c450..875567881f30 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -157,6 +157,8 @@ struct sun4i_i2s_quirks {
> >       int     (*set_chan_cfg)(const struct sun4i_i2s *,
> >                               const struct snd_pcm_hw_params *);
> >       int     (*set_fmt)(struct sun4i_i2s *, unsigned int);
> > +     void    (*set_txchanoffset)(const struct sun4i_i2s *, int);
> > +     void    (*set_rxchanoffset)(const struct sun4i_i2s *);
>
> The point of removing the regmap_field was that because having a
> one-size-fits-all function with regmap_field sort of making the
> abstraction was becoming more and more of a burden to maintain.
>
> Having functions for each and every register access is exactly the
> same as using regmap_field here, and the issue we adressed is not with
> regmap_fields in itself.
>
> If the H6 has a different register layout, then so be it, create a new
> set_chan_cfg or set_fmt function for the H6.
The H3 and the H6 have a similar register layout but the issue here is
that sooner
rather than later we would want to be supporting multi-channel audio
which requires the
offset to be applied to each TX channel channel select register(8chan
PCM for HDMI
requires 4 Tx channels). Currently we're only using one.
BR,
CK
>
> Maxime
