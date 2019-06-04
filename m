Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D734063
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfFDHhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:37:02 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59271 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfFDHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:37:02 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D5E191BF212;
        Tue,  4 Jun 2019 07:36:51 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:36:51 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 2/9] ASoC: sun4i-i2s: Add offset to RX channel select
Message-ID: <20190604073651.gst57ki7ohzxcrqz@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-3-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azthyenqniabzk6h"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-3-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azthyenqniabzk6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:28PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Whilst testing the capture functionality of the i2s on the newer
> SoCs it was noticed that the recording was somewhat distorted.
> This was due to the offset not being set correctly on the receiver
> side.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--azthyenqniabzk6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYfkwAKCRDj7w1vZxhR
xZFqAP9C7z4TKS6sO/uThXEHeSEOFsVxLA+hFezA6ZHPPwE+owD/YRL3Nd9adWWD
EG4ONA4mwLOBAc5utHFMpqL3ASmaTAA=
=3Iua
-----END PGP SIGNATURE-----

--azthyenqniabzk6h--
