Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC92194584
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCZRg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZRg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:36:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6691AF40;
        Thu, 26 Mar 2020 17:36:23 +0000 (UTC)
Message-ID: <486b5c63e5b9bd81051500c0c310e68af16956c4.camel@suse.de>
Subject: Re: [PATCH] drm/vc4: Fix HDMI mode validation
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     maxime@cerno.tech, linux-rpi-kernel@lists.infradead.org,
        f.fainelli@gmail.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Mar 2020 18:36:20 +0100
In-Reply-To: <c4b3e083-ac6e-b321-f0eb-f20e8ec3b1a6@i2se.com>
References: <20200326122001.22215-1-nsaenzjulienne@suse.de>
         <c4b3e083-ac6e-b321-f0eb-f20e8ec3b1a6@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WLjDMV1ZcTszpN+SQxBm"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WLjDMV1ZcTszpN+SQxBm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-26 at 18:19 +0100, Stefan Wahren wrote:
> Am 26.03.20 um 13:20 schrieb Nicolas Saenz Julienne:
> > Current mode validation impedes setting up some video modes which shoul=
d
> > be supported otherwise. Namely 1920x1200@60Hz.
> >=20
> > Fix this by lowering the minimum HDMI state machine clock to pixel cloc=
k
> > ratio allowed.
> >=20
> > Fixes: 32e823c63e90 ("drm/vc4: Reject HDMI modes with too high of clock=
s")
> > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
> > index cea18dc15f77..340719238753 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -681,11 +681,23 @@ static enum drm_mode_status
> >  vc4_hdmi_encoder_mode_valid(struct drm_encoder *crtc,
> >  			    const struct drm_display_mode *mode)
> >  {
> > -	/* HSM clock must be 108% of the pixel clock.  Additionally,
> > -	 * the AXI clock needs to be at least 25% of pixel clock, but
> > -	 * HSM ends up being the limiting factor.
> > +	/*
> > +	 * As stated in RPi's vc4 firmware "HDMI state machine (HSM) clock mu=
st
> > +	 * be faster than pixel clock, infinitesimally faster, tested in
> > +	 * simulation. Otherwise, exact value is unimportant for HDMI
> > +	 * operation." This conflicts with bcm2835's vc4 documentation, which
> > +	 * states HSM's clock has to be at least 108% of the pixel clock.
> > +	 *
> > +	 * Real life tests reveal that vc4's firmware statement holds up, and
> > +	 * users are able to use pixel clocks closer to HSM's, namely for
> > +	 * 1920x1200@60Hz. So it was decided to have leave a 1% margin betwee=
n
> > +	 * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
>=20
> s/RPi0-3/bcm2835/ ?

Well as Dave Stevenson stated on the previous thread[1], it's the firmware =
that
sets up the HSM limitation. IIUC technically both HSM and pixel clocks coul=
d be
increased. Hence this being more of a RPi limitation than the chip itself.

"Whilst the firmware would appear to use a fixed HSM clock on Pi0-3, I
don't anticipate there being any issue with varying it. It looks like
there was the expectation of it being variable in the past, but
someone has refactored it and either accidentally or deliberately
given up on the idea."

Regards,
Nicolas

[1] https://www.spinics.net/lists/arm-kernel/msg794591.html


--=-WLjDMV1ZcTszpN+SQxBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl586BQACgkQlfZmHno8
x/7xnQf6AuxYHKRPr2+3HAcUcMvGEUsg4+CG33ixIOsZSzYB4i53R8AaNPUXuT49
DgINWf1HDprPNcucqW0YHLK1MuOHLr037rJaEi8U7niiYwf1NhCowZarMRZsdng0
uDBenGjN+AfeI303kAU/U5oPK+5R013lkXTpi+KKGeAmdsg0cWCnCXvQj4eA2PrT
MJ67v2ageDmRvuA/OJ+N2+tpz7raOs08ErzH5kYW8OUIllpTpIQSNr8Vn1JJZgF9
FjyvhPl4PNuNaUaTQm/Hi+TMH3tW51q5q9ZWPkBikHpyGmUbIaEBqNV0ZEuDAXDR
LUhSe29/+lSxhq7Hvo7FH29Yz183Tw==
=RSrf
-----END PGP SIGNATURE-----

--=-WLjDMV1ZcTszpN+SQxBm--

