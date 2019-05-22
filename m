Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F244F271BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 23:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfEVVhL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 May 2019 17:37:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfEVVhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:37:10 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A0C6F283655;
        Wed, 22 May 2019 22:37:08 +0100 (BST)
Date:   Wed, 22 May 2019 23:37:05 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <20190522233705.234d75d5@collabora.com>
In-Reply-To: <20190522180446.GA30082@embeddedor>
References: <20190522180446.GA30082@embeddedor>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 13:04:46 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> NOTICE THAT:
> 
> "...we don't know whether we need fallthroughs or breaks there and this
> is just a change to avoid having new warnings when switching to
> -Wimplicit-fallthrough but this change might be entirely wrong."[1]
> 
> See the original thread of discussion here:
> 
> https://lore.kernel.org/patchwork/patch/1036251/
> 
> So, in preparation to enabling -Wimplicit-fallthrough, this patch silences
> the following warnings:
> 
> drivers/mtd/nand/onenand/onenand_base.c: In function ‘onenand_check_features’:
> drivers/mtd/nand/onenand/onenand_base.c:3264:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (ONENAND_IS_DDP(this))
>       ^
> drivers/mtd/nand/onenand/onenand_base.c:3284:2: note: here
>   case ONENAND_DEVICE_DENSITY_2Gb:
>   ^~~~
> drivers/mtd/nand/onenand/onenand_base.c:3288:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    this->options |= ONENAND_HAS_UNLOCK_ALL;
> drivers/mtd/nand/onenand/onenand_base.c:3290:2: note: here
>   case ONENAND_DEVICE_DENSITY_1Gb:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> [1] https://lore.kernel.org/lkml/20190509085318.34a9d4be@xps13/
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mtd/nand/onenand/onenand_base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index f41d76248550..6cf4df9f8c01 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
>  			if ((this->version_id & 0xf) == 0xe)
>  				this->options |= ONENAND_HAS_NOP_1;
>  		}
> +		/* Fall through - ? */

So, the only thing that you'll re-use by falling through the next case
is the '->options |= ONENAND_HAS_UNLOCK_ALL' operation. I find it easier
to follow with an explicit copy of this line + a break.

>  
>  	case ONENAND_DEVICE_DENSITY_2Gb:
>  		/* 2Gb DDP does not have 2 plane */
>  		if (!ONENAND_IS_DDP(this))
>  			this->options |= ONENAND_HAS_2PLANE;
>  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> +		/* Fall through - ? */

This fall through certainly doesn't make sense, as the only thing that
might be done in the 1Gb case is conditionally adding the
HAS_UNLOCK_ALL flag, and this flag is already unconditionally set.
Please add a break here.

>  
>  	case ONENAND_DEVICE_DENSITY_1Gb:
>  		/* A-Die has all block unlock */

