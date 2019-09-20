Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A568B8EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408729AbfITKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 06:49:57 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:47188 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbfITKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:49:57 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72D552F9;
        Fri, 20 Sep 2019 12:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1568976594;
        bh=ZRLNhELSrDVvsDc4wQX1GyKih6qSucdVjUH7bhYjr2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZ1oZtxip2xEUaGXJHKulGPwe9CiLcIihnUHmncJegyk6F4KjIXz8QXZKKTwOvur0
         8xOu/qptSg+o4KYk51i4RsddVMbi6XM4DDbtnPVhbc57o+pwaoPezc+qW3L3ElCz4Q
         KuQ2pcPkIU6344FseREsGVsYplabua+DrHSc8+bQ=
Date:   Fri, 20 Sep 2019 13:49:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com
Subject: Re: [PATCH v2] drm/bridge: analogix-anx78xx: add support for 7808
 addresses
Message-ID: <20190920104945.GC12950@pendragon.ideasonboard.com>
References: <20190920101438.6912-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920101438.6912-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Thank you for the patch.

On Fri, Sep 20, 2019 at 06:14:38AM -0400, Brian Masney wrote:
> According to the downstream Android sources, the anx7808 variants use
> address 0x78 for TX_P0 and the anx781x variants use address 0x70. Since
> the datasheets aren't available for these devices, and we only have the
> downstream kernel sources to look at, let's assume that these addresses
> are fixed based on the model, and pass the i2c addresses to the data
> pointer in the driver's of_match_table.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> V1 of this patch with some discussion:
> https://lore.kernel.org/lkml/20190815004854.19860-6-masneyb@onstation.org/
> 
>  drivers/gpu/drm/bridge/analogix-anx78xx.c | 36 +++++++++++++++--------
>  drivers/gpu/drm/bridge/analogix-anx78xx.h |  7 -----
>  2 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> index 48adf010816c..e25fae36dbe1 100644
> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> @@ -38,12 +38,20 @@
>  #define AUX_CH_BUFFER_SIZE	16
>  #define AUX_WAIT_TIMEOUT_MS	15
>  
> -static const u8 anx78xx_i2c_addresses[] = {
> -	[I2C_IDX_TX_P0] = TX_P0,
> -	[I2C_IDX_TX_P1] = TX_P1,
> -	[I2C_IDX_TX_P2] = TX_P2,
> -	[I2C_IDX_RX_P0] = RX_P0,
> -	[I2C_IDX_RX_P1] = RX_P1,
> +static const u8 anx7808_i2c_addresses[] = {
> +	[I2C_IDX_TX_P0] = 0x78,
> +	[I2C_IDX_TX_P1] = 0x7a,
> +	[I2C_IDX_TX_P2] = 0x72,
> +	[I2C_IDX_RX_P0] = 0x7e,
> +	[I2C_IDX_RX_P1] = 0x80,
> +};
> +
> +static const u8 anx781x_i2c_addresses[] = {
> +	[I2C_IDX_TX_P0] = 0x70,
> +	[I2C_IDX_TX_P1] = 0x7a,
> +	[I2C_IDX_TX_P2] = 0x72,
> +	[I2C_IDX_RX_P0] = 0x7e,
> +	[I2C_IDX_RX_P1] = 0x80,
>  };

If those addresses are really fixed they should have been added to DT,
in order for all fixed I2C addresses used on an I2C bus to be reported
in DT. I guess it's too late now :-/ This seems to be the best we can do
to solve the problem with existing DT. Updating the bindings could
however still be a good idea to make this clear moving forward.

>  struct anx78xx_platform_data {
> @@ -1348,6 +1356,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  	struct anx78xx *anx78xx;
>  	struct anx78xx_platform_data *pdata;
>  	unsigned int i, idl, idh, version;
> +	const u8 *i2c_addresses;
>  	bool found = false;
>  	int err;
>  
> @@ -1387,15 +1396,16 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  	}
>  
>  	/* Map slave addresses of ANX7814 */
> +	i2c_addresses = device_get_match_data(&client->dev);
>  	for (i = 0; i < I2C_NUM_ADDRESSES; i++) {
>  		struct i2c_client *i2c_dummy;
>  
>  		i2c_dummy = i2c_new_dummy_device(client->adapter,
> -						 anx78xx_i2c_addresses[i] >> 1);
> +						 i2c_addresses[i] >> 1);
>  		if (IS_ERR(i2c_dummy)) {
>  			err = PTR_ERR(i2c_dummy);
>  			DRM_ERROR("Failed to reserve I2C bus %02x: %d\n",
> -				  anx78xx_i2c_addresses[i], err);
> +				  i2c_addresses[i], err);
>  			goto err_unregister_i2c;
>  		}
>  
> @@ -1405,7 +1415,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  		if (IS_ERR(anx78xx->map[i])) {
>  			err = PTR_ERR(anx78xx->map[i]);
>  			DRM_ERROR("Failed regmap initialization %02x\n",
> -				  anx78xx_i2c_addresses[i]);
> +				  i2c_addresses[i]);
>  			goto err_unregister_i2c;
>  		}
>  	}
> @@ -1504,10 +1514,10 @@ MODULE_DEVICE_TABLE(i2c, anx78xx_id);
>  
>  #if IS_ENABLED(CONFIG_OF)
>  static const struct of_device_id anx78xx_match_table[] = {
> -	{ .compatible = "analogix,anx7808", },
> -	{ .compatible = "analogix,anx7812", },
> -	{ .compatible = "analogix,anx7814", },
> -	{ .compatible = "analogix,anx7818", },
> +	{ .compatible = "analogix,anx7808", .data = anx7808_i2c_addresses },
> +	{ .compatible = "analogix,anx7812", .data = anx781x_i2c_addresses },
> +	{ .compatible = "analogix,anx7814", .data = anx781x_i2c_addresses },
> +	{ .compatible = "analogix,anx7818", .data = anx781x_i2c_addresses },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, anx78xx_match_table);
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix-anx78xx.h
> index 25e063bcecbc..8697647709f7 100644
> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.h
> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.h
> @@ -6,13 +6,6 @@
>  #ifndef __ANX78xx_H
>  #define __ANX78xx_H
>  
> -#define TX_P0				0x70
> -#define TX_P1				0x7a
> -#define TX_P2				0x72
> -
> -#define RX_P0				0x7e
> -#define RX_P1				0x80
> -
>  /***************************************************************/
>  /* Register definition of device address 0x7e                  */
>  /***************************************************************/

Should you also rename the headers to mention [RT]X P[012] instead of
the numerical addresses ?

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
