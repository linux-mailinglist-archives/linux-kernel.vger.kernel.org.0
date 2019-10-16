Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29328D8B39
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391695AbfJPIkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:40:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389094AbfJPIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:40:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9G8e7Dh061401;
        Wed, 16 Oct 2019 03:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571215207;
        bh=FzydHRoxz6F3DddJ3LSZU2cJWwW/1+9y2x9SP14HWoc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zVRRtR+UOjB0rQk11SdMmU1yNPLFd0Yw6hDA+wOfxU9pHoxKROtwcxaK46DvD2E2p
         b2cHXcxU5uQZNENkM7smTZTWg/A8LMNIY54UXJ8TM1kY+/PRXWKW0q63HWPOPHSAsw
         lo1VwDVUdhmZHpLMZo2VjYuIystAlju/gwy98jKI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9G8e7Ux122410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 03:40:07 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 03:40:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 03:40:00 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G8e1vE114960;
        Wed, 16 Oct 2019 03:40:02 -0500
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: cadence-quadspi: disable the
 auto-poll for Intel LGM
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>, <jwboyer@gmail.com>,
        <boris.brezillon@free-electrons.com>, <cyrille.pitchen@atmel.com>,
        <david.oberhollenzer@sigma-star.at>, <miquel.raynal@bootlin.com>,
        <tudor.ambarus@gmail.com>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20190909104733.14273-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190909104733.14273-4-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a4d45efe-907f-6c87-c650-5ad19942f0e4@ti.com>
Date:   Wed, 16 Oct 2019 14:10:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909104733.14273-4-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/19 4:17 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> On Intel's Lightning Mountain(LGM) SoC QSPI controller do not auto-poll.
> This patch introduces to properly disable the auto-polling feature to

This patch disables auto polling when direct access mode is disabled
which should be noted in the commit message.

> improve the performance of cadence-quadspi.

How does this improve performance of cadence-quadspi? I would expect HW
auto-polling to be faster than SW polling.

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 73b9fbd1508a..60998eaad1cc 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -135,6 +135,8 @@ struct cqspi_driver_platdata {
>  #define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
>  #define CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
>  
> +#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
> +#define CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL	BIT(14)
>  #define CQSPI_REG_WR_INSTR			0x08
>  #define CQSPI_REG_WR_INSTR_OPCODE_LSB		0
>  #define CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
> @@ -471,6 +473,18 @@ static int cqspi_command_write_addr(struct spi_nor *nor,
>  	return cqspi_exec_flash_cmd(cqspi, reg);
>  }
>  
> +static int cqspi_disable_auto_poll(struct cqspi_st *cqspi)
> +{
> +	void __iomem *reg_base = cqspi->iobase;
> +	unsigned int reg;
> +
> +	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +	reg |= CQSPI_REG_WR_COMPLETION_DISABLE_AUTO_POLL;
> +	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
> +
> +	return 0;
> +}
> +
>  static int cqspi_read_setup(struct spi_nor *nor)
>  {
>  	struct cqspi_flash_pdata *f_pdata = nor->priv;
> @@ -508,6 +522,11 @@ static int cqspi_read_setup(struct spi_nor *nor)
>  	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
>  	reg |= (nor->addr_width - 1);
>  	writel(reg, reg_base + CQSPI_REG_SIZE);
> +
> +	/* Disable auto-polling */
> +	if (!f_pdata->use_direct_mode)
> +		cqspi_disable_auto_poll(cqspi);
> +
>  	return 0;
>  }
>  

Hmmm.. There is no need to disable polling for every read/write
operation. It should be enough to do it once in cqspi_controller_init()



> @@ -627,6 +646,11 @@ static int cqspi_write_setup(struct spi_nor *nor)
>  	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
>  	reg |= (nor->addr_width - 1);
>  	writel(reg, reg_base + CQSPI_REG_SIZE);
> +
> +	/* Disable auto-polling */
> +	if (!f_pdata->use_direct_mode)
> +		cqspi_disable_auto_poll(cqspi);
> +
>  	return 0;
>  }
>  
> 

-- 
Regards
Vignesh
