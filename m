Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726C3E4292
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 06:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389755AbfJYEiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 00:38:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:21871 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbfJYEiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 00:38:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 21:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="282150315"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2019 21:38:49 -0700
Date:   Thu, 24 Oct 2019 21:43:11 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 03/11] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20191024214311.43d76a5c@jacob-builder>
In-Reply-To: <ae437be4-e633-e670-0e1f-d07b4364f651@linux.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571946904-86776-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <ae437be4-e633-e670-0e1f-d07b4364f651@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

Thanks for the review. please see my comments inline.

On Fri, 25 Oct 2019 10:30:48 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 10/25/19 3:54 AM, Jacob Pan wrote:
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
> >   drivers/iommu/Kconfig       |  1 +
> >   drivers/iommu/intel-iommu.c | 67
> > +++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |  2 ++ 3 files changed, 70
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index fd50ddffffbf..961fe5795a90 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -211,6 +211,7 @@ config INTEL_IOMMU_SVM
> >   	bool "Support for Shared Virtual Memory with Intel IOMMU"
> >   	depends on INTEL_IOMMU && X86
> >   	select PCI_PASID
> > +	select IOASID
> >   	select MMU_NOTIFIER
> >   	help
> >   	  Shared Virtual Memory (SVM) provides a facility for
> > devices diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 3f974919d3bd..ced1d89ef977
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1706,6 +1706,9 @@ static void free_dmar_iommu(struct
> > intel_iommu *iommu) if (ecap_prs(iommu->ecap))
> >   			intel_svm_finish_prq(iommu);
> >   	}
> > +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> > +
> > ioasid_unregister_allocator(&iommu->pasid_allocator);  
> 
> Since scalable mode is disabled if pasid allocator failed to register,
> add sm_support(iommu) check here will be better.
> 
I was thinking to be symmetric with register call, checking for the
same conditions. Also, I like your advice below to only disable SVA
instead of scalable mode.
> > +
> >   #endif
> >   }
> >   
> > @@ -4910,6 +4913,44 @@ static int __init
> > probe_acpi_namespace_devices(void) return 0;
> >   }
> >   
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
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
> > +	if (min < PASID_MIN || max > intel_pasid_max_id)
> > +		return INVALID_IOASID;
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +
> > +	return ioasid;
> > +}
> > +
> > +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> > +{
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
> > +	if (ioasid_find(NULL, ioasid, NULL)) {
> > +		pr_alert("Cannot free active IOASID %d\n", ioasid);
> > +		return;
> > +	}
> > +	vcmd_free_pasid(iommu, ioasid);
> > +}
> > +#endif
> > +
> >   int __init intel_iommu_init(void)
> >   {
> >   	int ret = -ENODEV;
> > @@ -5020,6 +5061,32 @@ int __init intel_iommu_init(void)
> >   				       "%s", iommu->name);
> >   		iommu_device_set_ops(&iommu->iommu,
> > &intel_iommu_ops); iommu_device_register(&iommu->iommu);
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +		if (ecap_vcs(iommu->ecap) &&
> > vccap_pasid(iommu->vccap)) {
> > +			pr_info("Register custom PASID
> > allocator\n");
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
> 
> It's insufficient to disable scalable mode by only clearing
> intel_iommu_sm. The DMA_RTADDR_SMT bit in root entry has already been
> set. Probably, you need to
> 
> for each iommu
> 	clear DMA_RTADDR_SMT in root entry
> 
> Alternatively, since vSVA is the only customer of this custom PASID
> allocator, is it possible to only disable SVA here?
> 
Yeah, I think disable SVA is better. We can still do gIOVA in SM. I
guess we need to introduce a flag for sva_enabled.
> > +			}
> > +		}
> > +#endif
> >   	}
> >   
> >   	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 1d4b8dcdc5d8..c624733cb2e6
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -19,6 +19,7 @@
> >   #include <linux/iommu.h>
> >   #include <linux/io-64-nonatomic-lo-hi.h>
> >   #include <linux/dmar.h>
> > +#include <linux/ioasid.h>
> >   
> >   #include <asm/cacheflush.h>
> >   #include <asm/iommu.h>
> > @@ -546,6 +547,7 @@ struct intel_iommu {
> >   #ifdef CONFIG_INTEL_IOMMU_SVM
> >   	struct page_req_dsc *prq;
> >   	unsigned char prq_name[16];    /* Name for PRQ interrupt
> > */
> > +	struct ioasid_allocator_ops pasid_allocator; /* Custom
> > allocator for PASIDs */ #endif
> >   	struct q_inval  *qi;            /* Queued invalidation
> > info */ u32 *iommu_state; /* Store iommu states between suspend and
> > resume.*/ 
> 
> Best regards,
> baolu

[Jacob Pan]
