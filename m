Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F370F75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfGWC7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 22:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfGWC7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:59:48 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404C320840;
        Tue, 23 Jul 2019 02:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563850787;
        bh=PJiN02ZaWspoUTjLls5lAtxfgWphvYqbJjQlh5XlcHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekX8CnU6zapYYvnuUZQglOYWEjDnb0Z33UZj+V8z3FqIpiedzymGLNV7yOQA5gBCS
         82jTTq18J7YH9gEscNYcBWx3ZZk1Gsq4X/6rNI/DFCQyKAn1pVjj0QCPkNNsy5ILrW
         EPRaVfMdj2cCzVq1Nt8OV9yxTC9f9iKoA+etvGw0=
Date:   Tue, 23 Jul 2019 10:59:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com, p.zabel@pengutronix.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Message-ID: <20190723025916.GL3738@dragon>
References: <20190705085406.22483-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705085406.22483-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 04:54:05PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MM can reuse i.MX8MQ's reset driver, update the compatible
> property and related info to support i.MX8MM.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Hi Philipp,

Let me know if you want me to pick this up.

Shawn

> ---
> Changes since V3:
> 	- Add comments to those reset indices to indicate which are NOT supported on i.MX8MM.
> ---
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  6 +++--
>  include/dt-bindings/reset/imx8mq-reset.h           | 28 +++++++++++-----------
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> index 13e0951..c2489e4 100644
> --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - compatible:
>  	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
>  	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
> +	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"
>  - reg: should be register base and length as documented in the
>    datasheet
>  - interrupts: Should contain SRC interrupt
> @@ -46,5 +47,6 @@ Example:
>  
>  
>  For list of all valid reset indices see
> -<dt-bindings/reset/imx7-reset.h> for i.MX7 and
> -<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
> +<dt-bindings/reset/imx7-reset.h> for i.MX7,
> +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
> +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MM
> diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
> index 57c5924..f17ef2a 100644
> --- a/include/dt-bindings/reset/imx8mq-reset.h
> +++ b/include/dt-bindings/reset/imx8mq-reset.h
> @@ -38,26 +38,26 @@
>  #define IMX8MQ_RESET_PCIEPHY_PERST		27
>  #define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
>  #define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF	29
> -#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30
> +#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30	/* i.MX8MM does NOT support */
>  #define IMX8MQ_RESET_DISP_RESET			31
>  #define IMX8MQ_RESET_GPU_RESET			32
>  #define IMX8MQ_RESET_VPU_RESET			33
> -#define IMX8MQ_RESET_PCIEPHY2			34
> -#define IMX8MQ_RESET_PCIEPHY2_PERST		35
> -#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36
> -#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37
> -#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38
> -#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39
> -#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40
> -#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41
> -#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42
> -#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43
> +#define IMX8MQ_RESET_PCIEPHY2			34	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_PCIEPHY2_PERST		35	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43	/* i.MX8MM does NOT support */
>  #define IMX8MQ_RESET_DDRC1_PRST			44
>  #define IMX8MQ_RESET_DDRC1_CORE_RESET		45
>  #define IMX8MQ_RESET_DDRC1_PHY_RESET		46
> -#define IMX8MQ_RESET_DDRC2_PRST			47
> -#define IMX8MQ_RESET_DDRC2_CORE_RESET		48
> -#define IMX8MQ_RESET_DDRC2_PHY_RESET		49
> +#define IMX8MQ_RESET_DDRC2_PRST			47	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_DDRC2_CORE_RESET		48	/* i.MX8MM does NOT support */
> +#define IMX8MQ_RESET_DDRC2_PHY_RESET		49	/* i.MX8MM does NOT support */
>  
>  #define IMX8MQ_RESET_NUM			50
>  
> -- 
> 2.7.4
> 
