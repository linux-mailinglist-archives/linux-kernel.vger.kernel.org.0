Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C526E1438ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAUJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:04:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgAUJEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:04:02 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B318217F4;
        Tue, 21 Jan 2020 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597441;
        bh=0H0bh1Jo/UYT268NBP9XJ/xrV/lNAdl64vvZCHXIpWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1KWMsrnqW/cswbFn9+0WcD81L2LSztxIrowKZN9mQBc0XgGK/rtvvFp/2lwyIlSAF
         RakyBoq4cYNF1jTtQNoy90XRMpcpVgIkQc48g4BTNIAHVWjeSYFi+OM+SCpD+XZlSJ
         W4vL7hdPmGsfFRhiU9tX/JPKW9JPfX/Tg/ztA340=
Date:   Tue, 21 Jan 2020 10:03:58 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/9] arm64: dts: allwinner: Enable button wakeup on
 Orange Pi PC2
Message-ID: <20200121090358.6mbrbhabtg6gkhpx@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c7ftjrc3bbfqytxr"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7ftjrc3bbfqytxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:30:56AM -0600, Samuel Holland wrote:
> The Orange Pi PC2 features a GPIO button. As the button is connected to
> Port L (pin PL3), it can be used as a wakeup source. Enable this.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--c7ftjrc3bbfqytxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia+fgAKCRDj7w1vZxhR
xRkVAP943gYCXiKg93jTbLbHeiSAWTJCK7Vv7DiW+3NyES0zmQD+OHcexubzHhjo
SLUbywQHwdDXWublL3xrFtyl1lb0WAo=
=+s0l
-----END PGP SIGNATURE-----

--c7ftjrc3bbfqytxr--
