Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16A5130FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 11:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAFKD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 05:03:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42809 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:03:57 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ioPEp-00016j-2P; Mon, 06 Jan 2020 11:03:55 +0100
Message-ID: <5cd1dc11df43d86d9db0dc2520de9b2e839ea7cc.camel@pengutronix.de>
Subject: Re: [PATCH 2/6] drm/etnaviv: determine product, customer and eco id
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Mon, 06 Jan 2020 11:03:52 +0100
In-Reply-To: <20200102100230.420009-3-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
         <20200102100230.420009-3-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> They will be used for extended HWDB support. The eco id logic was taken
> from galcore kernel driver sources.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 17 +++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  6 +++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index d47d1a8e0219..253301be9e95 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -321,6 +321,18 @@ static void etnaviv_hw_specs(struct etnaviv_gpu *gpu)
>  		gpu->identity.varyings_count -= 1;
>  }
>  
> +static void etnaviv_hw_eco_id(struct etnaviv_gpu *gpu)
> +{
> +	const u32 chipDate = gpu_read(gpu, VIVS_HI_CHIP_DATE);
> +	gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
> +
> +	if (etnaviv_is_model_rev(gpu, GC1000, 0x5037) && (chipDate == 0x20120617))
> +		gpu->identity.eco_id = 1;
> +
> +	if (etnaviv_is_model_rev(gpu, GC320, 0x5303) && (chipDate == 0x20140511))
> +		gpu->identity.eco_id = 1;

I'm not sure if those two checks warrant a separate function. Maybe
just place them besides the other ID fixups?

> +}
> +
>  static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
>  {
>  	u32 chipIdentity;
> @@ -362,6 +374,8 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
>  			}
>  		}
>  
> +		gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
> +
>  		/*
>  		 * NXP likes to call the GPU on the i.MX6QP GC2000+, but in
>  		 * reality it's just a re-branded GC3000. We can identify this
> @@ -375,6 +389,9 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
>  		}
>  	}
>  
> +	etnaviv_hw_eco_id(gpu);
> +	gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);

I don't like this scattering of identity register reads. Please move
all of those reads to the else clause where we currently read
model/rev. I doubt that the customer ID register is available on the
really early cores, that only have the VIVS_HI_CHIP_IDENTITY register.

Regards,
Lucas

>  	dev_info(gpu->dev, "model: GC%x, revision: %x\n",
>  		 gpu->identity.model, gpu->identity.revision);
>  
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> index 8f9bd4edc96a..68bd966e3916 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -15,11 +15,11 @@ struct etnaviv_gem_submit;
>  struct etnaviv_vram_mapping;
>  
>  struct etnaviv_chip_identity {
> -	/* Chip model. */
>  	u32 model;
> -
> -	/* Revision value.*/
>  	u32 revision;
> +	u32 product_id;
> +	u32 customer_id;
> +	u32 eco_id;
>  
>  	/* Supported feature fields. */
>  	u32 features;

