Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F6E10B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 05:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbfJWD7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 23:59:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:14139 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbfJWD7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 23:59:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 20:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="209908838"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 22 Oct 2019 20:59:39 -0700
Date:   Tue, 22 Oct 2019 21:04:00 -0700
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
Subject: Re: [PATCH v6 02/10] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20191022210400.357e69a9@jacob-builder>
In-Reply-To: <20191023005129.GC100970@otc-nc-03>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571788403-42095-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20191023005129.GC100970@otc-nc-03>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 17:51:29 -0700
"Raj, Ashok" <ashok.raj@intel.com> wrote:

> On Tue, Oct 22, 2019 at 04:53:15PM -0700, Jacob Pan wrote:
> > When VT-d driver runs in the guest, PASID allocation must be
> > performed via virtual command interface. This patch registers a
> > custom IOASID allocator which takes precedence over the default
> > XArray based allocator. The resulting IOASID allocation will always
> > come from the host. This ensures that PASID namespace is system-
> > wide.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/Kconfig       |  1 +
> >  drivers/iommu/intel-iommu.c | 67
> > +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |  2 ++ 3 files changed, 70
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index fd50ddffffbf..961fe5795a90 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -211,6 +211,7 @@ config INTEL_IOMMU_SVM
> >  	bool "Support for Shared Virtual Memory with Intel IOMMU"
> >  	depends on INTEL_IOMMU && X86
> >  	select PCI_PASID
> > +	select IOASID
> >  	select MMU_NOTIFIER
> >  	help
> >  	  Shared Virtual Memory (SVM) provides a facility for
> > devices diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 3f974919d3bd..3aff0141c522
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1706,6 +1706,8 @@ static void free_dmar_iommu(struct
> > intel_iommu *iommu) if (ecap_prs(iommu->ecap))
> >  			intel_svm_finish_prq(iommu);
> >  	}
> > +	ioasid_unregister_allocator(&iommu->pasid_allocator);
> > +
> >  #endif
> >  }
> >  
> > @@ -4910,6 +4912,46 @@ static int __init
> > probe_acpi_namespace_devices(void) return 0;
> >  }
> >  
> > +#ifdef CONFIG_INTEL_IOMMU_SVM  
> 
> Maybe move them to intel-svm.c instead? that's where the bulk
> of the svm support is?
> 
The reason I put them in intel-iommu.c is that pasid allocators need to
be registered during initialization of Intel iommu. No strong
preference.

> > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > void *data) +{
> > +	struct intel_iommu *iommu = data;
> > +	ioasid_t ioasid;
> > +
> > +	/*
> > +	 * VT-d virtual command interface always uses the full 20
> > bit
> > +	 * PASID range. Host can partition guest PASID range based
> > on
> > +	 * policies but it is out of guest's control.
> > +	 */
> > +	if (min < PASID_MIN || max > PASID_MAX)
> > +		return INVALID_IOASID;  
> 
> What are these PASID_MIN/MAX? Do you check if these are within the 
> limits supported by the iommu/vIOMMU as its enumerated?
> 
PASID_MIN/MAX is the full range, 1-2M.
I do not check range because VCMD interface will always use the
full range. vIOMMU will always support full 20 bit guest PASID.
The host VFIO code calls IOASID allocator which should respect IOMMU
enumerated range.
> 
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +
> > +	return ioasid;
> > +}
> > +
> > +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> > +{
> > +	struct iommu_pasid_alloc_info *svm;
> > +	struct intel_iommu *iommu = data;
> > +
> > +	if (!iommu)
> > +		return;
> > +	/*
> > +	 * Sanity check the ioasid owner is done at upper layer,
> > e.g. VFIO
> > +	 * We can only free the PASID when all the devices are
> > unbond.
> > +	 */
> > +	svm = ioasid_find(NULL, ioasid, NULL);
> > +	if (!svm) {
> > +		pr_warn("Freeing unbond IOASID %d\n", ioasid);
> > +		return;
> > +	}
> > +	vcmd_free_pasid(iommu, ioasid);
> > +}
> > +#endif
> > +
> >  int __init intel_iommu_init(void)
> >  {
> >  	int ret = -ENODEV;
> > @@ -5020,6 +5062,31 @@ int __init intel_iommu_init(void)
> >  				       "%s", iommu->name);
> >  		iommu_device_set_ops(&iommu->iommu,
> > &intel_iommu_ops); iommu_device_register(&iommu->iommu);
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +		if (cap_caching_mode(iommu->cap) &&
> > sm_supported(iommu)) {  
> 
> do you need to check against cap_caching_mode() or ecap_vcmd?
> 
I guess ecap_vcmd() will suffice. Kind of redundant.
> 
> > +			/*
> > +			 * Register a custom ASID allocator if we
> > are running
> > +			 * in a guest, the purpose is to have a
> > system wide PASID
> > +			 * namespace among all PASID users.
> > +			 * There can be multiple vIOMMUs in each
> > guest but only
> > +			 * one allocator is active. All vIOMMU
> > allocators will
> > +			 * eventually be calling the same host
> > allocator.
> > +			 */
> > +			iommu->pasid_allocator.alloc =
> > intel_ioasid_alloc;
> > +			iommu->pasid_allocator.free =
> > intel_ioasid_free;
> > +			iommu->pasid_allocator.pdata = (void
> > *)iommu;
> > +			ret =
> > ioasid_register_allocator(&iommu->pasid_allocator);
> > +			if (ret) {
> > +				pr_warn("Custom PASID allocator
> > registeration failed\n");
> > +				/*
> > +				 * Disable scalable mode on this
> > IOMMU if there
> > +				 * is no custom allocator. Mixing
> > SM capable vIOMMU
> > +				 * and non-SM vIOMMU are not
> > supported.
> > +				 */
> > +				intel_iommu_sm = 0;
> > +			}
> > +		}
> > +#endif
> >  	}
> >  
> >  	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index eea7468694a7..fb1973a761c1
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/dmar.h>
> > +#include <linux/ioasid.h>
> >  
> >  #include <asm/cacheflush.h>
> >  #include <asm/iommu.h>
> > @@ -542,6 +543,7 @@ struct intel_iommu {
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> >  	struct page_req_dsc *prq;
> >  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> > +	struct ioasid_allocator_ops pasid_allocator; /* Custom
> > allocator for PASIDs */ #endif
> >  	struct q_inval  *qi;            /* Queued invalidation
> > info */ u32 *iommu_state; /* Store iommu states between suspend and
> > resume.*/ -- 
> > 2.7.4
> >   

[Jacob Pan]
