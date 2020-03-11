Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656A6181079
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 07:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgCKGNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 02:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKGNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:13:25 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2CD20873;
        Wed, 11 Mar 2020 06:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583907205;
        bh=jAVjS4LHx4J2YBJ/NlhABffxBXS41+Ke8Fes7SpT2QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hyM6r/7mblSrckwDB11uuLIzXTpxYRt669ca+pxZjWGnM3NBeFpQap1/F1QlN6iBi
         uqPVRFwDvW7FU41/H/j7i+kM762DmQkZf8Br36WgAEAus24WHdVPwil+Ik6Syvhupw
         dDrWQUm5n7jKVL1jjOVdhan5EyJYNSMy1tZkP10k=
Date:   Wed, 11 Mar 2020 14:13:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] arm64: defconfig: Enable QorIQ IFC NAND controller
 driver
Message-ID: <20200311061320.GC29269@dragon>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-10-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582585690-463-10-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 05:08:04PM -0600, Li Yang wrote:
> Enables NXP/FSL QorIQ IFC flash controller driver for NAND.  Enabled as
> built-in to load RFS from nand flash without initramfs.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d2d5d470a6fc..a625e322fa27 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -217,6 +217,7 @@ CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_NAND_DENALI_DT=y
>  CONFIG_MTD_NAND_MARVELL=y
> +CONFIG_MTD_NAND_FSL_IFC=y
>  CONFIG_MTD_NAND_QCOM=y
>  CONFIG_MTD_SPI_NOR=y
>  CONFIG_SPI_CADENCE_QUADSPI=y
> @@ -801,7 +802,6 @@ CONFIG_ARCH_K3_J721E_SOC=y
>  CONFIG_TI_SCI_PM_DOMAINS=y
>  CONFIG_EXTCON_USB_GPIO=y
>  CONFIG_EXTCON_USBC_CROS_EC=y
> -CONFIG_MEMORY=y

Why is this getting removed?  Maybe worth a mentioning in the commit
log?

Shawn

>  CONFIG_IIO=y
>  CONFIG_EXYNOS_ADC=y
>  CONFIG_QCOM_SPMI_ADC5=m
> -- 
> 2.17.1
> 
