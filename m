Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246787AA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfG3NzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 09:55:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33712 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfG3NzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:55:02 -0400
Received: from pendragon.ideasonboard.com (ae138143.dynamic.ppp.asahi-net.or.jp [14.3.138.143])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 353A4CC;
        Tue, 30 Jul 2019 15:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564494900;
        bh=XpIPjfe/F3FQ+H5+8txaijGuPyeYSuXcxTVBGDeoaSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkDRK5OGcQwkOY6aSOLLY9pfaLrd8cqoicWK6CuCSE5NHAox4osG5mZHElhGRr7ln
         wr92dUagk49vEuU8Gxd/KncXEHOJTDXAtFWEg2ugKgpAIuqzBTsvYYaO2sTgb6GeiQ
         6PI0qQB828wC6m6ODIJjj4xKQNLqhzlVzgdecrTk=
Date:   Tue, 30 Jul 2019 16:54:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        eric@anholt.net, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/bridge: lvds-encoder: Fix build error while
 CONFIG_DRM_KMS_HELPER=m
Message-ID: <20190730135455.GB4806@pendragon.ideasonboard.com>
References: <20190729065344.9680-1-yuehaibing@huawei.com>
 <20190729071216.27488-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729071216.27488-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Thank you for the patch.

On Mon, Jul 29, 2019 at 03:12:16PM +0800, YueHaibing wrote:
> If DRM_LVDS_ENCODER=y but CONFIG_DRM_KMS_HELPER=m,
> build fails:
> 
> drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
> lvds-encoder.c:(.text+0x155): undefined reference to `devm_drm_panel_bridge_add'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: dbb58bfd9ae6 ("drm/bridge: Fix lvds-encoder since the panel_bridge rework.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2: remove tc358764 log in commit log, also fix Fixes tag
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index a6eec90..77e4b95 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -48,6 +48,7 @@ config DRM_DUMB_VGA_DAC
>  config DRM_LVDS_ENCODER
>  	tristate "Transparent parallel to LVDS encoder support"
>  	depends on OF
> +	select DRM_KMS_HELPER
>  	select DRM_PANEL_BRIDGE
>  	help
>  	  Support for transparent parallel to LVDS encoders that don't require

-- 
Regards,

Laurent Pinchart
