Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64ADB1A7A0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 13:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfEKLBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 07:01:40 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:34684
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbfEKLBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 07:01:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 0821B3FE9A;
        Sat, 11 May 2019 12:55:41 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jqyj6kYSd3xh; Sat, 11 May 2019 12:55:40 +0200 (CEST)
Received: from jerusalem (host87-8-dynamic.4-87-r.retail.telecomitalia.it [87.4.8.87])
        by sysam.it (Postfix) with ESMTPSA id 6C8FF3FBE6;
        Sat, 11 May 2019 12:55:40 +0200 (CEST)
Date:   Sat, 11 May 2019 12:55:39 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire
 peripherals
Message-ID: <20190511105539.GA20920@jerusalem>
References: <20190429081937.7544-1-geert@linux-m68k.org>
 <CAK8P3a1NbjYAGCTq2RUfqEX1OgppEV5mKmBJ0t=JiFF13zSytg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1NbjYAGCTq2RUfqEX1OgppEV5mKmBJ0t=JiFF13zSytg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 29, 2019 at 02:39:47PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 29, 2019 at 10:19 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > The generic definitions of mmio_{read,write}{16,32}be() in lib/iomap.c
> > assume that the {read,write}[wl]() I/O accessors always use little
> > endian accesses, and swap the result.
> >
> > However, the Coldfire versions of the {read,write}[wl]() I/O accessors are
> > special, in that they use native big endian instead of little endian for
> > accesses to the on-SoC peripheral block, thus violating the assumption.
> >
> > Fix this by providing our own variants, using the raw accessors,
> > reinstating the old behavior.  This is fine on m68k, as no special
> > barriers are needed, and also avoids swapping data twice.
> >
> > Reported-by: Angelo Dureghello <angelo@sysam.it>
> > Fixes: aecc787c06f4300f ("iomap: Use non-raw io functions for io{read|write}XXbe")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > This can be reverted later, after this oddity of the Coldfire I/O
> > support has been fixed, and drivers have been updated.
> > ---
> >  arch/m68k/include/asm/io.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
> > index aabe6420ead2a599..d47e7384681ab1cd 100644
> > --- a/arch/m68k/include/asm/io.h
> > +++ b/arch/m68k/include/asm/io.h
> > @@ -8,6 +8,12 @@
> >  #include <asm/io_mm.h>
> >  #endif
> >
> > +#define mmio_read16be(addr)            __raw_readw(addr)
> > +#define mmio_read32be(addr)            __raw_readl(addr)
> > +
> > +#define mmio_write16be(val, port)      __raw_writew((val), (port))
> > +#define mmio_write32be(val, port)      __raw_writel((val), (port))
> > +
> >  #include <asm-generic/io.h>
> 
> This looks correct to me, but there are two points that stick out to me:
> 
> - why do you only do this for mmio and not for pio?
> - why do you even use the generic_iomap wrappers rather than
>   the trivial asm-generic versions of those functions?
> 
>        Arnd

At least i applied it and it works properly, dspi / dma drivers are
back working.

Thanks, 

Regards
Angelo
