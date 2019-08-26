Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82EC9CC72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfHZJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 05:20:06 -0400
Received: from verein.lst.de ([213.95.11.211]:47254 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHZJUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:20:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46384227A81; Mon, 26 Aug 2019 11:20:01 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:20:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Xen-devel] [PATCH 01/11] xen/arm: use dma-noncoherent.h calls
 for xen-swiotlb cache maintainance
Message-ID: <20190826092001.GA13476@lst.de>
References: <20190816130013.31154-1-hch@lst.de> <20190816130013.31154-2-hch@lst.de> <65248838-f273-6097-22f4-e5809078ddba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65248838-f273-6097-22f4-e5809078ddba@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:45:17PM +0100, Julien Grall wrote:
> On 8/16/19 2:00 PM, Christoph Hellwig wrote:
>> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
>> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
>> +	     enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	unsigned long page_pfn = page_to_xen_pfn(page);
>> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
>> +	unsigned long compound_pages =
>> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
>> +	bool local = (page_pfn <= dev_pfn) &&
>> +		(dev_pfn - page_pfn < compound_pages);
>> +
>
> The Arm version as a comment here. Could we retain it?

I've added it in this patch, altough the rewrites later on mean it will
go away in favour of a new comment elsewhere anyway.
