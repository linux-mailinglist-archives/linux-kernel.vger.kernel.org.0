Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD89E2CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393019AbfJXJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 05:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfJXJNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:13:08 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F91A2166E;
        Thu, 24 Oct 2019 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571908387;
        bh=94SGITL+w13cs21+YWm/2mrBkeLrhfSnXixPWxASHZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7eBgKB/LnonMT8DJUrTUn7M2Re+QL7lE04vQh3IVdmZgI515HPhtzdWbfAT77KMO
         l2C9GMpZ6riIM/3taO6yPSL4Kmzao9gbNPNwx4BxuboVrLGUhnnGJyKc3KckYB/nwE
         u0AXlOCkNvAR4pAEtOfX6eVx3ePI74WKvVbGBJkU=
Date:   Thu, 24 Oct 2019 11:13:04 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Lange <linuxstuff@milaw.biz>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Add IR remote
 mapping
Message-ID: <20191024091304.kx27imohmuzufvtr@gilmour>
References: <20191024054135.3819223-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yoemxlzmfbbaspsf"
Content-Disposition: inline
In-Reply-To: <20191024054135.3819223-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yoemxlzmfbbaspsf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Oct 24, 2019 at 07:41:35AM +0200, Jernej Skrabec wrote:
> Tanix TX6 box comes with a remote. Add a mapping for it.
>
> Suggested-by: Michael Lange <linuxstuff@milaw.biz>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index 7e7cb10e3d96..e9428ad4266e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -81,6 +81,7 @@
>  };
>
>  &r_ir {
> +	linux,rc-map-name = "rc-tanix-tx5max";
>  	status = "okay";
>  };

It doesn't look like it's documented in the binding. Please add it
there as well.

Maxime

--yoemxlzmfbbaspsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbFrIAAKCRDj7w1vZxhR
xSLmAQCrGSV7h6ubrgNIb93gmoTRSxqGtJeh8hrmzYdc3uFNbwD+MBU0i/CRyUNp
RH2WGZE4M2I578Xre1fIqzZ5VlEiaQk=
=Wl18
-----END PGP SIGNATURE-----

--yoemxlzmfbbaspsf--
