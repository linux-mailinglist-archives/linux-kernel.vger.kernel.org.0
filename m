Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945AAEADAF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfJaKoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:44:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46504 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfJaKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:44:03 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 67FEF28BC5D;
        Thu, 31 Oct 2019 10:44:02 +0000 (GMT)
Date:   Thu, 31 Oct 2019 11:43:58 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/32] mtd: spi-nor: Use dev_err() instead of
 pr_err()
Message-ID: <20191031114358.4f9016d7@collabora.com>
In-Reply-To: <20191029111615.3706-7-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-7-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:16:57 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Print identifying information about struct device.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index e801f390728c..c794eff69fe9 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -448,7 +448,7 @@ static int spi_nor_read_sr(struct spi_nor *nor)
>  	}
>  
>  	if (ret) {
> -		pr_err("error %d reading SR\n", ret);
> +		dev_err(nor->dev, "error %d reading SR\n", ret);

nor->dev is not exactly what we should use since it points to the SPI
NOR controller device in the !SPI_MEM case, and those controllers can
be attached several SPI NOR devs. Ideally we should use mtd->dev, but
that requires splitting the MTD initialization and registration steps
so mtd->dev can have a valid name before registration time.

Anyway, I guess this change is good enough for now, just mentioned the
problem in case anyone is interested working on it.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

>  		return ret;
>  	}
>  
> @@ -478,7 +478,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor)
>  	}
>  
>  	if (ret) {
> -		pr_err("error %d reading FSR\n", ret);
> +		dev_err(nor->dev, "error %d reading FSR\n", ret);
>  		return ret;
>  	}
>  

