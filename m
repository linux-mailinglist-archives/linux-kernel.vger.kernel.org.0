Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8D8D1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfHNLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 07:08:45 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:52515 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfHNLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:08:43 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6340A240007;
        Wed, 14 Aug 2019 11:08:41 +0000 (UTC)
Date:   Wed, 14 Aug 2019 09:20:07 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
Message-ID: <20190814072007.6tfvhzsw4oxbwpc2@flea>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-16-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgil7vhvwetdcvgj"
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-16-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgil7vhvwetdcvgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 08:08:54AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> to reflect this.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

This patch looks like it's fixing something while the commit log
doesn't mention what is being fixed.

Having some context here would be great.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dgil7vhvwetdcvgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVO2JwAKCRDj7w1vZxhR
xRxTAQCYD2CO3SPSOc5RdlVUrQv1djtiH0pfZP5VbijJa1lzPwD+PM6hd04us2FV
WlQk7WtocalzR0MoGH07HDDW7ZocGA0=
=ba8a
-----END PGP SIGNATURE-----

--dgil7vhvwetdcvgj--
