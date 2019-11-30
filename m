Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128AE10DE96
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 19:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfK3She (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 13:37:34 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38546 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3Shd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 13:37:33 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7FBE880563;
        Sat, 30 Nov 2019 19:37:30 +0100 (CET)
Date:   Sat, 30 Nov 2019 19:37:29 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel: simple: Add support for the Frida
 FRD350H54004 panel
Message-ID: <20191130183729.GD24722@ravnborg.org>
References: <20191120171027.1102250-1-paul@crapouillou.net>
 <20191120171027.1102250-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120171027.1102250-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=4eiu5t_5MPiKWv0nutYA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

I am not sure if I already wrote this...

On Wed, Nov 20, 2019 at 06:10:27PM +0100, Paul Cercueil wrote:
> The FRD350H54004 is a simple 3.5" 320x240 24-bit TFT panel, found for
> instance inside the Anbernic RG-350 handheld gaming console.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 28fa6ba7b767..8c03f7fe461c 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1378,6 +1378,32 @@ static const struct panel_desc evervision_vgg804821 = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
>  };
>  
> +static const struct drm_display_mode frida_frd350h54004_mode = {
> +	.clock = 6777,
> +	.hdisplay = 320,
> +	.hsync_start = 320 + 70,
> +	.hsync_end = 320 + 70 + 50,
> +	.htotal = 320 + 70 + 50 + 10,
> +	.vdisplay = 240,
> +	.vsync_start = 240 + 5,
> +	.vsync_end = 240 + 5 + 1,
> +	.vtotal = 240 + 5 + 1 + 5,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +};
> +
> +static const struct panel_desc frida_frd350h54004 = {
> +	.modes = &frida_frd350h54004_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 77,
> +		.height = 64,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
> +};
> +
>  static const struct drm_display_mode foxlink_fl500wvr00_a0t_mode = {
>  	.clock = 32260,
>  	.hdisplay = 800,

In alphabetic order. frida comes after foxlink.

> @@ -3186,6 +3212,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "evervision,vgg804821",
>  		.data = &evervision_vgg804821,
> +	}, {
> +		.compatible = "frida,frd350h54004",
> +		.data = &frida_frd350h54004,
>  	}, {
>  		.compatible = "foxlink,fl500wvr00-a0t",
>  		.data = &foxlink_fl500wvr00_a0t,
In alphabetic order. frida comes after foxlink.

	Sam
