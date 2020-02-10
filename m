Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577AD157D83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 15:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgBJOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 09:37:20 -0500
Received: from foss.arm.com ([217.140.110.172]:34650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbgBJOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:37:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DE5B1FB;
        Mon, 10 Feb 2020 06:37:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D626E3F68E;
        Mon, 10 Feb 2020 06:37:18 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:37:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, lars@metafoo.de, alsa-devel@alsa-project.org,
        vkoul@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Consider DMA cache caused delay in
 pointer callback
Message-ID: <20200210143717.GO7685@sirena.org.uk>
References: <20200210140423.10232-1-peter.ujfalusi@ti.com>
 <s5hmu9qfrq7.wl-tiwai@suse.de>
 <15c7df10-cf9f-109c-3cbf-e73af7f4f66a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7pXD3OQNRL3RjWCz"
Content-Disposition: inline
In-Reply-To: <15c7df10-cf9f-109c-3cbf-e73af7f4f66a@ti.com>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7pXD3OQNRL3RjWCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 04:28:44PM +0200, Peter Ujfalusi wrote:
> On 10/02/2020 16.21, Takashi Iwai wrote:

> >>  	delay +=3D codec_delay;
> >> =20
> >> -	runtime->delay =3D delay;
> >> +	runtime->delay +=3D delay;

> > Is it correct?
> > delay already takes runtime->delay as its basis, so it'll result in a
> > double.

> The delay here is coming from the DAI and the codec.
> The runtime->delay hold the PCM (DMA) caused delay.

I think Takashi's point here (and a query I have) is that we end up with

	delay =3D runtime->delay;
	delay +=3D stuff;
	runtime->delay +=3D delay;

which is equivalent to

	runtime->delay =3D (runtime->delay * 2) + stuff;

and that's a bit surprising.

--7pXD3OQNRL3RjWCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BapwACgkQJNaLcl1U
h9DBhQf/Tk/iC/yKWJP7T7Lj64Ke/xkylo2HhoZpN9ztDp+jgiRLcSddDcUu60nF
EU51o1aMPIxaxLpO+nyhm35DDgSBLoe1GxQ9zGF/gBoy/GD3pVsdYuNS6a1yK5nY
y1XkpONUhfp28jG1QI6uFTKa6lQuy0zOsBBS9Bm7hnLTOgWZLj+O7GcmqEuc5ZSH
FQ5jm9M7ur2web3e9M+AZ8Xh+6+4Wz5ZheFpN8nuGbCaqkcCtSm2/N+LEc1/u9w7
vCQ6Cwl0/y+7ApwMdQHOEvr/1sOug+LZssOvYVR1XBAsxP7zeLMdw64KRP093ePk
bj5e/vWn+pqcRn1OI04cY6IeAo+qtQ==
=Kcuw
-----END PGP SIGNATURE-----

--7pXD3OQNRL3RjWCz--
