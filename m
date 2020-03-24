Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383991906DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 08:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgCXHzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 03:55:16 -0400
Received: from verein.lst.de ([213.95.11.211]:34316 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgCXHzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:55:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 038C268BFE; Tue, 24 Mar 2020 08:55:15 +0100 (CET)
Date:   Tue, 24 Mar 2020 08:55:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200324075514.GK23447@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru> <20200323083705.GA31245@lst.de> <20200323085059.GA32528@lst.de> <87sghz2ibh.fsf@linux.ibm.com> <20200323172256.GB31269@lst.de> <ffce1af6-a215-dee8-7b5c-2111f43accfd@ozlabs.ru> <87pnd22rke.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnd22rke.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 12:00:09PM +0530, Aneesh Kumar K.V wrote:
> dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
> 		unsigned long offset, size_t size, enum dma_data_direction dir,
> 		unsigned long attrs)
> {
> 	phys_addr_t phys = page_to_phys(page) + offset;
> 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
> 
> 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> 			return iommu_map(dev, phys, size, dir, attrs);
> 
> 		return DMA_MAPPING_ERROR;

If powerpc hardware / firmware people really come up with crap that
stupid you'll have to handle it yourself and will always pay the
indirect call penality.
