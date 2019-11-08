Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED43F4F38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 16:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKHPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 10:17:24 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:53337 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfKHPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:17:23 -0500
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 01487100008;
        Fri,  8 Nov 2019 15:17:20 +0000 (UTC)
Date:   Fri, 8 Nov 2019 16:17:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] soc: fsl: Enable COMPILE_TEST
Message-ID: <20191108151720.GB216543@piout.net>
References: <20191108130213.23684-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108130213.23684-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/11/2019 21:02:13+0800, YueHaibing wrote:
> When do COMPILE_TEST buiding for RTC_DRV_FSL_FTM_ALARM,
> we get this warning:
> 
> WARNING: unmet direct dependencies detected for FSL_RCPM
>   Depends on [n]: PM_SLEEP [=y] && (ARM || ARM64)
>   Selected by [m]:
>   - RTC_DRV_FSL_FTM_ALARM [=m] && RTC_CLASS [=y] && (ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST [=y])
> 
> This enable COMPILE_TEST for FSL_RCPM to fix the issue.
> 
> Fixes: e1c2feb1efa2 ("rtc: fsl-ftm-alarm: allow COMPILE_TEST")

I've removed that patch until the fsl maintainers apply this one.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> In commit c6c2d36bc46f ("rtc: fsl-ftm-alarm: Fix build error without PM_SLEEP")
> I posted a wrong kconfig warning(which PM_SLEEP is n), sorry for confusion.
> ---
>  drivers/soc/fsl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 4df32bc..e142662 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -43,7 +43,7 @@ config DPAA2_CONSOLE
>  
>  config FSL_RCPM
>  	bool "Freescale RCPM support"
> -	depends on PM_SLEEP && (ARM || ARM64)
> +	depends on PM_SLEEP && (ARM || ARM64 || COMPILE_TEST)
>  	help
>  	  The NXP QorIQ Processors based on ARM Core have RCPM module
>  	  (Run Control and Power Management), which performs all device-level
> -- 
> 2.7.4
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
