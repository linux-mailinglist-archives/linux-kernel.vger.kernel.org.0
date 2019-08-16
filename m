Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C96190607
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfHPQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:43:32 -0400
Received: from verein.lst.de ([213.95.11.211]:56735 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfHPQnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:43:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7255227A81; Fri, 16 Aug 2019 18:43:28 +0200 (CEST)
Date:   Fri, 16 Aug 2019 18:43:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/11] xen/arm: pass one less argument to
 dma_cache_maint
Message-ID: <20190816164328.GB3629@lst.de>
References: <20190816130013.31154-1-hch@lst.de> <20190816130013.31154-4-hch@lst.de> <8585fb27-14e0-888c-6749-6862b4e16418@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8585fb27-14e0-888c-6749-6862b4e16418@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 02:37:58PM +0100, Robin Murphy wrote:
> On 16/08/2019 14:00, Christoph Hellwig wrote:
>> Instead of taking apart the dma address in both callers do it inside
>> dma_cache_maint itself.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   arch/arm/xen/mm.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
>> index 90574d89d0d4..d9da24fda2f7 100644
>> --- a/arch/arm/xen/mm.c
>> +++ b/arch/arm/xen/mm.c
>> @@ -43,13 +43,15 @@ static bool hypercall_cflush = false;
>>     /* functions called by SWIOTLB */
>>   -static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
>> -	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
>> +static void dma_cache_maint(dma_addr_t handle, size_t size,
>> +		enum dma_data_direction dir, enum dma_cache_op op)
>>   {
>>   	struct gnttab_cache_flush cflush;
>>   	unsigned long xen_pfn;
>> +	unsigned long offset = handle & ~PAGE_MASK;
>>   	size_t left = size;
>>   +	offset &= PAGE_MASK;
>
> Ahem... presumably that should be handle, not offset.

Ooops, yes.
