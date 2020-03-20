Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F718CF96
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgCTN5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 09:57:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:62279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCTN5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:57:47 -0400
IronPort-SDR: IJRgNLPotou0Gba/aY1v1Et2JT86bcIyotQh6j7iC7lEhIFIW8ru1/fdapY2ahbFXCvI42/g/L
 1kz7tPNwQH/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 06:57:46 -0700
IronPort-SDR: yvjBrOOURHBM8gKE88ZBhZ2rJoI18IPpRiP27yzmUiPEWVEgOAj16RYPXYrxFI+vXBm/9akVmd
 rIZ7tv9WassQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="237235659"
Received: from che5-mobl.ccr.corp.intel.com (HELO [10.254.213.15]) ([10.254.213.15])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 06:57:44 -0700
Cc:     baolu.lu@linux.intel.com, Raj Ashok <ashok.raj@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 3/3] iommu/vt-d: Add build dependency on IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2f2b5c45-552f-1399-ad7d-0c460ab783f4@linux.intel.com>
Date:   Fri, 20 Mar 2020 21:57:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584678751-43169-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/20 12:32, Jacob Pan wrote:
> IOASID code is needed by VT-d scalable mode for PASID allocation.
> Add explicit dependency such that IOASID is built-in whenever Intel
> IOMMU is enabled.
> Otherwise, aux domain code will fail when IOMMU is built-in and IOASID
> is compiled as a module.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 59a623374dc38 ("iommu/vt-d: Replace Intel specific PASID 
allocator with IOASID")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d2fade984999..25149544d57c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -188,6 +188,7 @@ config INTEL_IOMMU
>   	select NEED_DMA_MAP_STATE
>   	select DMAR_TABLE
>   	select SWIOTLB
> +	select IOASID
>   	help
>   	  DMA remapping (DMAR) devices support enables independent address
>   	  translations for Direct Memory Access (DMA) from devices.
> 
