Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D689E57F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 04:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfJZCD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 22:03:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:17121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfJZCD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 22:03:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 19:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="224095675"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 19:03:53 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a9a1c3ed-0134-f531-fbf1-789f6cc78ce3@linux.intel.com>
Date:   Sat, 26 Oct 2019 10:01:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/19 3:55 AM, Jacob Pan wrote:
> When supporting guest SVA with emulated IOMMU, the guest PASID
> table is shadowed in VMM. Updates to guest vIOMMU PASID table
> will result in PASID cache flush which will be passed down to
> the host as bind guest PASID calls.
> 
> For the SL page tables, it will be harvested from device's
> default domain (request w/o PASID), or aux domain in case of
> mediated device.
> 
>      .-------------.  .---------------------------.
>      |   vIOMMU    |  | Guest process CR3, FL only|
>      |             |  '---------------------------'
>      .----------------/
>      | PASID Entry |--- PASID cache flush -
>      '-------------'                       |
>      |             |                       V
>      |             |                CR3 in GPA
>      '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>        v        v                          v
> Host
>      .-------------.  .----------------------.
>      |   pIOMMU    |  | Bind FL for GVA-GPA  |
>      |             |  '----------------------'
>      .----------------/  |
>      | PASID Entry |     V (Nested xlate)
>      '----------------\.------------------------------.
>      |             |   |SL for GPA-HPA, default domain|
>      |             |   '------------------------------'
>      '-------------'
> Where:
>   - FL = First level/stage one page tables
>   - SL = Second level/stage two page tables
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>   drivers/iommu/intel-iommu.c |   4 +
>   drivers/iommu/intel-svm.c   | 184 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/intel-iommu.h |   8 +-
>   include/linux/intel-svm.h   |  17 ++++
>   4 files changed, 212 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index acd1ac787d8b..5fab32fbc4b4 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6026,6 +6026,10 @@ const struct iommu_ops intel_iommu_ops = {
>   	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>   	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>   	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> +#endif
>   };
>   
>   static void quirk_iommu_igfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index a18b02a9709d..ae13a310cf96 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -216,6 +216,190 @@ static LIST_HEAD(global_svm_list);
>   	list_for_each_entry(sdev, &svm->devs, list)	\
>   	if (dev == sdev->dev)				\

Add an indent tab please.

>   
> +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +			struct device *dev,
> +			struct iommu_gpasid_bind_data *data)
> +{
> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct dmar_domain *ddomain;
> +	struct intel_svm_dev *sdev;
> +	struct intel_svm *svm;
> +	int ret = 0;
> +
> +	if (WARN_ON(!iommu) || !data)
> +		return -EINVAL;
> +
> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> +		data->format != IOMMU_PASID_FORMAT_INTEL_VTD)

Alignment should match open parenthesis.

Run "scripts/checkpatch.pl --strict" for all in this patch. I will
ignore others.

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
> +	 */
> +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
> +		return -EINVAL;
> +
> +	ddomain = to_dmar_domain(domain);
> +	/* REVISIT:
> +	 * Sanity check adddress width and paging mode support

s/adddress/address/g

> +	 * width matching in two dimensions:
> +	 * 1. paging mode CPU <= IOMMU
> +	 * 2. address width Guest <= Host.
> +	 */ > +	mutex_lock(&pasid_mutex);
> +	svm = ioasid_find(NULL, data->hpasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}

A blank line looks better.

> +	if (svm) {
> +		/*
> +		 * If we found svm for the PASID, there must be at
> +		 * least one device bond, otherwise svm should be freed.
> +		 */
> +		BUG_ON(list_empty(&svm->devs));

Avoid crashing kernel, use WARN_ON() instead.

	if (WARN_ON(list_empty(&svm->devs))) {
		ret = -EINVAL;
		goto out;
	}

> +
> +		for_each_svm_dev(svm, dev) {
> +			/* In case of multiple sub-devices of the same pdev assigned, we should

Make line shorter. Not over 80 characters.

The same for other lines.

> +			 * allow multiple bind calls with the same PASID and pdev.
> +			 */
> +			sdev->users++;
> +			goto out;
> +		}

I remember I ever pointed this out before. But I forgot how we addressed
it. So forgive me if this has been addressed.

What if we have a valid bound svm but @dev doesn't belong to it
(a.k.a. @dev not in svm->devs list)?

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
> +			svm->flags |= SVM_FLAG_GUEST_PASID;
> +		}
> +		ioasid_set_data(data->hpasid, svm);
> +		INIT_LIST_HEAD_RCU(&svm->devs);
> +		INIT_LIST_HEAD(&svm->list);
> +
> +		mmput(svm->mm);
> +	}

A blank line, please.

> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev) {
> +		if (list_empty(&svm->devs))
> +			kfree(svm);

This is dangerous. This might leave a wild pointer bound with gpasid.

> +		ret = -ENOMEM;
> +		goto out;
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
> +				&data->vtd,
> +				ddomain,
> +				data->addr_width);
> +	if (ret) {
> +		dev_err(dev, "Failed to set up PASID %llu in nested mode, Err %d\n",
> +			data->hpasid, ret);

This error handling is insufficient. You should at least:

1. free sdev
2. if list_empty(&svm->devs)
	unbound the svm from gpasid
	free svm

The same for above error handling. Add a branch for error recovery at
the end of function might help here.

> +		kfree(sdev);
> +		goto out;
> +	}
> +	svm->flags |= SVM_FLAG_GUEST_MODE;
> +
> +	init_rcu_head(&sdev->rcu);
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

Make it symmetrical with bind function.

	if (WARN_ON(!iommu))
		goto out;

> +
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR_OR_NULL(svm)) {
> +		ret = PTR_ERR(svm);

If svm == NULL, this function will return success. This is not expected,
right?

> +		goto out;
> +	}
> +
> +	for_each_svm_dev(svm, dev) {
> +		ret = 0;
> +		sdev->users--;
> +		if (!sdev->users) {
> +			list_del_rcu(&sdev->list);
> +			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> +			/* TODO: Drain in flight PRQ for the PASID since it
> +			 * may get reused soon, we don't want to
> +			 * confuse with its previous life.
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

Exchange order. First unbind svm from gpasid and then free svm.

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
>   int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>   {
>   	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3dba6ad3e9ad..6c74c71b1ebf 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -673,7 +673,9 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
>   int intel_svm_init(struct intel_iommu *iommu);
>   extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>   extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -
> +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_gpasid_bind_data *data);
> +extern int intel_svm_unbind_gpasid(struct device *dev, int pasid);
>   struct svm_dev_ops;
>   
>   struct intel_svm_dev {
> @@ -690,9 +692,13 @@ struct intel_svm_dev {
>   struct intel_svm {
>   	struct mmu_notifier notifier;
>   	struct mm_struct *mm;
> +
>   	struct intel_iommu *iommu;
>   	int flags;
>   	int pasid;
> +	int gpasid; /* Guest PASID in case of vSVA bind with non-identity host
> +		     * to guest PASID mapping.
> +		     */
>   	struct list_head devs;
>   	struct list_head list;
>   };
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index 94f047a8a845..a2c189ad0b01 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -44,6 +44,23 @@ struct svm_dev_ops {
>    * do such IOTLB flushes automatically.
>    */
>   #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> +/*
> + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind to a device.
> + * In this case the mm_struct is in the guest kernel or userspace, its life
> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this API provides
> + * means to bind/unbind guest CR3 with PASIDs allocated for a device.
> + */
> +#define SVM_FLAG_GUEST_MODE	(1<<2)

How about keeping this aligned with top by adding a tab?

BIT macro is preferred. Hence, make it BIT(1), BIT(2), BIT(3) is
preferred.

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

Ditto.

Best regards,
baolu
