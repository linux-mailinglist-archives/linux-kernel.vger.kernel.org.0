Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC31D9DE52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfH0HBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 03:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfH0HBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:01:05 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88C1206BF;
        Tue, 27 Aug 2019 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566889264;
        bh=Biq9mF8dTT+XjGplKumTdtUTNHz0ImKVfvD7CkyAwj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgQhsTQ0uGStkRN08ze0pp7gYCNZAgjNr980p+jcVF5VXiEywouzHu1X/QaioYG7h
         pCwT9TmFUF4jd97IjGFMlF+qXHiYfnmwMA/XS1uzU8+t2GJf5VfqFsV2wMcd3tXQ08
         RHKJsMf0efsZ6ws16aWkFS5lZ0ADFggxZxhDxI0I=
Date:   Tue, 27 Aug 2019 09:01:01 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v6 3/3] ASoC: sun4i-i2s: Adjust LRCLK width
Message-ID: <20190827070101.tastgcqvzrgv3kc5@flea>
References: <20190826180734.15801-1-codekipper@gmail.com>
 <20190826180734.15801-4-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aewobl2wvpczcoyt"
Content-Disposition: inline
In-Reply-To: <20190826180734.15801-4-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aewobl2wvpczcoyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 08:07:34PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Some codecs such as i2s based HDMI audio and the Pine64 DAC require
> a different amount of bit clocks per frame than what is calculated
> by the sample width. Use the values obtained by the tdm slot bindings
> to adjust the LRCLK width accordingly.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 056a299c03fb..0965a97c96e5 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -455,7 +455,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>  		break;
>
>  	case SND_SOC_DAIFMT_I2S:
> -		lrck_period = params_physical_width(params);
> +		if (i2s->slot_width)
> +			lrck_period = i2s->slot_width;
> +		else
> +			lrck_period = params_physical_width(params);
>  		break;

That would be the case with the DSP formats too, right?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--aewobl2wvpczcoyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWTVLQAKCRDj7w1vZxhR
xSAlAQCvR8zoBbzxDhfl4BOVHlf7M+d/VwTWUWIndBN6/bMNDAD+KSWSTL9rCbyM
5aTcKxbY8Hi2H/ljbFggOIAykqgEnQI=
=88rE
-----END PGP SIGNATURE-----

--aewobl2wvpczcoyt--
