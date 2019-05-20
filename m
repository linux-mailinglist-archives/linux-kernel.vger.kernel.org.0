Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1522222D61
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbfETHuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 03:50:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57579 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfETHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:50:16 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CB6B320006;
        Mon, 20 May 2019 07:50:06 +0000 (UTC)
Date:   Mon, 20 May 2019 09:50:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
Message-ID: <20190520075006.pwrsaytg57d44377@flea>
References: <20190518154014.28998-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ccv2ztaysqwm5bmp"
Content-Disposition: inline
In-Reply-To: <20190518154014.28998-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ccv2ztaysqwm5bmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 18, 2019 at 05:40:14PM +0200, Jernej Skrabec wrote:
> mmc1 node where wifi module is connected doesn't have properly defined
> power supplies so wifi module is never powered up. Fix that by
> specifying additional power supplies.
>
> Additionally, this STB may have either Realtek or Broadcom based wifi
> module. One based on Broadcom module also needs external clock to work
> properly. Fix that by adding clock property to wifi_pwrseq node.
>
> Fixes: e582b47a9252 ("ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ccv2ztaysqwm5bmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOJcLgAKCRDj7w1vZxhR
xektAP9SnxxVhsL3J9tjBeCsUfx6I7mOWHiMoulYMbgQCQtW1AD/VJuC+zZfSxgg
QyXsTvQqjqBuraleNIOqwbIEAuz6ugI=
=nQKm
-----END PGP SIGNATURE-----

--ccv2ztaysqwm5bmp--
