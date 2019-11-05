Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76971EFD16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 13:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfKEMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 07:21:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60704 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbfKEMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:21:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5CLBP0017462;
        Tue, 5 Nov 2019 06:21:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572956471;
        bh=XdarqqgV7CHO0J2b+o2EUifq7q1n3LIXgOfSWZleKzs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C4H9JKTA2iE5k236NiEEMmGP9j7dDeyU6c93yRxvFIMME+Tcf+XQMHzfdFcCKjQ8n
         33mwcBJDVBvDeeBHwGTsu6IP1uDrvRrxnHHmFK4q4gyxkb4WdYPbS6CGOhvpobeIN4
         +nF7pDmW7WS8QVJrAOYaPmafaSN/i8emD07SYVLc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5CLBiW050932
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 06:21:11 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 06:21:10 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 06:20:56 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5CL8X5070778;
        Tue, 5 Nov 2019 06:21:09 -0600
Subject: Re: [PATCH v4 11/20] mtd: spi-nor: Check all the bits written, not
 just the BP ones
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-12-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <037932b0-329f-f974-25b5-ac584ad69262@ti.com>
Date:   Tue, 5 Nov 2019 17:51:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-12-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/19 4:53 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Check that all the bits written in the write_sr_and_check() method
> match the status_new received value. Failing to write the other bits
> is dangerous too, extend the check.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  drivers/mtd/spi-nor/spi-nor.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 14146619bf19..8f5e9833081b 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -960,8 +960,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
>  }
>  
>  /* Write status register and ensure bits in mask match written values */
> -static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
> -				      u8 mask)
> +static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new)
>  {
>  	int ret;
>  
> @@ -975,7 +974,7 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
>  	if (ret)
>  		return ret;
>  
> -	return ((nor->bouncebuf[0] & mask) != (status_new & mask)) ? -EIO : 0;
> +	return (nor->bouncebuf[0] != status_new) ? -EIO : 0;
>  }
>  
>  /**
> @@ -1774,7 +1773,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  	if ((status_new & mask) < (status_old & mask))
>  		return -EINVAL;
>  
> -	return spi_nor_write_sr_and_check(nor, status_new, mask);
> +	return spi_nor_write_sr_and_check(nor, status_new);
>  }
>  
>  /*
> @@ -1859,7 +1858,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  	if ((status_new & mask) > (status_old & mask))
>  		return -EINVAL;
>  
> -	return spi_nor_write_sr_and_check(nor, status_new, mask);
> +	return spi_nor_write_sr_and_check(nor, status_new);
>  }
>  
>  /*
> 

-- 
Regards
Vignesh
