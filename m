Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB36B1368C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 09:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgAJIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 03:10:27 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:45263 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAJIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:10:27 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2998810000D;
        Fri, 10 Jan 2020 08:10:25 +0000 (UTC)
Date:   Fri, 10 Jan 2020 09:10:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: nand: spi: rework detect procedure for
 different read id op
Message-ID: <20200110091024.56918193@xps13>
In-Reply-To: <20200110090422.75988c49@collabora.com>
References: <20200110025218.1257809-1-gch981213@gmail.com>
        <20200110075859.3edfae3a@collabora.com>
        <CAJsYDVK4RtX92O3M+EOsZa5qS4TxE0OVaEq=KOnAuP6DEHvw2Q@mail.gmail.com>
        <20200110090422.75988c49@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Fri, 10 Jan
2020 09:04:22 +0100:

> On Fri, 10 Jan 2020 15:34:28 +0800
> Chuanhong Guo <gch981213@gmail.com> wrote:
> 
> > Hi!
> > 
> > On Fri, Jan 10, 2020 at 2:59 PM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:  
> > > [...]    
> > > > +     ret = spinand_read_id_op(spinand, 1, 0, id);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +     ret = spinand_manufacturer_match(spinand,
> > > > +                                      SPINAND_READID_METHOD_OPCODE_ADDR);
> > > > +     if (!ret)
> > > > +             return 0;
> > > > +
> > > > +     ret = spinand_read_id_op(spinand, 0, 1, id);    
> > >
> > > Hm, we should probably do only one of each read_id and iterate over all
> > > manufacturers/chips each time instead of doing 3 read_ids per
> > > manufacturer.    
> > 
> > This actually do the former instead of the latter. Maybe the function
> > names are a bit
> > misleading. spinand_manufacturer_match iterates over all manufacturers
> > in one call,
> > and spinand_manufacturer_detect is called once in spinand_detect.
> > Do you have suggestions on function naming?  
> 
> Maybe you can just inline the content of this function in
> spinand_detect().

Actually I found that part clear enough, I would keep it as is, out of
the spinand_detect() function as long as there is no actual reason to
merge them?
