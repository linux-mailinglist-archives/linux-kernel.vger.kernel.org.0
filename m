Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1E8EFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 17:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfHOPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 11:48:47 -0400
Received: from 8bytes.org ([81.169.241.247]:49818 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730805AbfHOPsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:48:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9919C3AA; Thu, 15 Aug 2019 17:48:45 +0200 (CEST)
Date:   Thu, 15 Aug 2019 17:48:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v6 5/8] iommu: Add bounce page APIs
Message-ID: <20190815154845.GA18327@8bytes.org>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com>
 <20190730045229.3826-6-baolu.lu@linux.intel.com>
 <20190814083842.GB22669@8bytes.org>
 <445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 02:15:32PM +0800, Lu Baolu wrote:
> iommu_map/unmap() APIs haven't parameters for dma direction and
> attributions. These parameters are elementary for DMA APIs. Say,
> after map, if the dma direction is TO_DEVICE and a bounce buffer is
> used, we must sync the data from the original dma buffer to the bounce
> buffer; In the opposite direction, if dma is FROM_DEVICE, before unmap,
> we need to sync the data from the bounce buffer onto the original
> buffer.

The DMA direction from DMA-API maps to the protections in iommu_map():

	DMA_FROM_DEVICE:	IOMMU_WRITE
	DMA_TO_DEVICE:		IOMMU_READ
	DMA_BIDIRECTIONAL	IOMMU_READ | IOMMU_WRITE

And for the sync DMA-API also has separate functions for either
direction. So I don't see why these extra functions are needed in the
IOMMU-API.


Regards,

	Joerg
