Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A44103D59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfKTOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:36:20 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38031 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfKTOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:36:20 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 158EB2305B;
        Wed, 20 Nov 2019 15:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1574260576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=XxLY2KUVk9j04RdLZYmRnJxNBTPZO0RA1SEcDGhoa18=;
        b=RO6KW4gMeS9f8AX1jfeY/ecoZlibh7SyoZ+aCsK/9RElQBc2IE9RxizX3se9Z0PRav/esX
        AGQDe92l4cYhVfYScvWoaUOgORXHBzTGGAVhx5EXQ8xh8vH82qghX3p/2Y4JcNPWLhREEd
        9kGT9HoRBq3oNUeDQ75tKpBHVl+VgsA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Nov 2019 15:36:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     wen.he_1@nxp.com
Cc:     devicetree@vger.kernel.org, leoyang.li@nxp.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        sboyd@kernel.org
Subject: Re: [v9 2/2] clk: ls1028a: Add clock driver for Display output
 interface
In-Reply-To: <20191119080747.35250-2-wen.he_1@nxp.com>
Message-ID: <b300cc0f4d8a2c5650abc847d76bc380@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 158EB2305B
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Add clock driver for QorIQ LS1028A Display output interfaces(LCD, 
> DPHY),
> as implemented in TSMC CLN28HPM PLL, this PLL supports the programmable
> integer division and range of the display output pixel clock's 
> 27-594MHz.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> ---
> change in v9:
> 	- Use the fixed mfd in plldig_set_rate
> 
>  drivers/clk/Kconfig      |  10 ++
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-plldig.c | 297 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 308 insertions(+)
>  create mode 100644 drivers/clk/clk-plldig.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 0530bebfc25a..9f6b0196c604 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -218,6 +218,16 @@ config CLK_QORIQ
>  	  This adds the clock driver support for Freescale QorIQ platforms
>  	  using common clock framework.
> 
> +config CLK_LS1028A_PLLDIG
> +        tristate "Clock driver for LS1028A Display output"
> +        depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +        default ARCH_LAYERSCAPE
> +        help
> +          This driver support the Display output interfaces(LCD, DPHY) 
> pixel clocks
> +          of the QorIQ Layerscape LS1028A, as implemented TSMC 
> CLN28HPM PLL. Not all
> +          features of the PLL are currently supported by the driver. 
> By default,
> +          configured bypass mode with this PLL.
> +
>  config COMMON_CLK_XGENE
>  	bool "Clock driver for APM XGene SoC"
>  	default ARCH_XGENE
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 0138fb14e6f8..97d1e5bc6de5 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
>  obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
>  obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
>  obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
> +obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
>  obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
>  obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
>  obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
> diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
> new file mode 100644
> index 000000000000..f940a9d3d011
> --- /dev/null
> +++ b/drivers/clk/clk-plldig.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP
> + *
> + * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/bitfield.h>
> +
> +/* PLLDIG register offsets and bit masks */
> +#define PLLDIG_REG_PLLSR            0x24
> +#define PLLDIG_REG_PLLDV            0x28
> +#define PLLDIG_REG_PLLFM            0x2c
> +#define PLLDIG_REG_PLLFD            0x30
> +#define PLLDIG_REG_PLLCAL1          0x38
> +#define PLLDIG_REG_PLLCAL2          0x3c
> +#define PLLDIG_LOCK_MASK            BIT(2)
> +#define PLLDIG_REG_FIELD_SSCGBYP    BIT(30)
> +#define PLLDIG_REG_FIELD_FDEN       BIT(30)
> +#define PLLDIG_REG_FIELD_DTHDIS     GENMASK(17, 16)
> +#define PLLDIG_REG_FIELD_MULT       GENMASK(7, 0)
> +#define PLLDIG_REG_FIELD_RFDPHI1    GENMASK(30, 25)
> +
> +/* Minimum output clock frequency, in Hz */
> +#define PHI1_MIN_FREQ 27000000
> +
> +/* Maximum output clock frequency, in Hz */
> +#define PHI1_MAX_FREQ 600000000
> +
> +/* Maximum of the divider */
> +#define MAX_RFDPHI1          63
> +
> +/*
> + * Clock configuration relationship between the PHI1 
> frequency(fpll_phi) and
> + * the output frequency of the PLL is determined by the PLLDV, 
> according to
> + * the following equation:
> + * fpll_phi = (pll_ref * mfd) / div_rfdphi1
> + */
> +struct plldig_phi1_param {
> +	unsigned long rate;
> +	unsigned int rfdphi1;
> +	unsigned int mfd;
> +};
> +
> +static const struct clk_parent_data parent_data[] = {
> +	{.index = 0},
> +};
> +
> +struct clk_plldig {
> +	struct clk_hw hw;
> +	void __iomem *regs;
> +	unsigned int mfd;
> +};
> +
> +#define to_clk_plldig(_hw)	container_of(_hw, struct clk_plldig, hw)
> +
> +static int plldig_enable(struct clk_hw *hw)
> +{
> +	struct clk_plldig *data = to_clk_plldig(hw);
> +	u32 val;
> +
> +	val = readl(data->regs + PLLDIG_REG_PLLFM);
> +	/*
> +	 * Use Bypass mode with PLL off by default, the frequency overshoot
> +	 * detector output was disable. SSCG Bypass mode should be enable.
> +	 */
> +	val |= PLLDIG_REG_FIELD_SSCGBYP;
> +	writel(val, data->regs + PLLDIG_REG_PLLFM);
> +
> +	val = readl(data->regs + PLLDIG_REG_PLLFD);
> +	/* Disable dither and Sigma delta modulation in bypass mode */
> +	val |= FIELD_PREP(PLLDIG_REG_FIELD_FDEN, 0x1) |

Unlike mentioned in the documentation, FDEN is "fractional divider 
enable".



> +	       FIELD_PREP(PLLDIG_REG_FIELD_DTHDIS, 0x3);
> +
> +	writel(val, data->regs + PLLDIG_REG_PLLFD);
> +
> +	return 0;
> +}
> +
> +static void plldig_disable(struct clk_hw *hw)
> +{
> +	struct clk_plldig *data = to_clk_plldig(hw);
> +	u32 val;
> +
> +	val = readl(data->regs + PLLDIG_REG_PLLFM);
> +
> +	val &= ~PLLDIG_REG_FIELD_SSCGBYP;
> +	val |= FIELD_PREP(PLLDIG_REG_FIELD_SSCGBYP, 0x0);
> +
> +	writel(val, data->regs + PLLDIG_REG_PLLFM);
> +}
> +
> +static int plldig_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_plldig *data = to_clk_plldig(hw);
> +
> +	return (readl(data->regs + PLLDIG_REG_PLLFM) &
> +			      PLLDIG_REG_FIELD_SSCGBYP);
> +}
> +
> +static unsigned long plldig_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct clk_plldig *data = to_clk_plldig(hw);
> +	u32 mult, div, val;
> +
> +	val = readl(data->regs + PLLDIG_REG_PLLDV);
> +
> +	/* Check if PLL is bypassed */
> +	if (val & PLLDIG_REG_FIELD_SSCGBYP)
> +		return parent_rate;
> +
> +	/* Checkout multiplication factor divider value */
> +	mult = FIELD_GET(PLLDIG_REG_FIELD_MULT, val);
> +
> +	/* Checkout divider value of the output frequency */
> +	div = FIELD_GET(PLLDIG_REG_FIELD_RFDPHI1, val);
> +
> +	return (parent_rate * mult) / div;
> +}
> +
> +static int plldig_calc_target_rate(unsigned long target_rate,
> +				   unsigned long parent_rate,
> +				   struct plldig_phi1_param *phi1)
> +{
> +	unsigned int div, ret;
> +	unsigned long round_rate;
> +
> +	/* Range limitation of the request target rate */
> +	if (target_rate > PHI1_MAX_FREQ)
> +		target_rate = PHI1_MAX_FREQ;
> +	else if (target_rate < PHI1_MIN_FREQ)
> +		target_rate = PHI1_MIN_FREQ;
> +
> +	/*
> +	 * Firstly, check the request target rate whether is divisible
> +	 * by the best VCO frequency.
> +	 */
> +	round_rate = parent_rate * phi1->mfd;
> +	div = round_rate / target_rate;
Can't you use DIV_ROUND_UP(), DIV_ROUND_DOWN_ULL() or 
DIV_ROUND_CLOSEST_ULL() and drop the stuff below except the range check?


> +	if (!div || div > MAX_RFDPHI1)
> +		return -EINVAL;
> +
> +	ret = round_rate % target_rate;
> +	if (ret) {
> +		/*
> +		 * Rounded down the request target rate, VESA specifies
> +		 * 0.5% pixel clock tolerance, therefore this algorithm
> +		 * can able to compatible a lot of request rates within
> +		 * range of the tolerance.
> +		 */
> +		round_rate += (target_rate / 2);
> +		div = round_rate / target_rate;
> +		if (!div || div > MAX_RFDPHI1)
> +			return -EINVAL;
> +	}
> +
> +	phi1->rfdphi1 = div;
> +	phi1->rate = target_rate;
> +
> +	return 0;
> +}
> +
> +static int plldig_determine_rate(struct clk_hw *hw,
> +				 struct clk_rate_request *req)
> +{
> +	int ret;
> +	unsigned long parent_rate;
> +	struct clk_hw *parent;
> +	struct plldig_phi1_param phi1_param;
> +	struct clk_plldig *data = to_clk_plldig(hw);
> +
> +	if (!req->rate)
> +		return -ERANGE;
> +
> +	phi1_param.mfd = data->mfd;
> +	parent = clk_hw_get_parent(hw);
> +	parent_rate = clk_hw_get_rate(parent);
> +
> +	ret = plldig_calc_target_rate(req->rate, parent_rate, &phi1_param);
> +	if (ret)
> +		return ret;
> +
> +	req->rate = phi1_param.rate;
> +
> +	return 0;
> +}
> +
> +static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
> +		unsigned long parent_rate)
> +{
> +	struct clk_plldig *data = to_clk_plldig(hw);
> +	struct plldig_phi1_param phi1_param;
> +	unsigned int val, cond;
> +	int ret;
> +
> +	phi1_param.mfd = data->mfd;
> +	ret = plldig_calc_target_rate(rate, parent_rate, &phi1_param);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(data->regs + PLLDIG_REG_PLLDV);
> +	val = FIELD_PREP(PLLDIG_REG_FIELD_MULT, phi1_param.mfd) |
> +	      FIELD_PREP(PLLDIG_REG_FIELD_RFDPHI1, phi1_param.rfdphi1);
> +
> +	writel(val, data->regs + PLLDIG_REG_PLLDV);
> +
> +	/* delay 200us make sure that old lock state is cleared */
> +	udelay(200);
> +
> +	/* Wait until PLL is locked or timeout (maximum 1000 usecs) */
> +	return readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR, cond,
> +					 cond & PLLDIG_LOCK_MASK, 0,
> +					 USEC_PER_MSEC);
> +}
> +
> +static const struct clk_ops plldig_clk_ops = {
> +	.enable = plldig_enable,
> +	.disable = plldig_disable,
> +	.is_enabled = plldig_is_enabled,
> +	.recalc_rate = plldig_recalc_rate,
> +	.determine_rate = plldig_determine_rate,
> +	.set_rate = plldig_set_rate,
> +};
> +
> +static int plldig_clk_probe(struct platform_device *pdev)
> +{
> +	struct clk_plldig *data;
> +	struct resource *mem;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->regs = devm_ioremap_resource(dev, mem);
> +	if (IS_ERR(data->regs))
> +		return PTR_ERR(data->regs);
> +
> +	 /*
> +	  * Support to get the best loop multiplication divider value
> +	  * from DTS file, since this PLL can't changed this value on
> +	  * the fly, write the fixed value.
> +	  */
> +	ret = of_property_read_u32(dev->of_node, "best-mfd", &data->mfd);
> +	if (ret)
> +		data->mfd = 0x2c;

IMHO this is a really bad device tree binding. First it is not described 
anywhere, ie it is missing in the dt-bindings file and second, to 
actually make use of the "best-mfd" the user has to know the parent 
clock, the desired vco frequency and have to calculate it by himself. 
IMHO a better one would be something like "vco-frequency". Also you 
should use the fractional divider to get better results. Using the 
fractional divider almost any VCO frequency is possible (within a 
certain range which should be checked [650 MHz to 1300 MHz]).


> +
> +	writel(data->mfd, data->regs + PLLDIG_REG_PLLDV);
> +
> +	data->hw.init = CLK_HW_INIT_PARENTS_DATA("dpclk",
> +						 parent_data,
> +						 &plldig_clk_ops,
> +						 0);
> +
> +	ret = devm_clk_hw_register(dev, &data->hw);
> +	if (ret) {
> +		dev_err(dev, "failed to register %s clock\n",
> +						dev->of_node->name);
> +		return ret;
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					   &data->hw);
> +}
> +
> +static const struct of_device_id plldig_clk_id[] = {
> +	{ .compatible = "fsl,ls1028a-plldig"},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, plldig_clk_id);
> +
> +static struct platform_driver plldig_clk_driver = {
> +	.driver = {
> +		.name = "plldig-clock",
> +		.of_match_table = plldig_clk_id,
> +	},
> +	.probe = plldig_clk_probe,
> +};
> +module_platform_driver(plldig_clk_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Wen He <wen.he_1@nxp.com>");
> +MODULE_DESCRIPTION("LS1028A Display output interface pixel clock 
> driver");

-michael
