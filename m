Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771FBC4782
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 08:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfJBGGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 02:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfJBGG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 02:06:29 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D285A215EA;
        Wed,  2 Oct 2019 06:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569996389;
        bh=mrR8xebiuz9rTlfAOEfd7Sbt87fGTQ7Pn9IgS0HFSyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFv7h78FZn9gJtdttxlXUBjMRibrhHSjJTUoCcx5i5lnY6MujyHv60z8JWd2Ipyge
         LtDT7l64DdHrmIJIBMjbDrEodTxOgzKERcvSRicmE0PdFlNVlHxbvpW0/P0e2hBSwM
         iXBac1sHKS53V4ln39KE9rT2lkVn7dugShF1I43Q=
Date:   Wed, 2 Oct 2019 08:06:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: h6: Allow GPU to change parent rate
Message-ID: <20191002060626.kd37juvhu3jlbxrp@gilmour>
References: <20191001200656.730198-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="koys76tdgwpzy4oy"
Content-Disposition: inline
In-Reply-To: <20191001200656.730198-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--koys76tdgwpzy4oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Oct 01, 2019 at 10:06:56PM +0200, Jernej Skrabec wrote:
> GPU PLL was designed with dynamic frequency switching in mind so driver
> can adjust rate based on the GPU load.
>
> Allow GPU clock to change parent rate (GPU PLL is the only possible
> parent of GPU clock).
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> index d89353a3cdec..e254c06c8621 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -290,7 +290,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
>  				       0, 3,	/* M */
>  				       24, 1,	/* mux */
>  				       BIT(31),	/* gate */
> -				       0);
> +				       CLK_SET_RATE_PARENT);
>
>  static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
>  		      0x67c, BIT(0), 0);

Applied, thanks!
Maxime

--koys76tdgwpzy4oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZQ+YgAKCRDj7w1vZxhR
xWXAAQCx7lXrCQV8wI7Ez5oXy+i4MIWGIqE/gik3AIuhe8Yy6gEAjojC/6WxQno2
IjkWiZ4VGFrkyIK8BuYE1IuDsPHSpQ8=
=k/gb
-----END PGP SIGNATURE-----

--koys76tdgwpzy4oy--
