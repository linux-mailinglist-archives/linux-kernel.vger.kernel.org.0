Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3EC1360FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgAITVP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jan 2020 14:21:15 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52347 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgAITVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:21:15 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 34A87E0002;
        Thu,  9 Jan 2020 19:21:11 +0000 (UTC)
Date:   Thu, 9 Jan 2020 20:21:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Piotr Sroka <piotrs@cadence.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: cadence: fix address space mixup
Message-ID: <20200109202110.2af111dc@xps13>
In-Reply-To: <20191210200014.949529-1-arnd@arndb.de>
References: <20191210200014.949529-1-arnd@arndb.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Tue, 10 Dec 2019 20:59:55 +0100:

> dma_addr_t and pointers can are not interchangeable, and can
> be different sizes:
> 
> drivers/mtd/nand/raw/cadence-nand-controller.c: In function 'cadence_nand_cdma_transfer':
> drivers/mtd/nand/raw/cadence-nand-controller.c:1283:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>             (void *)dma_buf, (void *)dma_ctrl_dat,
>             ^
> drivers/mtd/nand/raw/cadence-nand-controller.c:1283:29: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>             (void *)dma_buf, (void *)dma_ctrl_dat,
>                              ^
> 
> Use dma_addr_t consistently here, which cleans up a couple of casts
> as a side-effect.
> 
> Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I just realized that I received three patches for the same issue in a
very tight timeframe about a month ago, yours was of course entirely
valid but I choose to apply the one from someone not contributing a lot
to encourage him, hope you don't mind :)


Cheers,
Miquèl
