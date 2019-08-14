Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF68D1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfHNLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 07:08:50 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45145 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfHNLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:08:44 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 441D6240009;
        Wed, 14 Aug 2019 11:08:42 +0000 (UTC)
Date:   Wed, 14 Aug 2019 09:20:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v5 12/15] ASoC: sun4i-i2s: Add multi-lane functionality
Message-ID: <20190814072046.metavychqvhuohwy@flea>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-13-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qyuby3czmo42ymqj"
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-13-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qyuby3czmo42ymqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 08:08:51AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The i2s block supports multi-lane i2s output however this functionality
> is only possible in earlier SoCs where the pins are exposed and for
> the i2s block used for HDMI audio on the later SoCs.
>
> To enable this functionality, an optional property has been added to
> the bindings.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Wasn't the plan to support only stereo for now?

Either way, that property should be documented.

Maxime
--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qyuby3czmo42ymqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVO2TgAKCRDj7w1vZxhR
xRheAQDnbjxSxOz3vnVbgOs4yo3FPOLzvk/zjkD6SLnNZwzRngD/YbHNYcIMu7s8
wIIaiLlZLD55zQWzMfEKW1PxachR/g0=
=vuZB
-----END PGP SIGNATURE-----

--qyuby3czmo42ymqj--
