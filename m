Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024BB5682C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfFZMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 08:04:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36428 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:04:23 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A70A2289366;
        Wed, 26 Jun 2019 13:04:20 +0100 (BST)
Date:   Wed, 26 Jun 2019 14:04:17 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over
 write driver's read_page()/write_page()
Message-ID: <20190626140417.440cf762@collabora.com>
In-Reply-To: <DM6PR02MB4779D347620E88BDB943DEB4AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
        <20190626084807.3f06e718@collabora.com>
        <DM6PR02MB47796E3306C166A91E0BAE91AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
        <20190626132715.6128d8b1@collabora.com>
        <DM6PR02MB4779D347620E88BDB943DEB4AFE20@DM6PR02MB4779.namprd02.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 11:51:12 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Sent: Wednesday, June 26, 2019 4:57 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de; richard@nod.at;
> > dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com;
> > vigneshr@ti.com; bbrezillon@kernel.org; yamada.masahiro@socionext.com; linux-
> > mtd@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over write
> > driver's read_page()/write_page()
> > 
> > On Wed, 26 Jun 2019 11:22:33 +0000
> > Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> >   
> > > Hi Boris,
> > >  
> > > > -----Original Message-----
> > > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Sent: Wednesday, June 26, 2019 12:18 PM
> > > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > > richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> > > > marek.vasut@gmail.com; vigneshr@ti.com; bbrezillon@kernel.org;
> > > > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not
> > > > over write driver's read_page()/write_page()
> > > >
> > > > On Mon, 24 Jun 2019 22:46:29 -0600
> > > > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> > > >  
> > > > > Add check before assigning chip->ecc.read_page() and
> > > > > chip->ecc.write_page()
> > > > >
> > > > > Signed-off-by: Naga Sureshkumar Relli
> > > > > <naga.sureshkumar.relli@xilinx.com>
> > > > > ---
> > > > >  drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
> > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mtd/nand/raw/nand_micron.c
> > > > > b/drivers/mtd/nand/raw/nand_micron.c
> > > > > index cbd4f09ac178..565f2696c747 100644
> > > > > --- a/drivers/mtd/nand/raw/nand_micron.c
> > > > > +++ b/drivers/mtd/nand/raw/nand_micron.c
> > > > > @@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *chip)
> > > > >  		chip->ecc.size = 512;
> > > > >  		chip->ecc.strength = chip->base.eccreq.strength;
> > > > >  		chip->ecc.algo = NAND_ECC_BCH;
> > > > > -		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> > > > > -		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
> > > > > +		if (!chip->ecc.read_page)
> > > > > +			chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
> > > > > +
> > > > > +		if (!chip->ecc.write_page)
> > > > > +			chip->ecc.write_page = micron_nand_write_page_on_die_ecc;  
> > > >
> > > > That's wrong, if you don't want on-die ECC to be used, simply don't
> > > > set nand-ecc-mode to "on- die".  
> > > Ok. But if we want to use on-die ECC then you mean to say it is mandatory to use  
> > micron_nand_read/write_page_on_die_ecc()?
> > 
> > Absolutely, and if it doesn't work that means you driver does not
> > implement raw accesses correctly, which means it's still buggy...  
> I agree. But let's say, if there is a limitation with the controller. Then it is must to have this check right?
> I mean, for pl353 controller, we must clear the CS during the data phase, hence we are splitting the 
> Transfer in the pl353_read/write_page_raw().
> +	pl353_nand_read_data_op(chip, buf, mtd->writesize, false);
> +	p = chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	xnfc->dataphase_addrflags |= PL353_NAND_CLEAR_CS;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> As the above sequence is needed even for raw access, PL353 is unable to use the on_die_page reads.

This "de-assert CS on last access" logic should be done in the
exec_op() implementation. I also wonder how that works for operations
that don't have data cycles. Oh, BTW, most chips are CE-don't-care,
which means you can assert/de-assert CS on each read_data_op() without
any issues.
