Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D156D202DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEPJxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 05:53:05 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47143 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:53:05 -0400
Received: from localhost (unknown [80.215.244.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7D2D9240003;
        Thu, 16 May 2019 09:52:59 +0000 (UTC)
Date:   Thu, 16 May 2019 11:11:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v10 0/2] drm/sun4i: sun6i_mipi_dsi: Fixes/updates
Message-ID: <20190516091105.er6oeyrnompwik3j@flea>
References: <20190512184128.13720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ce3qofktjm47bfnn"
Content-Disposition: inline
In-Reply-To: <20190512184128.13720-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ce3qofktjm47bfnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2019 at 12:11:25AM +0530, Jagan Teki wrote:
> This is v10 for the previous series[1] and few pathes are dropped
> as part of this series since it would require separate rework same
> will send in separately or another series.

APplied both, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ce3qofktjm47bfnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN0pKQAKCRDj7w1vZxhR
xUFPAP9qQEmAom0RveVfdjeyYEidWvLU6MUme3eTHox9GhsoXQD6Aio7WpCJH0Hs
BM+RV1KwgBuakfuaClq/zq0ivu9hZgw=
=wdAl
-----END PGP SIGNATURE-----

--ce3qofktjm47bfnn--
