Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB5F19E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfKFPVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 10:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbfKFPVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:21:46 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F712166E;
        Wed,  6 Nov 2019 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573053706;
        bh=Z5uRUEYMHnBMAkQQBIKbi4YuTu5BKSlKgXYE8gT6Bec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKVvy8T7SQJv8gsuGyvvTQw5ONXKSc54BOSU448ev64QRk472PQZFFT/nTB1gGfTm
         HRd4abZ6Xa7XqWJMo9HkBoVMefaUGGv+B1N4aOjiFIldwk1TT+GQZckyJ9+VsuL24s
         agEi5bAJHcKcE/67YTYJsBFrzLGsfB8dA+5fwHKE=
Date:   Wed, 6 Nov 2019 16:21:31 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] drm/bridge: split some definitions of ANX78xx to
 dedicated headers
Message-ID: <20191106152131.GD8617@gilmour.lan>
References: <20191104110400.F319F68BE1@verein.lst.de>
 <20191104110605.F012268BFE@verein.lst.de>
 <20191105104126.GC3876@gilmour.lan>
 <20191105173332.GA11570@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <20191105173332.GA11570@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

On Tue, Nov 05, 2019 at 06:33:32PM +0100, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Some definitions currently in analogix-anx78xx.h are not restricted to
> the ANX78xx series, but also applicable to other DisplayPort
> transmitters by Analogix.
>
> Split out them to dedicated headers, and make analogix-anx78xx.h include
> them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>
> ---
>
> On Tue, Nov 05, 2019 at 11:41:26AM +0100, Maxime Ripard wrote:
> >
> > This one doesn't apply on drm-misc-next. The fix doesn't look really
> > obvious to me, can you rebase and resend it?
>
> Sure.
> The set was based on 5.4-rc5, which lacks 025910db8057f from drm-misc-next
> You'll also have to
> diff -r anx6345-v5/v5-0005-drm-bridge-Add-Analogix-anx6345-support.patch anx6345-v5a/v5-0005-drm-bridge-Add-Analogix-anx6345-support.patch
> 116,117c116,117
> < +     [I2C_IDX_DPTX]  = ANALOGIX_I2C_DPTX,
> < +     [I2C_IDX_TXCOM] = ANALOGIX_I2C_TXCOMMON,
> ---
> > +     [I2C_IDX_DPTX]  = 0x70,
> > +     [I2C_IDX_TXCOM] = 0x72,
>
> To make it compile, with the changed coding style of 025910db8057f.
> Can you change that on the fly in 5/7 or shall I resend that, too?

Please resend the whole series rebased on top of either linux-next or
drm-misc-next.

Maxime

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcLk+wAKCRDj7w1vZxhR
xbUHAQDw1ZTTedeTOWdyiLtw5dPLgY1kNJLxyuWvOWpHnLkvfwEAtl4uNwJQytsL
qdyuTkhCiUtsu2g+nFxjoWkC/bEU0Q0=
=JKza
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
