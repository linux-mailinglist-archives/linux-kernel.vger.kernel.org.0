Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B4162EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 19:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBRSsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 13:48:35 -0500
Received: from foss.arm.com ([217.140.110.172]:58880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgBRSsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:48:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CC9731B;
        Tue, 18 Feb 2020 10:48:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DC53F703;
        Tue, 18 Feb 2020 10:48:33 -0800 (PST)
Date:   Tue, 18 Feb 2020 18:48:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas2562: Return invalid for when bitwidth is
 invalid
Message-ID: <20200218184832.GL4232@sirena.org.uk>
References: <20200218174706.27309-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline
In-Reply-To: <20200218174706.27309-1-dmurphy@ti.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 11:47:06AM -0600, Dan Murphy wrote:
> If the bitwidth passed in to the set_bitwidth function is not supported
> then return an error.
>=20
> Fixes: 29b74236bd57 ("ASoC: tas2562: Introduce the TAS2562 amplifier")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  scripts/conmakehash        | Bin 0 -> 13120 bytes
>  scripts/sortextable        | Bin 0 -> 18040 bytes
>  sound/soc/codecs/tas2562.c |   3 ++-
>  3 files changed, 2 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/conmakehash
>  create mode 100755 scripts/sortextable
>=20
> diff --git a/scripts/conmakehash b/scripts/conmakehash
> new file mode 100755
> index 0000000000000000000000000000000000000000..17eec37019b8ae45f42f3c820=
46d1a55a6f69cb3
> GIT binary patch
> literal 13120
> zcmeHOeQ;D&mcN}25CU`u1i`Q23C#=3Dv(j@XB0Wx-n4!le?@~!SFHl6fK(rc$X+x=3DRD

This is...  fun?  I'm guessing it's not intentional, it's certainly a
little difficult to review.  :)

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MMX8ACgkQJNaLcl1U
h9AE1Qf/Zp6m3NI0e0rXFXTJ2XbGhyY0eb9a56oQ6NAH8Cxv75wmSpRtYY56PGpK
XgBcQN67E9zoR9G+t8WS3t60tOmLAOyAVVDNQ4llIzUsl5oq0zcN5QZhG0GeDPwF
gfKhGhyKgyZ7cNY0IJETfg9kgF+zvUq49Dh9APTHkBr4OMd0XDJxuBSc2+oCFeAb
ozO7V5pje1NZe3zcwJY7ZvrjJ+MXnwevO+V9r+1QpFXS6als6G+JC3nChaDBHT7P
3rQJVO1Wtbl9m9cN2zUj18Zbg5dYjGQLr2ak91NLBjeawlzVSCQucidm0rAaGL4H
BrBsxv18mqZb8bouvke9jMA+15ovmw==
=piVj
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--
