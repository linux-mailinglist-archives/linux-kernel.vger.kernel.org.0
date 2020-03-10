Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7183D18082B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCJTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 15:33:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49928 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:33:15 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 88B7C28A3AF;
        Tue, 10 Mar 2020 19:33:13 +0000 (GMT)
Date:   Tue, 10 Mar 2020 20:33:10 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, allison@lohutok.net,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        rfontana@redhat.com, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v3 3/4] mtd: rawnand: Add support manufacturer specific
 suspend/resume operation
Message-ID: <20200310203310.5fe74c57@collabora.com>
In-Reply-To: <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 15:21:23 +0800
Mason Yang <masonccyang@mxic.com.tw> wrote:

> Patch nand_suspend() & nand_resume() for manufacturer specific
> suspend/resume operation.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 11 ++++++++---
>  include/linux/mtd/rawnand.h      |  4 ++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 769be81..b44e460 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4327,7 +4327,9 @@ static int nand_suspend(struct mtd_info *mtd)
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  
>  	mutex_lock(&chip->lock);
> -	chip->suspended = 1;
> +	if (chip->_suspend)
> +		if (!chip->_suspend(chip))
> +			chip->suspended = 1;
>  	mutex_unlock(&chip->lock);
>  
>  	return 0;
> @@ -4342,11 +4344,14 @@ static void nand_resume(struct mtd_info *mtd)
>  	struct nand_chip *chip = mtd_to_nand(mtd);
>  
>  	mutex_lock(&chip->lock);
> -	if (chip->suspended)
> +	if (chip->suspended) {
> +		if (chip->_resume)
> +			chip->_resume(chip);
>  		chip->suspended = 0;
> -	else
> +	} else {
>  		pr_err("%s called for a chip which is not in suspended state\n",
>  			__func__);
> +	}
>  	mutex_unlock(&chip->lock);
>  }
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index bc2fa3c..c0055ed 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1064,6 +1064,8 @@ struct nand_legacy {
>   * @lock:		lock protecting the suspended field. Also used to
>   *			serialize accesses to the NAND device.
>   * @suspended:		set to 1 when the device is suspended, 0 when it's not.
> + * @_suspend:		[REPLACEABLE] specific NAND device suspend operation
> + * @_resume:		[REPLACEABLE] specific NAND device resume operation
>   * @bbt:		[INTERN] bad block table pointer
>   * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
>   *			lookup.
> @@ -1119,6 +1121,8 @@ struct nand_chip {
>  
>  	struct mutex lock;
>  	unsigned int suspended : 1;
> +	int (*_suspend)(struct nand_chip *chip);
> +	void (*_resume)(struct nand_chip *chip);

I thought we agreed on not prefixing new hooks with _ ?

>  
>  	uint8_t *oob_poi;
>  	struct nand_controller *controller;

