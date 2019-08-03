Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3B805BB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 12:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbfHCKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 06:30:30 -0400
Received: from verein.lst.de ([213.95.11.211]:59810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388432AbfHCKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 06:30:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4321A227A81; Sat,  3 Aug 2019 12:30:24 +0200 (CEST)
Date:   Sat, 3 Aug 2019 12:30:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] dma-mapping: remove ARCH_NO_COHERENT_DMA_MMAP
Message-ID: <20190803103024.GA32624@lst.de>
References: <20190725063401.29904-1-hch@lst.de> <20190725063401.29904-6-hch@lst.de> <20190802070354.GA8280@lst.de> <s5hh870rn4t.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh870rn4t.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:24:02AM +0200, Takashi Iwai wrote:
> I wasn't careful enough to look at that change, sorry.
> 
> The code there tries to check whether dma_mmap_coherent() would always
> fail on some platforms.  Then the driver clears the mmap capability
> flag at the device open time and notifies user-space to fall back to
> the dumb read/write mode.
> 
> So I'm afraid that simply dropping the check would cause the behavior
> regression, e.g. on PARISC.
> 
> Is there any simple way to test whether dma_mmap_coherent() would work
> or not in general on the target platform?  It's not necessarily in an
> ifdef at all.

This isn't really a platform, but a per-device question.  I can add a
"bool dma_can_mmap(struct device *dev)" helper to check that.  But how
do I get at a suitable struct device in hw_support_mmap()?
