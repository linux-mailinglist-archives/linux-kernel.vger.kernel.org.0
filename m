Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5DD1624E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgBRKrz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Feb 2020 05:47:55 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39791 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgBRKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:47:54 -0500
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0F8B8100003;
        Tue, 18 Feb 2020 10:47:51 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:47:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mtd: rawnand: cadence: change bad block marker size
Message-ID: <20200218114751.70efa015@xps13>
In-Reply-To: <1581328530-29966-3-git-send-email-piotrs@cadence.com>
References: <1581328530-29966-1-git-send-email-piotrs@cadence.com>
        <1581328530-29966-3-git-send-email-piotrs@cadence.com>
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

Piotr Sroka <piotrs@cadence.com> wrote on Mon, 10 Feb 2020 10:55:27
+0100:

> Increase bad block marker size from one byte to two bytes.
> Bad block marker is handled by skip bytes feature of HPNFC.
> Controller excpects this value to be an even number.

             expects

Do we break existing users with this change? Do you know how the
controller behaved until now?

Also needs a Fixes/stable tag I guess?

> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  drivers/mtd/nand/raw/cadence-nand-controller.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
> index 2ebfd0934739..5c1bbb05ab51 100644
> --- a/drivers/mtd/nand/raw/cadence-nand-controller.c
> +++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
> @@ -2612,12 +2612,9 @@ int cadence_nand_attach_chip(struct nand_chip *chip)
>  	chip->options |= NAND_NO_SUBPAGE_WRITE;
>  
>  	cdns_chip->bbm_offs = chip->badblockpos;
> -	if (chip->options & NAND_BUSWIDTH_16) {
> -		cdns_chip->bbm_offs &= ~0x01;
> -		cdns_chip->bbm_len = 2;
> -	} else {
> -		cdns_chip->bbm_len = 1;
> -	}
> +	cdns_chip->bbm_offs &= ~0x01;
> +	/* this value should be even number */
> +	cdns_chip->bbm_len = 2;
>  
>  	ret = nand_ecc_choose_conf(chip,
>  				   &cdns_ctrl->ecc_caps,

Thanks,
Miquèl
