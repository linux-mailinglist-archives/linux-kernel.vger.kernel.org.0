Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0236C9E97D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 15:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfH0Ner (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 09:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfH0Ner (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:34:47 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FD420828;
        Tue, 27 Aug 2019 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566912886;
        bh=JUTyWwX2ET5pcAqmDZd9yiuKVN2SmCNm8sEP12RzMMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8ZvR5DOjP38DXOaIx0j7myXAl5RgAQIqWTAFcW9XrI6yxAULG4QtZbJ00ES1PtER
         0IuAUFyISZy/h9ClfTor1novhWyk4vkJPnoMSOET1v3C+MutUZDXG8jrEcjoUM4EX5
         QdPdAZBYQ45xuf4Ibd0L1LDj/JdnCbt+yZMwUXI4=
Date:   Tue, 27 Aug 2019 15:34:43 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: pine64-plus: Add PHY
 regulator delay
Message-ID: <20190827133443.fdxl5wjmgkerc3uh@flea>
References: <20190825130336.14154-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hjrahydg6q3alewh"
Content-Disposition: inline
In-Reply-To: <20190825130336.14154-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hjrahydg6q3alewh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 25, 2019 at 03:03:36PM +0200, Jernej Skrabec wrote:
> Depending on kernel and bootloader configuration, it's possible that
> Realtek ethernet PHY isn't powered on properly. It needs some time
> before it can be used.
>
> Fix that by adding 100ms ramp delay to regulator responsible for
> powering PHY.
>
> Fixes: 94dcfdc77fc5 ("arm64: allwinner: pine64-plus: Enable dwmac-sun8i")
> Suggested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

How was that delay found?

It should at least have a comment explaining why it's there.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hjrahydg6q3alewh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWUxcwAKCRDj7w1vZxhR
xQcDAP9PcjmKcemio5RyGsvXfmaqZINOqCwOKsTiONK54RVLbQEAgaFOmHxFyHfJ
oQcsq82EY17PkSDieqvgY9JWjjbwrgo=
=kJyJ
-----END PGP SIGNATURE-----

--hjrahydg6q3alewh--
