Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06037FC7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 14:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKNNdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 08:33:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfKNNdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:33:38 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73364206DA;
        Thu, 14 Nov 2019 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573738418;
        bh=ygzFe5vChXq5wl0QvvRF0Eo8W1LO0yicEOlA6tLXLdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wX4quWK7cO7m4Jyt7GwynG0wHF8+0SjDsZVUZ56yGTGcA34gqScBqbTxP5OsWKTrw
         XSvT3heD9a/jvZ/ldsBPaVlI2miUZmunMd0V68G05exEMxQA8Q+rckGYfu4TgVU6Lc
         HUK/zYNW1BDqEUF//CG7QkVuOnIIr/xBLsaYQwa0=
Date:   Thu, 14 Nov 2019 14:33:35 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Enable USB 3.0 host for
 Beelink GS1 and Tanix TX6
Message-ID: <20191114133335.GP4345@gilmour.lan>
References: <20191114102541.27361-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="skNneT8yDpR3Aw11"
Content-Disposition: inline
In-Reply-To: <20191114102541.27361-1-peron.clem@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--skNneT8yDpR3Aw11
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 11:25:41AM +0100, Cl=E9ment P=E9ron wrote:
> Enable USB 3.0 phy and host controller.
>
> VBUS is directly connected to DCIN 5V and doesn't
> require to be switched on.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Queued for 5.6, thanks!
Maxime

--skNneT8yDpR3Aw11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXc1XrgAKCRDj7w1vZxhR
xfWaAP9GhZ+LI5gvY7lFBH/oAypeCSJ7h2h3Qr+sThPaYvJl9AEA+XwhXEYwFXH8
nxlj+PJMWgRGUn/QqPcvy8EXZTrY0AY=
=HhBK
-----END PGP SIGNATURE-----

--skNneT8yDpR3Aw11--
