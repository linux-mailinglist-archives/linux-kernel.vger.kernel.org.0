Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6B59AA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404866AbfHWIj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:39:59 -0400
Received: from 8bytes.org ([81.169.241.247]:51056 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403907AbfHWIj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:39:58 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 91BBF246; Fri, 23 Aug 2019 10:39:57 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:39:56 +0200
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v7 1/7] iommu/vt-d: Don't switch off swiotlb if use
 direct dma
Message-ID: <20190823083956.GB24194@8bytes.org>
References: <20190823071735.30264-1-baolu.lu@linux.intel.com>
 <20190823071735.30264-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823071735.30264-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:17:29PM +0800, Lu Baolu wrote:
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4569,9 +4569,6 @@ static int __init platform_optin_force_iommu(void)
>  		iommu_identity_mapping |= IDENTMAP_ALL;
>  
>  	dmar_disabled = 0;
> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
> -	swiotlb = 0;
> -#endif
>  	no_iommu = 0;
>  
>  	return 1;
> @@ -4710,9 +4707,6 @@ int __init intel_iommu_init(void)
>  	}
>  	up_write(&dmar_global_lock);
>  
> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
> -	swiotlb = 0;
> -#endif

So this will cause the 64MB SWIOTLB aperture to be allocated even when
there will never be an untrusted device in the system, right? I guess
this will break some kdump setups as they need to resize their low
memory allocations to make room for the aperture because of this
patch-set.

But I also don't see a way around this for now as untrusted devices are
usually hotplugged and might not be present at boot. So we can't make
the decision about the allocation at boot time.

But this mechanism needs to be moved to the dma-iommu implementation at
some point, and then we should allocate the bounce memory pages
on-demand. We can easily do this in page-size chunks and map them
together with iommu page-tables. This way we don't need to pre-allocate
a large memory-chunk at boot.

Regards,

	Joerg
