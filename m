Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7576E141076
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 19:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgAQSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 13:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQSMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:12:23 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE02220748;
        Fri, 17 Jan 2020 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579284743;
        bh=IdyrMy2nrlmfkVGDIpnIS4HjWOBUiobj0MXhdDTQd80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qn8SJYF+AS+5NobYCLPOms9TMfbOAaRLKRT/vF9O3TGrTA/TSz2xio4FkapxEPz75
         ddlusE4o2/5Y5ESlOgi6OjeXsjycbBuHKF0v1wIePlD9F9K4cLQ30MncZqSa7pMBI2
         naGnJwDelSv6i33seCm+qy64/LRjP4yCKeXIGxo0=
Date:   Fri, 17 Jan 2020 19:12:20 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: a83t: Fix incorrect clk and reset
 macros for EMAC device
Message-ID: <20200117181220.biryjou5zvqfxdnt@gilmour.lan>
References: <20200114094252.8908-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bzobas6k7fsnitoh"
Content-Disposition: inline
In-Reply-To: <20200114094252.8908-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bzobas6k7fsnitoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2020 at 05:42:52PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> When the raw numbers used for clk and reset indices in the EMAC device
> node were converted to the new macros, the order of the clk and reset
> properties was overlooked, and thus the incorrect macros were used.
> This results in the EMAC being non-responsive, as well as an oops due
> to incorrect usage of the reset control.
>
> Correct the macro types, and also reorder the clk and reset properties
> to match all the other device nodes.
>
> Fixes: 765866edb16a ("ARM: dts: sunxi: Use macros for references to CCU clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Queued as a fix for 5.6, thanks!
Maxime

--bzobas6k7fsnitoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiH5BAAKCRDj7w1vZxhR
xaaXAQDsG2aEO1qdNIVRhFZfwLaBsqA68VlRWQyNaM9q4IclmgEApgHG16xb1DWI
RSmavsHC0ZQmsOTVpBI4SiaME4t3qw0=
=cMS9
-----END PGP SIGNATURE-----

--bzobas6k7fsnitoh--
