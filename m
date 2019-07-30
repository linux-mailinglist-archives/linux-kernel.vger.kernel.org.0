Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD079E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 04:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfG3CAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 22:00:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56974 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfG3CAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:00:07 -0400
Received: from pendragon.ideasonboard.com (om126208166005.22.openmobile.ne.jp [126.208.166.5])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57C35CC;
        Tue, 30 Jul 2019 04:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564452005;
        bh=M4bJxfcsKMIIHE5Z4bopQDCvjHsPpiVRe3VEDLR/A2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMXsPAzDQPTmgpHu4jx+FY099DDEXG2uaehfrjfh5gy4UKrd7wpVpxgIKXC2XqRL8
         1C7G4QKutM7taDTw7dRQFr51P5ZG0z6ZsQ9e3fATdBFAa3JwyvpJKK/s5vikoXDp4j
         Txn+dSWgNYET20yh2IxK7bpqahJHJdRGsTK8iZrI=
Date:   Tue, 30 Jul 2019 04:59:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: tc358764: Fix build error
Message-ID: <20190730015954.GA4852@pendragon.ideasonboard.com>
References: <20190729090520.25968-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729090520.25968-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Thank you for the patch.

On Mon, Jul 29, 2019 at 05:05:20PM +0800, YueHaibing wrote:
> If CONFIG_DRM_TOSHIBA_TC358764=y but CONFIG_DRM_KMS_HELPER=m,
> building fails:
> 
> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x228): undefined reference to `drm_atomic_helper_connector_reset'
> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x240): undefined reference to `drm_helper_probe_single_connector_modes'
> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x268): undefined reference to `drm_atomic_helper_connector_duplicate_state'
> drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x270): undefined reference to `drm_atomic_helper_connector_destroy_state'
> 
> Like TC358767, select DRM_KMS_HELPER to fix this, and
> change to select DRM_PANEL to avoid recursive dependency.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: f38b7cca6d0e ("drm/bridge: tc358764: Add DSI to LVDS bridge driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index a6eec90..323f72d 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -116,9 +116,10 @@ config DRM_THINE_THC63LVD1024
>  
>  config DRM_TOSHIBA_TC358764
>  	tristate "TC358764 DSI/LVDS bridge"
> -	depends on DRM && DRM_PANEL
>  	depends on OF
>  	select DRM_MIPI_DSI
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL
>  	help
>  	  Toshiba TC358764 DSI/LVDS bridge driver.
>  

-- 
Regards,

Laurent Pinchart
