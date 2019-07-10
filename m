Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF46644FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGJKMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 06:12:33 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51473 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:12:33 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 76E2860006;
        Wed, 10 Jul 2019 10:12:29 +0000 (UTC)
Date:   Wed, 10 Jul 2019 12:12:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
Message-ID: <20190710101229.54ufuhmh22dfxclr@flea>
References: <20190709145151.23086-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ahmo6bieusk7uhsj"
Content-Disposition: inline
In-Reply-To: <20190709145151.23086-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ahmo6bieusk7uhsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
> The named mode could be invalid and then cmdline parser misses to validate
> mode's dimensions, happily adding 0x0 mode as a valid mode. One case where
> this happens is NVIDIA Tegra devices that are using downstream bootloader
> which adds "video=tegrafb" to the kernel's cmdline and thus upstream Tegra
> DRM driver fails to probe because of the invalid mode.
>
> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied to drm-misc-next-fixes

Thanks for figuring this out!

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ahmo6bieusk7uhsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXSW6DQAKCRDj7w1vZxhR
xUYsAP9EUafm0rr0sX06bl/cIzBTLvcr/5GalKzSZToTJ2kjlwD/aGukUMgjynHS
9tpGZZ5GnYj8IbRYJWM5g6SBjjc6MA4=
=8k/L
-----END PGP SIGNATURE-----

--ahmo6bieusk7uhsj--
