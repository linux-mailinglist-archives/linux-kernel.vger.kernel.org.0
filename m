Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E870BA35E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfH3LpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 07:45:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfH3LpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CadVpplwVADEGUMaV44Yr02WNCKjS5HQb+wLfMCybs8=; b=UGmbbQ88FNLbZfxFjM3A0cMHt
        TaIyi9zVfjiD4eA4fWwgul7Vt43hIahRefpwbkX96EUCZTFz4H3E3wT1SwxNmwK3aKENVVM+r53QH
        V3x2dAW8tbipYwEtRYz8JqCm3eHGyqR7cHjg267upTxE4j/WAA4vTlOO7vnCOcbVwgOUA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fKs-0006IC-Ir; Fri, 30 Aug 2019 11:44:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AF78F2742B61; Fri, 30 Aug 2019 12:44:57 +0100 (BST)
Date:   Fri, 30 Aug 2019 12:44:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     codekipper@gmail.com
Cc:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        be17068@iperbole.bo.it
Subject: Re: [PATCH] ASoC: sun4i-i2s: incorrect regmap for A83t
Message-ID: <20190830114457.GB5182@sirena.co.uk>
References: <20190821162320.28653-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20190821162320.28653-1-codekipper@gmail.com>
X-Cookie: Send some filthy mail.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 06:23:20PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---

This doesn't apply against current code, please check and resend.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1pDDgACgkQJNaLcl1U
h9BCoQf/W0mCzcRW3NldO/WLGdATE7AdgyPsicKChjYVaeDuLtVqG9DYuWwozZci
YSfNIM3/lZh43VMgLDNxpnn5tpHFtt0EgdV/bDu/HyqVYU4c0ggzyDcLOP6WlMtP
fg/jqzCUNlhyFntMh/z9f7ucofEh0CmCHWiZNTSTz9Cd23HuNK4yqdqQGdpRDWSU
YB2NiAEFg3SAwqFie2W8m7kqy6oznKq4LPZZCK8lQwovwnV1ewsvjoAee+uv8i2/
kjIQzeRO10yai4eUwoM6uecsEV/uc7t30gGEbzXLjqeagtYA64bRSiXunO1hP65q
no0bDJN4bQSY79n4G3XxV47omRg40w==
=KsOX
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
