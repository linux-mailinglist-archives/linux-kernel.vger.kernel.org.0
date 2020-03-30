Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B486B198328
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 20:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgC3SQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Mar 2020 14:16:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:4449 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgC3SQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:16:04 -0400
IronPort-SDR: cUADZhr76F+e0hTj4XXobD8gV0KVXYq+lM7LLXHrDGz207l3x2nae0Yq94WjEKPLRKGsXIFrCL
 KWh4tS8KgItw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 11:16:03 -0700
IronPort-SDR: VueScOZHMnv2YlMT1V/jmezkFYo+mVj61gW8xR+pcaoZz++ET4SPPMANB204kaJu9e8sDn0xHg
 Eo3LQgMGMQSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="242106448"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 11:16:03 -0700
Date:   Mon, 30 Mar 2020 11:21:49 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Yi L <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 05/11] iommu/vt-d: Add nested translation helper
 function
Message-ID: <20200330112149.523d17af@jacob-builder>
In-Reply-To: <e500aa58-e37c-179a-c5de-5aae1ccaf410@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED9C1@SHSMSX104.ccr.corp.intel.com>
        <e500aa58-e37c-179a-c5de-5aae1ccaf410@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Mar 2020 16:03:36 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/3/27 20:21, Tian, Kevin wrote:
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Sent: Saturday, March 21, 2020 7:28 AM
> >>
> >> Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.  
> > 
> > now the spec is already at rev3.1 😊  
> 
> Updated.
> 
> >   
> >> With PASID granular translation type set to 0x11b, translation
> >> result from the first level(FL) also subject to a second level(SL)
> >> page table translation. This mode is used for SVA virtualization,
> >> where FL performs guest virtual to guest physical translation and
> >> SL performs guest physical to host physical translation.
> >>
> >> This patch adds a helper function for setting up nested translation
> >> where second level comes from a domain and first level comes from
> >> a guest PGD.
> >>
> >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel-pasid.c | 240
> >> +++++++++++++++++++++++++++++++++++++++++++-
> >>   drivers/iommu/intel-pasid.h |  12 +++
> >>   include/linux/intel-iommu.h |   3 +
> >>   3 files changed, 252 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iommu/intel-pasid.c
> >> b/drivers/iommu/intel-pasid.c index 9bdb7ee228b6..10c7856afc6b
> >> 100644 --- a/drivers/iommu/intel-pasid.c
> >> +++ b/drivers/iommu/intel-pasid.c
> >> @@ -359,6 +359,76 @@ pasid_set_flpm(struct pasid_entry *pe, u64
> >> value) pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
> >>   }
> >>
> >> +/*
> >> + * Setup the Extended Memory Type(EMT) field (Bits 91-93)
> >> + * of a scalable mode PASID entry.
> >> + */
> >> +static inline void
> >> +pasid_set_emt(struct pasid_entry *pe, u64 value)
> >> +{
> >> +	pasid_set_bits(&pe->val[1], GENMASK_ULL(29, 27), value <<
> >> 27); +}
> >> +
> >> +/*
> >> + * Setup the Page Attribute Table (PAT) field (Bits 96-127)
> >> + * of a scalable mode PASID entry.
> >> + */
> >> +static inline void
> >> +pasid_set_pat(struct pasid_entry *pe, u64 value)
> >> +{
> >> +	pasid_set_bits(&pe->val[1], GENMASK_ULL(63, 32), value <<
> >> 32); +}
> >> +
> >> +/*
> >> + * Setup the Cache Disable (CD) field (Bit 89)
> >> + * of a scalable mode PASID entry.
> >> + */
> >> +static inline void
> >> +pasid_set_cd(struct pasid_entry *pe)
> >> +{
> >> +	pasid_set_bits(&pe->val[1], 1 << 25, 1 << 25);
> >> +}
> >> +
> >> +/*
> >> + * Setup the Extended Memory Type Enable (EMTE) field (Bit 90)
> >> + * of a scalable mode PASID entry.
> >> + */
> >> +static inline void
> >> +pasid_set_emte(struct pasid_entry *pe)
> >> +{
> >> +	pasid_set_bits(&pe->val[1], 1 << 26, 1 << 26);
> >> +}
> >> +
> >> +/*
> >> + * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
> >> + * of a scalable mode PASID entry.
> >> + */
> >> +static inline void
> >> +pasid_set_eafe(struct pasid_entry *pe)
> >> +{
> >> +	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
> >> +}
> >> +
> >> +/*
> >> + * Setup the Page-level Cache Disable (PCD) field (Bit 95)
> >> + * of a scalable mode PASID entry.
> >> + */
> >> +static inline void
> >> +pasid_set_pcd(struct pasid_entry *pe)
> >> +{
> >> +	pasid_set_bits(&pe->val[1], 1 << 31, 1 << 31);
> >> +}
> >> +
> >> +/*
> >> + * Setup the Page-level Write-Through (PWT)) field (Bit 94)
> >> + * of a scalable mode PASID entry.
> >> + */
> >> +static inline void
> >> +pasid_set_pwt(struct pasid_entry *pe)
> >> +{
> >> +	pasid_set_bits(&pe->val[1], 1 << 30, 1 << 30);
> >> +}
> >> +
> >>   static void
> >>   pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
> >>   				    u16 did, int pasid)
> >> @@ -492,7 +562,7 @@ int intel_pasid_setup_first_level(struct
> >> intel_iommu *iommu,
> >>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> >>
> >>   	/* Setup Present and PASID Granular Transfer Type: */
> >> -	pasid_set_translation_type(pte, 1);
> >> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
> >>   	pasid_set_present(pte);
> >>   	pasid_flush_caches(iommu, pte, pasid, did);
> >>
> >> @@ -564,7 +634,7 @@ int intel_pasid_setup_second_level(struct
> >> intel_iommu *iommu,
> >>   	pasid_set_domain_id(pte, did);
> >>   	pasid_set_slptr(pte, pgd_val);
> >>   	pasid_set_address_width(pte, agaw);
> >> -	pasid_set_translation_type(pte, 2);
> >> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
> >>   	pasid_set_fault_enable(pte);
> >>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> >>
> >> @@ -598,7 +668,7 @@ int intel_pasid_setup_pass_through(struct
> >> intel_iommu *iommu,
> >>   	pasid_clear_entry(pte);
> >>   	pasid_set_domain_id(pte, did);
> >>   	pasid_set_address_width(pte, iommu->agaw);
> >> -	pasid_set_translation_type(pte, 4);
> >> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
> >>   	pasid_set_fault_enable(pte);
> >>   	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> >>
> >> @@ -612,3 +682,167 @@ int intel_pasid_setup_pass_through(struct
> >> intel_iommu *iommu,
> >>
> >>   	return 0;
> >>   }
> >> +
> >> +static int intel_pasid_setup_bind_data(struct intel_iommu *iommu,
> >> +				struct pasid_entry *pte,
> >> +				struct iommu_gpasid_bind_data_vtd
> >> *pasid_data)
> >> +{
> >> +	/*
> >> +	 * Not all guest PASID table entry fields are passed down
> >> during bind,
> >> +	 * here we only set up the ones that are dependent on
> >> guest settings.
> >> +	 * Execution related bits such as NXE, SMEP are not
> >> meaningful to IOMMU,
> >> +	 * therefore not set. Other fields, such as snoop
> >> related, are set based
> >> +	 * on host needs regardless of guest settings.
> >> +	 */
> >> +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_SRE) {
> >> +		if (!ecap_srs(iommu->ecap)) {
> >> +			pr_err("No supervisor request support on
> >> %s\n",
> >> +			       iommu->name);
> >> +			return -EINVAL;
> >> +		}
> >> +		pasid_set_sre(pte);
> >> +	}
> >> +
> >> +	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> >> +		if (!ecap_eafs(iommu->ecap)) {
> >> +			pr_err("No extended access flag support
> >> on %s\n",
> >> +				iommu->name);
> >> +			return -EINVAL;
> >> +		}
> >> +		pasid_set_eafe(pte);
> >> +	}
> >> +
> >> +	/*
> >> +	 * Memory type is only applicable to devices inside
> >> processor coherent
> >> +	 * domain. PCIe devices are not included. We can skip the
> >> rest of the
> >> +	 * flags if IOMMU does not support MTS.  
> > 
> > when you say that PCI devices are not included, is it simple for
> > information or should we impose some check to make sure below path
> > not applied to them?  
> 
> Jacob, does it work for you if I add below check?
> 
> 	if (ecap_mts(iommu->ecap) && !dev_is_pci(dev))
> 
> Or, we need to remove this comment line?
> 
> >   
> >> +	 */
> >> +	if (ecap_mts(iommu->ecap)) {
> >> +		if (pasid_data->flags &
> >> IOMMU_SVA_VTD_GPASID_EMTE) {
> >> +			pasid_set_emte(pte);
> >> +			pasid_set_emt(pte, pasid_data->emt);
> >> +		}
> >> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PCD)
> >> +			pasid_set_pcd(pte);
> >> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_PWT)
> >> +			pasid_set_pwt(pte);
> >> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_CD)
> >> +			pasid_set_cd(pte);
> >> +		pasid_set_pat(pte, pasid_data->pat);
> >> +	} else if (pasid_data->flags &
> >> IOMMU_SVA_VTD_GPASID_MTS_MASK) {
> >> +		pr_err("No memory type support for bind guest
> >> PASID on %s\n",
> >> +			iommu->name);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +}
> >> +
> >> +/**
> >> + * intel_pasid_setup_nested() - Set up PASID entry for nested
> >> translation.
> >> + * This could be used for guest shared virtual address. In this
> >> case, the
> >> + * first level page tables are used for GVA-GPA translation in
> >> the guest,
> >> + * second level page tables are used for GPA-HPA translation.  
> > 
> > GVA->GPA is just one example. It could be gIOVA->GPA too. Here the
> > point is that the first level is the translation table managed by
> > the guest.  
> 
> Agreed.
> 
Yes, that is why I chose the word "could be" :), but mention both cases
are good.

> >   
> >> + *
> >> + * @iommu:      IOMMU which the device belong to
> >> + * @dev:        Device to be set up for translation
> >> + * @gpgd:       FLPTPTR: First Level Page translation pointer in
> >> GPA
> >> + * @pasid:      PASID to be programmed in the device PASID table
> >> + * @pasid_data: Additional PASID info from the guest bind request
> >> + * @domain:     Domain info for setting up second level page
> >> tables
> >> + * @addr_width: Address width of the first level (guest)
> >> + */
> >> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> >> +			struct device *dev, pgd_t *gpgd,
> >> +			int pasid, struct
> >> iommu_gpasid_bind_data_vtd *pasid_data,
> >> +			struct dmar_domain *domain,
> >> +			int addr_width)
> >> +{
> >> +	struct pasid_entry *pte;
> >> +	struct dma_pte *pgd;
> >> +	int ret = 0;
> >> +	u64 pgd_val;
> >> +	int agaw;
> >> +	u16 did;
> >> +
> >> +	if (!ecap_nest(iommu->ecap)) {
> >> +		pr_err("IOMMU: %s: No nested translation
> >> support\n",
> >> +		       iommu->name);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	pte = intel_pasid_get_entry(dev, pasid);
> >> +	if (WARN_ON(!pte))
> >> +		return -EINVAL;  
> > 
> > should we have intel_pasid_get_entry to return error which is then
> > carried here? Looking at that function there could be error
> > conditions both being invalid parameter and no memory...  
> 
> Agreed. Will do this in a followup patch.
> 
> >   
> >> +
> >> +	/*
> >> +	 * Caller must ensure PASID entry is not in use, i.e. not
> >> bind the
> >> +	 * same PASID to the same device twice.
> >> +	 */
> >> +	if (pasid_pte_is_present(pte))
> >> +		return -EBUSY;  
> > 
> > is any lock held outside of this function? curious whether any race
> > condition may happen in between.  
> 
> The pasid entry change should always be protected by iommu->lock.
> 
Agreed.

> >   
> >> +
> >> +	pasid_clear_entry(pte);
> >> +
> >> +	/* Sanity checking performed by caller to make sure
> >> address
> >> +	 * width matching in two dimensions:
> >> +	 * 1. CPU vs. IOMMU
> >> +	 * 2. Guest vs. Host.
> >> +	 */
> >> +	switch (addr_width) {
> >> +	case ADDR_WIDTH_5LEVEL:
> >> +		if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> >> +			cap_5lp_support(iommu->cap)) {
> >> +			pasid_set_flpm(pte, 1);  
> > 
> > define a macro for 4lvl and 5lvl
> >   
> >> +		} else {
> >> +			dev_err(dev, "5-level paging not
> >> supported\n");
> >> +			return -EINVAL;
> >> +		}
> >> +		break;
> >> +	case ADDR_WIDTH_4LEVEL:
> >> +		pasid_set_flpm(pte, 0);
> >> +		break;
> >> +	default:
> >> +		dev_err(dev, "Invalid guest address width %d\n",
> >> addr_width);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* First level PGD is in GPA, must be supported by the
> >> second level */
> >> +	if ((u64)gpgd > domain->max_addr) {
> >> +		dev_err(dev, "Guest PGD %llx not supported, max
> >> %llx\n",
> >> +			(u64)gpgd, domain->max_addr);
> >> +		return -EINVAL;
> >> +	}
> >> +	pasid_set_flptr(pte, (u64)gpgd);
> >> +
> >> +	ret = intel_pasid_setup_bind_data(iommu, pte, pasid_data);
> >> +	if (ret) {
> >> +		dev_err(dev, "Guest PASID bind data not
> >> supported\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	/* Setup the second level based on the given domain */
> >> +	pgd = domain->pgd;
> >> +
> >> +	agaw = iommu_skip_agaw(domain, iommu, &pgd);
> >> +	if (agaw < 0) {
> >> +		dev_err(dev, "Invalid domain page table\n");
> >> +		return -EINVAL;
> >> +	}
> >> +	pgd_val = virt_to_phys(pgd);
> >> +	pasid_set_slptr(pte, pgd_val);
> >> +	pasid_set_fault_enable(pte);
> >> +
> >> +	did = domain->iommu_did[iommu->seq_id];
> >> +	pasid_set_domain_id(pte, did);
> >> +
> >> +	pasid_set_address_width(pte, agaw);
> >> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
> >> +
> >> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
> >> +	pasid_set_present(pte);
> >> +	pasid_flush_caches(iommu, pte, pasid, did);
> >> +
> >> +	return ret;
> >> +}
> >> diff --git a/drivers/iommu/intel-pasid.h
> >> b/drivers/iommu/intel-pasid.h index 92de6df24ccb..698015ee3f04
> >> 100644 --- a/drivers/iommu/intel-pasid.h
> >> +++ b/drivers/iommu/intel-pasid.h
> >> @@ -36,6 +36,7 @@
> >>    * to vmalloc or even module mappings.
> >>    */
> >>   #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
> >> +#define PASID_FLAG_NESTED		BIT(1)
> >>
> >>   /*
> >>    * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for
> >> first- @@ -51,6 +52,11 @@ struct pasid_entry {
> >>   	u64 val[8];
> >>   };
> >>
> >> +#define PASID_ENTRY_PGTT_FL_ONLY	(1)
> >> +#define PASID_ENTRY_PGTT_SL_ONLY	(2)
> >> +#define PASID_ENTRY_PGTT_NESTED		(3)
> >> +#define PASID_ENTRY_PGTT_PT		(4)
> >> +
> >>   /* The representative of a PASID table */
> >>   struct pasid_table {
> >>   	void			*table;		/*
> >> pasid table pointer */ @@ -99,6 +105,12 @@ int
> >> intel_pasid_setup_second_level(struct intel_iommu *iommu,
> >>   int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
> >>   				   struct dmar_domain *domain,
> >>   				   struct device *dev, int
> >> pasid); +int intel_pasid_setup_nested(struct intel_iommu *iommu,
> >> +			struct device *dev, pgd_t *pgd,
> >> +			int pasid,
> >> +			struct iommu_gpasid_bind_data_vtd
> >> *pasid_data,
> >> +			struct dmar_domain *domain,
> >> +			int addr_width);
> >>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> >>   				 struct device *dev, int pasid);
> >>
> >> diff --git a/include/linux/intel-iommu.h
> >> b/include/linux/intel-iommu.h index ed7171d2ae1f..eda1d6687144
> >> 100644 --- a/include/linux/intel-iommu.h
> >> +++ b/include/linux/intel-iommu.h
> >> @@ -42,6 +42,9 @@
> >>   #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
> >>   #define DMA_FL_PTE_XD		BIT_ULL(63)
> >>
> >> +#define ADDR_WIDTH_5LEVEL	(57)
> >> +#define ADDR_WIDTH_4LEVEL	(48)
> >> +
> >>   #define CONTEXT_TT_MULTI_LEVEL	0
> >>   #define CONTEXT_TT_DEV_IOTLB	1
> >>   #define CONTEXT_TT_PASS_THROUGH 2
> >> --
> >> 2.7.4  
> >   
> 
> Best regards,
> baolu

[Jacob Pan]
