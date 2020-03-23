Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9220918F8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 16:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCWPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 11:51:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44607 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCWPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:51:15 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jGPM3-0004GB-Ny; Mon, 23 Mar 2020 16:51:07 +0100
Message-ID: <d39209a3664179f895a7dfabbd02d27a6adb9895.camel@pengutronix.de>
Subject: Re: [PATCH] drm/mxsfb: Make supported modifiers explicit
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Mar 2020 16:51:05 +0100
In-Reply-To: <26877532e272c12a74c33188e2a72abafc9a2e1c.1584973664.git.agx@sigxcpu.org>
References: <26877532e272c12a74c33188e2a72abafc9a2e1c.1584973664.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 23.03.2020, 15:52 +0100 schrieb Guido Günther:
> In contrast to other display controllers on imx like DCSS and ipuv3
> lcdif/mxsfb does not support detiling e.g. vivante tiled layouts.
> Since mesa might assume otherwise make it explicit that only
> DRM_FORMAT_MOD_LINEAR is supported.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 762379530928..fc71e7a7a02e 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -73,6 +73,11 @@ static const uint32_t mxsfb_formats[] = {
>  	DRM_FORMAT_RGB565
>  };
>  
> +static const uint64_t mxsfb_modifiers[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
>  static struct mxsfb_drm_private *
>  drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
>  {
> @@ -334,8 +339,8 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
>  	}
>  
>  	ret = drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
> -			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
> -			mxsfb->connector);
> +			mxsfb_formats, ARRAY_SIZE(mxsfb_formats),
> +			mxsfb_modifiers, mxsfb->connector);
>  	if (ret < 0) {
>  		dev_err(drm->dev, "Cannot setup simple display pipe\n");
>  		goto err_vblank;

