Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B267CCE10F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfJGL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfJGL7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:59:44 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B148D206C0;
        Mon,  7 Oct 2019 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570449584;
        bh=5jiwPkl3ecC5PC4thXvIU8gFWAfwR8hG/EemIoCj5g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=00DN5m1u+OpR2j7HvOfVHqIseRTMp9+SH7IzGzNwUnxPEVT1j+E0xUjCc5l7eTm7x
         Gx7frdd95PSPb2j45D5gFNFQqa77rhHn7lLb+ZDGyQExfG7w0YS/+y41odBO4dEx2l
         GW59SWBe2FL9LX3l+322/QB8nvCEiuq5VgO6q9bM=
Date:   Mon, 7 Oct 2019 13:59:41 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/3] drm/sun4i: dsi: fix the overhead of the
 horizontal front porch
Message-ID: <20191007115941.psgcn4dl5r5wz7eb@gilmour>
References: <20191006160303.24413-1-icenowy@aosc.io>
 <20191006160303.24413-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vfde45ofwoem3io"
Content-Disposition: inline
In-Reply-To: <20191006160303.24413-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vfde45ofwoem3io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2019 at 12:03:01AM +0800, Icenowy Zheng wrote:
> The formula in the BSP kernel indicates that a 16-byte overhead is used
> when sending the HFP. However, this value is currently set to 6 in the
> sun6i_mipi_dsi driver, which makes some panels flashing.
>
> Fix this overhead value.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks

Maxime

--5vfde45ofwoem3io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZsorQAKCRDj7w1vZxhR
xcP8AP47n6BFMYH1VcgTqWrgGo5/vrIabj3UlEvNbcGcQXgpgQD9GkwZ/EbXI2Dp
TngzLKib/Ovm7hiqxQLsL6DKkKWGGw0=
=25Nh
-----END PGP SIGNATURE-----

--5vfde45ofwoem3io--
