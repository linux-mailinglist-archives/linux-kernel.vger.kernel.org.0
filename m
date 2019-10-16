Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5193D9450
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393836AbfJPOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 10:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390729AbfJPOvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:51:06 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331AE2168B;
        Wed, 16 Oct 2019 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571237465;
        bh=Xh/9gWmwBKdF+8neE3kItdxVMfpHXwc3n8w1uZywGNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMkLi5d63UN14+72d9h18uH19CkeKG76vGq+CqQ+wIG2Cyem630Ojwrt9CEOdzh1f
         nfcG0oLaZc2le2vb93goK32+ObpHGn+url2irqclWJw+pWdZempUJgMh0VLuA1KDwD
         FgYwaZLYrXiSq3mJDbHG9vjPT2zA1qR1eMkuVBy4=
Date:   Wed, 16 Oct 2019 16:51:03 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Code Kipper <codekipper@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [PATCH v6 1/7] ASoC: sun4i-i2s: Move channel select offset
Message-ID: <20191016145103.im4h75qi2fcdcmar@gilmour>
References: <20191016070740.121435-1-codekipper@gmail.com>
 <20191016070740.121435-2-codekipper@gmail.com>
 <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
 <CAEKpxBmNCA4U8-X8iSwOxBZ7T3dp6352S2Kfxc6f5E4N671zvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fi6amry3fbotqfax"
Content-Disposition: inline
In-Reply-To: <CAEKpxBmNCA4U8-X8iSwOxBZ7T3dp6352S2Kfxc6f5E4N671zvg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fi6amry3fbotqfax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2019 at 10:41:31AM +0200, Code Kipper wrote:
> On Wed, 16 Oct 2019 at 10:04, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Wed, Oct 16, 2019 at 09:07:34AM +0200, codekipper@gmail.com wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > On the newer SoCs the offset is used to set the mode of the
> > > connection. As it is to be used elsewhere then it makes sense
> > > to move it to the main structure.
> >
> > Elsewhere where, and to do what?
> Thanks...How does this sound?
>
> As it is to be used to set the same offset for each TX data channel in use
> during multi-channel audio then let's move it to the main structure.

That still doesn't explain why you want to move it to the main
structure. It's there, it's calculated already, and can be used during
multi-channel audio if you set it up in the same function. What you
need to explain is why you can't do it in the same function.

Maxime

--fi6amry3fbotqfax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXacuVwAKCRDj7w1vZxhR
xTaQAP0X2iGfJ5IY9S8B+s9Zh5MP11erZjYLItvMfIJTyW5EAgD/QxPJRbfuSz03
Mqd/XK6k/sf6xBYpSzArepQAruvCDQs=
=rCXO
-----END PGP SIGNATURE-----

--fi6amry3fbotqfax--
