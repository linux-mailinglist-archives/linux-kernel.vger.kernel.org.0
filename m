Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC702922AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfHSLpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 07:45:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHSLpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:45:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 514ED28;
        Mon, 19 Aug 2019 04:45:20 -0700 (PDT)
Received: from [10.37.12.162] (unknown [10.37.12.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2BA23F246;
        Mon, 19 Aug 2019 04:45:18 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 01/11] xen/arm: use dma-noncoherent.h calls
 for xen-swiotlb cache maintainance
To:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-2-hch@lst.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <65248838-f273-6097-22f4-e5809078ddba@arm.com>
Date:   Mon, 19 Aug 2019 12:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816130013.31154-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 8/16/19 2:00 PM, Christoph Hellwig wrote:
> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> +	     enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long page_pfn = page_to_xen_pfn(page);
> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> +	unsigned long compound_pages =
> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> +	bool local = (page_pfn <= dev_pfn) &&
> +		(dev_pfn - page_pfn < compound_pages);
> +

The Arm version as a comment here. Could we retain it?

> +	if (local)
> +		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
> +	else
> +		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> +}
> +

Cheers,

-- 
Julien Grall
