Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F09AFC68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfIKMVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 08:21:43 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33641 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKMVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:21:43 -0400
X-Originating-IP: 148.69.85.38
Received: from localhost (unknown [148.69.85.38])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 95794FF810;
        Wed, 11 Sep 2019 12:21:40 +0000 (UTC)
Date:   Wed, 11 Sep 2019 14:21:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH 2/2] clk: at91: select parent if main oscillator or
 bypass is enabled
Message-ID: <20190911122137.GM21254@piout.net>
References: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
 <1568042692-11784-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568042692-11784-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2019 15:30:34+0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Selecting the right parent for the main clock is done using only
> main oscillator enabled bit.
> In case we have this oscillator bypassed by an external signal (no driving
> on the XOUT line), we still use external clock, but with BYPASS bit set.
> So, in this case we must select the same parent as before.
> Create a macro that will select the right parent considering both bits from
> the MOR register.
> Use this macro when looking for the right parent.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index ebe9b99..87083b3 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -21,6 +21,10 @@
>  
>  #define MOR_KEY_MASK		(0xff << 16)
>  
> +#define clk_main_parent_select(s)	(((s) & \
> +					(AT91_PMC_MOSCEN | \
> +					AT91_PMC_OSCBYPASS)) ? 1 : 0)
> +
>  struct clk_main_osc {
>  	struct clk_hw hw;
>  	struct regmap *regmap;
> @@ -113,7 +117,7 @@ static int clk_main_osc_is_prepared(struct clk_hw *hw)
>  
>  	regmap_read(regmap, AT91_PMC_SR, &status);
>  
> -	return (status & AT91_PMC_MOSCS) && (tmp & AT91_PMC_MOSCEN);
> +	return (status & AT91_PMC_MOSCS) && clk_main_parent_select(tmp);
>  }
>  
>  static const struct clk_ops main_osc_ops = {
> @@ -450,7 +454,7 @@ static u8 clk_sam9x5_main_get_parent(struct clk_hw *hw)
>  
>  	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
>  
> -	return status & AT91_PMC_MOSCEN ? 1 : 0;
> +	return clk_main_parent_select(status);
>  }
>  
>  static const struct clk_ops sam9x5_main_ops = {
> @@ -492,7 +496,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
>  	clkmain->hw.init = &init;
>  	clkmain->regmap = regmap;
>  	regmap_read(clkmain->regmap, AT91_CKGR_MOR, &status);
> -	clkmain->parent = status & AT91_PMC_MOSCEN ? 1 : 0;
> +	clkmain->parent = clk_main_parent_select(status);
>  
>  	hw = &clkmain->hw;
>  	ret = clk_hw_register(NULL, &clkmain->hw);
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
