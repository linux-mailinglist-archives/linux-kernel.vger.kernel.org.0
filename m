Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B161353CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 08:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgAIHma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 02:42:30 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43388 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgAIHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:42:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0097gN2H020521;
        Thu, 9 Jan 2020 01:42:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578555743;
        bh=vwU6q6zvMd5OU31CXYsLStuFLRdqUJGECJE4onbG3Bw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=g3+jX2mDYQqns4Ll8bBE2WWIUYJkH10YRYQla3uuHQ6DImu7QWIOncPXcAa3tXMYo
         s5aY6aUkAo01Tw+mitFJLsoMXSmadK+uJyOzrANu0QmNzcx+CBxPmnXOlSnDGs6cR2
         f/kAG9FUfMwEzJhuQ33cy9wd4lqgY9p0nV8K6TC4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0097gNPF070204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jan 2020 01:42:23 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Jan
 2020 01:42:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Jan 2020 01:42:22 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0097gJuf121104;
        Thu, 9 Jan 2020 01:42:20 -0600
Subject: Re: [PATCH v2 2/2] phy: ti: j721e-wiz: Implement DisplayPort mode to
 the wiz driver
To:     Jyri Sarha <jsarha@ti.com>, <linux-kernel@vger.kernel.org>
CC:     <tomi.valkeinen@ti.com>, <praneeth@ti.com>, <yamonkar@cadence.com>,
        <sjakhade@cadence.com>, <robh+dt@kernel.org>, <rogerq@ti.com>
References: <cover.1578471433.git.jsarha@ti.com>
 <08f35af7ad6b948bd6ccab9f0807e36b6ddfb1c3.1578471433.git.jsarha@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7c793ac4-59ae-1fcb-227c-2029240cf009@ti.com>
Date:   Thu, 9 Jan 2020 13:14:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <08f35af7ad6b948bd6ccab9f0807e36b6ddfb1c3.1578471433.git.jsarha@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyri,

On 08/01/20 2:00 PM, Jyri Sarha wrote:
> For DisplayPort use we need to set WIZ_CONFIG_LANECTL register's
> P_STANDARD_MODE bits to "mode 3". In the DisplayPort use also the
> P_ENABLE bits of the same register are set to P_ENABLE instead of
> P_ENABLE_FORCE, so that the DisplayPort driver can enable and disable
> the lane as needed. The DisplayPort mode is selected according to
> "cdns,phy-type"-properties found in link subnodes under the managed
> serdes (see "ti,sierra-phy-t0" and "ti,j721e-serdes-10g" devicetree
> bindings for details). All other values of "cdns,phy-type"-property
> but PHY_TYPE_DP will set P_STANDARD_MODE bits to 0 and P_ENABLE bits
> to force enable.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/phy/ti/phy-j721e-wiz.c | 59 +++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index b5f6019e5c7d..22bc04846cdb 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -20,6 +20,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> +#include <dt-bindings/phy/phy.h>
>  
>  #define WIZ_SERDES_CTRL		0x404
>  #define WIZ_SERDES_TOP_CTRL	0x408
> @@ -78,6 +79,8 @@ static const struct reg_field p_enable[WIZ_MAX_LANES] = {
>  	REG_FIELD(WIZ_LANECTL(3), 30, 31),
>  };
>  
> +enum p_enable { P_ENABLE = 2, P_ENABLE_FORCE = 1, P_ENABLE_DISABLE = 0 };
> +
>  static const struct reg_field p_align[WIZ_MAX_LANES] = {
>  	REG_FIELD(WIZ_LANECTL(0), 29, 29),
>  	REG_FIELD(WIZ_LANECTL(1), 29, 29),
> @@ -220,6 +223,7 @@ struct wiz {
>  	struct reset_controller_dev wiz_phy_reset_dev;
>  	struct gpio_desc	*gpio_typec_dir;
>  	int			typec_dir_delay;
> +	u32 lane_phy_type[WIZ_MAX_LANES];
>  };
>  
>  static int wiz_reset(struct wiz *wiz)
> @@ -242,12 +246,17 @@ static int wiz_reset(struct wiz *wiz)
>  static int wiz_mode_select(struct wiz *wiz)
>  {
>  	u32 num_lanes = wiz->num_lanes;
> +	enum wiz_lane_standard_mode mode;
>  	int ret;
>  	int i;
>  
>  	for (i = 0; i < num_lanes; i++) {
> -		ret = regmap_field_write(wiz->p_standard_mode[i],
> -					 LANE_MODE_GEN4);
> +		if (wiz->lane_phy_type[i] == PHY_TYPE_DP)
> +			mode = LANE_MODE_GEN1;
> +		else
> +			mode = LANE_MODE_GEN4;
> +
> +		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
>  		if (ret)
>  			return ret;
>  	}
> @@ -707,7 +716,7 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
>  		return ret;
>  	}
>  
> -	ret = regmap_field_write(wiz->p_enable[id - 1], false);
> +	ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_DISABLE);
>  	return ret;
>  }
>  
> @@ -734,7 +743,11 @@ static int wiz_phy_reset_deassert(struct reset_controller_dev *rcdev,
>  		return ret;
>  	}
>  
> -	ret = regmap_field_write(wiz->p_enable[id - 1], true);
> +	if (wiz->lane_phy_type[id - 1] == PHY_TYPE_DP)
> +		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE);
> +	else
> +		ret = regmap_field_write(wiz->p_enable[id - 1], P_ENABLE_FORCE);
> +
>  	return ret;
>  }
>  
> @@ -761,6 +774,40 @@ static const struct of_device_id wiz_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, wiz_id_table);
>  
> +static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
> +{
> +	struct device_node *serdes, *subnode;
> +
> +	serdes = of_get_child_by_name(dev->of_node, "serdes");
> +	if (!serdes) {
> +		dev_err(dev, "%s: Getting \"serdes\"-node failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(serdes, subnode) {
> +		u32 reg, num_lanes = 1, phy_type = PHY_NONE;
> +		int ret, i;
> +
> +		ret = of_property_read_u32(subnode, "reg", &reg);
> +		if (ret) {
> +			dev_err(dev,
> +				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
> +				__func__, subnode->name, ret);
> +			return ret;
> +		}
> +		of_property_read_u32(subnode, "cdns,num-lanes", &num_lanes);
> +		of_property_read_u32(subnode, "cdns,phy-type", &phy_type);
This would require the Torrent bindings to be Reviewed and Acked.

Thanks
Kishon
