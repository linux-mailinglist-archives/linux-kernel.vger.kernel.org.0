Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2331A3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfEJULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 16:11:48 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40221 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfEJULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:11:47 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F2EA7C0002;
        Fri, 10 May 2019 20:11:43 +0000 (UTC)
Date:   Fri, 10 May 2019 22:11:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] clk: at91: sckc: sama5d4 has no bypass support
Message-ID: <20190510201143.GC7622@piout.net>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
 <1557487388-32098-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557487388-32098-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 11:23:27+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> The slow clock of SAMA5D4 has no bypass support thus remove it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/sckc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index e76b1d64e905..6c55a7a86f79 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -429,7 +429,6 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  	struct clk_init_data init;
>  	const char *xtal_name;
>  	const char *parent_names[2] = { "slow_rc_osc", "slow_osc" };
> -	bool bypass;
>  	int ret;
>  
>  	if (!regbase)
> @@ -443,8 +442,6 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  
>  	xtal_name = of_clk_get_parent_name(np, 0);
>  
> -	bypass = of_property_read_bool(np, "atmel,osc-bypass");
> -
>  	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
>  	if (!osc)
>  		return;
> @@ -459,9 +456,6 @@ static void __init of_sama5d4_sckc_setup(struct device_node *np)
>  	osc->sckcr = regbase;
>  	osc->startup_usec = 1200000;
>  
> -	if (bypass)
> -		writel((readl(regbase) | AT91_SCKC_OSC32BYP), regbase);
> -
>  	hw = &osc->hw;
>  	ret = clk_hw_register(NULL, &osc->hw);
>  	if (ret) {
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
