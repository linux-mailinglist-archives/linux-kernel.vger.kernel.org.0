Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF6E10C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 06:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfJWEPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 00:15:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:40073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfJWEPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:15:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 21:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="201874968"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2019 21:15:09 -0700
Date:   Tue, 22 Oct 2019 21:19:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 03/10] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
Message-ID: <20191022211930.2ef8138f@jacob-builder>
In-Reply-To: <20191023005859.GD100970@otc-nc-03>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571788403-42095-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20191023005859.GD100970@otc-nc-03>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 17:58:59 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> On Tue, Oct 22, 2019 at 04:53:16PM -0700, Jacob Pan wrote:
> > Make use of generic IOASID code to manage PASID allocation,
> > free, and lookup. Replace Intel specific code.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 12 ++++++------
> >  drivers/iommu/intel-pasid.c | 36
> > ------------------------------------ drivers/iommu/intel-svm.c   |
> > 37 +++++++++++++++++++++---------------- 3 files changed, 27
> > insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 3aff0141c522..72febcf2c48f
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5311,7 +5311,7 @@ static void auxiliary_unlink_device(struct
> > dmar_domain *domain, domain->auxd_refcnt--;
> >  
> >  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		intel_pasid_free_id(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);  
> 
> if the domain is gauranteed to be torn down, its ok.. but otherwise
> do you need to clear domain->default_pasid to avoid accidental
> reference in some other code path?
> 
Good point, but i think it is out of the scope of this patch. Perhaps
another patch to fix that.
> >  }
> >  
> >  static int aux_domain_add_dev(struct dmar_domain *domain,
> > @@ -5329,10 +5329,10 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, if (domain->default_pasid <= 0) {
> >  		int pasid;
> >  
> > -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> > -
> > pci_max_pasids(to_pci_dev(dev)),
> > -					     GFP_KERNEL);
> > -		if (pasid <= 0) {
> > +		/* No private data needed for the default pasid */
> > +		pasid = ioasid_alloc(NULL, PASID_MIN,
> > pci_max_pasids(to_pci_dev(dev)) - 1,  
> 
> If we ensure IOMMU max-pasid is full 20bit width, its good. In a
> vIOMMU if iommu max pasid is restricted for some kind of partitioning
> in future you want to consider limiting to no more than what's
> provisioned in the vIOMMU right?
> 
Yes, I agree we should double check IOMMU ecap PSS.
But it is outside the scope of this patch, which is merely replacing the
current logic with a different API.
Also, unless we do nested mdev, this code should run in host only,
no vIOMMU, right?
> 
> > +				NULL);
> > +		if (pasid == INVALID_IOASID) {
> >  			pr_err("Can't allocate default pasid\n");
> >  			return -ENODEV;
> >  		}
> > @@ -5368,7 +5368,7 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, spin_unlock(&iommu->lock);
> >  	spin_unlock_irqrestore(&device_domain_lock, flags);
> >  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		intel_pasid_free_id(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >  
> >  	return ret;
> >  }
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 76bcbb21e112..c0d1f28d3412
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -26,42 +26,6 @@
> >   */
> >  static DEFINE_SPINLOCK(pasid_lock);
> >  u32 intel_pasid_max_id = PASID_MAX;
> > -static DEFINE_IDR(pasid_idr);
> > -
> > -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
> > -{
> > -	int ret, min, max;
> > -
> > -	min = max_t(int, start, PASID_MIN);
> > -	max = min_t(int, end, intel_pasid_max_id);
> > -
> > -	WARN_ON(in_interrupt());
> > -	idr_preload(gfp);
> > -	spin_lock(&pasid_lock);
> > -	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
> > -	spin_unlock(&pasid_lock);
> > -	idr_preload_end();
> > -
> > -	return ret;
> > -}
> > -
> > -void intel_pasid_free_id(int pasid)
> > -{
> > -	spin_lock(&pasid_lock);
> > -	idr_remove(&pasid_idr, pasid);
> > -	spin_unlock(&pasid_lock);
> > -}
> > -
> > -void *intel_pasid_lookup_id(int pasid)
> > -{
> > -	void *p;
> > -
> > -	spin_lock(&pasid_lock);
> > -	p = idr_find(&pasid_idr, pasid);
> > -	spin_unlock(&pasid_lock);
> > -
> > -	return p;
> > -}
> >  
> >  static int check_vcmd_pasid(struct intel_iommu *iommu)
> >  {
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 9b159132405d..5aef5b7bf561 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/dmar.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/ioasid.h>
> >  #include <asm/page.h>
> >  
> >  #include "intel-pasid.h"
> > @@ -318,16 +319,15 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (pasid_max >
> > intel_pasid_max_id) pasid_max = intel_pasid_max_id;
> >  
> > -		/* Do not use PASID 0 in caching mode (virtualised
> > IOMMU) */
> > -		ret = intel_pasid_alloc_id(svm,
> > -					   !!cap_caching_mode(iommu->cap),
> > -					   pasid_max - 1,
> > GFP_KERNEL);
> > -		if (ret < 0) {
> > +		/* Do not use PASID 0, reserved for RID to PASID */
> > +		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> > +					pasid_max - 1, svm);
> > +		if (svm->pasid == INVALID_IOASID) {
> >  			kfree(svm);
> >  			kfree(sdev);
> > +			ret = ENOSPC;
> >  			goto out;
> >  		}
> > -		svm->pasid = ret;
> >  		svm->notifier.ops = &intel_mmuops;
> >  		svm->mm = mm;
> >  		svm->flags = flags;
> > @@ -337,7 +337,7 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (mm) {
> >  			ret =
> > mmu_notifier_register(&svm->notifier, mm); if (ret) {
> > -				intel_pasid_free_id(svm->pasid);
> > +				ioasid_free(svm->pasid);
> >  				kfree(svm);
> >  				kfree(sdev);
> >  				goto out;
> > @@ -353,7 +353,7 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (ret) {
> >  			if (mm)
> >  				mmu_notifier_unregister(&svm->notifier,
> > mm);
> > -			intel_pasid_free_id(svm->pasid);
> > +			ioasid_free(svm->pasid);
> >  			kfree(svm);
> >  			kfree(sdev);
> >  			goto out;
> > @@ -401,7 +401,12 @@ int intel_svm_unbind_mm(struct device *dev,
> > int pasid) if (!iommu)
> >  		goto out;
> >  
> > -	svm = intel_pasid_lookup_id(pasid);
> > +	svm = ioasid_find(NULL, pasid, NULL);
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> > +
> >  	if (!svm)
> >  		goto out;
> >  
> > @@ -423,7 +428,7 @@ int intel_svm_unbind_mm(struct device *dev, int
> > pasid) kfree_rcu(sdev, rcu);
> >  
> >  				if (list_empty(&svm->devs)) {
> > -
> > intel_pasid_free_id(svm->pasid);
> > +					ioasid_free(svm->pasid);
> >  					if (svm->mm)
> >  						mmu_notifier_unregister(&svm->notifier,
> > svm->mm); 
> > @@ -458,10 +463,11 @@ int intel_svm_is_pasid_valid(struct device
> > *dev, int pasid) if (!iommu)
> >  		goto out;
> >  
> > -	svm = intel_pasid_lookup_id(pasid);
> > -	if (!svm)
> > +	svm = ioasid_find(NULL, pasid, NULL);
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> >  		goto out;
> > -
> > +	}
> >  	/* init_mm is used in this case */
> >  	if (!svm->mm)
> >  		ret = 1;
> > @@ -568,13 +574,12 @@ static irqreturn_t prq_event_thread(int irq,
> > void *d) 
> >  		if (!svm || svm->pasid != req->pasid) {
> >  			rcu_read_lock();
> > -			svm = intel_pasid_lookup_id(req->pasid);
> > +			svm = ioasid_find(NULL, req->pasid, NULL);
> >  			/* It *can't* go away, because the driver
> > is not permitted
> >  			 * to unbind the mm while any page faults
> > are outstanding.
> >  			 * So we only need RCU to protect the
> > internal idr code. */ rcu_read_unlock();
> > -
> > -			if (!svm) {
> > +			if (IS_ERR(svm) || !svm) {
> >  				pr_err("%s: Page request for
> > invalid PASID %d: %08llx %08llx\n", iommu->name, req->pasid,
> > ((unsigned long long *)req)[0], ((unsigned long long *)req)[1]);
> > -- 
> > 2.7.4
> >   
