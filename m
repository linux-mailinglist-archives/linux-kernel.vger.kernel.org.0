Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87141EAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfEOJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 05:12:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36506 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:12:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so3141062edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=p+AzmpZG9ssvqNQdDvf61/wCHf9qPfT4ZDODShcElfo=;
        b=B0COwuh3ZHw0nsC0/uwKs1dS/HiaSVLg6KZh0IeJmXsGf9E2c/iD7YWDIy4wWdmg02
         4b7sGsLK0DSyXOfO3avjtUIX2z6DSRhrfdOoO3jKJxOM7G8Pr0loKXXB4h7R9+EdxmFT
         o8omzibNtiXksmUIwsT+XccPJ1e5urjq6Sa33pl4wa1s8yrVQI4lgZ7SqD5/lIiqKwno
         O7wLhnRBF8RRPKGTGxtYAbwCYh+g9galM50Q95/nCqrbV4zxeM2d2t3c/H8GIOzQ4dnw
         MKoBtpPoTTaQzUnNkcQYBTYM82Lo+zvd+ggv9c5wIglAChHOJsoDN9Reuz8+ODRUoDl7
         3PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=p+AzmpZG9ssvqNQdDvf61/wCHf9qPfT4ZDODShcElfo=;
        b=Tgi0ajscSW/85E4EgfH54gor5E9pTO1qqH7P0bZ4o1GBJKrEZlk/hZDQ3TOF0bo9aB
         pApR53XiLH/tEZuCrymMcRGh68jkEwPLqCpvMIqCCE1B2KkTshnhWaOZLnble5ncnJ36
         /TFwGkt+cjAP2xcf+U0RoEIepybpcbaBCDkgySY+waBfTl92HKa6frjxNxSqxYNOwFPa
         Vo3j7H+y2ARKZxR8AjtbzBJNQqG3aabnIlrKnFIdTji84BJMih7Y1SAz7hQRpOvZerxU
         E3MJ7R91U/uk8cw11+EFfYWQ2A6LrNJkaaOYY13o2bXtfoybJ28qVFELJEnGDRz+kQx6
         Xueg==
X-Gm-Message-State: APjAAAXyQ99Vdrxfi43OGBuXGNzezlE4h9oea0o+LZ0AgVuq04I7i2pk
        HKtiYeUZnp9jff6uHYH1aKptQw==
X-Google-Smtp-Source: APXvYqwmaFIXyjvOsUyoDS9Kl1N0oXbHrzIy5YXs1l0SkgYMRu5EEIS7ue1RMLnJVaPAmD5JznhDrw==
X-Received: by 2002:aa7:d6d3:: with SMTP id x19mr41615861edr.67.1557911524754;
        Wed, 15 May 2019 02:12:04 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id h44sm593809eda.3.2019.05.15.02.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 02:12:04 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <C02560B2-DD7F-4B59-8E63-8A06E5DF2271@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E1065D95-62D8-4302-A47A-E458FE1A436F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] lightnvm: pblk: Fix freeing merged pages
Date:   Wed, 15 May 2019 11:12:02 +0200
In-Reply-To: <20190515003952.12541-1-hlitz@ucsc.edu>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Heiner Litz <hlitz@ucsc.edu>
References: <20190515003952.12541-1-hlitz@ucsc.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_E1065D95-62D8-4302-A47A-E458FE1A436F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 15 May 2019, at 02.39, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> bio_add_pc_page() may merge pages when a bio is padded due to a flush.
> Fix iteration over the bio to free the correct pages in case of a =
merge.
>=20
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
> drivers/lightnvm/pblk-core.c | 18 ++++++++++--------
> 1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 773537804319..88d61b27a9ab 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -323,14 +323,16 @@ void pblk_free_rqd(struct pblk *pblk, struct =
nvm_rq *rqd, int type)
> void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
> 			 int nr_pages)
> {
> -	struct bio_vec bv;
> -	int i;
> -
> -	WARN_ON(off + nr_pages !=3D bio->bi_vcnt);
> -
> -	for (i =3D off; i < nr_pages + off; i++) {
> -		bv =3D bio->bi_io_vec[i];
> -		mempool_free(bv.bv_page, &pblk->page_bio_pool);
> +	struct bio_vec *bv;
> +	struct page *page;
> +	int i,e, nbv =3D 0;
> +
> +	for (i =3D 0; i < bio->bi_vcnt; i++) {
> +		bv =3D &bio->bi_io_vec[i];
> +		page =3D bv->bv_page;
> +		for (e =3D 0; e < bv->bv_len; e +=3D =
PBLK_EXPOSED_PAGE_SIZE, nbv++)
> +			if (nbv >=3D off)
> +				mempool_free(page++, =
&pblk->page_bio_pool);
> 	}
> }
>=20
> --
> 2.17.1

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_E1065D95-62D8-4302-A47A-E458FE1A436F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlzb1+IACgkQPEYBfS0l
eOAdURAAvM/6R6qT4bUjMVc3udUQeeCPR+M/SqeEVr04vNMVhCK6JAEgBr8QZCeB
KeAXltRDHq0hDDaD5Yyx7QcOZNczQdWojgKYsUt1xx210TII94TAP8JucgRtDQyn
hRZSQa0lLqMvO8iZiqqVpehTCiMGYf7JgREi7kqnu8IFkwtl2VnXB2wcpQjPdh7P
bgDtmKr47j8xqvyZRGqGtB4ZORxJKgOnmchtyVodknRe87vGoPX4Q14YXBz4toYd
ZdhJoCfwiTaB3fsYOC2zc16w4S02QaAb+ntufAKZsayytw6nFTJmY0uzNX25G/ON
fX6Kjk14Drs9hd9le8M6FKRL81ncEPObM9D3XMsByMvRNBSIjP2iem8PH0B+Ok75
5gIy7b6KzPQMSmJQRmK/9E4vMu1/jX8nJXcnyHTDwh+joPsPc2oBd758frpDeEG8
p8XroxRHa2ZUXrLo14pbDQQ+MzzJuC3G5KP8JI2WnEl9l78PcX+CPLxqku0sRXxF
TEVTzb/VJPs51Bmou5VGXMPBAwHM4NcZa8tnATSruON9JQgpDLfzTZbmAmQBL6TL
U0WVwVASmwtHRNcOYsVPUUSobCvPCpBXJMhixmrGOM7EE+0e0dz7KLH73+fkTMK1
6WxnoW0joLqvWjkRs5p7nm+W4Fs360tiLOCmcQZlVBGDEEYZhWk=
=Fqe8
-----END PGP SIGNATURE-----

--Apple-Mail=_E1065D95-62D8-4302-A47A-E458FE1A436F--
