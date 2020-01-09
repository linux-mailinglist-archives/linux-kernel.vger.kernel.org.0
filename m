Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830FF135427
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 09:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgAIIQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 03:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbgAIIQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:16:14 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C15520673;
        Thu,  9 Jan 2020 08:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578557774;
        bh=Ig8MmN3PyaZFfhXHd04xYCXqXztbORRcP6mk3OMhKnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFz7kL6Rli3iJa2zYrYYlZjt0VSUQ22isIyA1VxMG6wKcYMCe9VLNckYhxRwGBMgT
         1+2m7RK5AwqLAeAyhcahD9ZLmVyatAKzjUAImqCGlgTxcpaOX7F96TpFYmGpLVAPZw
         5hifcxbkywB4paXwMHunnTBrONed5/gDHLO1M5Hw=
Date:   Thu, 9 Jan 2020 16:16:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH] ARM: imx: use of_root to simplify code
Message-ID: <20200109081603.GI4456@T480>
References: <1577696316-27635-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577696316-27635-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:03:51AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> start_kernel
>      |->setup_arch
>      |       |->unflatten_device_tree->of_root ready
>      |
>      |->do_initcalls
>            |->customize_machine
>                        |->init_machine
>                               |->imx_soc_device_init
> 
> When imx_soc_device_init, of_root is ready, so we could directly use it.

IMO, of_root is something for OF core code, not really for platform.

Shawn

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  Tested on i.MX7D-SDB
> 
>  arch/arm/mach-imx/cpu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index 06f8d64b65af..77319b359070 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -88,7 +88,6 @@ struct device * __init imx_soc_device_init(void)
>  	struct soc_device_attribute *soc_dev_attr;
>  	const char *ocotp_compat = NULL;
>  	struct soc_device *soc_dev;
> -	struct device_node *root;
>  	struct regmap *ocotp = NULL;
>  	const char *soc_id;
>  	u64 soc_uid = 0;
> @@ -101,9 +100,7 @@ struct device * __init imx_soc_device_init(void)
>  
>  	soc_dev_attr->family = "Freescale i.MX";
>  
> -	root = of_find_node_by_path("/");
> -	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> -	of_node_put(root);
> +	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
>  	if (ret)
>  		goto free_soc;
>  
> -- 
> 2.16.4
> 
