Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E9719F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfGWOIV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Jul 2019 10:08:21 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37081 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfGWOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:08:21 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C74AC100010;
        Tue, 23 Jul 2019 14:08:18 +0000 (UTC)
Date:   Tue, 23 Jul 2019 16:08:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Add of_node_put()
 before return
Message-ID: <20190723160818.2bf7eb80@xps13>
In-Reply-To: <20190723105108.8306-1-nishkadg.linux@gmail.com>
References: <20190723105108.8306-1-nishkadg.linux@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishka,

Nishka Dasgupta <nishkadg.linux@gmail.com> wrote on Tue, 23 Jul 2019
16:21:08 +0530:

> Each iteration of for_each_available_child_of_node puts the previous
> node, but in the case of a return from the middle of the loop, there is
> no put, thus causing a memory leak. Hence add an of_node_put before the
> return in two places.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> index 8812a104c233..0ebac46435bd 100644
> --- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> @@ -277,13 +277,17 @@ static int mvebu_a3700_comphy_probe(struct platform_device *pdev)
>  		}
>  
>  		lane = devm_kzalloc(&pdev->dev, sizeof(*lane), GFP_KERNEL);
> -		if (!lane)
> +		if (!lane) {
> +			of_node_put(child);
>  			return -ENOMEM;
> +		}
>  
>  		phy = devm_phy_create(&pdev->dev, child,
>  				      &mvebu_a3700_comphy_ops);
> -		if (IS_ERR(phy))
> +		if (IS_ERR(phy)) {
> +			of_node_put(child);
>  			return PTR_ERR(phy);
> +		}
>  
>  		lane->dev = &pdev->dev;
>  		lane->mode = PHY_MODE_INVALID;

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
