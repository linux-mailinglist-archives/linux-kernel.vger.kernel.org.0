Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44C143918
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAUJHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgAUJHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:07:30 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23C720882;
        Tue, 21 Jan 2020 09:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597650;
        bh=2qwj5/J/r5ZVIvYolpNA+jAlvm+KWqLfUb8A7e1VOYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sexNha7w7lt7e5WPJkatQYHA6alGDbfRSNh81Ba9K5ciP6IJHcWZAB5QThYDxzmFu
         0CSWcUaSOorWPtBdUIFwjD+lB5NcF6slFZn2GYFYuCBskIqbgVTfyhyDjOiYTadr7O
         VO33cwGf9r65jw7CF1EyehzX1K/kril9vOQy2mNo=
Date:   Tue, 21 Jan 2020 10:07:28 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 7/9] arm64: dts: allwinner: pinebook: Add GPIO port
 regulators
Message-ID: <20200121090728.bqf5kirl7oaumtyr@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-7-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ymv7yl4clepyn5em"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-7-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ymv7yl4clepyn5em
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:31:02AM -0600, Samuel Holland wrote:
> Allwinner A64 SoC has separate supplies for PC, PD, PE, PG and PL.
>
> VCC-PC and VCC-PG are supplied by ELDO1 at 1.8v.
> VCC-PD is supplied by DCDC1 (VCC-IO) at 3.3v.
> VCC-PE is supplied by ALDO1, and is unused.
>
> VCC-PL creates a circular dependency, so it is omitted for now.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--ymv7yl4clepyn5em
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia/TwAKCRDj7w1vZxhR
xemtAQD2HAgHft1XZ1CTcBisdm4o8+6dwqGs8VYdxgxkbGcfmQEAt+S15a+XDFB8
/DeRW5zpu5B+jCMVI5EswXXR+nl5XAw=
=axfZ
-----END PGP SIGNATURE-----

--ymv7yl4clepyn5em--
