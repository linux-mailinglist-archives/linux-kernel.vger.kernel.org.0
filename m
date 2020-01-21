Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C94143912
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgAUJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:06:53 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D9820882;
        Tue, 21 Jan 2020 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597612;
        bh=uOFeO8+xSkz1g/WoZXXNCEctOGa57Vko3qDcP4KDO4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loe08d5GCQ4lGBv64K/gROUsh2slCFB19gmnXpLOgSysG42o9E9acH5vIPxpYxDgN
         j6gV3CfV0KOCxwwiLCCNY6A8ucsMNVVX1kahG04PxLJFbvPxMDogAXiy+sTI7T9qEK
         tOuQSvRyRSVKZ68vTRI37XgY+QzekyV0sVOwd8AM=
Date:   Tue, 21 Jan 2020 10:06:50 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 6/9] arm64: dts: allwinner: pinebook: Document MMC0 CD
 pin name
Message-ID: <20200121090650.2cgf7y2bs6twup27@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f2ox7e6bc4u3a3iv"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-6-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f2ox7e6bc4u3a3iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:31:01AM -0600, Samuel Holland wrote:
> Normally GPIO pin references are followed by a comment giving the pin
> name for searchability. Add the comment here where it was missing.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--f2ox7e6bc4u3a3iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia/KgAKCRDj7w1vZxhR
xSHtAQD/Npxdkdc8Lip7lWDOEFQHZajpQGieBk3AWwrJVG47uAD9H/dQmjoKqsKM
+y3GQk+vPuFZuAxxSgSDoxLfUyk6fAg=
=3emx
-----END PGP SIGNATURE-----

--f2ox7e6bc4u3a3iv--
