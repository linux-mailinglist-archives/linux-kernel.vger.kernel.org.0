Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070784C7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfFTHNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 03:13:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTHNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:13:18 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5F3D82639EC;
        Thu, 20 Jun 2019 08:13:17 +0100 (BST)
Date:   Thu, 20 Jun 2019 09:13:14 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Peter Pan <peterpandong@micron.com>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spinand: read return badly if the last page has
 bitflips
Message-ID: <20190620091314.70bc99a2@collabora.com>
In-Reply-To: <1560992416-5753-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1560992416-5753-1-git-send-email-liaoweixiong@allwinnertech.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 09:00:16 +0800
liaoweixiong <liaoweixiong@allwinnertech.com> wrote:

> In case of the last page containing bitflips (ret > 0),
> spinand_mtd_read() will return that number of bitflips for the last
> page. But to me it looks like it should instead return max_bitflips like
> it does when the last page read returns with 0.
> 
> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/nand/spi/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 556bfdb..6b9388d 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -511,12 +511,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>  		if (ret == -EBADMSG) {
>  			ecc_failed = true;
>  			mtd->ecc_stats.failed++;
> -			ret = 0;
>  		} else {
>  			mtd->ecc_stats.corrected += ret;
>  			max_bitflips = max_t(unsigned int, max_bitflips, ret);
>  		}
>  
> +		ret = 0;
>  		ops->retlen += iter.req.datalen;
>  		ops->oobretlen += iter.req.ooblen;
>  	}

