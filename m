Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7983161F09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 03:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgBRCiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 21:38:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:56191 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgBRCiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 21:38:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 18:38:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,454,1574150400"; 
   d="scan'208";a="407934661"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.1]) ([10.254.210.1])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2020 18:38:15 -0800
Subject: Re: [PATCH 3/5] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     jroedel@suse.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <83b21e50-9097-06db-d404-8fe400134bac@linux.intel.com>
Date:   Tue, 18 Feb 2020 10:38:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217193858.26990-4-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Thanks for doing this.

On 2020/2/18 3:38, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The attachment of deferred devices needs to happen before the check
> whether the device is identity mapped or not. Otherwise the check will
> return wrong results, cause warnings boot failures in kdump kernels, like
> 
> 	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70
> 
> 	[...]
> 
> 	 Call Trace:
> 	  __intel_map_single+0x55/0x190
> 	  intel_alloc_coherent+0xac/0x110
> 	  dmam_alloc_attrs+0x50/0xa0
> 	  ahci_port_start+0xfb/0x1f0 [libahci]
> 	  ata_host_start.part.39+0x104/0x1e0 [libata]
> 
> With the earlier check the kdump boot succeeds and a crashdump is written.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/intel-iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 42cdcce1602e..32f43695a22b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
>   
>   static struct dmar_domain *deferred_attach_domain(struct device *dev)
>   {
> -	if (unlikely(attach_deferred(dev)))
> -		do_deferred_attach(dev);
> -

This should also be moved to the call place of deferred_attach_domain()
in bounce_map_single().

bounce_map_single() assumes that devices always use DMA domain, so it
doesn't call iommu_need_mapping(). We could do_deferred_attach() there
manually.

Best regards,
baolu

>   	return find_domain(dev);
>   }
>   
> @@ -3595,6 +3592,9 @@ static bool iommu_need_mapping(struct device *dev)
>   	if (iommu_dummy(dev))
>   		return false;
>   
> +	if (unlikely(attach_deferred(dev)))
> +		do_deferred_attach(dev);
> +
>   	ret = identity_mapping(dev);
>   	if (ret) {
>   		u64 dma_mask = *dev->dma_mask;
> 
