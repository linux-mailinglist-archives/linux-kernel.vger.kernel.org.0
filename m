Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83153116E17
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 14:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfLINnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 08:43:08 -0500
Received: from foss.arm.com ([217.140.110.172]:60976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLINnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:43:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0B2328;
        Mon,  9 Dec 2019 05:43:07 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFEB23F718;
        Mon,  9 Dec 2019 05:43:06 -0800 (PST)
Subject: Re: [PATCH] mfd: rk808: Always use poweroff when requested
To:     Soeren Moch <smoch@web.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191209115746.12953-1-smoch@web.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <40f82334-8f89-e2bd-985a-b09f71be20ce@arm.com>
Date:   Mon, 9 Dec 2019 13:43:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209115746.12953-1-smoch@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2019 11:57 am, Soeren Moch wrote:
> With the device tree property "rockchip,system-power-controller" we
> explicitly request to use this PMIC to power off the system. So always
> register our poweroff function, even if some other handler (probably
> PSCI poweroff) was registered before.

This seems preferable to abusing syscore ops, and at least it does allow 
the firmware behaviour to be encapsulated in the DT (and thus more 
easily updated if and when a firmware-based shutdown can be achieved on 
currently-crippled boards) rather than baking assumptions into the 
kernel. And in the meantime, I *would* quite like to be able to power 
down my RK3399 board without having to lean on the button... so I guess,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Soeren Moch <smoch@web.de>
> ---
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/mfd/rk808.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index a69a6742ecdc..616e44e7ef98 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -550,7 +550,7 @@ static int rk808_probe(struct i2c_client *client,
>   	const struct mfd_cell *cells;
>   	int nr_pre_init_regs;
>   	int nr_cells;
> -	int pm_off = 0, msb, lsb;
> +	int msb, lsb;
>   	unsigned char pmic_id_msb, pmic_id_lsb;
>   	int ret;
>   	int i;
> @@ -674,16 +674,9 @@ static int rk808_probe(struct i2c_client *client,
>   		goto err_irq;
>   	}
> 
> -	pm_off = of_property_read_bool(np,
> -				"rockchip,system-power-controller");
> -	if (pm_off && !pm_power_off) {
> +	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
>   		rk808_i2c_client = client;
>   		pm_power_off = rk808->pm_pwroff_fn;
> -	}
> -
> -	if (pm_off && !pm_power_off_prepare) {
> -		if (!rk808_i2c_client)
> -			rk808_i2c_client = client;
>   		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
>   	}
> 
> --
> 2.17.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
