Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9594AE7053
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 12:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfJ1LZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 07:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfJ1LZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:25:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891692086D;
        Mon, 28 Oct 2019 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572261903;
        bh=uIJQi/xVzH0ESZKekPUQxJmUM83EGRAVC0wB5kU/siI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQe5GHkfEvuKJNrCByV/qt4ubTUJPa5HvnNSdzA8Coiq+mGHE2JneqDRdBlJUeKEt
         fc3QlteFbO+2MRHqlDpmCFrOlK+X5Vo8iD6mcMVX+kVr/8iI9CZ7LCfXA6uZte3vOi
         A/VF/+J94ncgU2R2BBzUZIOKXk20sOYmsN9m+jFo=
Date:   Mon, 28 Oct 2019 11:24:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     isaacm@codeaurora.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191028112457.GB4122@willie-the-truck>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
 <20191026053026.GA14545@lst.de>
 <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
 <20191028074156.GB20443@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191028074156.GB20443@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Oct 28, 2019 at 08:41:56AM +0100, Christoph Hellwig wrote:
> On Sat, Oct 26, 2019 at 03:12:57AM -0700, isaacm@codeaurora.org wrote:
> > On 2019-10-25 22:30, Christoph Hellwig wrote:
> >> The definition makes very little sense.
> > Can you please clarify what part doesn’t make sense, and why?
> 
> It looks like complete garbage to me.  That might just be because it
> uses tons of terms I've never heard of of and which aren't used anywhere
> in the DMA API.  It also might be because it doesn't explain how the
> flag might actually be practically useful.

Agreed. The way I /think/ it works is that on many SoCs there is a
system/last-level cache (LLC) which effectively sits in front of memory for
all masters. Even if a device isn't coherent with the CPU caches, we still
want to be able to allocate into the LLC. Why this doesn't happen
automatically is beyond me, but it appears that on these Qualcomm designs
you actually have to set the memory attributes up in the page-table to
ensure that the resulting memory transactions are non-cacheable for the CPU
but cacheable for the LLC. Without any changes, the transactions are
non-cacheable in both of them which assumedly has a performance cost.

But you can see that I'm piecing things together myself here. Isaac?

> > This is 
> > really just an extension of this patch that got mainlined, so that clients 
> > that use the DMA API can use IOMMU_QCOM_SYS_CACHE as well: 
> > https://patchwork.kernel.org/patch/10946099/
> >>  Any without a user in the same series it is a complete no-go anyway.
> > IOMMU_QCOM_SYS_CACHE does not have any current users in the mainline, nor 
> > did it have it in the patch series in which it got merged, yet it is still 
> > present? Furthermore, there are plans to upstream support for one of our 
> > SoCs that may benefit from this, as seen here: 
> > https://www.spinics.net/lists/iommu/msg39608.html.
> 
> Which means it should have never been merged.  As a general policy we do
> not add code to the Linux kernel without actual users.

Yes, in this case I was hoping a user would materialise via a different
tree, but it didn't happen, hence my post last week about removing this
altogether:

https://lore.kernel.org/linux-iommu/20191024153832.GA7966@jcrouse1-lnx.qualcomm.com/T/#t

which I suspect prompted this patch that unfortunately fails to solve the
problem.

Will
