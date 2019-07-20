Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D375E6EDE2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 07:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfGTFnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 01:43:00 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:50971 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfGTFnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 01:43:00 -0400
Received: from localhost (91-163-65-175.subs.proxad.net [91.163.65.175])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4F917100005;
        Sat, 20 Jul 2019 05:42:56 +0000 (UTC)
Date:   Sat, 20 Jul 2019 07:42:55 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] drm/sun4i: Add support for color encoding and range
Message-ID: <20190720054255.vyma2lyiu2tohl74@flea>
References: <20190713120346.30349-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bp3a2hzmkf5ifze"
Content-Disposition: inline
In-Reply-To: <20190713120346.30349-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bp3a2hzmkf5ifze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 13, 2019 at 02:03:43PM +0200, Jernej Skrabec wrote:
> In order to correctly convert image between YUV and RGB, you have to
> know color encoding and color range. This patch set adds appropriate
> properties and considers them when choosing CSC conversion matrix for
> DE2 and DE3.
>
> Note that this is only the half of needed changes when using HDMI output.
> DW HDMI bridge driver has to be extended to have a property to select
> limited (TVs) or full (PC monitors) range. But that will be done at a
> later time.
>
> Please take a look.

Sorry for the delay, I applied all three.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4bp3a2hzmkf5ifze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTKp3wAKCRDj7w1vZxhR
xb/MAP0YGFEL32Wso4KP7I+AUWQBVf1s5y0UbrS6kdiCC1q+pwD+IxvTlGoVYE3C
XSeD1QTADsnw4LRHiB1TTiZsmdd3rw4=
=gCkd
-----END PGP SIGNATURE-----

--4bp3a2hzmkf5ifze--
