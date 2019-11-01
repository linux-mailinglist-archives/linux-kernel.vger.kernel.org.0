Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39FEC0AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 10:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKAJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 05:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKAJk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:40:26 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C45721734;
        Fri,  1 Nov 2019 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572601226;
        bh=FGHcwE+KAHKomXUaoUwKYu+vAkGOtW4dwmT/9C9fgpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vp0H3p2HmIWcVodPtCyEKBCLAUp4ExhTOIAZGZ9yfkVruUg5T0QW9xFH207NQSNQz
         Z3SeiIh2bzgkW/895Hd9bCSF94pUME9ti06DXe6MmcfuO0Fg4GXCwhnyPsmYQmjcFK
         Kbr3CspGt+0M4E660ZeVOdSBRuTQtnfh2VnH4Kjw=
Date:   Fri, 1 Nov 2019 10:04:12 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        igor.pecovnik@gmail.com, priit.laes@paf.com, usunov@olimex.com
Subject: Re: [PATCH] ARM: sunxi_defconfig: Enable MICREL_PHY
Message-ID: <20191101090412.4o7ag52vo47p6iz4@hendrix>
References: <20191101075712.3058-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tva27k5kibkpot7t"
Content-Disposition: inline
In-Reply-To: <20191101075712.3058-1-plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tva27k5kibkpot7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 09:57:09AM +0200, Priit Laes wrote:
> Include support for Micrel KSZ9031 PHY driver in sunxi_defconfig,
> which fixes issues of link not coming up at boot time with
> certain link partners.
>
> Micrel KSZ9031 PHY chip is used on Olimex A20-OLinuXino-LIME2
> boards.
>
> The errata fix itself has been implemented in commit
> "3aed3e2a143c96: net: phy: micrel: add Asym Pause workaround"
>
> Signed-off-by: Priit Laes <plaes@plaes.org>

Applied, thanks!
Maxime

--tva27k5kibkpot7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbv1DAAKCRDj7w1vZxhR
xYceAP9uQCFhQnWocEKMbYYXac3F5BtZ8loVj7pqpCdJGm4yWQD/RNry4bXHUW88
RxPVJXtDLH6TSj5Sy0IdqfmXuzw9nw0=
=GDa3
-----END PGP SIGNATURE-----

--tva27k5kibkpot7t--
