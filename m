Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333A2EB10C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfJaNUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 09:20:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50524 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaNUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2ifd5ovM9AoSL8d0s/U0l8+nqR4uIYQi1wR5b3uhayg=; b=TV2PGLT1/fHPYrJ/nfvyb0+E+
        PQ/PahNER7WR6MT0LmH/Fto0m0OO2VI/TgxF3PxDHxfb5Nw8bYWjsbVBZqtVID79eCdE44rVef5BU
        SGydLykO10UggutBB84CDGrrOWLskk3E95Bp3ym0H1bCktphOAH1KtPGbi4e5jnsKEotM=;
Received: from [91.217.168.176] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iQAN0-0007nu-Jy; Thu, 31 Oct 2019 13:20:10 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 298D4D020AA; Thu, 31 Oct 2019 13:20:10 +0000 (GMT)
Date:   Thu, 31 Oct 2019 14:20:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5677: Make rt5677_spi_pcm_page static
Message-ID: <20191031132010.GR4568@sirena.org.uk>
References: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XQ/JOjNzrAcf1KaA"
Content-Disposition: inline
In-Reply-To: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XQ/JOjNzrAcf1KaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 08:15:19PM +0800, zhong jiang wrote:
> The GCC complains the following warning.
>=20
> sound/soc/codecs/rt5677-spi.c:365:13: warning: symbol 'rt5677_spi_pcm_pag=
e' was not declared. Should it be static?

It looks like this has been fixed already in the latest code.

--XQ/JOjNzrAcf1KaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2634kACgkQJNaLcl1U
h9A8KQf+PSbdofWiY5XFUVrKIJ6TvYvhkCTXoer7zqBiSsIZSptCLsR62aLe2Z+m
2dXj5FW5Y6JaDnFc+k/078SEiQW4bSOP5h6iyijF6Yj8LRpoen2YE22roMvzqsDR
EpBiFoaRYTwhnVFE69/XT/bnPK3wMzKblk2+ENCMTTvfc5VS6pXDBMueO64G25C/
IaMuarHobO/oY1iUj+FJeHbIz9tJIwGPDKMYwfTVJjcmxlhMkfHsIFnCNq0tcy1O
dwl+sQoVZ96hLeH7fC/v5bEO3n0xJ+eClpYsgIPDVqNSfC/3A2R5KPnZp7wLvEGF
KLUdT/zuMdYe3s3NGBIH9xzhiRrT/w==
=OAyt
-----END PGP SIGNATURE-----

--XQ/JOjNzrAcf1KaA--
