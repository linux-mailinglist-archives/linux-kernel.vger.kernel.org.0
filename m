Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75B5EB693
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfJaSCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 14:02:45 -0400
Received: from foss.arm.com ([217.140.110.172]:53472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaSCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:02:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8783A1FB;
        Thu, 31 Oct 2019 11:02:44 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86E343F6C4;
        Thu, 31 Oct 2019 11:02:42 -0700 (PDT)
Date:   Thu, 31 Oct 2019 18:02:40 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, wahrenst@gmx.net, marc.zyngier@arm.com,
        will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mm@kvack.org,
        mbrugger@suse.com, Qian Cai <cai@lca.pw>,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        Robin Murphy <Robin.Murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v6 3/4] arm64: use both ZONE_DMA and ZONE_DMA32
Message-ID: <20191031180240.GH39590@arrakis.emea.arm.com>
References: <6703f8dab4a21fe4e1049f8f224502e1733bf72c.camel@suse.de>
 <A1A8EEF0-2273-4338-B4D8-D9B1328484B4@lca.pw>
 <9208de061fe2b9ee7b74206b3cd52cc116e43ac0.camel@suse.de>
 <AA6D37F1-A1B3-4EC4-8620-007095168BC7@lca.pw>
 <1956a2c8f4911b2a7e2ba3c53506c0f06efb93f8.camel@suse.de>
 <20191031155145.GF39590@arrakis.emea.arm.com>
 <6fd539b82cbbb2ae307a67a76eb4c2ead0bd5d4a.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fd539b82cbbb2ae307a67a76eb4c2ead0bd5d4a.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 05:04:34PM +0100, Nicolas Saenz Julienne wrote:
> On Thu, 2019-10-31 at 15:51 +0000, Catalin Marinas wrote:
> > (sorry, I've been away last week and only now caught up with emails)
> > 
> > On Tue, Oct 22, 2019 at 01:23:32PM +0200, Nicolas Saenz Julienne wrote:
> > > On Mon, 2019-10-21 at 16:36 -0400, Qian Cai wrote:
> > > > I managed to get more information here,
> > > > 
> > > > [    0.000000] cma: dma_contiguous_reserve(limit c0000000)
> > > > [    0.000000] cma: dma_contiguous_reserve: reserving 64 MiB for global
> > > > area
> > > > [    0.000000] cma: cma_declare_contiguous(size 0x0000000004000000, base
> > > > 0x0000000000000000, limit 0x00000000c0000000 alignment 0x0000000000000000)
> > > > [    0.000000] cma: Failed to reserve 512 MiB
> > > > 
> > > > Full dmesg:
> > > > 
> > > > https://cailca.github.io/files/dmesg.txt
> > > 
> > > OK I got it, reproduced it too.
> > > 
> > > Here are the relevant logs:
> > > 
> > > 	[    0.000000]   DMA      [mem 0x00000000802f0000-0x00000000bfffffff]
> > > 	[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
> > > 	[    0.000000]   Normal   [mem 0x0000000100000000-0x00000097fcffffff]
> > > 
> > > As you can see ZONE_DMA spans from 0x00000000802f0000-0x00000000bfffffff
> > > which
> > > is slightly smaller than 1GB.
> > > 
> > > 	[    0.000000] crashkernel reserved: 0x000000009fe00000 -
> > > 0x00000000bfe00000 (512 MB)
> > > 
> > > Here crashkernel reserved 512M in ZONE_DMA.
> > > 
> > > 	[    0.000000] cma: Failed to reserve 512 MiB
> > > 
> > > CMA tried to allocate 512M in ZONE_DMA which fails as there is no enough
> > > space.
> > > Makes sense.
> > > 
> > > A fix could be moving crashkernel reservations after CMA and then if unable
> > > to
> > > fit in ZONE_DMA try ZONE_DMA32 before bailing out. Maybe it's a little over
> > > the
> > > top, yet although most devices will be fine with ZONE_DMA32, the RPi4 needs
> > > crashkernel to be reserved in ZONE_DMA.
> > 
> > Does RPi4 need CMA in ZONE_DMA? If not, I'd rather reserve the CMA from
> > ZONE_DMA32.
> 
> Yes, CMA is imperatively to be reserved in ZONE_DMA.
> 
> > Even if you moved the crash kernel, someone else might complain that
> > they had 2GB of CMA and it no longer works.
> 
> I have yet to look into it, but I've been told that on x86/x64 they have a
> 'high' flag to be set alongside with crashkernel that forces the allocation
> into ZONE_DMA32. We could mimic this behavior for big servers that don't depend
> on ZONE_DMA but need to reserve big chunks of memory.

The 'high' flag actually talks about crashkernel reserved above 4G which
is not really the case here. Since RPi4 is the odd one out, I'd rather
have the default crashkernel and CMA in the ZONE_DMA32 (current mainline
behaviour) and have the RPi4 use explicit size@offset parameters for
crashkernel and cma.

-- 
Catalin
