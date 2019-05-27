Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA72B80B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfE0PAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 11:00:37 -0400
Received: from 8bytes.org ([81.169.241.247]:40352 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfE0PAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:00:36 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 99DA0244; Mon, 27 May 2019 17:00:35 +0200 (CEST)
Date:   Mon, 27 May 2019 17:00:34 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] iommu/vt-d: Delegate DMA domain to generic iommu
Message-ID: <20190527150033.GC12745@8bytes.org>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey James, Lu Baolu,

On Sat, May 25, 2019 at 01:41:21PM +0800, Lu Baolu wrote:
> James Sewart (1):
>   iommu/vt-d: Implement apply_resv_region iommu ops entry
> 
> Lu Baolu (14):
>   iommu: Add API to request DMA domain for device
>   iommu/vt-d: Expose ISA direct mapping region via
>     iommu_get_resv_regions
>   iommu/vt-d: Enable DMA remapping after rmrr mapped
>   iommu/vt-d: Add device_def_domain_type() helper
>   iommu/vt-d: Delegate the identity domain to upper layer
>   iommu/vt-d: Delegate the dma domain to upper layer
>   iommu/vt-d: Identify default domains replaced with private
>   iommu/vt-d: Handle 32bit device with identity default domain
>   iommu/vt-d: Probe DMA-capable ACPI name space devices
>   iommu/vt-d: Implement is_attach_deferred iommu ops entry
>   iommu/vt-d: Cleanup get_valid_domain_for_dev()
>   iommu/vt-d: Remove startup parameter from device_def_domain_type()
>   iommu/vt-d: Remove duplicated code for device hotplug
>   iommu/vt-d: Remove static identity map code

Thanks for working on this. I think it is time to give it some testing
in linux-next, so I applied it to my tree. Fingers crossed this can make
it into v5.3 :)


Regards,

	Joerg
