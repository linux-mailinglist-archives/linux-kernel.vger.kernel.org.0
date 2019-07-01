Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53DD2CA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfE1Pqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 11:46:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5115 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726243AbfE1Pqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:46:50 -0400
X-UUID: 8dfb5a0ce4274b74b434e317d5e50b7d-20190528
X-UUID: 8dfb5a0ce4274b74b434e317d5e50b7d-20190528
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1322292173; Tue, 28 May 2019 23:46:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 28 May 2019 23:46:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 28 May 2019 23:46:45 +0800
Message-ID: <1559058405.26151.6.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: mm: make CONFIG_ZONE_DMA32 configurable
From:   Miles Chen <miles.chen@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Tue, 28 May 2019 23:46:45 +0800
In-Reply-To: <814b9bd0-38de-4b8d-92b3-d663931d90bf@arm.com>
References: <1558973315-19655-1-git-send-email-miles.chen@mediatek.com>
         <814b9bd0-38de-4b8d-92b3-d663931d90bf@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 11:43 +0100, Robin Murphy wrote:
> On 27/05/2019 17:08, Miles Chen wrote:
> > This change makes CONFIG_ZONE_DMA32 defuly y and allows users
> > to overwrite it.
> > 
> > For the SoCs that do not need CONFIG_ZONE_DMA32, this is the
> > first step to manage all available memory by a single
> > zone(normal zone) to reduce the overhead of multiple zones.
> > 
> > The change also fixes a build error when CONFIG_NUMA=y and
> > CONFIG_ZONE_DMA32=n.
> > 
> > arch/arm64/mm/init.c:195:17: error: use of undeclared identifier 'ZONE_DMA32'
> >                  max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
> > 
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >   arch/arm64/Kconfig   | 3 ++-
> >   arch/arm64/mm/init.c | 2 ++
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 76f6e4765f49..9d20a736d1d1 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -260,7 +260,8 @@ config GENERIC_CALIBRATE_DELAY
> >   	def_bool y
> >   
> >   config ZONE_DMA32
> > -	def_bool y
> > +	bool "Support DMA32 zone"
> 
> This probably warrants an "if EMBEDDED" or "if EXPERT", since turning it 
> off produces a kernel which won't work at all on certain systems (I've 
> played around with this before...)

Thanks for your comment. 
I'll put a "if EXPERT"  here to avoid this case.

> 
> > +	default y
> >   
> >   config HAVE_GENERIC_GUP
> >   	def_bool y
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index d2adffb81b5d..96829ce21f99 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -191,8 +191,10 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> >   {
> >   	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> >   
> > +#ifdef CONFIG_ZONE_DMA32
> >   	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> 
> There's no point keeping the IS_ENABLED() check when it's entirely 
> redundant with the #ifdefs.

I'll remove the IS_ENABLE() code in next patch.

-Miles
> 
> Robin.
> 
> >   		max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
> > +#endif
> >   	max_zone_pfns[ZONE_NORMAL] = max;
> >   
> >   	free_area_init_nodes(max_zone_pfns);
> > 


