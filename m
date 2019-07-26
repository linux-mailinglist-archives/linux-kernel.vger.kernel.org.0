Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3563C75F11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 08:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfGZGa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 02:30:29 -0400
Received: from verein.lst.de ([213.95.11.211]:41842 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfGZGa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:30:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CEB8F227A81; Fri, 26 Jul 2019 08:30:25 +0200 (CEST)
Date:   Fri, 26 Jul 2019 08:30:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dma-contiguous: page-align the size in
 dma_free_contiguous()
Message-ID: <20190726063025.GF22881@lst.de>
References: <20190725233959.15129-1-nicoleotsuka@gmail.com> <20190725233959.15129-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725233959.15129-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 04:39:59PM -0700, Nicolin Chen wrote:
> According to the original dma_direct_alloc_pages() code:
> {
> 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> 
> 	if (!dma_release_from_contiguous(dev, page, count))
> 		__free_pages(page, get_order(size));
> }
> 
> The count parameter for dma_release_from_contiguous() was page
> aligned before the right-shifting operation, while the new API
> dma_free_contiguous() forgets to have PAGE_ALIGN() at the size.
> 
> So this patch simply adds it to prevent any corner case.
> 
> Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
