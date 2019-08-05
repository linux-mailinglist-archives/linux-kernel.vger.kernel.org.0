Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2E58267C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHEU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 16:58:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:22862 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbfHEU64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:58:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 13:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="325430305"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2019 13:58:43 -0700
Date:   Mon, 5 Aug 2019 14:02:21 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
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
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 11/22] iommu: Introduce guest PASID bind function
Message-ID: <20190805140221.14da41e2@jacob-builder>
In-Reply-To: <706dacc1-18de-2a9a-23d9-3e10e9b14262@redhat.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-12-git-send-email-jacob.jun.pan@linux.intel.com>
        <706dacc1-18de-2a9a-23d9-3e10e9b14262@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 18:44:56 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 6/9/19 3:44 PM, Jacob Pan wrote:
> > Guest shared virtual address (SVA) may require host to shadow guest
> > PASID tables. Guest PASID can also be allocated from the host via
> > enlightened interfaces. In this case, guest needs to bind the guest
> > mm, i.e. cr3 in guest physical address to the actual PASID table in
> > the host IOMMU. Nesting will be turned on such that guest virtual
> > address can go through a two level translation:
> > - 1st level translates GVA to GPA
> > - 2nd level translates GPA to HPA
> > This patch introduces APIs to bind guest PASID data to the assigned
> > device entry in the physical IOMMU. See the diagram below for usage
> > explaination.
> > 
> >     .-------------.  .---------------------------.
> >     |   vIOMMU    |  | Guest process mm, FL only |
> >     |             |  '---------------------------'
> >     .----------------/
> >     | PASID Entry |--- PASID cache flush -
> >     '-------------'                       |
> >     |             |                       V
> >     |             |                      GP
> >     '-------------'
> > Guest
> > ------| Shadow |----------------------- GP->HP* ---------
> >       v        v                          |
> > Host                                      v
> >     .-------------.  .----------------------.
> >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >     |             |  '----------------------'
> >     .----------------/  |
> >     | PASID Entry |     V (Nested xlate)
> >     '----------------\.---------------------.
> >     |             |   |Set SL to GPA-HPA    |
> >     |             |   '---------------------'
> >     '-------------'
> > 
> > Where:
> >  - FL = First level/stage one page tables
> >  - SL = Second level/stage two page tables
> >  - GP = Guest PASID
> >  - HP = Host PASID
> > * Conversion needed if non-identity GP-HP mapping option is chosen.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommu.c      | 20 ++++++++++++++++
> >  include/linux/iommu.h      | 21 +++++++++++++++++
> >  include/uapi/linux/iommu.h | 58
> > ++++++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 99
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 1758b57..d0416f60 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1648,6 +1648,26 @@ int iommu_cache_invalidate(struct
> > iommu_domain *domain, struct device *dev, }
> >  EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> >  
> > +int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > +			struct device *dev, struct
> > gpasid_bind_data *data) +{
> > +	if (unlikely(!domain->ops->sva_bind_gpasid))
> > +		return -ENODEV;
> > +
> > +	return domain->ops->sva_bind_gpasid(domain, dev, data);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> > +
> > +int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +			ioasid_t pasid)
> > +{
> > +	if (unlikely(!domain->ops->sva_unbind_gpasid))
> > +		return -ENODEV;
> > +
> > +	return domain->ops->sva_unbind_gpasid(dev, pasid);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 8d766a8..560c8c8 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -25,6 +25,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/err.h>
> >  #include <linux/of.h>
> > +#include <linux/ioasid.h>
> >  #include <uapi/linux/iommu.h>
> >  
> >  #define IOMMU_READ	(1 << 0)
> > @@ -267,6 +268,8 @@ struct page_response_msg {
> >   * @detach_pasid_table: detach the pasid table
> >   * @cache_invalidate: invalidate translation caches
> >   * @pgsize_bitmap: bitmap of all possible supported page sizes
> > + * @sva_bind_gpasid: bind guest pasid and mm
> > + * @sva_unbind_gpasid: unbind guest pasid and mm  
> comment vs field ordering as pointed out by Jonathan on other patches
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -332,6 +335,10 @@ struct iommu_ops {
> >  	int (*page_response)(struct device *dev, struct
> > page_response_msg *msg); int (*cache_invalidate)(struct
> > iommu_domain *domain, struct device *dev, struct
> > iommu_cache_invalidate_info *inv_info);
> > +	int (*sva_bind_gpasid)(struct iommu_domain *domain,
> > +			struct device *dev, struct
> > gpasid_bind_data *data); +
> > +	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> >  
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -447,6 +454,10 @@ extern void iommu_detach_pasid_table(struct
> > iommu_domain *domain); extern int iommu_cache_invalidate(struct
> > iommu_domain *domain, struct device *dev,
> >  				  struct
> > iommu_cache_invalidate_info *inv_info); +extern int
> > iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > +		struct device *dev, struct gpasid_bind_data *data);
> > +extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> > +				struct device *dev, ioasid_t
> > pasid); extern struct iommu_domain *iommu_get_domain_for_dev(struct
> > device *dev); extern struct iommu_domain
> > *iommu_get_dma_domain(struct device *dev); extern int
> > iommu_map(struct iommu_domain *domain, unsigned long iova, @@
> > -998,6 +1009,16 @@ iommu_cache_invalidate(struct iommu_domain
> > *domain, { return -ENODEV;
> >  }
> > +static inline int iommu_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > +				struct device *dev, struct
> > gpasid_bind_data *data) +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int sva_unbind_gpasid(struct device *dev, int pasid)
> > +{
> > +	return -ENODEV;
> > +}
> >  
> >  #endif /* CONFIG_IOMMU_API */
> >  
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index ca4b753..a9cdc63 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -277,4 +277,62 @@ struct iommu_cache_invalidate_info {
> >  	};
> >  };
> >  
> > +/**
> > + * struct gpasid_bind_data_vtd - Intel VT-d specific data on
> > device and guest
> > + * SVA binding.
> > + *
> > + * @flags:	VT-d PASID table entry attributes
> > + * @pat:	Page attribute table data to compute effective
> > memory type
> > + * @emt:	Extended memory type
> > + *
> > + * Only guest vIOMMU selectable and effective options are passed
> > down to
> > + * the host IOMMU.
> > + */
> > +struct gpasid_bind_data_vtd {
> > +#define IOMMU_SVA_VTD_GPASID_SRE	(1 << 0) /* supervisor
> > request */ +#define IOMMU_SVA_VTD_GPASID_EAFE	(1 << 1) /*
> > extended access enable */ +#define IOMMU_SVA_VTD_GPASID_PCD
> > (1 << 2) /* page-level cache disable */ +#define
> > IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write
> > through */ +#define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /*
> > extended mem type enable */ +#define
> > IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level
> > cache disable */
> > +	__u64 flags;
> > +	__u32 pat;
> > +	__u32 emt;
> > +};
> > +
> > +/**
> > + * struct gpasid_bind_data - Information about device and guest
> > PASID binding
> > + * @version:	Version of this data structure
> > + * @format:	PASID table entry format
> > + * @flags:	Additional information on guest bind request
> > + * @gpgd:	Guest page directory base of the guest mm to bind
> > + * @hpasid:	Process address space ID used for the guest mm
> > in host IOMMU
> > + * @gpasid:	Process address space ID used for the guest mm
> > in guest IOMMU
> > + * @addr_width:	Guest virtual address width> + *
> > @vtd:	Intel VT-d specific data
> > + *
> > + * Guest to host PASID mapping can be an identity or non-identity,
> > where guest
> > + * has its own PASID space. For non-identify mapping, guest to
> > host PASID lookup
> > + * is needed when VM programs guest PASID into an assigned device.
> > VMM may
> > + * trap such PASID programming then request host IOMMU driver to
> > convert guest
> > + * PASID to host PASID based on this bind data.  
> Sorry I don't get when you have separate PASID space as I understand
> you eventually allocate the guest PASID with the host allocator
> (though paravirt)
For the current version it is true that we eventually allocate PASID
from the host. But in the future, we also want to support non-identical
host-guest PASID mapping. So want to leave space in the API to support
such case in the future.

> > + */
> > +struct gpasid_bind_data {  
> other structs in iommu.h are prefixed with iommu_?
> > +#define IOMMU_GPASID_BIND_VERSION_1	1
> > +	__u32 version;
> > +#define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > +	__u32 format;
> > +#define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid
> > */
> > +	__u64 flags;
> > +	__u64 gpgd;
> > +	__u64 hpasid;> +	__u64 gpasid;
> > +	__u32 addr_width;
> > +	__u8  padding[4];
> > +	/* Vendor specific data */
> > +	union {
> > +		struct gpasid_bind_data_vtd vtd;
> > +	};  
> vtd is not used in the series if I am not wrong
you are right. we had some internal discussion on what PASID entry
fields are actively used in the native case, whether they need to be
passed down or always set by the driver. It will be used in v5.

Thanks,

> > +};
> > +
> >  #endif /* _UAPI_IOMMU_H */
> >   
> Thanks
> 
> Eric

[Jacob Pan]
