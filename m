Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A358A12FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfH2HsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 03:48:04 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57148 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfH2HsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:48:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7T7ljtP121389;
        Thu, 29 Aug 2019 02:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567064865;
        bh=X+Fj4hIsR5gYR6FlIPa0m9Wu/dW1+GCcIhAdJVX2QZQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=QyLERRmyS4eQPIIkKg8MbpQZIbNUSHXbOTIHOzBWD0Av8QxbQqnIPnMU+Ld/tpneN
         rCwm2TAtC5Dug9nTTT/ZJDQ+YSsKPOgWDRoj2T025KXf/TZ2JBofU3tGz9Dizb1Rc/
         z0Th/zk/fgh2RNpDYwlZI3rwoE+jsDLoU/y2BGqU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7T7ljgS057052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Aug 2019 02:47:45 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 29
 Aug 2019 02:47:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 29 Aug 2019 02:47:45 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7T7lg7h121088;
        Thu, 29 Aug 2019 02:47:43 -0500
Subject: Re: [PATCH] mtd: spi-nor: remove superfluous pass of
 nor->info->sector_size
To:     <Tudor.Ambarus@microchip.com>, <marek.vasut@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20190828103423.8232-1-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <804122ef-683e-3ff8-0912-2b380444f92e@ti.com>
Date:   Thu, 29 Aug 2019 13:18:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828103423.8232-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/19 4:05 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> We already pass a pointer to nor, we can obtain the sector_size
> by dereferencing it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  drivers/mtd/spi-nor/spi-nor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 79c8f1dd8c6b..69532573dba9 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4257,11 +4257,12 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
>  	return erase;
>  }
>  
> -static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
> +static int spi_nor_select_erase(struct spi_nor *nor)
>  {
>  	struct spi_nor_erase_map *map = &nor->params.erase_map;
>  	const struct spi_nor_erase_type *erase = NULL;
>  	struct mtd_info *mtd = &nor->mtd;
> +	u32 wanted_size = nor->info->sector_size;
>  	int i;
>  
>  	/*
> @@ -4355,7 +4356,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
>  	}
>  
>  	/* Select the Sector Erase command. */
> -	err = spi_nor_select_erase(nor, nor->info->sector_size);
> +	err = spi_nor_select_erase(nor);
>  	if (err) {
>  		dev_err(nor->dev,
>  			"can't select erase settings supported by both the SPI controller and memory.\n");
> 

