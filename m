Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190E39A85D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbfHWHNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:13:44 -0400
Received: from shell.v3.sk ([90.176.6.54]:40112 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731093AbfHWHNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:13:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F065CD7697;
        Fri, 23 Aug 2019 09:13:39 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yGh66jtHXRfw; Fri, 23 Aug 2019 09:13:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 46C8AD7698;
        Fri, 23 Aug 2019 09:13:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9QtK_aypLOFJ; Fri, 23 Aug 2019 09:13:35 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D11F1D7697;
        Fri, 23 Aug 2019 09:13:34 +0200 (CEST)
Message-ID: <0897fa54f487f481bf8770ed516578b6f4f53380.camel@v3.sk>
Subject: Re: [PATCH v2 16/20] ARM: mmp: add SMP support
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Olof Johansson <olof@lixom.net>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Aug 2019 09:13:33 +0200
In-Reply-To: <6f9d2285-5ca4-a63a-610e-890b49a4f816@gmail.com>
References: <20190822092643.593488-1-lkundrak@v3.sk>
         <20190822092643.593488-17-lkundrak@v3.sk>
         <6f9d2285-5ca4-a63a-610e-890b49a4f816@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-22 at 09:36 -0700, Florian Fainelli wrote:
> On 8/22/19 2:26 AM, Lubomir Rintel wrote:
> > Used to bring up the second core on MMP3.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > ---
> > Changes since v1:
> > - Wrap SW_BRANCH_VIRT_ADDR with __pa_symbol()
> > 
> >  arch/arm/mach-mmp/Makefile  |  3 +++
> >  arch/arm/mach-mmp/platsmp.c | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 36 insertions(+)
> >  create mode 100644 arch/arm/mach-mmp/platsmp.c
> > 
> > diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
> > index 322c1c97dc900..7b3a7f979eece 100644
> > --- a/arch/arm/mach-mmp/Makefile
> > +++ b/arch/arm/mach-mmp/Makefile
> > @@ -22,6 +22,9 @@ ifeq ($(CONFIG_PM),y)
> >  obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
> >  obj-$(CONFIG_CPU_MMP2)		+= pm-mmp2.o
> >  endif
> > +ifeq ($(CONFIG_SMP),y)
> > +obj-$(CONFIG_MACH_MMP3_DT)	+= platsmp.o
> > +endif
> >  
> >  # board support
> >  obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
> > diff --git a/arch/arm/mach-mmp/platsmp.c b/arch/arm/mach-mmp/platsmp.c
> > new file mode 100644
> > index 0000000000000..98d5ef23623cb
> > --- /dev/null
> > +++ b/arch/arm/mach-mmp/platsmp.c
> > @@ -0,0 +1,33 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
> > + */
> > +#include <linux/io.h>
> > +#include <asm/smp_scu.h>
> > +#include <asm/smp.h>
> > +#include "addr-map.h"
> > +
> > +#define SW_BRANCH_VIRT_ADDR	CIU_REG(0x24)
> > +
> > +static int mmp3_boot_secondary(unsigned int cpu, struct task_struct *idle)
> > +{
> > +	/*
> > +	 * Apparently, the boot ROM on the second core spins on this
> > +	 * register becoming non-zero and then jumps to the address written
> > +	 * there. No IPIs involved.
> > +	 */
> > +	__raw_writel(virt_to_phys(secondary_startup),
> > +			__pa_symbol(SW_BRANCH_VIRT_ADDR));
> 
> That looks wrong, the __pa_symbol() is applicable to secondary_startup,
> while SW_BRANCH_VIRT_ADDR does not need that.

Whoops, sorry for that. Will fix in the next patch version in a few
days.

Thanks
Lubo

