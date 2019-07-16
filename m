Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A96AD13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfGPQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 12:46:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfGPQqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 337AA882F5;
        Tue, 16 Jul 2019 16:46:00 +0000 (UTC)
Received: from [10.36.116.32] (ovpn-116-32.ams2.redhat.com [10.36.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B12EF5DA34;
        Tue, 16 Jul 2019 16:45:52 +0000 (UTC)
From:   Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v4 20/22] iommu/vt-d: Add bind guest PASID support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yi L <yi.l.liu@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1560087862-57608-21-git-send-email-jacob.jun.pan@linux.intel.com>
Message-ID: <2c5a7686-aef7-f98f-cb1c-8e0eb31b2bfa@redhat.com>
Date:   Tue, 16 Jul 2019 18:45:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1560087862-57608-21-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 16 Jul 2019 16:46:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 6/9/19 3:44 PM, Jacob Pan wrote:
> When supporting guest SVA with emulated IOMMU, the guest PASID
> table is shadowed in VMM. Updates to guest vIOMMU PASID table
> will result in PASID cache flush which will be passed down to
> the host as bind guest PASID calls.
> 
> For the SL page tables, it will be harvested from device's
> default domain (request w/o PASID), or aux domain in case of
> mediated device.
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |   4 +
>  drivers/iommu/intel-svm.c   | 187 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  13 ++-
>  include/linux/intel-svm.h   |  17 ++++
>  4 files changed, 219 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 7cfa0eb..3b4d712 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5782,6 +5782,10 @@ const struct iommu_ops intel_iommu_ops = {
>  	.dev_enable_feat	= intel_iommu_dev_enable_feat,
>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> +#endif
>  };
>  
>  static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 66d98e1..f06a82f 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -229,6 +229,193 @@ static LIST_HEAD(global_svm_list);
>  	list_for_each_entry(sdev, &svm->devs, list)	\
>  	if (dev == sdev->dev)				\
>  
> +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +			struct device *dev,
> +			struct gpasid_bind_data *data)
> +{
> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct intel_svm_dev *sdev;
> +	struct intel_svm *svm = NULL;
not requested
> +	struct dmar_domain *ddomain;
> +	int ret = 0;
> +
> +	if (WARN_ON(!iommu) || !data)
> +		return -EINVAL;
> +
> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> +		data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	if (dev_is_pci(dev)) {
> +		/* VT-d supports devices with full 20 bit PASIDs only */
> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> +			return -EINVAL;
> +	}
> +
> +	/*
> +	 * We only check host PASID range, we have no knowledge to check
> +	 * guest PASID range nor do we use the guest PASID.
guest pasid is set below in svm->gpasid.
So I am confused, do you handle gpasid or not? If you don't use gpasid
at the moment, then you may return -EINVAL if data->flags &
IOMMU_SVA_GPASID_VAL.

I confess I don't really understand gpasid as I thought you use
enlightened PASID allocation to use a system wide PASID allocator on
host so in which case guest and host PASID do differ?
> +	 */
> +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
> +		return -EINVAL;
> +
> +	ddomain = to_dmar_domain(domain);
> +	/* REVISIT:
> +	 * Sanity check adddress width and paging mode support
> +	 * width matching in two dimensions:
> +	 * 1. paging mode CPU <= IOMMU
> +	 * 2. address width Guest <= Host.
> +	 */
> +	mutex_lock(&pasid_mutex);
> +	svm = ioasid_find(NULL, data->hpasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +	if (svm) {
> +		/*
> +		 * If we found svm for the PASID, there must be at
> +		 * least one device bond, otherwise svm should be freed.
> +		 */
> +		BUG_ON(list_empty(&svm->devs));
> +
> +		for_each_svm_dev() {
> +			/* In case of multiple sub-devices of the same pdev assigned, we should
> +			 * allow multiple bind calls with the same PASID and pdev.
> +			 */
> +			sdev->users++;
> +			goto out;
> +		}
> +	} else {
> +		/* We come here when PASID has never been bond to a device. */
> +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> +		if (!svm) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		/* REVISIT: upper layer/VFIO can track host process that bind the PASID.
> +		 * ioasid_set = mm might be sufficient for vfio to check pasid VMM
> +		 * ownership.
> +		 */
> +		svm->mm = get_task_mm(current);
> +		svm->pasid = data->hpasid;
> +		if (data->flags & IOMMU_SVA_GPASID_VAL) {
> +			svm->gpasid = data->gpasid;
> +			svm->flags &= SVM_FLAG_GUEST_PASID;
I guest you mean |= ?
> +		}
> +		refcount_set(&svm->refs, 0);
> +		ioasid_set_data(data->hpasid, svm);
> +		INIT_LIST_HEAD_RCU(&svm->devs);
> +		INIT_LIST_HEAD(&svm->list);
> +
> +		mmput(svm->mm);
> +	}
> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev) {
> +		ret = -ENOMEM;
> +		goto out;
from now on, if any error occurs below and if you've just created the
svm object, no sdev will be attached to the svm object => opposed to
comment above and likely to hit BUG_ON() on next call.
> +	}
> +	sdev->dev = dev;
> +	sdev->users = 1;
> +
> +	/* Set up device context entry for PASID if not enabled already */
> +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable PASID capability\n");
> +		kfree(sdev);
> +		goto out;
> +	}
> +
> +	/*
> +	 * For guest bind, we need to set up PASID table entry as follows:
> +	 * - FLPM matches guest paging mode
> +	 * - turn on nested mode
> +	 * - SL guest address width matching
> +	 */
> +	ret = intel_pasid_setup_nested(iommu,
> +				dev,
> +				(pgd_t *)data->gpgd,
> +				data->hpasid,
> +				data->flags,
> +				ddomain,
> +				data->addr_width);
So at the moment you don't seem to use the data->vtd field and pass it
to intel_pasid_setup_nested(). Don't you need to perform some sanity
checks on some fields against the extended capability reg?


wouldn't it be simpler to pass a struct gpasid_bind_data pointer to
intel_pasid_setup_nested.
> +	if (ret) {
> +		dev_err(dev, "Failed to set up PASID %llu in nested mode, Err %d\n",
> +			data->hpasid, ret);
> +		kfree(sdev);
> +		goto out;
> +	}
> +	svm->flags |= SVM_FLAG_GUEST_MODE;
> +
> +	init_rcu_head(&sdev->rcu);
> +	refcount_inc(&svm->refs);
> +	list_add_rcu(&sdev->list, &svm->devs);
> + out:
> +	mutex_unlock(&pasid_mutex);
> +	return ret;
> +}
> +
> +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> +{
> +	struct intel_svm_dev *sdev;
> +	struct intel_iommu *iommu;
> +	struct intel_svm *svm;
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&pasid_mutex);
> +	iommu = intel_svm_device_to_iommu(dev);
> +	if (!iommu)
> +		goto out;
> +
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
> +	if (!svm)
> +		goto out;
IS_ERR_OR_NULL as advised by Lu in another patch
> +
> +	for_each_svm_dev() {
> +		ret = 0;
> +		sdev->users--;
> +		if (!sdev->users) {
> +			list_del_rcu(&sdev->list);
> +			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> +			/* TODO: Drain in flight PRQ for the PASID since it
> +			 * may get reused soon, we don't want to
> +			 * confuse with its previous live.
life
> +			 * intel_svm_drain_prq(dev, pasid);
> +			 */
> +			kfree_rcu(sdev, rcu);
> +
> +			if (list_empty(&svm->devs)) {
> +				list_del(&svm->list);
> +				kfree(svm);
> +				/*
> +				 * We do not free PASID here until explicit call
> +				 * from VFIO to free. The PASID life cycle
> +				 * management is largely tied to VFIO management
> +				 * of assigned device life cycles. In case of
> +				 * guest exit without a explicit free PASID call,
> +				 * the responsibility lies in VFIO layer to free
> +				 * the PASIDs allocated for the guest.
> +				 * For security reasons, VFIO has to track the
> +				 * PASID ownership per guest anyway to ensure
> +				 * that PASID allocated by one guest cannot be
> +				 * used by another.
> +				 */
> +				ioasid_set_data(pasid, NULL);
> +			}
> +		}
> +		break;
> +	}
> + out:
> +	mutex_unlock(&pasid_mutex);
> +
> +	return ret;
> +}
> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index b75f17d..94d3a9a 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -677,7 +677,9 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
>  int intel_svm_init(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -
> +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +		struct device *dev, struct gpasid_bind_data *data);
> +extern int intel_svm_unbind_gpasid(struct device *dev, int pasid);
>  struct svm_dev_ops;
>  
>  struct intel_svm_dev {
> @@ -693,12 +695,19 @@ struct intel_svm_dev {
>  
>  struct intel_svm {
>  	struct mmu_notifier notifier;
> -	struct mm_struct *mm;
> +	union {
> +		struct mm_struct *mm;
> +		u64 gcr3;
> +	};
not related to that patch?
>  	struct intel_iommu *iommu;
>  	int flags;
>  	int pasid;
> +	int gpasid; /* Guest PASID in case of vSVA bind with non-identity host
> +		     * to guest PASID mapping.
> +		     */
>  	struct list_head devs;
>  	struct list_head list;
> +	refcount_t refs; /* Number of devices sharing this PASID */
>  };
>  
>  extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index e3f7631..577d5df 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -52,6 +52,23 @@ struct svm_dev_ops {
>   * do such IOTLB flushes automatically.
>   */
>  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> +/*
> + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind to a device.
> + * In this case the mm_struct is in the guest kernel or userspace, its life
> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this API provides
> + * means to bind/unbind guest CR3 with PASIDs allocated for a device.
> + */
> +#define SVM_FLAG_GUEST_MODE	(1<<2)
> +/*
> + * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID space,
> + * which requires guest and host PASID translation at both directions. We keep
> + * track of guest PASID in order to provide lookup service to device drivers.
> + * One such example is a physical function (PF) driver that supports mediated
> + * device (mdev) assignment. Guest programming of mdev configuration space can
> + * only be done with guest PASID, therefore PF driver needs to find the matching
> + * host PASID to program the real hardware.
> + */
> +#define SVM_FLAG_GUEST_PASID	(1<<3)
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  
> 

Thanks

Eric
