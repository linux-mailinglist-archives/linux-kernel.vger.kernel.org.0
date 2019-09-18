Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C04B665D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfIROq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 10:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfIROq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:46:26 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 956C920665;
        Wed, 18 Sep 2019 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568817986;
        bh=sh1/pWZQhmLEdoTgy9qc8FXTS1/RZaYcRnv+3EKj65E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLwZ/6VIpFCY9nmCA/pyN0QOt0xG9M/wyRbUo2JejYMhSu66brQVBmIP8uqq8zLId
         m/S/imTVnNLYNb2unr1BoQwtKGdVyqTtOIlmQNM/KzvSs8iSdvtoWP5eDlZ5WnFaw4
         4rlc9Dwz41fHMSDoK2WE021TSBxPVvCmIq6ooAb0=
Date:   Wed, 18 Sep 2019 16:46:23 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: a64: pine64-plus: Add PHY
 regulator delay
Message-ID: <20190918144623.tkwrhykb3sxqbr6d@gilmour>
References: <20190909184235.13196-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="td5nie2iuibay3rv"
Content-Disposition: inline
In-Reply-To: <20190909184235.13196-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--td5nie2iuibay3rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2019 at 08:42:35PM +0200, Jernej Skrabec wrote:
> Depending on kernel and bootloader configuration, it's possible that
> Realtek ethernet PHY isn't powered on properly. According to the
> datasheet, it needs 30ms to power up and then some more time before it
> can be used.
>
> Fix that by adding 100ms ramp delay to regulator responsible for
> powering PHY.
>
> Fixes: 94dcfdc77fc5 ("arm64: allwinner: pine64-plus: Enable dwmac-sun8i")
> Suggested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued as a fix for 5.4, thanks!
Maxime

--td5nie2iuibay3rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYJDPwAKCRDj7w1vZxhR
xdK4AP0RZ4CscsTpkYmuYSXG3hH/C10hoz66XEjSw3F/uixspAD+O2C20oxlnZhd
xnwehkcetGTGELnGwpmVspE3HGCD+gA=
=CDeL
-----END PGP SIGNATURE-----

--td5nie2iuibay3rv--
