Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE38164460
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 13:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBSMhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 07:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgBSMhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:37:15 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5505924654;
        Wed, 19 Feb 2020 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582115834;
        bh=U+Ccu+qodZQF5R9TKwMdKiDlgQqekTrccjPfmt2hzAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxlTibBtDT5kOVybylM1mh7E9F5Fv+2NSpCsPVedk5Ge0FEuD5LqnEyP0P2bnhqKu
         KbgFaoznIVmXCPCezJXTpqcM+GuFHNPCcybbbWauQ0OoiBSmCa3I/axm41iVdGKkrt
         8mUYeKW/8PeQBEfLtNTIBAdRpLcYWAhgvm9t+/e8=
Date:   Wed, 19 Feb 2020 12:37:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Liam Mark <lmark@codeaurora.org>, Joerg Roedel <joro@8bytes.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
Message-ID: <20200219123704.GC19400@willie-the-truck>
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
 <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 04:46:14PM +0000, Robin Murphy wrote:
> On 14/02/2020 8:30 pm, Liam Mark wrote:
> > 
> > When the IOVA framework applies IOVA alignment it aligns all
> > IOVAs to the smallest PAGE_SIZE order which is greater than or
> > equal to the requested IOVA size.
> > 
> > We support use cases that requires large buffers (> 64 MB in
> > size) to be allocated and mapped in their stage 1 page tables.
> > However, with this alignment scheme we find ourselves running
> > out of IOVA space for 32 bit devices, so we are proposing this
> > config, along the similar vein as CONFIG_CMA_ALIGNMENT for CMA
> > allocations.
> 
> As per [1], I'd really like to better understand the allocation patterns
> that lead to such a sparsely-occupied address space to begin with, given
> that the rbtree allocator is supposed to try to maintain locality as far as
> possible, and the rcaches should further improve on that. Are you also
> frequently cycling intermediate-sized buffers which are smaller than 64MB
> but still too big to be cached?  Are there a lot of non-power-of-two
> allocations?

Right, information on the allocation pattern would help with this change
and also the choice of IOVA allocation algorithm. Without it, we're just
shooting in the dark.

> > Add CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT to limit the alignment of
> > IOVAs to some desired PAGE_SIZE order, specified by
> > CONFIG_IOMMU_IOVA_ALIGNMENT. This helps reduce the impact of
> > fragmentation caused by the current IOVA alignment scheme, and
> > gives better IOVA space utilization.
> 
> Even if the general change did prove reasonable, this IOVA allocator is not
> owned by the DMA API, so entirely removing the option of strict
> size-alignment feels a bit uncomfortable. Personally I'd replace the bool
> argument with an actual alignment value to at least hand the authority out
> to individual callers.
> 
> Furthermore, even in DMA API terms, is anyone really ever going to bother
> tuning that config? Since iommu-dma is supposed to be a transparent layer,
> arguably it shouldn't behave unnecessarily differently from CMA, so simply
> piggy-backing off CONFIG_CMA_ALIGNMENT would seem logical.

Agreed, reusing CONFIG_CMA_ALIGNMENT makes a lot of sense here as callers
relying on natural alignment of DMA buffer allocations already have to
deal with that limitation. We could fix it as an optional parameter at
init time (init_iova_domain()), and have the DMA IOMMU implementation
pass it in there.

Will
