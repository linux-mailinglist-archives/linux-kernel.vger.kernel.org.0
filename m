Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E04130EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 09:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAFIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 03:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFIxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:53:13 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CF620848;
        Mon,  6 Jan 2020 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300793;
        bh=gGt53+T2QpuKFFig2c67HzTNBOHPtf+uVFA+hg/Q4lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNWq+JMn6qkB8nOciEMFpcK41iSy9C7xD6JjWbxszWRW22tRWFyaaS3msGnclalTk
         KQv3uRZ9+neBQab31ecZXXbR+ZSlO8USA4crcl1YhD2Z17v5c+/WIEC8HPO7Ul1LSw
         VLsUxlJkPz4ra3Nfugs/7c+U+7i3LyJr0dRfuBDs=
Date:   Mon, 6 Jan 2020 09:53:11 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: pinebook: Fix lid wakeup
Message-ID: <20200106085311.nurmbdwr3bjdwlaz@gilmour.lan>
References: <20200105021137.46542-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljcm7vm7yuabjva4"
Content-Disposition: inline
In-Reply-To: <20200105021137.46542-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljcm7vm7yuabjva4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 04, 2020 at 08:11:37PM -0600, Samuel Holland wrote:
> By default, gpio-keys configures the pin to trigger wakeup IRQs on
> either edge. The lid switch should only trigger wakeup when opening the
> lid, not when closing it.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--ljcm7vm7yuabjva4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhL1dwAKCRDj7w1vZxhR
xT0HAQDrkJZI1CqZH3uwLnrFRjLzqsehNHgv8hEsBxg3719iyAEA9xfbbnHMmQk8
yCmfp3X3hgPbmZoRy11TXA4XmytyswE=
=nVEf
-----END PGP SIGNATURE-----

--ljcm7vm7yuabjva4--
