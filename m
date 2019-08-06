Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C91382AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 07:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfHFF3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 01:29:54 -0400
Received: from verein.lst.de ([213.95.11.211]:53166 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfHFF3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:29:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 233B468B05; Tue,  6 Aug 2019 07:29:50 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:29:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] ALSA: pcm: use dma_can_mmap() to check if a device
 supports dma_mmap_*
Message-ID: <20190806052949.GC13409@lst.de>
References: <20190805091159.7826-1-hch@lst.de> <20190805091159.7826-5-hch@lst.de> <s5hzhkonf0k.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzhkonf0k.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:22:03AM +0200, Takashi Iwai wrote:
> This won't work as expected, unfortunately.  It's a bit tricky check,
> since the driver may have its own mmap implementation via
> substream->ops->mmap, and the dma_buffer.dev.dev might point to
> another object depending on the dma_buffer.dev.type.
> 
> So please replace with something like below:

From my gut feeling I'd reorder it a bit to make it more clear like
this:

http://git.infradead.org/users/hch/misc.git/commitdiff/958fccf54d00c16740522f818d23f9350498e911

if this is fine it'll be in the next version, waiting for a little more
feedback on the other patches.
