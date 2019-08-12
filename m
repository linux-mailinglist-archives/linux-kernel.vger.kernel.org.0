Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0789C83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 13:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfHLLXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 07:23:30 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41419 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfHLLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:23:30 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 75E3C20008;
        Mon, 12 Aug 2019 11:23:28 +0000 (UTC)
Date:   Mon, 12 Aug 2019 13:23:28 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 0/2] Allwinner H6 SPDIF support
Message-ID: <20190812112328.o6xznp2mvnuchswe@flea>
References: <20190812105115.26676-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jy2mseu76lv4s422"
Content-Disposition: inline
In-Reply-To: <20190812105115.26676-1-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jy2mseu76lv4s422
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 12:51:13PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) which
> is different from the previous H3 generation and not compatible.
>
> Difference are an increase of fifo sizes, some memory mapping are differe=
nt
> and there is now the possibility to output the master clock on a pin.
>
> Actually all these features are unused and only a bit for flushing the TX
> fifo is required.

Applied both, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jy2mseu76lv4s422
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVFMLwAKCRDj7w1vZxhR
xcPRAP0ebGBO67tqWojTHkbb+BtT7hi+/h6+hwFFzFt8mCG2RQD9GxoAuuARoreO
CEPXNNW5FHOEKlw26Jh57e6Xkr2X1A8=
=n+Qt
-----END PGP SIGNATURE-----

--jy2mseu76lv4s422--
