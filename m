Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8F19B7EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 23:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgDAVwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 17:52:54 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:58472 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:52:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 825C18030886;
        Wed,  1 Apr 2020 21:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GdA5Bpm0qipx; Thu,  2 Apr 2020 00:52:47 +0300 (MSK)
Date:   Thu, 2 Apr 2020 00:52:58 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache
 drivers
Message-ID: <20200401215258.jnemcpeac5wf3hyu@ubsrv2.baikal.int>
References: <20200306130731.938808030702@mail.baikalelectronics.ru>
 <20200306153246.9373B80307C4@mail.baikalelectronics.ru>
 <20200401150612.addu2gzahrarpgep@ubsrv2.baikal.int>
 <CAK8P3a0+3xqLa9-Xsu-WWd5XZZ=4mPzwHhOmGSc9y9W=92L9Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0+3xqLa9-Xsu-WWd5XZZ=4mPzwHhOmGSc9y9W=92L9Uw@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:10:20PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 1, 2020 at 5:06 PM Sergey Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> > On Fri, Mar 06, 2020 at 04:19:47PM +0100, Arnd Bergmann wrote:
> > > On Fri, Mar 6, 2020 at 2:07 PM <Sergey.Semin@baikalelectronics.ru> wrote:
> > > >
> > > > From: Serge Semin <fancer.lancer@gmail.com>
> > > >
> > > > Aside from PCIe/SATA/DDR/I2C/CPU-reboot specific settings the Baikal-T1
> > > > system controller provides three vendor-specific blocks. In particular
> > > > there are two Errors Handler Blocks to detect and report an info regarding
> > > > any problems discovered on the AXI and APB buses. These are the main buses
> > > > utilized by the SoC devices to interact with each other. In addition there
> > > > is a way to tune the MIPS P5600 CM2 L2-cache up by setting the Tag/Data/WS
> > > > L2-to-RAM latencies. All of this functionality is implemented in the
> > > > APB/AXI EHB and L2-cache control block drivers to be a part of the kernel soc
> > > > subsystem (as being specific to the Baikal-T1 SoC) and introduced in the
> > > > framework of this patchset.
> > > >
> > > > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > > > commit 98d54f81e36b ("Linux 5.6-rc4").
> > >
> > > I have no objection to the drivers, but I wonder if these should be
> > > in drivers/bus and drivers/memory instead of drivers/soc, which have
> > > similar drivers already. The driver for the L2 cache is not really a
> > > memory controller driver, but it may be close enough, and we
> > > already have a couple of different things in there.
> > >
> 
> > Regarding l2 driver. Do you really think that L2 cache should be in
> > drivers/memory? First there is no any cache-related drivers in that
> > subsystem (at least I couldn't find any). Second the Baikal-T1
> > L2-cache-RAM config block has just indirect connection with RAM.
> > The block just tunes the L2-cache<->RAM stall clock cycles up on
> > WS/Tag/Data RAM IO-operations. This config seems more SoC-specific,
> > than memory-like. Do you think that the driver should still be in
> > drivers/memory?
> 
> Either way could work, and both locations are a bit of a dumping
> ground for different kinds of drivers. My preference would be
> drivers/memory, but if anyone has a strong opinion the other way,
> drivers/soc would be acceptable as well.
> 
> > On the other hand the block is part of the System Controller. I could
> > just embed the l2-cache driver functionality into the System Controller
> > MFD driver. Though honestly IMHO the functionality should live in
> > a dedicated driver and drivers/soc is a better place for it. I also have
> > doubts this part will be well accepted by Lee (drivers/mfd maintainer).
> >
> > So what do you think?
> 
> If you make it a combined driver with the system controller,
> drivers/soc would be the most logical place. drivers/mfd should
> only be used for a multiplexer with child drivers doing the
> actual functionality.
> 
>         Arnd

I see. Thanks for the comment. I'll move the l2-cache driver to the
drivers/memory then and send a new patchset referring to this discussion
when it's ready. I'll make sure it'll be Cc'ed to you too.

Regards,
-Sergey
