Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6143A2645F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfEVNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 09:13:08 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43858 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfEVNNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:13:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DBFE6FB03;
        Wed, 22 May 2019 15:13:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 016_fW5-3grm; Wed, 22 May 2019 15:13:04 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 26DC440FF6; Wed, 22 May 2019 15:13:04 +0200 (CEST)
Date:   Wed, 22 May 2019 15:13:04 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Message-ID: <20190522131304.GA5692@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bcc: 
Subject: Re: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisions
Reply-To: 
In-Reply-To: <20190508124018.GA16859@bogon.m.sigxcpu.org>

Hi Leonard,,
On Wed, May 08, 2019 at 02:40:18PM +0200, Guido Günther wrote:
> Hi Leonard,
> 
> Thanks for your comments. Let's try s.th. different then: identify by
> bootrom, ocotop and anatop and fall back to ATF afterwards (I'll split
> out the DT part and add binding docs if this makes sense). I'm also
> happy to drop the whole ATF logic until mailine ATF catched up:
> 
> The mainline ATF doesn't currently support the FSL_SIP_GET_SOC_INFO call
> nor does it have the code to identify different imx8mq SOC revisions so
> mimic what NXPs ATF does here.

Does this makes sense? If so I'll send this out as a series.

> 
> As a fallback use ATF so we can identify new revisions once it gains
> support or when using NXPs ATF.

I'm also fine with dropping the ATF part if we don't want to depend on
it in mainline.
Cheers,
 -- Guido

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 12 ++++
>  drivers/soc/imx/soc-imx8.c                | 68 ++++++++++++++++++-----
>  2 files changed, 67 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 6d635ba0904c..52aa1600b33b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -246,6 +246,18 @@
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
>  		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
>  
> +		bus@00000000 { /* ROM */
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x00000000 0x00000000 0x20000>;
> +
> +			rom@00000000 {
> +				compatible = "fsl,imx8mq-bootrom";
> +				reg = <0x00000000 0x1e800>;
> +			};
> +		};
> +
>  		bus@30000000 { /* AIPS1 */
>  			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
>  			#address-cells = <1>;
> diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
> index fc6429f9170a..0a1fe82efe86 100644
> --- a/drivers/soc/imx/soc-imx8.c
> +++ b/drivers/soc/imx/soc-imx8.c
> @@ -3,6 +3,7 @@
>   * Copyright 2019 NXP.
>   */
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/of_address.h>
> @@ -11,39 +12,80 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  
> +#define REV_A0				0x10
> +#define REV_B0				0x20
>  #define REV_B1				0x21
>  
> +#define IMX8MQ_SW_INFO_A0		0x800
> +#define IMX8MQ_SW_INFO_B0		0x83C
>  #define IMX8MQ_SW_INFO_B1		0x40
>  #define IMX8MQ_SW_MAGIC_B1		0xff0055aa
>  
> +#define FSL_SIP_GET_SOC_INFO		0xc2000006
> +
>  struct imx8_soc_data {
>  	char *name;
>  	u32 (*soc_revision)(void);
>  };
>  
> -static u32 __init imx8mq_soc_revision(void)
> +static u32 __init imx8mq_soc_revision_atf(void)
> +{
> +	struct arm_smccc_res res = { 0 };
> +
> +	arm_smccc_smc(FSL_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
> +	/*
> +	 * Bit [23:16] is the silicon ID
> +	 * Bit[7:4] is the base layer revision,
> +	 * Bit[3:0] is the metal layer revision
> +	 * e.g. 0x10 stands for Tapeout 1.0
> +	 */
> +	return res.a0 & 0xff;
> +}
> +
> +static u32 __init imx8mq_soc_magic_node(const char *node, u32 offset)
>  {
>  	struct device_node *np;
> -	void __iomem *ocotp_base;
> +	void __iomem *base;
>  	u32 magic;
> -	u32 rev = 0;
>  
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
> +	np = of_find_compatible_node(NULL, NULL, node);
>  	if (!np)
> -		goto out;
> +		return 0;
> +	base = of_iomap(np, 0);
> +	WARN_ON(!base);
> +
> +	magic = readl_relaxed(base + offset);
> +	iounmap(base);
> +	of_node_put(np);
> +
> +	return magic;
> +}
>  
> -	ocotp_base = of_iomap(np, 0);
> -	WARN_ON(!ocotp_base);
> +static u32 __init imx8mq_soc_revision(void)
> +{
> +	u32 magic;
>  
> -	magic = readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);
> +	/* B1 revision identified by ocotop */
> +	magic = imx8mq_soc_magic_node("fsl,imx8mq-ocotp", IMX8MQ_SW_INFO_B1);
>  	if (magic == IMX8MQ_SW_MAGIC_B1)
> -		rev = REV_B1;
> +		return REV_B1;
>  
> -	iounmap(ocotp_base);
> +	/* B0 identified by bootrom */
> +	magic = imx8mq_soc_magic_node("fsl,imx8mq-bootrom", IMX8MQ_SW_INFO_B0);
> +	if ((magic & 0xff) == REV_B0)
> +		return REV_B0;
>  
> -out:
> -	of_node_put(np);
> -	return rev;
> +	/* A0 identified by anatop */
> +	magic = imx8mq_soc_magic_node("fsl,imx8mq-anatop", IMX8MQ_SW_INFO_A0);
> +	if ((magic & 0xff) == REV_A0)
> +		return REV_A0;
> +
> +	/* Read revision from ATF as fallback */
> +	magic = imx8mq_soc_revision_atf();
> +	if (magic != 0xff)
> +		return magic;
> +
> +	return 0;
>  }
>  
>  static const struct imx8_soc_data imx8mq_soc_data = {
> -- 
> 2.20.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
