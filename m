Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663369A5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 04:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbfHWCtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 22:49:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:52499 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfHWCty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:49:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 19:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; 
   d="scan'208";a="330590484"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2019 19:49:53 -0700
Received: from [10.226.38.19] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.19])
        by linux.intel.com (Postfix) with ESMTP id 66DAA5803A5;
        Thu, 22 Aug 2019 19:49:51 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     kishon@ti.com, robh@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com
References: <20190822102843.47964-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190822102843.47964-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190822130848.GO30120@smile.fi.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <3fc56164-e193-f43e-2377-ceb52ce48d88@linux.intel.com>
Date:   Fri, 23 Aug 2019 10:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822130848.GO30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 22/8/2019 9:08 PM, Andy Shevchenko wrote:
> On Thu, Aug 22, 2019 at 06:28:43PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for eMMC PHY on Intel's Lightning Mountain SoC.
>>
> Thanks for an update!
> One minor comment below. After addressing it
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Thank you so much for review comments and your time.
will update minor comment and also Reviewed-by tag as well.

---
With Best Regards
Vadivel Murugan
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>> chnages in v4:
>>   - As per Andy's review comments,the following update
>>   - add license_tag, macro, blank_line, error_check and grouping
>>
>> changes in v3:
>>   - As per Andy's review comments macro optimization,aligned
>>     function call in proper order and udelay added.
>>
>> changes in v2:
>>   - optimize IS_CALDONE() and IS_DLLRDY() macro
>>   - remove unneccessary comment
>>   - remove redundant assignment
>>   - add return the error ptr
>> ---
>>   drivers/phy/Kconfig                |   1 +
>>   drivers/phy/Makefile               |   1 +
>>   drivers/phy/intel/Kconfig          |   9 ++
>>   drivers/phy/intel/Makefile         |   2 +
>>   drivers/phy/intel/phy-intel-emmc.c | 281 +++++++++++++++++++++++++++++++++++++
>>   5 files changed, 294 insertions(+)
>>   create mode 100644 drivers/phy/intel/Kconfig
>>   create mode 100644 drivers/phy/intel/Makefile
>>   create mode 100644 drivers/phy/intel/phy-intel-emmc.c
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 0263db2ac874..b3ed94b98d9b 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -69,5 +69,6 @@ source "drivers/phy/socionext/Kconfig"
>>   source "drivers/phy/st/Kconfig"
>>   source "drivers/phy/tegra/Kconfig"
>>   source "drivers/phy/ti/Kconfig"
>> +source "drivers/phy/intel/Kconfig"
>>   
>>   endmenu
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index 0d9fddc498a6..3f1fc9efbbed 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -19,6 +19,7 @@ obj-y					+= broadcom/	\
>>   					   cadence/	\
>>   					   freescale/	\
>>   					   hisilicon/	\
>> +					   intel/	\
>>   					   marvell/	\
>>   					   motorola/	\
>>   					   mscc/	\
>> diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
>> new file mode 100644
>> index 000000000000..4ea6a8897cd7
>> --- /dev/null
>> +++ b/drivers/phy/intel/Kconfig
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Phy drivers for Intel Lightning Mountain(LGM) platform
>> +#
>> +config PHY_INTEL_EMMC
>> +	tristate "Intel EMMC PHY driver"
>> +	select GENERIC_PHY
>> +	help
>> +	  Enable this to support the Intel EMMC PHY
>> diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
>> new file mode 100644
>> index 000000000000..6b876a75599d
>> --- /dev/null
>> +++ b/drivers/phy/intel/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
>> diff --git a/drivers/phy/intel/phy-intel-emmc.c b/drivers/phy/intel/phy-intel-emmc.c
>> new file mode 100644
>> index 000000000000..4f0226f37ab0
>> --- /dev/null
>> +++ b/drivers/phy/intel/phy-intel-emmc.c
>> @@ -0,0 +1,281 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel eMMC PHY driver
>> + * Copyright (C) 2019 Intel, Corp.
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +/* eMMC phy register definitions */
>> +#define EMMC_PHYCTRL0_REG	0xa8
>> +#define DR_TY_MASK		GENMASK(30, 28)
>> +#define DR_TY_SHIFT(x)		(((x) << 28) & DR_TY_MASK)
>> +#define OTAPDLYENA		BIT(14)
>> +#define OTAPDLYSEL_MASK		GENMASK(13, 10)
>> +#define OTAPDLYSEL_SHIFT(x)	(((x) << 10) & OTAPDLYSEL_MASK)
>> +
>> +#define EMMC_PHYCTRL1_REG	0xac
>> +#define PDB_MASK		BIT(0)
>> +#define PDB_SHIFT(x)		(((x) << 0) & PDB_MASK)
>> +#define ENDLL_MASK		BIT(7)
>> +#define ENDLL_SHIFT(x)		(((x) << 7) & ENDLL_MASK)
>> +
>> +#define EMMC_PHYCTRL2_REG	0xb0
>> +#define FRQSEL_25M		0
>> +#define FRQSEL_50M		1
>> +#define FRQSEL_100M		2
>> +#define FRQSEL_150M		3
>> +#define FRQSEL_MASK		GENMASK(24, 22)
>> +#define FRQSEL_SHIFT(x)		(((x) << 22) & FRQSEL_MASK)
>> +
>> +#define EMMC_PHYSTAT_REG	0xbc
>> +#define CALDONE_MASK		BIT(9)
>> +#define DLLRDY_MASK		BIT(8)
>> +#define IS_CALDONE(x)	((x) & CALDONE_MASK)
>> +#define IS_DLLRDY(x)	((x) & DLLRDY_MASK)
>> +
>> +struct intel_emmc_phy {
>> +	struct regmap *syscfg;
>> +	struct clk *emmcclk;
>> +};
>> +
>> +static int intel_emmc_phy_power(struct phy *phy, bool on_off)
>> +{
>> +	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
>> +	unsigned int caldone;
>> +	unsigned int dllrdy;
>> +	unsigned int freqsel;
>> +	unsigned long rate;
>> +	int ret, quot;
>> +
>> +	/*
>> +	 * Keep phyctrl_pdb and phyctrl_endll low to allow
>> +	 * initialization of CALIO state M/C DFFs
>> +	 */
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, PDB_MASK,
>> +				 PDB_SHIFT(0));
>> +	if (ret) {
>> +		dev_err(&phy->dev, "CALIO power down bar failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Already finish power_off above */
>> +	if (!on_off)
>> +		return 0;
>> +
>> +	rate = clk_get_rate(priv->emmcclk);
>> +	quot = DIV_ROUND_CLOSEST(rate, 50000000);
>> +	if (quot > FRQSEL_150M)
>> +		dev_warn(&phy->dev, "Unsupported rate: %lu\n", rate);
>> +	freqsel = clamp_t(int, quot, FRQSEL_25M, FRQSEL_150M);
>> +
>> +	/*
>> +	 * According to the user manual, calpad calibration
>> +	 * cycle takes more than 2us without the minimal recommended
>> +	 * value, so we may need a little margin here
>> +	 */
>> +	udelay(5);
>> +
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, PDB_MASK, 1);
> 1 is magic.
>
>> +	if (ret) {
>> +		dev_err(&phy->dev, "CALIO power down bar failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * According to the user manual, it asks driver to wait 5us for
>> +	 * calpad busy trimming. However it is documented that this value is
>> +	 * PVT(A.K.A process,voltage and temperature) relevant, so some
>> +	 * failure cases are found which indicates we should be more tolerant
>> +	 * to calpad busy trimming.
>> +	 */
>> +	ret = regmap_read_poll_timeout(priv->syscfg, EMMC_PHYSTAT_REG,
>> +				       caldone, IS_CALDONE(caldone),
>> +				       0, 50);
>> +	if (ret) {
>> +		dev_err(&phy->dev, "caldone failed, ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Set the frequency of the DLL operation */
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL2_REG, FRQSEL_MASK,
>> +				 FRQSEL_SHIFT(freqsel));
>> +	if (ret) {
>> +		dev_err(&phy->dev, "set the frequency of dll failed:%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Turn on the DLL */
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, ENDLL_MASK,
>> +				 ENDLL_SHIFT(1));
>> +	if (ret) {
>> +		dev_err(&phy->dev, "turn on the dll failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * After enabling analog DLL circuits docs say that we need 10.2 us if
>> +	 * our source clock is at 50 MHz and that lock time scales linearly
>> +	 * with clock speed.  If we are powering on the PHY and the card clock
>> +	 * is super slow (like 100 kHZ) this could take as long as 5.1 ms as
>> +	 * per the math: 10.2 us * (50000000 Hz / 100000 Hz) => 5.1 ms
>> +	 * Hopefully we won't be running at 100 kHz, but we should still make
>> +	 * sure we wait long enough.
>> +	 *
>> +	 * NOTE: There appear to be corner cases where the DLL seems to take
>> +	 * extra long to lock for reasons that aren't understood.  In some
>> +	 * extreme cases we've seen it take up to over 10ms (!).  We'll be
>> +	 * generous and give it 50ms.
>> +	 */
>> +	ret = regmap_read_poll_timeout(priv->syscfg,
>> +				       EMMC_PHYSTAT_REG,
>> +				       dllrdy, IS_DLLRDY(dllrdy),
>> +				       0, 50 * USEC_PER_MSEC);
>> +	if (ret) {
>> +		dev_err(&phy->dev, "dllrdy failed. ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int intel_emmc_phy_init(struct phy *phy)
>> +{
>> +	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
>> +
>> +	/*
>> +	 * We purposely get the clock here and not in probe to avoid the
>> +	 * circular dependency problem. We expect:
>> +	 * - PHY driver to probe
>> +	 * - SDHCI driver to start probe
>> +	 * - SDHCI driver to register it's clock
>> +	 * - SDHCI driver to get the PHY
>> +	 * - SDHCI driver to init the PHY
>> +	 *
>> +	 * The clock is optional, so upon any error just return it like
>> +	 * any other error to user.
>> +	 *
>> +	 */
>> +	priv->emmcclk = clk_get_optional(&phy->dev, "emmcclk");
>> +	if (IS_ERR(priv->emmcclk)) {
>> +		dev_err(&phy->dev, "ERROR: getting emmcclk\n");
>> +		return PTR_ERR(priv->emmcclk);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int intel_emmc_phy_exit(struct phy *phy)
>> +{
>> +	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
>> +
>> +	clk_put(priv->emmcclk);
>> +
>> +	return 0;
>> +}
>> +
>> +static int intel_emmc_phy_power_on(struct phy *phy)
>> +{
>> +	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
>> +	int ret;
>> +
>> +	/* Drive impedance: 50 Ohm */
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, DR_TY_MASK,
>> +				 DR_TY_SHIFT(6));
>> +	if (ret) {
>> +		dev_err(&phy->dev, "ERROR set drive-impednce-50ohm: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Output tap delay: disable */
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, OTAPDLYENA, 0);
>> +	if (ret) {
>> +		dev_err(&phy->dev, "ERROR Set output tap delay : %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Output tap delay */
>> +	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG,
>> +				 OTAPDLYSEL_MASK, OTAPDLYSEL_SHIFT(4));
>> +	if (ret) {
>> +		dev_err(&phy->dev, "ERROR: output tap dly select: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Power up eMMC phy analog blocks */
>> +	return intel_emmc_phy_power(phy, true);
>> +}
>> +
>> +static int intel_emmc_phy_power_off(struct phy *phy)
>> +{
>> +	/* Power down eMMC phy analog blocks */
>> +	return intel_emmc_phy_power(phy, false);
>> +}
>> +
>> +static const struct phy_ops ops = {
>> +	.init		= intel_emmc_phy_init,
>> +	.exit		= intel_emmc_phy_exit,
>> +	.power_on	= intel_emmc_phy_power_on,
>> +	.power_off	= intel_emmc_phy_power_off,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static int intel_emmc_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct intel_emmc_phy *priv;
>> +	struct phy *generic_phy;
>> +	struct phy_provider *phy_provider;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	/* Get eMMC phy (accessed via chiptop) regmap */
>> +	priv->syscfg = syscon_regmap_lookup_by_phandle(np, "intel,syscon");
>> +	if (IS_ERR(priv->syscfg)) {
>> +		dev_err(dev, "failed to find syscon\n");
>> +		return PTR_ERR(priv->syscfg);
>> +	}
>> +
>> +	generic_phy = devm_phy_create(dev, np, &ops);
>> +	if (IS_ERR(generic_phy)) {
>> +		dev_err(dev, "failed to create PHY\n");
>> +		return PTR_ERR(generic_phy);
>> +	}
>> +
>> +	phy_set_drvdata(generic_phy, priv);
>> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +	return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static const struct of_device_id intel_emmc_phy_dt_ids[] = {
>> +	{ .compatible = "intel,lgm-emmc-phy" },
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, intel_emmc_phy_dt_ids);
>> +
>> +static struct platform_driver intel_emmc_driver = {
>> +	.probe		= intel_emmc_phy_probe,
>> +	.driver		= {
>> +		.name	= "intel-emmc-phy",
>> +		.of_match_table = intel_emmc_phy_dt_ids,
>> +	},
>> +};
>> +
>> +module_platform_driver(intel_emmc_driver);
>> +
>> +MODULE_AUTHOR("Peter Harliman Liem <peter.harliman.liem@intel.com>");
>> +MODULE_DESCRIPTION("Intel eMMC PHY driver");
>> -- 
>> 2.11.0
>>
