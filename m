Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5FC34041
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfFDHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:34:53 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50925 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfFDHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:34:51 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 803FD20010;
        Tue,  4 Jun 2019 07:34:43 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:34:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 1/9] ASoC: sun4i-i2s: Fix sun8i tx channel offset mask
Message-ID: <20190604073443.cnnqd7ucbaehxdvj@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-2-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oguexniktnsgbuau"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-2-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oguexniktnsgbuau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:27PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Although not causing any noticeable issues, the mask for the
> channel offset is covering too many bits.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--oguexniktnsgbuau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYfEwAKCRDj7w1vZxhR
xWTgAP46CpvpBxgUOlrtYU+GAVae+CKXAiXNKOPwVAQgkXV9YwEA1KFPel403xOw
LGVrq+HZ5ELbkBkQpaqRXjEtJjf3eAE=
=n1Fa
-----END PGP SIGNATURE-----

--oguexniktnsgbuau--
