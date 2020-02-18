Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC11624EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 11:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgBRKsj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Feb 2020 05:48:39 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:49425 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBRKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:48:39 -0500
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C0F8D100010;
        Tue, 18 Feb 2020 10:48:37 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:48:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mtd: rawnand: cadence: reinit complete before
 execute command
Message-ID: <20200218114837.2d5e6104@xps13>
In-Reply-To: <1581328530-29966-4-git-send-email-piotrs@cadence.com>
References: <1581328530-29966-1-git-send-email-piotrs@cadence.com>
        <1581328530-29966-4-git-send-email-piotrs@cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Piotr Sroka <piotrs@cadence.com> wrote on Mon, 10 Feb 2020 10:55:28
+0100:

> Reinitilaize complete object before executing CDMA command to make sure
> that done flag is ok.

Looks fine, besides the need for Fixes/Stable tags, what do you think?

> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  drivers/mtd/nand/raw/cadence-nand-controller.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
> index 5c1bbb05ab51..efddc5c68afb 100644
> --- a/drivers/mtd/nand/raw/cadence-nand-controller.c
> +++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
> @@ -998,6 +998,7 @@ static int cadence_nand_cdma_send(struct cdns_nand_ctrl *cdns_ctrl,
>  		return status;
>  
>  	cadence_nand_reset_irq(cdns_ctrl);
> +	reinit_completion(&cdns_ctrl->complete);
>  
>  	writel_relaxed((u32)cdns_ctrl->dma_cdma_desc,
>  		       cdns_ctrl->reg + CMD_REG2);

Thanks,
Miquèl
