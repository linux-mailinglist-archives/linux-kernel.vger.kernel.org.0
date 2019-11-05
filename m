Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88562F0596
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390772AbfKETDu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Nov 2019 14:03:50 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48345 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390514AbfKETDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:03:50 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4E88320004;
        Tue,  5 Nov 2019 19:03:46 +0000 (UTC)
Date:   Tue, 5 Nov 2019 20:03:44 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
Message-ID: <20191105200344.1e8c3eab@xps13>
In-Reply-To: <20191021193343.41320-1-kdasu.kdev@gmail.com>
References: <20191021193343.41320-1-kdasu.kdev@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Richard, something to look into below :)

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Mon, 21 Oct 2019 15:32:52
-0400:

> Check mtd panic write flag and set the mtd partition panic
> write flag so that low level drivers can use it to take
> required action to ensure oops data gets written to assigned
> mtd partition.

I feel there is something wrong with the current implementation
regarding partitions but I am not sure this is the right fix. Is this
something you detected with some kind of static checker or did you
actually experience an issue?

In the commit log you say "check mtd (I suppose you mean the
master) panic write flag and set the mtd partition panic write flag"
which makes sense, but in reality my understanding is that you do the
opposite: you check mtd->oops_panic_write which is the partitions'
structure, and set part->parent->oops_panic_write which is the master's
flag.

Also, I am not sure if it is worth checking anything, why not just set
mtd->oops_panic_write in this function?

Same comment for the -already existing- condition in mtd_panic_write.
As soon as we are in these functions, we know there is a panic, right?
So why checking if the bit is already set before forcing it?

> 
> Fixes: 9f897bfdd8 ("mtd: Add flag to indicate panic_write")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/mtdpart.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 7328c066c5ba..b4f6479abeda 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -159,6 +159,10 @@ static int part_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		size_t *retlen, const u_char *buf)
>  {
>  	struct mtd_part *part = mtd_to_part(mtd);
> +
> +	if (mtd->oops_panic_write)
> +		part->parent->oops_panic_write = true;
> +
>  	return part->parent->_panic_write(part->parent, to + part->offset, len,
>  					  retlen, buf);
>  }

Thanks,
Miquèl
