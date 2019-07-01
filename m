Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CBF0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfD3G5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 02:57:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3G5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A28AB859FB;
        Tue, 30 Apr 2019 06:57:37 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66D4F6B8F5;
        Tue, 30 Apr 2019 06:57:32 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 19/19] iommu/vt-d: Add svm/sva invalidate function
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-20-git-send-email-jacob.jun.pan@linux.intel.com>
 <26398960-f484-d5dd-eff5-c44810528194@redhat.com>
 <20190429154146.20e0c13c@jacob-builder>
Message-ID: <ddcc3770-d5f4-e6a1-db63-45a6412f8c52@redhat.com>
Date:   Tue, 30 Apr 2019 08:57:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190429154146.20e0c13c@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 30 Apr 2019 06:57:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/19 12:41 AM, Jacob Pan wrote:
> On Fri, 26 Apr 2019 19:23:03 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Jacob,
>> On 4/24/19 1:31 AM, Jacob Pan wrote:
>>> When Shared Virtual Address (SVA) is enabled for a guest OS via
>>> vIOMMU, we need to provide invalidation support at IOMMU API and
>>> driver level. This patch adds Intel VT-d specific function to
>>> implement iommu passdown invalidate API for shared virtual address.
>>>
>>> The use case is for supporting caching structure invalidation
>>> of assigned SVM capable devices. Emulated IOMMU exposes queue
>>> invalidation capability and passes down all descriptors from the
>>> guest to the physical IOMMU.
>>>
>>> The assumption is that guest to host device ID mapping should be
>>> resolved prior to calling IOMMU driver. Based on the device handle,
>>> host IOMMU driver can replace certain fields before submit to the
>>> invalidation queue.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
>>> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
>>> ---
>>>  drivers/iommu/intel-iommu.c | 159
>>> ++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 159
>>> insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c
>>> b/drivers/iommu/intel-iommu.c index 89989b5..54a3d22 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -5338,6 +5338,164 @@ static void
>>> intel_iommu_aux_detach_device(struct iommu_domain *domain,
>>> aux_domain_remove_dev(to_dmar_domain(domain), dev); }
>>>  
>>> +/*
>>> + * 2D array for converting and sanitizing IOMMU generic TLB
>>> granularity to
>>> + * VT-d granularity. Invalidation is typically included in the
>>> unmap operation
>>> + * as a result of DMA or VFIO unmap. However, for assigned device
>>> where guest
>>> + * could own the first level page tables without being shadowed by
>>> QEMU. In
>>> + * this case there is no pass down unmap to the host IOMMU as a
>>> result of unmap
>>> + * in the guest. Only invalidations are trapped and passed down.
>>> + * In all cases, only first level TLB invalidation (request with
>>> PASID) can be
>>> + * passed down, therefore we do not include IOTLB granularity for
>>> request
>>> + * without PASID (second level).
>>> + *
>>> + * For an example, to find the VT-d granularity encoding for IOTLB
>>> + * type and page selective granularity within PASID:
>>> + * X: indexed by iommu cache type
>>> + * Y: indexed by enum iommu_inv_granularity
>>> + * [IOMMU_INV_TYPE_TLB][IOMMU_INV_GRANU_PAGE_PASID]
>>> + *
>>> + * Granu_map array indicates validity of the table. 1: valid, 0:
>>> invalid
>>> + *
>>> + */
>>> +const static int
>>> inv_type_granu_map[NR_IOMMU_CACHE_TYPE][NR_IOMMU_CACHE_INVAL_GRANU]
>>> = {  
>> The size is frozen for a given uapi version so I guess you can
>> hardcode the limits for a given version.
> I guess I could, I just felt more readable this way.
>>> +	/* PASID based IOTLB, support PASID selective and page
>>> selective */
>>> +	{0, 1, 1},
>>> +	/* PASID based dev TLBs, only support all PASIDs or single
>>> PASID */
>>> +	{1, 1, 0},
>>> +	/* PASID cache */
>>> +	{1, 1, 0}
>>> +};
>>> +
>>> +const static u64
>>> inv_type_granu_table[NR_IOMMU_CACHE_TYPE][NR_IOMMU_CACHE_INVAL_GRANU]
>>> = {
>>> +	/* PASID based IOTLB */
>>> +	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
>>> +	/* PASID based dev TLBs */
>>> +	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
>>> +	/* PASID cache */
>>> +	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
>>> +};  
>> Can't you use a single matrix instead, ie. inv_type_granu_table
>>
> The reason i have an additional inv_type_granu_map[] matrix is that
> some of fields can be 0 but still valid. A single matrix would not be
> able to tell the difference between a valid 0 or invalid field.
Ah OK sorry I missed that.
>>> +
>>> +static inline int to_vtd_granularity(int type, int granu, u64
>>> *vtd_granu) +{
>>> +	if (type >= NR_IOMMU_CACHE_TYPE || granu >=
>>> NR_IOMMU_CACHE_INVAL_GRANU ||
>>> +		!inv_type_granu_map[type][granu])
>>> +		return -EINVAL;
>>> +
>>> +	*vtd_granu = inv_type_granu_table[type][granu];
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
>>> +{
>>> +	u64 nr_pages;  
>> direct initialization?
> will do, thanks
>>> +	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9
>>> for 2MB, etc.
>>> +	 * IOMMU cache invalidate API passes granu_size in bytes,
>>> and number of
>>> +	 * granu size in contiguous memory.
>>> +	 */
>>> +
>>> +	nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
>>> +	return order_base_2(nr_pages);
>>> +}
>>> +
>>> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
>>> +		struct device *dev, struct
>>> iommu_cache_invalidate_info *inv_info) +{
>>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>> +	struct device_domain_info *info;
>>> +	struct intel_iommu *iommu;
>>> +	unsigned long flags;
>>> +	int cache_type;
>>> +	u8 bus, devfn;
>>> +	u16 did, sid;
>>> +	int ret = 0;
>>> +	u64 granu;
>>> +	u64 size;
>>> +
>>> +	if (!inv_info || !dmar_domain ||
>>> +		inv_info->version !=
>>> IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
>>> +		return -EINVAL;
>>> +
>>> +	if (!dev || !dev_is_pci(dev))
>>> +		return -ENODEV;
>>> +
>>> +	iommu = device_to_iommu(dev, &bus, &devfn);
>>> +	if (!iommu)
>>> +		return -ENODEV;
>>> +
>>> +	spin_lock(&iommu->lock);
>>> +	spin_lock_irqsave(&device_domain_lock, flags);  
>> mix of _irqsave and non _irqsave looks suspicious to me.
> It should be in reverse order. Any other concerns?
I understand both locks are likely to be taken in ISR context so
_irqsave should be called on the first call.
>>> +	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus,
>>> devfn);
>>> +	if (!info) {
>>> +		ret = -EINVAL;
>>> +		goto out_unlock;
>>> +	}
>>> +	did = dmar_domain->iommu_did[iommu->seq_id];
>>> +	sid = PCI_DEVID(bus, devfn);
>>> +	size = to_vtd_size(inv_info->addr_info.granule_size,
>>> inv_info->addr_info.nb_granules); +
>>> +	for_each_set_bit(cache_type, (unsigned long
>>> *)&inv_info->cache, NR_IOMMU_CACHE_TYPE) { +
>>> +		ret = to_vtd_granularity(cache_type,
>>> inv_info->granularity, &granu);
>>> +		if (ret) {
>>> +			pr_err("Invalid range type %d, granu
>>> %d\n", cache_type,  
>> s/Invalid range type %d, granu %d/Invalid cache type/granu combination
>> (%d/%d)
> sounds good, indeed it is the combination that is invalid.
>>> +				inv_info->granularity);
>>> +			break;
>>> +		}
>>> +
>>> +		switch (BIT(cache_type)) {
>>> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
>>> +			if (size && (inv_info->addr_info.addr &
>>> ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
>>> +				pr_err("Address out of range,
>>> 0x%llx, size order %llu\n",
>>> +					inv_info->addr_info.addr,
>>> size);
>>> +				ret = -ERANGE;
>>> +				goto out_unlock;
>>> +			}
>>> +
>>> +			qi_flush_piotlb(iommu, did,
>>> mm_to_dma_pfn(inv_info->addr_info.addr),
>>> +					inv_info->addr_info.pasid,
>>> +					size, granu);
>>> +
>>> +			/*
>>> +			 * Always flush device IOTLB if ATS is
>>> enabled since guest
>>> +			 * vIOMMU exposes CM = 1, no device IOTLB
>>> flush will be passed
>>> +			 * down. REVISIT: cannot assume Linux guest
>>> +			 */
>>> +			if (info->ats_enabled) {
>>> +				qi_flush_dev_piotlb(iommu, sid,
>>> info->pfsid,
>>> +
>>> inv_info->addr_info.pasid, info->ats_qdep,
>>> +
>>> inv_info->addr_info.addr, size,
>>> +						granu);
>>> +			}
>>> +			break;
>>> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
>>> +			if (info->ats_enabled) {
>>> +				qi_flush_dev_piotlb(iommu, sid,
>>> info->pfsid,
>>> +
>>> inv_info->addr_info.pasid, info->ats_qdep,
>>> +
>>> inv_info->addr_info.addr, size,
>>> +						granu);
>>> +			} else
>>> +				pr_warn("Passdown device IOTLB
>>> flush w/o ATS!\n"); +
>>> +			break;
>>> +		case IOMMU_CACHE_INV_TYPE_PASID:
>>> +			qi_flush_pasid_cache(iommu, did, granu,
>>> inv_info->pasid); +
>>> +			break;
>>> +		default:
>>> +			dev_err(dev, "Unsupported IOMMU
>>> invalidation type %d\n",
>>> +				cache_type);
>>> +			ret = -EINVAL;
>>> +		}
>>> +	}
>>> +out_unlock:
>>> +	spin_unlock(&iommu->lock);
>>> +	spin_unlock_irqrestore(&device_domain_lock, flags);  
>> I would expect the opposite order
> yes, i reversed in the lock order such that irq is disabled.
spin_unlock_irqsave(&iommu->lock, flags);
spin_lock(&device_domain_lock);
../..
spin_unlock_irqrestore(&device_domain_lock);
spin_unlock_irqrestore(&iommu->lock);
?

Thanks

Eric
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int intel_iommu_map(struct iommu_domain *domain,
>>>  			   unsigned long iova, phys_addr_t hpa,
>>>  			   size_t size, int iommu_prot)
>>> @@ -5769,6 +5927,7 @@ const struct iommu_ops intel_iommu_ops = {
>>>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>>>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>> +	.cache_invalidate	= intel_iommu_sva_invalidate,
>>>  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>>>  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>>>  #endif
>>>   
>> Thanks
>>
>> Eric
> 
> Thank you so much for your review. I will roll up the next version
> soon, hopefully this week.
> 
> Jacob
> 
