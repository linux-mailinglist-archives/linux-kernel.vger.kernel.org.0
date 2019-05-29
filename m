Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494562D9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 11:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfE2J5l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 May 2019 05:57:41 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:54618 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfE2J5l (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Wed, 29 May 2019 05:57:41 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 29 May 2019 03:57:40 -0600
Message-Id: <5CEE57910200007800233571@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 29 May 2019 03:57:37 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Stefano Stabellini" <sstabellini@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v2 3/3] xen/swiotlb: remember having
 called xen_create_contiguous_region()
References: <20190529090407.1225-1-jgross@suse.com>
 <20190529090407.1225-4-jgross@suse.com>
In-Reply-To: <20190529090407.1225-4-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 29.05.19 at 11:04, <jgross@suse.com> wrote:
> @@ -345,8 +346,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
>  	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
> -		     range_straddles_page_boundary(phys, size)))
> +		     range_straddles_page_boundary(phys, size)) &&
> +	    PageXenRemapped(virt_to_page(vaddr))) {
>  		xen_destroy_contiguous_region(phys, order);
> +		ClearPageXenRemapped(virt_to_page(vaddr));
> +	}

To be symmetric with setting the flag only after having made the region
contiguous, and to avoid (perhaps just theoretical) races, wouldn't it be
better to clear the flag before calling xen_destroy_contiguous_region()?
Even better would be a TestAndClear...() operation.

Jan


