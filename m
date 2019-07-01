Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D321341
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 06:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfEQExO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 00:53:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:56156 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEQExO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:53:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 21:53:13 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2019 21:53:11 -0700
Cc:     baolu.lu@linux.intel.com, alex.williamson@redhat.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v3 7/7] iommu/vt-d: Differentiate relaxable and non
 relaxable RMRRs
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
References: <20190516100817.12076-1-eric.auger@redhat.com>
 <20190516100817.12076-8-eric.auger@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2ebc33ed-ded6-0eee-96ef-84e6f61f692e@linux.intel.com>
Date:   Fri, 17 May 2019 12:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516100817.12076-8-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 5/16/19 6:08 PM, Eric Auger wrote:
> Now we have a new IOMMU_RESV_DIRECT_RELAXABLE reserved memory
> region type, let's report USB and GFX RMRRs as relaxable ones.
> 
> This allows to have a finer reporting at IOMMU API level of
> reserved memory regions. This will be exploitable by VFIO to
> define the usable IOVA range and detect potential conflicts
> between the guest physical address space and host reserved
> regions.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/iommu/intel-iommu.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a36604f4900f..af1d65fdedfc 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5493,7 +5493,9 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   	for_each_rmrr_units(rmrr) {
>   		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>   					  i, i_dev) {
> +			struct pci_dev *pdev = to_pci_dev(device);

Probably should be:

struct pci_dev *pdev = dev_is_pci(device) ? to_pci_dev(device) : NULL;

Best regards,
Lu Baolu

