Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E0658752
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfF0Qkx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jun 2019 12:40:53 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55849 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0Qkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:40:53 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 15D332000E;
        Thu, 27 Jun 2019 16:40:48 +0000 (UTC)
Date:   Thu, 27 Jun 2019 18:40:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: ingenic: fix ingenic_ecc dependency
Message-ID: <20190627184047.6faa058a@xps13>
In-Reply-To: <20190617141659.376c0271@xps13>
References: <20190617111110.2103786-1-arnd@arndb.de>
        <1560770644.1774.0@crapouillou.net>
        <CAK8P3a28NrvLP1nE7TQUCqwYXVwrSnVUJoH0yTSqRpz93f4g2Q@mail.gmail.com>
        <20190617141659.376c0271@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Mon, 17 Jun 2019
14:16:59 +0200:

> Hello,
> 
> Arnd Bergmann <arnd@arndb.de> wrote on Mon, 17 Jun 2019 14:12:48 +0200:
> 
> > On Mon, Jun 17, 2019 at 1:24 PM Paul Cercueil <paul@crapouillou.net> wrote:
> >   
> > > I think there's a better way to fix it, only in Kconfig.
> > >
> > > * Add a bool symbol MTD_NAND_INGENIC_USE_HW_ECC
> > > * Have the three ECC/BCH drivers select this symbol instead of
> > >   MTD_NAND_INGENIC_ECC
> > > * Add the following to the MTD_NAND_JZ4780 config option:
> > >   "select MTD_NAND_INGENIC_ECC if MTD_NAND_INGENIC_USE_HW_ECC"    
> > 
> > I don't see much difference to my approach here, but if you want
> > to submit that version with 'Reported-by: Arnd Bergmann <arnd@arndb.de>',
> > please do so.
> > 
> > Yet another option would be to use Makefile code to link both
> > files into one module, and remove the EXPORT_SYMBOL statements:
> > 
> > obj-$(CONFIG_MTD_NAND_JZ4780) += jz4780_nand.o
> > jz4780_nand-y += ingenic_nand.o
> > jz4780_nand-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o
> >   
> 
> I personally have a preference for this one.

Would you mind sending the above change? I forgot about it but I would
like to queue it for the next release. Preferably the last version Arnd
proposed.


Thanks,
Miquèl
