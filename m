Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D204C3A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfJAQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:09:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43018 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJAQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:09:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A1422260417
Subject: Re: [PATCH v3] drm/bridge: analogix-anx78xx: add support for 7808
 addresses
To:     Brian Masney <masneyb@onstation.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com
Cc:     jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190922175940.5311-1-masneyb@onstation.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f4f6eaca-eea9-d017-7ff8-b6ccab63ee04@collabora.com>
Date:   Tue, 1 Oct 2019 18:09:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190922175940.5311-1-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/9/19 19:59, Brian Masney wrote:
> According to the downstream Android sources, the anx7808 variants use
> address 0x78 for TX_P0 and the anx781x variants use address 0x70. Since
> the datasheets aren't available for these devices, and we only have the
> downstream kernel sources to look at, let's assume that these addresses
> are fixed based on the model, and pass the i2c addresses to the driver
> via the data pointer in the driver's of_match_table.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The patch looks good to me:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
> Changes since v2:
> - Change comments in analogix-anx78xx.h from using the address to the
>   name
> 
>  drivers/gpu/drm/bridge/analogix-anx78xx.c | 36 +++++++++++++++--------
>  drivers/gpu/drm/bridge/analogix-anx78xx.h | 17 ++++-------
>  2 files changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
> index 8daee6b1fa88..dec3f7e66aa0 100644
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
>  
>  struct anx78xx_platform_data {
> @@ -1315,6 +1323,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  	struct anx78xx *anx78xx;
>  	struct anx78xx_platform_data *pdata;
>  	unsigned int i, idl, idh, version;
> +	const u8 *i2c_addresses;
>  	bool found = false;
>  	int err;
>  
> @@ -1354,15 +1363,16 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
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
> @@ -1372,7 +1382,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
>  		if (IS_ERR(anx78xx->map[i])) {
>  			err = PTR_ERR(anx78xx->map[i]);
>  			DRM_ERROR("Failed regmap initialization %02x\n",
> -				  anx78xx_i2c_addresses[i]);
> +				  i2c_addresses[i]);
>  			goto err_unregister_i2c;
>  		}
>  	}
> @@ -1471,10 +1481,10 @@ MODULE_DEVICE_TABLE(i2c, anx78xx_id);
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
> index 25e063bcecbc..55d6c2109740 100644
> --- a/drivers/gpu/drm/bridge/analogix-anx78xx.h
> +++ b/drivers/gpu/drm/bridge/analogix-anx78xx.h
> @@ -6,15 +6,8 @@
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
> -/* Register definition of device address 0x7e                  */
> +/* Register definitions for RX_PO                              */
>  /***************************************************************/
>  
>  /*
> @@ -171,7 +164,7 @@
>  #define SP_VSI_RCVD			BIT(1)
>  
>  /***************************************************************/
> -/* Register definition of device address 0x80                  */
> +/* Register definitions for RX_P1                              */
>  /***************************************************************/
>  
>  /* HDCP BCAPS Shadow Register */
> @@ -217,7 +210,7 @@
>  #define SP_SET_AVMUTE			BIT(0)
>  
>  /***************************************************************/
> -/* Register definition of device address 0x70                  */
> +/* Register definitions for TX_P0                              */
>  /***************************************************************/
>  
>  /* HDCP Status Register */
> @@ -451,7 +444,7 @@
>  #define SP_DP_BUF_DATA0_REG		0xf0
>  
>  /***************************************************************/
> -/* Register definition of device address 0x72                  */
> +/* Register definitions for TX_P2                              */
>  /***************************************************************/
>  
>  /*
> @@ -674,7 +667,7 @@
>  #define SP_INT_CTRL_REG			0xff
>  
>  /***************************************************************/
> -/* Register definition of device address 0x7a                  */
> +/* Register definitions for TX_P1                              */
>  /***************************************************************/
>  
>  /* DP TX Link Training Control Register */
> 
