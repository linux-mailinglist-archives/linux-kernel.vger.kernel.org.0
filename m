Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722B5165308
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 00:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBSXWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 18:22:46 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:14751 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgBSXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:22:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582154565; h=Content-Type: MIME-Version: References:
 Message-ID: In-Reply-To: Subject: cc: To: From: Date: Sender;
 bh=OoH3nBuJ4gUwnYrlBEJolPCpDS2l7kU8MwVdSXLXSxo=; b=UFopVNt9QD3uqLjoRzB6zRRqabudhy8nYh0XGc1cNgBZ7+Vs9JaOs2IxI+K2Mh7V3yaobB+3
 HUaZd+zMvixrTKEvuMsQjXP0ZkXKjXPeRsIOnMOG+5bbAO+9o4ug4a54QbEcRcHMEutpdPFx
 E8X/FZHbrOUYDZdB8Kw/bEorFu4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4dc340.7f935f950730-smtp-out-n03;
 Wed, 19 Feb 2020 23:22:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 456D5C433A2; Wed, 19 Feb 2020 23:22:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47668C43383;
        Wed, 19 Feb 2020 23:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47668C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Wed, 19 Feb 2020 15:22:36 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Will Deacon <will@kernel.org>
cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
In-Reply-To: <20200219123704.GC19400@willie-the-truck>
Message-ID: <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com> <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com> <20200219123704.GC19400@willie-the-truck>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2046127808-1217393763-1582154557=:636"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2046127808-1217393763-1582154557=:636
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Wed, 19 Feb 2020, Will Deacon wrote:

> On Mon, Feb 17, 2020 at 04:46:14PM +0000, Robin Murphy wrote:
> > On 14/02/2020 8:30 pm, Liam Mark wrote:
> > > 
> > > When the IOVA framework applies IOVA alignment it aligns all
> > > IOVAs to the smallest PAGE_SIZE order which is greater than or
> > > equal to the requested IOVA size.
> > > 
> > > We support use cases that requires large buffers (> 64 MB in
> > > size) to be allocated and mapped in their stage 1 page tables.
> > > However, with this alignment scheme we find ourselves running
> > > out of IOVA space for 32 bit devices, so we are proposing this
> > > config, along the similar vein as CONFIG_CMA_ALIGNMENT for CMA
> > > allocations.
> > 
> > As per [1], I'd really like to better understand the allocation patterns
> > that lead to such a sparsely-occupied address space to begin with, given
> > that the rbtree allocator is supposed to try to maintain locality as far as
> > possible, and the rcaches should further improve on that. Are you also
> > frequently cycling intermediate-sized buffers which are smaller than 64MB
> > but still too big to be cached?  Are there a lot of non-power-of-two
> > allocations?
> 
> Right, information on the allocation pattern would help with this change
> and also the choice of IOVA allocation algorithm. Without it, we're just
> shooting in the dark.
> 

Thanks for the responses.

I am looking into how much of our allocation pattern details I can share.

My general understanding is that this issue occurs on a 32bit devices 
which have additional restrictions on the IOVA range they can use within those 
32bits.

An example is a use case which involves allocating a lot of buffers ~80MB 
is size, the current algorithm will require an alignment of 128MB for 
those buffers. My understanding is that it simply can't accommodate the number of 80MB 
buffers that are required because the of amount of IOVA space which can't 
be used because of the 128MB alignment requirement.

> > > Add CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT to limit the alignment of
> > > IOVAs to some desired PAGE_SIZE order, specified by
> > > CONFIG_IOMMU_IOVA_ALIGNMENT. This helps reduce the impact of
> > > fragmentation caused by the current IOVA alignment scheme, and
> > > gives better IOVA space utilization.
> > 
> > Even if the general change did prove reasonable, this IOVA allocator is not
> > owned by the DMA API, so entirely removing the option of strict
> > size-alignment feels a bit uncomfortable. Personally I'd replace the bool
> > argument with an actual alignment value to at least hand the authority out
> > to individual callers.
> > 
> > Furthermore, even in DMA API terms, is anyone really ever going to bother
> > tuning that config? Since iommu-dma is supposed to be a transparent layer,
> > arguably it shouldn't behave unnecessarily differently from CMA, so simply
> > piggy-backing off CONFIG_CMA_ALIGNMENT would seem logical.
> 
> Agreed, reusing CONFIG_CMA_ALIGNMENT makes a lot of sense here as callers
> relying on natural alignment of DMA buffer allocations already have to
> deal with that limitation. We could fix it as an optional parameter at
> init time (init_iova_domain()), and have the DMA IOMMU implementation
> pass it in there.
> 

My concern with using CONFIG_CMA_ALIGNMENT alignment is that for us this 
would either involve further fragmenting our CMA regions (moving our CMA 
max alignment from 1MB to max 2MB) or losing so of our 2MB IOVA block 
mappings (changing our IOVA max alignment form 2MB to 1MB).

At least for us CMA allocations are often not DMA mapped into stage 1 page 
tables so moving the CMA max alignment to 2MB in our case would, I think, 
only provide the disadvantage of having to increase the size our CMA 
regions to accommodate this large alignment (which isn�t optimal for 
memory utilization since CMA regions can't satisfy unmovable page 
allocations).

As an alternative would it be possible for the dma-iommu layer to use the 
size of the allocation and the domain pgsize_bitmap field to pick a max 
IOVA alignment, which it can pass in for that IOVA allocation, which will 
maximize block mappings but not waste IOVA space?

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
---2046127808-1217393763-1582154557=:636--
