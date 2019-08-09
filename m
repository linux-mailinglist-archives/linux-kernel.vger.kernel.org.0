Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E009C87A10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406960AbfHIMbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 08:31:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406946AbfHIMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pyBBsbalHEvtPhoCExuHav8txrXCNwbsReP97YH2hRk=; b=Wh7hAlHDJXrNQvL2E8vafoxwe
        eXEdpKG1tXNZupk7mE6dJQYL6UgojaSJdJoQsz2L0bWq12zW9kxuI4cVhiPI+T7y5WnwwCG5s2FVl
        ucUNM4/CdbBjNqW5GoFaSjBKISPhvig8gDI5VMLhMzdQRAk5pC7iTmHPwYRzyBeRYrRZ8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hw437-00060J-Ee; Fri, 09 Aug 2019 12:31:13 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7B2A8274303D; Fri,  9 Aug 2019 13:31:12 +0100 (BST)
Date:   Fri, 9 Aug 2019 13:31:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, kbuild-all@01.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix odd_ptr_err.cocci warnings
Message-ID: <20190809123112.GC3963@sirena.co.uk>
References: <alpine.DEB.2.21.1908091229140.2946@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908091229140.2946@hadrien>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:

> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/w=
ip
> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new machin=
e driver wip
> :::::: branch date: 20 hours ago
> :::::: commit date: 20 hours ago
>=20
>  j721e-evm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- a/sound/soc/ti/j721e-evm.c
> +++ b/sound/soc/ti/j721e-evm.c
> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf

This file isn't upstream, it's only in the TI BSP.

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1NZ48ACgkQJNaLcl1U
h9CcMQf+Km4bvdFc5fXpozUNHkhmiDGf5UtThFctMq6C6MK4tB+cTSjQqpLPip75
hihD/NMWNNvcxkJxNaK5pDv4yEWI+F9DLhjLePmCOdUjg68CwYF2e5tLEKs7LAzo
muAywApdJXbOOd+1yGG5lKw0EEoidrU5n9rzBYSbSjKwbtFhf4C1rQ8GO7T15S7U
+0sq47MSOf3Q5fji1RcvGy98RkZbzU9gcheLcTXcQfRZ+eapGu11PmHR+OqgO/GG
owL2DpqbypT+9iLdfmR9AOxwi3ykOWtU93h8uMh1tmDxfT4Auuj5j8leIEVdoCHP
KKhhYS2X70ImKlg4SeUrEJQTcWVntw==
=ykm0
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
