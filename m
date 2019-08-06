Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6E82BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 08:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbfHFGnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 02:43:52 -0400
Received: from verein.lst.de ([213.95.11.211]:53731 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbfHFGnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:43:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DAA6F68B02; Tue,  6 Aug 2019 08:43:47 +0200 (CEST)
Date:   Tue, 6 Aug 2019 08:43:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Apply per-device dma_ops
Message-ID: <20190806064347.GA14906@lst.de>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com> <20190801060156.8564-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801060156.8564-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

I really do like the switch to the per-device dma_map_ops, but:

On Thu, Aug 01, 2019 at 02:01:55PM +0800, Lu Baolu wrote:
> Current Intel IOMMU driver sets the system level dma_ops. This
> implementation has at least the following drawbacks: 1) each
> dma API will go through the IOMMU driver even the devices are
> using identity mapped domains; 2) if user requests to use an
> identity mapped domain (a.k.a. bypass iommu translation), the
> driver might fall back to dma domain blindly if the device is
> not able to address all system memory.

This is very clearly a behavioral regression.  The intel-iommu driver
has always used the iommu mapping to provide decent support for
devices that do not have the full 64-bit addressing capability, and
changing this will make a lot of existing setups go slower.

I don't think having to use swiotlb for these devices helps anyone.
