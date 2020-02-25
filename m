Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA216BFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 12:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgBYLmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 06:42:37 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:47102 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgBYLmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:42:36 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9E1941C208D; Tue, 25 Feb 2020 12:42:35 +0100 (CET)
Date:   Tue, 25 Feb 2020 12:42:34 +0100
From:   Pavel Machek <pavel@denx.de>
To:     pavel@denx.de
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 184/191] drm/amdgpu/smu10: fix
 smu10_get_clock_by_type_with_latency
Message-ID: <20200225114234.GB2591@amd>
References: <20200221072250.732482588@linuxfoundation.org>
 <20200221072312.821201678@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20200221072312.821201678@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Alex Deucher <alexander.deucher@amd.com>
>=20
> [ Upstream commit 4d0a72b66065dd7e274bad6aa450196d42fd8f84 ]
>=20
> Only send non-0 clocks to DC for validation.  This mirrors
> what the windows driver does.

> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 1546bc49004f8..3fa6e8123b8eb 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -994,12 +994,15 @@ static int smu10_get_clock_by_type_with_latency(str=
uct pp_hwmgr *hwmgr,
> =20
>  	clocks->num_levels =3D 0;
>  	for (i =3D 0; i < pclk_vol_table->count; i++) {
> -		clocks->data[i].clocks_in_khz =3D pclk_vol_table->entries[i].clk * 10;
> -		clocks->data[i].latency_in_us =3D latency_required ?
> -						smu10_get_mem_latency(hwmgr,
> -						pclk_vol_table->entries[i].clk) :
> -						0;
> -		clocks->num_levels++;
> +		if (pclk_vol_table->entries[i].clk) {
> +			clocks->data[clocks->num_levels].clocks_in_khz =3D
> +				pclk_vol_table->entries[i].clk * 10;
> +			clocks->data[clocks->num_levels].latency_in_us =3D latency_required ?
> +				smu10_get_mem_latency(hwmgr,
> +						      pclk_vol_table->entries[i].clk) :
> +				0;
> +			clocks->num_levels++;
> +		}
>  	}

This results in very ugly wrapping. Better way would be to do
"if !(pclk_vol_table->entries[i].clk) continue;"...

"drm/amdgpu/smu10: fix smu10_get_clock_by_type_with_voltage" could be
improved in similar way.

Best regards,
							Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5VCCoACgkQMOfwapXb+vLXQgCffdt12/YTK2DTCSDvMalPYVdb
lCMAmwQ257909XAf0gGoMrf1TiEyAaJT
=zSlR
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
