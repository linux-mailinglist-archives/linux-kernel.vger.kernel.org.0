Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC12B1D17
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 14:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfIMMLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 08:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfIMMLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:11:00 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D4E2084F;
        Fri, 13 Sep 2019 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568376659;
        bh=FImV5Wq2wnlVDJQJ0cPRAqO4Ulwuut3JipAbAXiZP/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnQgWi3zVU/eEwNcUziGBkjZME18TnXuqtb7uosH8tcwnufrV6XXCx8ZL/tsLjC7X
         EvDZ6H3PzoDi6AmxufMmOPqZ/0TH9TxDCHmNCFI9+wogHCZcdQc815kHrKT5Um9skt
         tL2SggScWfXRqd2wGNzP4qMbfBHkUFbeA/0jQUHA=
Date:   Fri, 13 Sep 2019 14:10:56 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 9/9] sunxi_defconfig: add new crypto options
Message-ID: <20190913121056.h2iotti6dzpsp6lx@localhost.localdomain>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
 <20190906184551.17858-10-clabbe.montjoie@gmail.com>
 <20190907040353.hrz7gmqgzpfpo4xj@flea>
 <20190913081555.GA22538@Red>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffgt2cjw56vmabzb"
Content-Disposition: inline
In-Reply-To: <20190913081555.GA22538@Red>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffgt2cjw56vmabzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 10:15:55AM +0200, Corentin Labbe wrote:
> On Sat, Sep 07, 2019 at 07:03:53AM +0300, Maxime Ripard wrote:
> > On Fri, Sep 06, 2019 at 08:45:51PM +0200, Corentin Labbe wrote:
> > > This patch adds the new allwinner crypto configs to sunxi_defconfig
> > >
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  arch/arm/configs/sunxi_defconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> >=20
> > Can you also enable it in arm64's defconfig as a module?
> >=20
>
> Does you prefer adding a Kconfig "DEFAULT m if ARCH_SUNXI" which
> permit to not touch any defconfig ?

It's not the preferred solution, unfortunately

Maxime
--ffgt2cjw56vmabzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXXuHUAAKCRDj7w1vZxhR
xVj6AQCte0LxsckHRmuiUFmI2uusqYR7WoJJUQuHpsZznP2FkQEArHYCXAXLwf4v
eUq+1BJhz/6J08UKnz6F1MN145U+fA4=
=du6r
-----END PGP SIGNATURE-----

--ffgt2cjw56vmabzb--
