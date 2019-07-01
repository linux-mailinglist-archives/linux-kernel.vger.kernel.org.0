Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1F581F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF0L51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 07:57:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42196 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF0L51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:57:27 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5711743F;
        Thu, 27 Jun 2019 13:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1561636644;
        bh=+Yw94xXBxTOU5ZeGcgeqs8j4etBdUYK7CTWY3lO0u6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idM4uYcxNxp48HTXmEn77yLKT5kmOl6KqQr6js6t9CO1AqwtMi+nl2XWUPoGY9fIY
         aFHFAaTw2VzNBf5187+GXWOY+RZ7Y6oYILw9Pi6v3KVAlX4zQUIyQ+gBFi6CGr0Us3
         nivTk4VMazT8ksiBxzY7stSV8uFKMe++rWcTWZSw=
Date:   Thu, 27 Jun 2019 14:57:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sjoerd.simons@collabora.co.uk" <sjoerd.simons@collabora.co.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v1] Adjust analogix chip driver location
Message-ID: <20190627115705.GB5021@pendragon.ideasonboard.com>
References: <20190627112939.GA4832@xin-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190627112939.GA4832@xin-VirtualBox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xin Ji,

Thank you for the patch.

On Thu, Jun 27, 2019 at 11:29:47AM +0000, Xin Ji wrote:
> Move analogix chip ANX78XX bridge driver into "analogix" directory.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig                           | 10 ----------
>  drivers/gpu/drm/bridge/Makefile                          |  3 +--
>  drivers/gpu/drm/bridge/analogix/Kconfig                  | 10 ++++++++++
>  drivers/gpu/drm/bridge/analogix/Makefile                 |  2 ++
>  drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c |  0
>  drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h |  0
>  6 files changed, 13 insertions(+), 12 deletions(-)
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (100%)
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h (100%)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index ee77746..862789b 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -16,16 +16,6 @@ config DRM_PANEL_BRIDGE
>  menu "Display Interface Bridges"
>  	depends on DRM && DRM_BRIDGE
>  
> -config DRM_ANALOGIX_ANX78XX
> -	tristate "Analogix ANX78XX bridge"
> -	select DRM_KMS_HELPER
> -	select REGMAP_I2C
> -	---help---
> -	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> -	  designed for portable devices. The ANX78XX transforms
> -	  the HDMI output of an application processor to MyDP
> -	  or DisplayPort.
> -
>  config DRM_CDNS_DSI
>  	tristate "Cadence DPI/DSI bridge"
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 4934fcf..02cb4cd 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>  obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
>  obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
> @@ -12,8 +11,8 @@ obj-$(CONFIG_DRM_SII9234) += sii9234.o
>  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
> -obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
>  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
>  obj-y += synopsys/
> +obj-y += analogix/

Could you place that line just above the synopsys/ directory, to have
them alphabetically sorted (this could also be done while applying) ?
Apart from that the patch looks good to me, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> index e930ff9..dfe84f5 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -1,4 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config DRM_ANALOGIX_ANX78XX
> +	tristate "Analogix ANX78XX bridge"
> +	select DRM_KMS_HELPER
> +	select REGMAP_I2C
> +	---help---
> +	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> +	  designed for portable devices. The ANX78XX transforms
> +	  the HDMI output of an application processor to MyDP
> +	  or DisplayPort.
> +
>  config DRM_ANALOGIX_DP
>  	tristate
>  	depends on DRM
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> index fdbf3fd..d4c54ac 100644
> --- a/drivers/gpu/drm/bridge/analogix/Makefile
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
> +
>  analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> similarity index 100%
> rename from drivers/gpu/drm/bridge/analogix-anx78xx.c
> rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
> similarity index 100%
> rename from drivers/gpu/drm/bridge/analogix-anx78xx.h
> rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h

-- 
Regards,

Laurent Pinchart
