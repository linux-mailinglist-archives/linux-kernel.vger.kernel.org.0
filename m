Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAB166AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 00:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgBTXL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 18:11:58 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:14761 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729150AbgBTXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:11:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582240317; h=Content-Type: MIME-Version: References:
 Message-ID: In-Reply-To: Subject: cc: To: From: Date: Sender;
 bh=4Ua+l2URoPGFdI23i0BjObQxmo48JHmZH6T7Ju4WQOw=; b=fGvpMoTgtJ1VYQ8AHzWspO2XBFDRGixlm00P6idViGMpOjkxnumhoA5UzPWrgHxE2kdSWFRI
 zJ7p0jnd5kJfr173RojcWQ8QqY09gEYjquYD7zqkFzEe9baoqmmIYQBonNwyZs5MApbQdu9f
 Qt2JT8A1QWsC7IrDfGbOLBwGzMw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4f123b.7fb6003e02d0-smtp-out-n01;
 Thu, 20 Feb 2020 23:11:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6B3CC4479F; Thu, 20 Feb 2020 23:11:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9711AC433A2;
        Thu, 20 Feb 2020 23:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9711AC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Thu, 20 Feb 2020 15:11:54 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Robin Murphy <robin.murphy@arm.com>
cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
In-Reply-To: <f0d4312b-a451-691a-3fcd-e9c90f6c5308@arm.com>
Message-ID: <alpine.DEB.2.10.2002201508320.1846@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com> <e9ae618c-58d4-d245-be80-e62fbde4f907@arm.com> <20200219123704.GC19400@willie-the-truck> <alpine.DEB.2.10.2002191517150.636@lmark-linux.qualcomm.com>
 <f0d4312b-a451-691a-3fcd-e9c90f6c5308@arm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2046127808-2041823424-1582240314=:1846"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2046127808-2041823424-1582240314=:1846
Content-Type: TEXT/PLAIN; charset=iso-8859-7
Content-Transfer-Encoding: 8BIT

On Thu, 20 Feb 2020, Robin Murphy wrote:

> > > > > Add CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT to limit the alignment of
> > > > > IOVAs to some desired PAGE_SIZE order, specified by
> > > > > CONFIG_IOMMU_IOVA_ALIGNMENT. This helps reduce the impact of
> > > > > fragmentation caused by the current IOVA alignment scheme, and
> > > > > gives better IOVA space utilization.
> > > > 
> > > > Even if the general change did prove reasonable, this IOVA allocator is
> > > > not
> > > > owned by the DMA API, so entirely removing the option of strict
> > > > size-alignment feels a bit uncomfortable. Personally I'd replace the
> > > > bool
> > > > argument with an actual alignment value to at least hand the authority
> > > > out
> > > > to individual callers.
> > > > 
> > > > Furthermore, even in DMA API terms, is anyone really ever going to
> > > > bother
> > > > tuning that config? Since iommu-dma is supposed to be a transparent
> > > > layer,
> > > > arguably it shouldn't behave unnecessarily differently from CMA, so
> > > > simply
> > > > piggy-backing off CONFIG_CMA_ALIGNMENT would seem logical.
> > > 
> > > Agreed, reusing CONFIG_CMA_ALIGNMENT makes a lot of sense here as callers
> > > relying on natural alignment of DMA buffer allocations already have to
> > > deal with that limitation. We could fix it as an optional parameter at
> > > init time (init_iova_domain()), and have the DMA IOMMU implementation
> > > pass it in there.
> > > 
> > 
> > My concern with using CONFIG_CMA_ALIGNMENT alignment is that for us this
> > would either involve further fragmenting our CMA regions (moving our CMA
> > max alignment from 1MB to max 2MB) or losing so of our 2MB IOVA block
> > mappings (changing our IOVA max alignment form 2MB to 1MB).
> > 
> > At least for us CMA allocations are often not DMA mapped into stage 1 page
> > tables so moving the CMA max alignment to 2MB in our case would, I think,
> > only provide the disadvantage of having to increase the size our CMA
> > regions to accommodate this large alignment (which isn�t optimal for
> > memory utilization since CMA regions can't satisfy unmovable page
> > allocations).
> > 
> > As an alternative would it be possible for the dma-iommu layer to use the
> > size of the allocation and the domain pgsize_bitmap field to pick a max
> > IOVA alignment, which it can pass in for that IOVA allocation, which will
> > maximize block mappings but not waste IOVA space?
> 
> Given that we already have DMA_ATTR_ALOC_SINGLE_PAGES for video drivers and
> suchlike that know enough to know they want "large buffer" allocation
> behaviour, would it suffice to have a similar attribute that says "I'm not too
> fussed about alignment"? That way there's no visible change for anyone who
> doesn't opt in and might be relying on the existing behaviour, intentionally
> or otherwise.
> 
> Then if necessary, the implementation can consider both flags together to
> decide whether to try to round down to the next block size or just shove it in
> anywhere.
> 

This should work for us.
My only concern is that many of our users would be using DMA-Buf memory, 
so DMA mapping would be done using dma_buf_map_attachment which I believe 
still doesn't support specifying any DMA attributes. 

I had previously tried to get support added upstream but wasn't 
successful.
https://lkml.org/lkml/2019/1/18/826
https://lkml.org/lkml/2019/1/18/827

But perhaps this new attribute will provide enough justification for DMA 
attributes (in some form, either explicitly or via flags) to be supported 
via dma_buf_map_attachment.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
---2046127808-2041823424-1582240314=:1846--
