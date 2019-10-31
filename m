Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7EEAE39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfJaLCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 07:02:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46784 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfJaLCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:02:10 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 18CD8290601;
        Thu, 31 Oct 2019 11:02:07 +0000 (GMT)
Date:   Thu, 31 Oct 2019 12:02:04 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 12/32] mtd: spi-nor: Void return type for
 spi_nor_clear_sr/fsr()
Message-ID: <20191031120204.5bd60bde@collabora.com>
In-Reply-To: <20191029111615.3706-13-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-13-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:17:07 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> spi_nor_clear_sr() and spi_nor_clear_fsr() are called just in case
> of errors. The callers didn't check their return value, make them
> of type void.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 4a1ecf452a39..e5ed9012cd50 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -654,7 +654,7 @@ static int s3an_sr_ready(struct spi_nor *nor)
>  	return !!(nor->bouncebuf[0] & XSR_RDY);
>  }
>  
> -static int spi_nor_clear_sr(struct spi_nor *nor)
> +static void spi_nor_clear_sr(struct spi_nor *nor)
>  {
>  	if (nor->spimem) {
>  		struct spi_mem_op op =
> @@ -690,7 +690,7 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
>  	return !(nor->bouncebuf[0] & SR_WIP);
>  }
>  
> -static int spi_nor_clear_fsr(struct spi_nor *nor)
> +static void spi_nor_clear_fsr(struct spi_nor *nor)
>  {
>  	if (nor->spimem) {
>  		struct spi_mem_op op =

