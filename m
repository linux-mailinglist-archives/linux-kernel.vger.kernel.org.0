Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07440E82C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 08:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfJ2HvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 03:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2HvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:51:22 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A6320862;
        Tue, 29 Oct 2019 07:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572335481;
        bh=6tlkf+68BBehN6NWoxxSf2mpJUjTFaOogiNKGoJC7bY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qV00x03f338JdvJ8sD/N37vqFpuGbrwN7BQvxXmDTNpn7dHPEk2t3zHB5EAarZMah
         NE93pTwnI5a7XjKftR2rVc8OPq2N3Uu3XkgoZKiTta6Z8OsNHLrUgGz+B7nS2DzKEc
         OYa7bgOM7aEXanYx0H/FiEjifC3Xvy1boi1qvMkM=
Date:   Tue, 29 Oct 2019 08:45:58 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: sun4i: Add support for suspending the display driver
Message-ID: <20191029074558.rarf2avdwg6r365j@hendrix>
References: <20191028214313.3463732-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="etwovadxcnmgzzzn"
Content-Disposition: inline
In-Reply-To: <20191028214313.3463732-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--etwovadxcnmgzzzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Oct 28, 2019 at 10:43:13PM +0100, Ondrej Jirman wrote:
> Shut down the display engine during suspend.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index a5757b11b730..c519d7cfcf43 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -346,6 +346,27 @@ static int sun4i_drv_add_endpoints(struct device *dev,
>  	return count;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sun4i_drv_drm_sys_suspend(struct device *dev)
> +{
> +        struct drm_device *drm = dev_get_drvdata(dev);
> +
> +        return drm_mode_config_helper_suspend(drm);
> +}
> +
> +static int sun4i_drv_drm_sys_resume(struct device *dev)
> +{
> +        struct drm_device *drm = dev_get_drvdata(dev);
> +
> +        return drm_mode_config_helper_resume(drm);
> +}
> +#endif

It looks like you've used spaces instead of tabs to indent. The rest
of the patch is fine though.

Maxime

--etwovadxcnmgzzzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbfuNgAKCRDj7w1vZxhR
xavJAP4yYAzBMFxdoeP+c8qATt84FYIsJ8KJOBusx6+6zRv0swD9ETG+/4EFeHLd
11lcmTIUtbetqxDMq0qB9BUz4ozo0g8=
=T1AE
-----END PGP SIGNATURE-----

--etwovadxcnmgzzzn--
