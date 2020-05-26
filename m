Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCD199AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgCaQHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:07:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:13005 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbgCaQHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:07:23 -0400
IronPort-SDR: t4ecdFlZ20m2Gx8R4GQFSgPGMwP3ZQvvMFYzAblg9ujGi9T8S+oDfs9VgKYV6q7GEdcdy2hOuH
 HIxXLRunyPVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 09:07:22 -0700
IronPort-SDR: h+OVUXAg6GYZUFsqwU54MN1Z2RMQJR2C2htp8VPkJdWHDNhcM21lQkVOVz/31oeivlz3to0giN
 nDK+U/rI5Zcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="422346227"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2020 09:07:22 -0700
Date:   Tue, 31 Mar 2020 09:13:09 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
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
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 07/11] iommu/vt-d: Support flushing more translation
 cache types
Message-ID: <20200331091309.6fb369b1@jacob-builder>
In-Reply-To: <20200330162834.5ef42700@jacob-builder>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-8-git-send-email-jacob.jun.pan@linux.intel.com>
        <c90fafad-253a-b2f5-2a6c-87bc319edd02@redhat.com>
        <20200330162834.5ef42700@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 16:28:34 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> On Fri, 27 Mar 2020 15:46:23 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
> > Hi Jacob,
> > 
> > On 3/21/20 12:27 AM, Jacob Pan wrote:  
> > > When Shared Virtual Memory is exposed to a guest via vIOMMU,
> > > scalable IOTLB invalidation may be passed down from outside IOMMU
> > > subsystems. This patch adds invalidation functions that can be
> > > used for additional translation cache types.
> > > 
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > 
> > > ---
> > > v9 -> v10:
> > > Fix off by 1 in pasid device iotlb flush
> > > 
> > > Address v7 missed review from Eric
> > > 
> > > ---
> > > ---
> > >  drivers/iommu/dmar.c        | 36
> > > ++++++++++++++++++++++++++++++++++++ drivers/iommu/intel-pasid.c |
> > > 3 ++- include/linux/intel-iommu.h | 20 ++++++++++++++++----
> > >  3 files changed, 54 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > > index f77dae7ba7d4..4d6b7b5b37ee 100644
> > > --- a/drivers/iommu/dmar.c
> > > +++ b/drivers/iommu/dmar.c
> > > @@ -1421,6 +1421,42 @@ void qi_flush_piotlb(struct intel_iommu
> > > *iommu, u16 did, u32 pasid, u64 addr, qi_submit_sync(&desc,
> > > iommu); }
> > >  
> > > +/* PASID-based device IOTLB Invalidate */
> > > +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid,
> > > u16 pfsid,
> > > +		u32 pasid,  u16 qdep, u64 addr, unsigned
> > > size_order, u64 granu) +{
> > > +	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order
> > > - 1);
> > > +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> > > +
> > > +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> > > QI_DEV_EIOTLB_SID(sid) |
> > > +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> > > +		QI_DEV_IOTLB_PFSID(pfsid);
> > > +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
> > > +
> > > +	/*
> > > +	 * If S bit is 0, we only flush a single page. If S bit
> > > is set,
> > > +	 * The least significant zero bit indicates the
> > > invalidation address
> > > +	 * range. VT-d spec 6.5.2.6.
> > > +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates
> > > 16KB.
> > > +	 * size order = 0 is PAGE_SIZE 4KB
> > > +	 * Max Invs Pending (MIP) is set to 0 for now until we
> > > have DIT in
> > > +	 * ECAP.
> > > +	 */
> > > +	desc.qw1 |= addr & ~mask;
> > > +	if (size_order)
> > > +		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
> > > +
> > > +	qi_submit_sync(&desc, iommu);
> > > +}
> > > +
> > > +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64
> > > granu, int pasid) +{
> > > +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> > > +
> > > +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
> > > QI_PC_GRAN(granu) | QI_PC_TYPE;
> > > +	qi_submit_sync(&desc, iommu);
> > > +}
> > > +
> > >  /*
> > >   * Disable Queued Invalidation interface.
> > >   */
> > > diff --git a/drivers/iommu/intel-pasid.c
> > > b/drivers/iommu/intel-pasid.c index 10c7856afc6b..9f6d07410722
> > > 100644 --- a/drivers/iommu/intel-pasid.c
> > > +++ b/drivers/iommu/intel-pasid.c
> > > @@ -435,7 +435,8 @@ pasid_cache_invalidation_with_pasid(struct
> > > intel_iommu *iommu, {
> > >  	struct qi_desc desc;
> > >  
> > > -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
> > > QI_PC_PASID(pasid);
> > > +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> > > +		QI_PC_PASID(pasid) | QI_PC_TYPE;    
> > Just a nit, this fix is not documented in the commit message.
> >   
> Thanks, I just sent out this fix separately. Will remove this from the
> set.
> https://lkml.org/lkml/2020/3/30/1065
> 
I just realized this is not a fix. since I redefined below macros such
that I could use them for granularity lookup without the QI_PC_TYPE.

 -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
 -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
 +/* PASID cache invalidation granu */
 +#define QI_PC_ALL_PASIDS	0
 +#define QI_PC_PASID_SEL		1

Thanks,

Jacob

> > Besides
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > 
> > Thanks
> > 
> > Eric
> >   
> > >  	desc.qw1 = 0;
> > >  	desc.qw2 = 0;
> > >  	desc.qw3 = 0;
> > > diff --git a/include/linux/intel-iommu.h
> > > b/include/linux/intel-iommu.h index 85b05120940e..43539713b3b3
> > > 100644 --- a/include/linux/intel-iommu.h
> > > +++ b/include/linux/intel-iommu.h
> > > @@ -334,7 +334,7 @@ enum {
> > >  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >>
> > > (DMA_TLB_FLUSH_GRANU_OFFSET-4)) #define QI_IOTLB_ADDR(addr)
> > > (((u64)addr) & VTD_PAGE_MASK) #define
> > > QI_IOTLB_IH(ih)		(((u64)ih) << 6) -#define
> > > QI_IOTLB_AM(am)		(((u8)am)) +#define
> > > QI_IOTLB_AM(am)		(((u8)am) & 0x3f) 
> > >  #define QI_CC_FM(fm)		(((u64)fm) << 48)
> > >  #define QI_CC_SID(sid)		(((u64)sid) << 32)
> > > @@ -353,16 +353,21 @@ enum {
> > >  #define QI_PC_DID(did)		(((u64)did) << 16)
> > >  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
> > >  
> > > -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> > > -#define QI_PC_PASID_SEL		(QI_PC_TYPE |
> > > QI_PC_GRAN(1)) +/* PASID cache invalidation granu */
> > > +#define QI_PC_ALL_PASIDS	0
> > > +#define QI_PC_PASID_SEL		1
> > >  
> > >  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> > >  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> > > -#define QI_EIOTLB_AM(am)	(((u64)am))
> > > +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
> > >  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
> > >  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
> > >  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
> > >  
> > > +/* QI Dev-IOTLB inv granu */
> > > +#define QI_DEV_IOTLB_GRAN_ALL		1
> > > +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0> +
> > >  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
> > >  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> > >  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> > > @@ -662,8 +667,15 @@ extern void qi_flush_iotlb(struct intel_iommu
> > > *iommu, u16 did, u64 addr, unsigned int size_order, u64 type);
> > >  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16
> > > sid, u16 pfsid, u16 qdep, u64 addr, unsigned mask);
> > > +
> > >  void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32
> > > pasid, u64 addr, unsigned long npages, bool ih);
> > > +
> > > +extern void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
> > > u16 sid, u16 pfsid,
> > > +			u32 pasid, u16 qdep, u64 addr, unsigned
> > > size_order, u64 granu); +
> > > +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16
> > > did, u64 granu, int pasid); +
> > >  extern int qi_submit_sync(struct qi_desc *desc, struct
> > > intel_iommu *iommu); 
> > >  extern int dmar_ir_support(void);
> > >     
> >   
> 
> [Jacob Pan]

[Jacob Pan]
