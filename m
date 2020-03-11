Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D77181CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgCKPuO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 11:50:14 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53777 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgCKPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:50:13 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B843BE0004;
        Wed, 11 Mar 2020 15:50:11 +0000 (UTC)
Date:   Wed, 11 Mar 2020 16:50:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 0/2] mtd: spinand: toshiba: Support for new Kioxia
 Serial NAND
Message-ID: <20200311165011.63a3d82e@xps13>
In-Reply-To: <cover.1583834323.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1583834323.git.ytc-mb-yfuruyama7@kioxia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Wed, 11 Mar
2020 10:47:04 +0900:

> First patch is to rename function name becase of add new device.
> Second patch is to supprot for new device.
> 
> Yoshio Furuyama (2):
>   mtd: spinand: toshiba: Rename function name to change suffix and
>     prefix (8Gbit)
>   mtd: spinand: toshiba: Support for new Kioxia Serial NAND
> 
>  drivers/mtd/nand/spi/toshiba.c | 173 +++++++++++++++++++++++++++++++----------
>  1 file changed, 130 insertions(+), 43 deletions(-)
> 

I am very sorry but actually I had issues applying all your patches not
because they were not based on v5.6-rc1, but because since then I
applied a patch changing the detection that changed the content of a
lot of structures (including in Toshiba's driver).

Can you please rebase again on top of the current nand/next? I am very
sorry for this extra work, this is my mistake.

Head should be:

	a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")

And the culprit commit is:

	f1541773af49 ("mtd: spinand: rework detect procedure for different READ_ID operation")

Thanks,
Miquèl

