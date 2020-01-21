Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C209E14391C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAUJIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbgAUJIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:08:00 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06BAD20882;
        Tue, 21 Jan 2020 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597679;
        bh=bgtnhmiV1JtWs2a+bSPsKzSbUBFjzhxvFmeI/dg9mF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWRBXJArnV7LihpPa2j0CoOBerWiwDml+skQ+vQ6BQSDzol3mUkdGIzTQfgC1P66G
         VeKEcX3kknNxYsqbeHh4X7cKTXasfBEPkzfPvHVefqpHUHzzeZnVmU+jNQLjR2py8k
         XhXqBKbJnzi+a2hqKkyF0Ft6Plz3bfr9mjZMFiTI=
Date:   Tue, 21 Jan 2020 10:07:57 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 8/9] arm64: dts: allwinner: pinebook: Fix backlight
 regulator
Message-ID: <20200121090757.y4du3fg2jdwz6itc@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lqx7ih2sgpkglldi"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-8-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lqx7ih2sgpkglldi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:31:03AM -0600, Samuel Holland wrote:
> The output from the backlight regulator is labeled as "VBKLT" in the
> schematic. Using the equation and resistor values from the schematic,
> the output is approximately 18V, not 3.3V. Since the regulator in use
> (SS6640STR) is a boost regulator powered by PS (battery or AC input),
> which are both >3.3V, the output could not be 3.3V anyway.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--lqx7ih2sgpkglldi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia/bQAKCRDj7w1vZxhR
xZCRAQD4o2+VihgD9ezDkitpsVkWEhvTpmqISioxCFC8JHhG2wEAi2Vm6h91eY4r
Ic1x8Kqc1qdxiURvYFFfOv/51z5z/gU=
=XXUo
-----END PGP SIGNATURE-----

--lqx7ih2sgpkglldi--
