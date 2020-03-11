Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED61D1811BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgCKHTb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 03:19:31 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46907 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgCKHTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:19:31 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F2B9E1BF209;
        Wed, 11 Mar 2020 07:19:18 +0000 (UTC)
Date:   Wed, 11 Mar 2020 08:19:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mtd: nand: spi: rework detect procedure for
 different read id op
Message-ID: <20200311081918.0f2c64c2@xps13>
In-Reply-To: <20200310183338.19961-1-miquel.raynal@bootlin.com>
References: <20200208074439.146296-1-gch981213@gmail.com>
        <20200310183338.19961-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhong,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Tue, 10 Mar 2020
19:33:38 +0100:

> On Sat, 2020-02-08 at 07:43:50 UTC, Chuanhong Guo wrote:
> > Currently there are 3 different variants of read_id implementation:
> > 1. opcode only. Found in GD5FxGQ4xF.
> > 2. opcode + 1 addr byte. Found in GD5GxGQ4xA/E
> > 3. opcode + 1 dummy byte. Found in other currently supported chips.
> > 
> > Original implementation was for variant 1 and let detect function
> > of chips with variant 2 and 3 to ignore the first byte. This isn't
> > robust:
> > 
> > 1. For chips of variant 2, if SPI master doesn't keep MOSI low
> > during read, chip will get a random id offset, and the entire id
> > buffer will shift by that offset, causing detect failure.
> > 
> > 2. For chips of variant 1, if it happens to get a devid that equals
> > to manufacture id of variant 2 or 3 chips, it'll get incorrectly
> > detected.
> > 
> > This patch reworks detect procedure to address problems above. New
> > logic do detection for all variants separatedly, in 1-2-3 order.
> > Since all current detect methods do exactly the same id matching
> > procedure, unify them into core.c and remove detect method from
> > manufacture_ops.
> > 
> > Tested on GD5F1GQ4UAYIG and W25N01GVZEIG.
> > 
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

I also changed the prefix to "mtd: spinand:".

Thanks,
Miquèl
