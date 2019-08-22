Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39C98B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 08:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfHVGRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 02:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfHVGRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:17:21 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765A92082F;
        Thu, 22 Aug 2019 06:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566454641;
        bh=QWkVZTnE7TpfYPs/BbkIMDM7h34eTIN/1qjE1rfxHwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcfzdWD0XF0SvN09G3WsSZHnoDTZ83QxE8ZR1f16L256nUV/JVvpNPaiyzA+8OCtk
         c3zlzAvy7VGv7iaCj4ulKymKVJbvIbmf717l/WcghKB6uQeggpSclZyaOUf80zD9hs
         HAWzVixeMrx0mJ2IEtaZKFcHSAvnKY+pbEpx/VC8=
Date:   Thu, 22 Aug 2019 08:17:17 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH] ASoC: sun4i-i2s: incorrect regmap for A83t
Message-ID: <20190822061717.yjvnnr326psa4r4c@flea>
References: <20190821162320.28653-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5ufzyzs2ggwjbupx"
Content-Disposition: inline
In-Reply-To: <20190821162320.28653-1-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ufzyzs2ggwjbupx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Markus,

On Wed, Aug 21, 2019 at 06:23:20PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

The patch is ok, but you should have a commit log here.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5ufzyzs2ggwjbupx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV4zbQAKCRDj7w1vZxhR
xfPfAP4zvSBPA7HpdlMc4iMU5KhOSpimaoOr1DymhZ0Xnazn6AD/aHTHKG9yy3Ej
6/fLGUWkpxamiWdf2Mz7J6d0XQjJuww=
=CDu6
-----END PGP SIGNATURE-----

--5ufzyzs2ggwjbupx--
