Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9569C341
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 14:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfHYMgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 08:36:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYMgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:36:31 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CA4A628A1AB;
        Sun, 25 Aug 2019 13:36:29 +0100 (BST)
Date:   Sun, 25 Aug 2019 14:36:26 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Message-ID: <20190825143626.2ad09b8f@collabora.com>
In-Reply-To: <20190824120650.14752-6-tudor.ambarus@microchip.com>
References: <20190824120650.14752-1-tudor.ambarus@microchip.com>
        <20190824120650.14752-6-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 12:07:16 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> s3an_nor_scan() was overriding the opcode selection done in
> spi_nor_default_setup(). Set nor->setup() method in order to
> avoid the unnecessary call to spi_nor_default_setup().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

I guess you checked that nothing in the S3AN init was relying on things
done in the default_setup() implementation.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 17e6c96f9f9a..5e16f293a83b 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2718,7 +2718,8 @@ static int spi_nor_check(struct spi_nor *nor)
>  	return 0;
>  }
>  
> -static int s3an_nor_scan(struct spi_nor *nor)
> +static int s3an_nor_setup(struct spi_nor *nor,
> +			  const struct spi_nor_hwcaps *hwcaps)
>  {
>  	int ret;
>  
> @@ -4546,6 +4547,11 @@ static void spansion_post_sfdp_fixups(struct spi_nor *nor)
>  	nor->mtd.erasesize = nor->info->sector_size;
>  }
>  
> +static void s3an_post_sfdp_fixups(struct spi_nor *nor)
> +{
> +	nor->params.setup = s3an_nor_setup;
> +}
> +
>  /**
>   * spi_nor_post_sfdp_fixups() - Updates the flash's parameters and settings
>   * after SFDP has been parsed (is also called for SPI NORs that do not
> @@ -4567,6 +4573,9 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
>  		break;
>  	}
>  
> +	if (nor->info->flags & SPI_S3AN)
> +		s3an_post_sfdp_fixups(nor);
> +
>  	if (nor->info->fixups && nor->info->fixups->post_sfdp)
>  		nor->info->fixups->post_sfdp(nor);
>  }
> @@ -4932,12 +4941,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		return -EINVAL;
>  	}
>  
> -	if (info->flags & SPI_S3AN) {
> -		ret = s3an_nor_scan(nor);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/* Send all the required SPI flash commands to initialize device */
>  	ret = spi_nor_init(nor);
>  	if (ret)

