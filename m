Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18478161199
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 13:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgBQMH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 07:07:27 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42025 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728898AbgBQMH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:07:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 96E596236;
        Mon, 17 Feb 2020 07:07:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Feb 2020 07:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=OfVcrpQMKRGKOHNjrwVqsjy8koy
        mmEYoZqQ/abqkNZs=; b=hbZg1DwrBLR7Fxkybgrro4ghvaganK+nfseQbao7P95
        3/Fso0j5h2tmYF5iSVA9O2HTDr/d0rgU5iKlwZiQjiPvsmajO8Z/TfJ5KUVAglF2
        eGGjrPydIjJ7vHfzSsdd3qhyYAUNc+GzitSrklhsFxGuWSK3l4ECJPRuRHa1eLAg
        CDldNsuUugcQndJh/8HeaONp4JAErrKwo9EU06202FCe5JD8/03YTgk2OhOaBLrC
        yJamIb8rEHovs/nMigGPKwKDZR36N+0ixrNKKk2xtJFI22At18n0aQPkwYZ012Bb
        zn85pcqiPpEGAD7KhrlwFCVeDibds9z3wNpIkM9KZyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OfVcrp
        QMKRGKOHNjrwVqsjy8koymmEYoZqQ/abqkNZs=; b=HBggl4cvfnASYd+UHHqOiH
        v/X0LFDNyy7SFDqGL5FM8i01+wnzi6ZCR4sK8bAFVQmog2fsL8xebknqsLOH5zw2
        ueBd3Am7Rn1VZ/kGhkE1o+uZhHDXRAxSAI2oKN4tlsha1ICpo0UkwlK4hD6X2s2c
        hrq57E+AF1wEUi4VnFPfUBKHGh3CbEuQR09jsldZXly8fnxK8HUryYDjHFZm8Iad
        KwyHdS1S2m2rYB1WssmxBLXrKNoE6zboBOwaiH+TDKUHjb4qpl20R4+1dRkMzxwo
        F7eBzN0W7AiZNUn/bEIy81LN/ChQtB/E/4pfhR61rKchke6V7d+TrdN0sKK4Bo0w
        ==
X-ME-Sender: <xms:-YFKXvGjcrlpeKMR2Ifly1NEdveEMxYgTiHaOk4T6_07YDvo4bswXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:-YFKXoOTA169LQhENRmuCrYtsyXVtoyJw3yureR7siGD5PHh7t1IJg>
    <xmx:-YFKXp-RrUaS9DQIyViu7xfFOEBeb5DlaSab2YWdlIabx3gW9EmW-w>
    <xmx:-YFKXl4tGPgYB97zKpFnxNujRiNBMMllGfXG8FoeOyN_pgY05nYY2w>
    <xmx:-4FKXhndzg31ChpHDy_zKvIUdThLVL5L015pzpSHXtVq77pPj-PMCg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE8373280063;
        Mon, 17 Feb 2020 07:07:20 -0500 (EST)
Date:   Mon, 17 Feb 2020 13:07:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?utf-8?Q?Myl=C3=A8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/34] sun8i-codec fixes and new features
Message-ID: <20200217120719.m37dldhe5fshcw27@gilmour.lan>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217091423.y2muniz3hosquho6@gilmour.lan>
 <CAGb2v65GuwLdJ3Rkt1cyU6EroWZ6pim7-sGry5jYBoi=mubpUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v65GuwLdJ3Rkt1cyU6EroWZ6pim7-sGry5jYBoi=mubpUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:44:36PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 17, 2020 at 5:14 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Mon, Feb 17, 2020 at 12:42:16AM -0600, Samuel Holland wrote:
> > > The sun8i-codec driver, as used in the Allwinner A33 and A64, currently
> > > only exposes a small subset of the available hardware features. In order
> > > to use the A64 in a smartphone (the PinePhone), I've added the necessary
> > > functionality to the driver:
> > >   * The full set of supported DAI format options
> > >   * Support for AIF2 and AIF3
> > >   * Additional routing knobs
> > >   * Additional volume controls
> > >
> > > Unfortunately, due to preexisting issues with the driver, there are some
> > > breaking changes, as explained further in the commit messages:
> > >   * The LRCK inversion issue means we need a new compatible for the A64.
> > >   * Some controls are named inaccurately, so they are renamed.
> > >   * Likewise, the DAPM widgets used in device trees were either named
> > >     wrong, or the device trees were using the wrong widgets in the first
> > >     place. (Specifically, the links between the analog codec and digital
> > >     codec happen at the ADC and DAC, not AIF1.)
> > >
> > > I tended to take the philosophy of "while I'm breaking things, I might
> > > as well do them right", so I've probably made a few more changes than
> > > absolutely necessary. I'm not sure about where all of the policy
> > > boundaries are, about how far I should go to maintain compatibility. For
> > > example, for the DT widget usage, I could:
> > >   * Rename everything and update the DTS files (which is what I did)
> > >   * Keep the old (misleading/wrong) name for the widgets, but repurpose
> > >     them to work correctly
> > >       (i.e. "ADC Left" would be named "AIF1 Slot 0 Left ADC", but it
> > >        would work just like "ADC Left" does in this patchset)
> > >   * Keep the old widgets around as a compatibility layer, but add new
> > >     widgets and update the in-tree DTS files to use them
> > >       (i.e. "ADC Left" would have a path from "AIF1 Slot 0 Left ADC",
> > >        but "AIF1 Slot 0 Left ADC" would be a no-op widget)
> > >   * Something else entirely
> >
> > I'm not sure this is really a concern here. We need to maintain the
> > compatibility with old DT's, but those will have an A33 compatible
> > too, and as far as I can see, you're not changing anything for that
> > compatible, so we're in the clear?
> >
> > If not, then the third option would probably be the best, especially
> > since it's only a couple of them.
>
> Unfortunately the description for both chips are shared, and they're wrong.
> So we probably need a new compatible (or a new driver)... or like options
> 2 or 3, keep the DT visible endpoints (but deprecate them), and route them
> to a new set of proper widgets.

And hmm, it might be a bit wild, but since it's basically just a sed
on a string in DT, can't we leverage the dynamic DT stuff to rewrite
the property if we find the old one at probe? That would keep the
driver clean.

Maxime
