Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10216D8BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391680AbfJPIyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:54:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732135AbfJPIye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:54:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 455E6AEC4;
        Wed, 16 Oct 2019 08:54:33 +0000 (UTC)
Message-ID: <52cb6d848c5d1d7d0e8dc359e9c3fe6c00ddceeb.camel@suse.de>
Subject: Re: [PATCH -next v2] arm64: mm: Fix unused variable warning in
 zone_sizes_init
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 10:54:31 +0200
In-Reply-To: <20191016031107.30045-1-natechancellor@gmail.com>
References: <20191015224304.20963-1-natechancellor@gmail.com>
         <20191016031107.30045-1-natechancellor@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XL1H6941T8hAsoF71YoD"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XL1H6941T8hAsoF71YoD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 20:11 -0700, Nathan Chancellor wrote:
> When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> get disabled so there is a warning about max_dma being unused.
>=20
> ../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
> [-Wunused-variable]
>         unsigned long max_dma =3D min;
>                       ^
> 1 warning generated.
>=20
> Add an ifdef around the variable to fix this.
>=20
> Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>=20
> v1 -> v2:
>=20
> * Fix check for CONFIG_ZONE_DMA32 as pointed out by Will.
>=20
>  arch/arm64/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 44f07fdf7a59..359c3b08b968 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -212,7 +212,9 @@ static void __init zone_sizes_init(unsigned long min,
> unsigned long max)
>  	struct memblock_region *reg;
>  	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
>  	unsigned long max_dma32 =3D min;
> +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
>  	unsigned long max_dma =3D min;
> +#endif
> =20
>  	memset(zone_size, 0, sizeof(zone_size));
> =20

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!


--=-XL1H6941T8hAsoF71YoD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2m2sgACgkQlfZmHno8
x/7nEwf+LdOYEsxQAo4l3mtCRbpNKjXVZ2OFojqmoIsNuqZIqyPBsjYenMIxAvm2
ytDau7vxVIP2CaX3ozL3bHrVeEeYW4M3QUZxotu0iIP92s+6wJt5RVPP7eiwESrK
6m3eCPfbuYbk427JLLliu18X0cpDAgzPtLURkSSs44p9eTIQys0y+1HEexmArZr9
afEwVp0p+X9hkQPI3+Se3ezBFIzFr3Jo2dC8UTrNy0k4hwIi3MCVD/3FEtXsz1DA
YS+z16lCsKBk1jCZ9TDcbUsvZ0eaPUSvDpHFWhglqTR7YiDhyPoPrEvcf7DeP2Ah
KnaMCQsCM47uhChDL7WzDjudTAVKlw==
=KDT/
-----END PGP SIGNATURE-----

--=-XL1H6941T8hAsoF71YoD--

