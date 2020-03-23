Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D4C18F514
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgCWMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:55:33 -0400
Received: from verein.lst.de ([213.95.11.211]:58500 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgCWMzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:55:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4428E68BEB; Mon, 23 Mar 2020 13:55:30 +0100 (CET)
Date:   Mon, 23 Mar 2020 13:55:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200323125530.GA17038@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <0a6003e5-8003-4509-4014-4b286d5e8fe0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6003e5-8003-4509-4014-4b286d5e8fe0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:14:08PM +0000, Robin Murphy wrote:
> On 2020-03-20 2:16 pm, Christoph Hellwig wrote:
>> Several IOMMU drivers have a bypass mode where they can use a direct
>> mapping if the devices DMA mask is large enough.  Add generic support
>> to the core dma-mapping code to do that to switch those drivers to
>> a common solution.
>
> Hmm, this is _almost_, but not quite the same as the case where drivers are 
> managing their own IOMMU mappings, but still need to use streaming DMA for 
> cache maintenance on the underlying pages.

In that case they should simply not call the DMA API at all.  We'll just
need versions of the cache maintainance APIs that tie in with the raw
IOMMU API.

> For that we need the ops bypass 
> to be a "true" bypass and also avoid SWIOTLB regardless of the device's DMA 
> mask. That behaviour should in fact be fine for the opportunistic bypass 
> case here as well, since the mask being "big enough" implies by definition 
> that this should never need to bounce either.

In practice it does.  But that means adding yet another code path
vs the simple direct call to dma_direct_* vs calling the DMA ops
which I'd rather avoid.
