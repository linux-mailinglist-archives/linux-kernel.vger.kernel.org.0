Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC31181F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgCKRfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 13:35:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32856 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbgCKRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:35:23 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 79F2C293DC6;
        Wed, 11 Mar 2020 17:35:21 +0000 (GMT)
Date:   Wed, 11 Mar 2020 18:35:17 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH v6 0/6] Add new series Micron SPI NAND devices
Message-ID: <20200311183517.054cc300@collabora.com>
In-Reply-To: <MN2PR08MB6397BAEC050EF2C1A9CE8CDAB8FC0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
        <20200311164932.23cc7a42@xps13>
        <MN2PR08MB6397BAEC050EF2C1A9CE8CDAB8FC0@MN2PR08MB6397.namprd08.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 17:33:41 +0000
"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:

> Hi Miquel,
> 
> > 
> > Hi Shiva,
> > 
> > shiva.linuxworks@gmail.com wrote on Mon,  9 Mar 2020 12:52:24 +0100:
> >   
> > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > >
> > > This patchset is for the new series of Micron SPI NAND devices, and the
> > > following links are their datasheets.
> > >
> > > M78A:
> > > [1] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m78a_1gb_3v_nand_spi.pdf  
> > > [2] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m78a_1gb_1_8v_nand_spi.pdf  
> > >
> > > M79A:
> > > [3] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf  
> > > [4] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf  
> > >
> > > M70A:
> > > [5] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf  
> > > [6] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf  
> > > [7] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf  
> > > [8] https://www.micron.com/~/media/documents/products/data-  
> > sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf  
> > >
> > > Changes since v5:
> > > -----------------
> > >
> > > 1. Rebased series to v5.6-rc1.  
> > 
> > I am very sorry but actually I had issues applying all your patches not
> > because they were not based on v5.6-rc1, but because since then I
> > applied a patch changing the detection that changed the content of a
> > lot of structures (including in Micron's patches).
> > 
> > Can you please rebase again on top of the current nand/next? I am very
> > sorry for this extra work, this is my mistake.
> > 
> > Head should be:
> > 
> > 	a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu
> > for dma transfers")
> > 
> > And the culprit commit is:
> > 
> > 	f1541773af49 ("mtd: spinand: rework detect procedure for different
> > READ_ID operation")  
> 
> 
> I will rebase and send the patches.
> Meanwhile, there will be small code change because of the READ_ID patch.
> 
> Do I need to drop Reviewed-by from Boris?

Nope, you can keep it.
