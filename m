Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5D11A815
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfLKJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:48:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58227 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfLKJsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:48:24 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ieybW-0001pa-QQ; Wed, 11 Dec 2019 10:48:22 +0100
Message-ID: <89d2d00058e34e7571fc0f50ce487cf54414cd49.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: Add Broadcom STB RESCAL reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Jim Quinlan <im2101024@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 11 Dec 2019 10:48:18 +0100
In-Reply-To: <20191210195903.24127-3-f.fainelli@gmail.com>
References: <20191210195903.24127-1-f.fainelli@gmail.com>
         <20191210195903.24127-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian, Jim,

On Tue, 2019-12-10 at 11:59 -0800, Florian Fainelli wrote:
> From: Jim Quinlan <jim2101024@gmail.com>
> 
> On BCM7216 there is a special purpose reset controller named RESCAL
> (reset calibration) which is necessary for SATA and PCIe0/1 to operate
> correctly. This commit adds support for such a reset controller to be
> available.
> 
> Signed-off-by: Jim Quinlan <im2101024@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/reset/Kconfig                |   7 ++
>  drivers/reset/Makefile               |   1 +
>  drivers/reset/reset-brcmstb-rescal.c | 124 +++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 drivers/reset/reset-brcmstb-rescal.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 12f5c897788d..b7cc0a2049d9 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -49,6 +49,13 @@ config RESET_BRCMSTB
>  	  This enables the reset controller driver for Broadcom STB SoCs using
>  	  a SUN_TOP_CTRL_SW_INIT style controller.
>  
> +config RESET_BRCMSTB_RESCAL
> +	bool "Broadcom STB RESCAL reset controller"
> +	default ARCH_BRCMSTB || COMPILE_TEST
> +	help
> +	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
> +	  BCM7216.
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 00767c03f5f2..1e4291185c52 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
> +obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
> new file mode 100644
> index 000000000000..58a30e624a14
> --- /dev/null
> +++ b/drivers/reset/reset-brcmstb-rescal.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2018 Broadcom */
> +
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/types.h>
> +
> +#define BRCM_RESCAL_START	0
> +#define	BRCM_RESCAL_START_BIT	BIT(0)
> +#define BRCM_RESCAL_CTRL	4
> +#define BRCM_RESCAL_STATUS	8
> +#define BRCM_RESCAL_STATUS_BIT	BIT(0)

Is there any reason the start bit is indented but the status bit is not?

> +
> +struct brcm_rescal_reset {
> +	void __iomem	*base;
> +	struct device *dev;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static int brcm_rescal_reset_assert(struct reset_controller_dev *rcdev,
> +				      unsigned long id)
> +{
> +	return 0;
> +}

Please do not implement the assert operation if it doesn't cause a reset
line to be asserted afterwards.
The reset core will return 0 from reset_control_assert() for shared
reset controls if .assert is not implemented.

> +
> +static int brcm_rescal_reset_deassert(struct reset_controller_dev *rcdev,
> +				      unsigned long id)
> +{
> +	struct brcm_rescal_reset *data =
> +		container_of(rcdev, struct brcm_rescal_reset, rcdev);
> +	void __iomem *base = data->base;
> +	const int NUM_RETRIES = 10;
> +	u32 reg;
> +	int i;
> +
> +	reg = readl(base + BRCM_RESCAL_START);
> +	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
> +	reg = readl(base + BRCM_RESCAL_START);

Are there any other fields beside the START_BIT in this register?

> +	if (!(reg & BRCM_RESCAL_START_BIT)) {
> +		dev_err(data->dev, "failed to start sata/pcie rescal\n");
> +		return -EIO;
> +	}
> +
> +	reg = readl(base + BRCM_RESCAL_STATUS);
> +	for (i = NUM_RETRIES; i >= 0 &&  !(reg & BRCM_RESCAL_STATUS_BIT); i--) {
> +		udelay(100);
> +		reg = readl(base + BRCM_RESCAL_STATUS);
> +	}

This timeout loop should be replaced by a single readl_poll_timeout().
At 100 µs waits per iteration this could use the sleeping variant.

> +	if (!(reg & BRCM_RESCAL_STATUS_BIT)) {
> +		dev_err(data->dev, "timedout on sata/pcie rescal\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	reg = readl(base + BRCM_RESCAL_START);
> +	writel(reg ^ BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);

Please use &= ~BRCM_RESCAL_START_BIT instead.

> +	reg = readl(base + BRCM_RESCAL_START);
> +	dev_dbg(data->dev, "sata/pcie rescal success\n");
> +
> +	return 0;
> +}

This whole function looks a lot like it doesn't just deassert a reset
line, but actually issues a complete reset procedure of some kind. Do
you have some insight on what actually happens in the hardware when the
start bit is triggered? I suspect this should be implemented with the
.reset operation.

> +
> +static int brcm_rescal_reset_xlate(struct reset_controller_dev *rcdev,
> +				   const struct of_phandle_args *reset_spec)
> +{
> +	/* This is needed if #reset-cells == 0. */
> +	return 0;
> +}
> +
> +static const struct reset_control_ops brcm_rescal_reset_ops = {
> +	.assert = brcm_rescal_reset_assert,
> +	.deassert = brcm_rescal_reset_deassert,
> +};
> +
> +static int brcm_rescal_reset_probe(struct platform_device *pdev)
> +{
> +	struct brcm_rescal_reset *data;
> +	struct resource *res;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(&pdev->dev, res);
> +
> +	if (IS_ERR(data->base))
> +		return PTR_ERR(data->base);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = 1;
> +	data->rcdev.ops = &brcm_rescal_reset_ops;
> +	data->rcdev.of_node = pdev->dev.of_node;
> +	data->rcdev.of_xlate = brcm_rescal_reset_xlate;
> +	data->dev = &pdev->dev;
> +
> +	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
> +}
> +
> +static const struct of_device_id brcm_rescal_reset_of_match[] = {
> +	{ .compatible = "brcm,bcm7216-pcie-sata-rescal" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, brcm_rescal_reset_of_match);
> +
> +static struct platform_driver brcm_rescal_reset_driver = {
> +	.probe = brcm_rescal_reset_probe,
> +	.driver = {
> +		.name	= "brcm-rescal-reset",
> +		.of_match_table	= brcm_rescal_reset_of_match,
> +	}
> +};
> +module_platform_driver(brcm_rescal_reset_driver);
> +
> +MODULE_AUTHOR("Broadcom");
> +MODULE_DESCRIPTION("Broadcom Sata/PCIe rescal reset controller");
> +MODULE_LICENSE("GPL v2");

regards
Philipp

