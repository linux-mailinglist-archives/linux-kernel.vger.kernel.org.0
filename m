Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48ACE14754
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfEFJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 05:15:09 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40335 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfEFJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:15:08 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id F05436000D;
        Mon,  6 May 2019 09:15:04 +0000 (UTC)
Date:   Mon, 6 May 2019 11:15:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra: Remove
 regulator-always-on
Message-ID: <20190506091504.mbkr5kqyym5gngeb@flea>
References: <1556924720-49372-1-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dvasnxeqq2ltvqq3"
Content-Disposition: inline
In-Reply-To: <1556924720-49372-1-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dvasnxeqq2ltvqq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2019 at 08:05:19PM -0300, Pablo Greco wrote:
> Now that the regulators are tied to the GPIO bank, we can remove the
> unneeded regulator-always-on in reg_aldo2
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Queued for 5.3, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dvasnxeqq2ltvqq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXM/7GAAKCRDj7w1vZxhR
xc9bAQC8YRi3gs8HuqDb8+sr+DijRefSa0vscw+8e3AW3uzKTwEAm8liWEtJpnJD
D9zHOmLRY4EuKSYRPGBj8xCScD/U5wU=
=Oikk
-----END PGP SIGNATURE-----

--dvasnxeqq2ltvqq3--
