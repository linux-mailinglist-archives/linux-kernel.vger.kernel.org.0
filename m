Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9067E149637
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAYP2L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 25 Jan 2020 10:28:11 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57093 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 10:28:10 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D3627240009;
        Sat, 25 Jan 2020 15:28:04 +0000 (UTC)
Date:   Sat, 25 Jan 2020 16:28:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM
 dependency
Message-ID: <20200125162803.5a2375d7@xps13>
In-Reply-To: <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
        <20191211192742.95699-3-brendanhiggins@google.com>
        <20200109162303.35f4f0a3@xps13>
        <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

Brendan Higgins <brendanhiggins@google.com> wrote on Fri, 24 Jan 2020
18:12:12 -0800:

> On Thu, Jan 9, 2020 at 7:23 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Brendan,
> >
> > Brendan Higgins <brendanhiggins@google.com> wrote on Wed, 11 Dec 2019
> > 11:27:37 -0800:
> >  
> > > Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
> > > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > > the following build error:
> > >
> > > ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
> > > drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
> > > ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'
> > >
> > > Fix the build error by adding the unspecified dependency.
> > >
> > > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---  
> >
> > Sorry for the delay.
> >
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> It looks like my change has not been applied to nand/next; is this the
> branch it should be applied to? I have also verified that this patch
> isn't in linux-next as of Jan 24th.
> 
> Is mtd/linux the correct tree for this? Or do I need to reach out to
> someone else?

When I sent my Acked-by I supposed someone else would pick the patch,
but there is actually no dependency with all the other patches so I
don't know why I did it... Sorry about that. I'll take it anyway in my
PR for 5.6.

Thanks,
Miquèl
