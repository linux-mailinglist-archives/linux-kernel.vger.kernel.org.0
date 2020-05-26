Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9832D19AF2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbgDAP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 11:57:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:57428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732980AbgDAP5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:57:51 -0400
IronPort-SDR: T9Ggzsxav7n9EjnAoUMgcMYNLZl8HeEi4Q5amPDKd57jJ8yOICawdWoFv53fihWbNoSXI5+tTh
 KNXlEkV6f5tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 08:57:51 -0700
IronPort-SDR: R5qywkNEyuyciznhRnV8XzvA+/gIvj8UOXCgWtUh6FpG/PTUBTUA9EGvieHCSyo5fBxw8tmIyO
 lq0B79f2wlqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="249497966"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2020 08:57:46 -0700
Date:   Wed, 1 Apr 2020 09:03:34 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20200401090334.05b12e9b@jacob-builder>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A21C475@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
        <20200331111332.0718ffd2@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D803C1B@SHSMSX104.ccr.corp.intel.com>
        <A2975661238FB949B60364EF0F2C25743A21C475@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 06:57:42 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Wednesday, April 1, 2020 2:24 PM
> > To: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Subject: RE: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate
> > function 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Wednesday, April 1, 2020 2:14 AM
> > >
> > > On Sat, 28 Mar 2020 10:01:42 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >  
> > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Sent: Saturday, March 21, 2020 7:28 AM
> > > > >
> > > > > When Shared Virtual Address (SVA) is enabled for a guest OS
> > > > > via vIOMMU, we need to provide invalidation support at IOMMU
> > > > > API and driver level. This patch adds Intel VT-d specific
> > > > > function to implement iommu passdown invalidate API for
> > > > > shared virtual address.
> > > > >
> > > > > The use case is for supporting caching structure invalidation
> > > > > of assigned SVM capable devices. Emulated IOMMU exposes
> > > > > queue  
> > > >
> > > > emulated IOMMU -> vIOMMU, since virito-iommu could use the
> > > > interface as well.
> > > >  
> > > True, but it does not invalidate this statement about emulated
> > > IOMMU. I will add another statement saying "the same interface
> > > can be used for virtio-IOMMU as well". OK?  
> > 
> > sure
> >   
> > >  
> > > > > invalidation capability and passes down all descriptors from
> > > > > the guest to the physical IOMMU.
> > > > >
> > > > > The assumption is that guest to host device ID mapping should
> > > > > be resolved prior to calling IOMMU driver. Based on the
> > > > > device handle, host IOMMU driver can replace certain fields
> > > > > before submit to the invalidation queue.
> > > > >
> > > > > ---
> > > > > v7 review fixed in v10
> > > > > ---
> > > > >
> > > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > > > > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > > > > ---
> > > > >  drivers/iommu/intel-iommu.c | 182
> > > > > ++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 182 insertions(+)
> > > > >
> > > > > diff --git a/drivers/iommu/intel-iommu.c
> > > > > b/drivers/iommu/intel-iommu.c index b1477cd423dd..a76afb0fd51a
> > > > > 100644 --- a/drivers/iommu/intel-iommu.c
> > > > > +++ b/drivers/iommu/intel-iommu.c
> > > > > @@ -5619,6 +5619,187 @@ static void
> > > > > intel_iommu_aux_detach_device(struct iommu_domain *domain,
> > > > >  	aux_domain_remove_dev(to_dmar_domain(domain), dev);
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * 2D array for converting and sanitizing IOMMU generic TLB
> > > > > granularity to
> > > > > + * VT-d granularity. Invalidation is typically included in
> > > > > the unmap operation
> > > > > + * as a result of DMA or VFIO unmap. However, for assigned
> > > > > devices guest
> > > > > + * owns the first level page tables. Invalidations of
> > > > > translation caches in the
> > > > > + * guest are trapped and passed down to the host.
> > > > > + *
> > > > > + * vIOMMU in the guest will only expose first level page
> > > > > tables, therefore
> > > > > + * we do not include IOTLB granularity for request without
> > > > > PASID (second level).  
> > > >
> > > > I would revise above as "We do not support IOTLB granularity for
> > > > request without PASID (second level), therefore any vIOMMU
> > > > implementation that exposes the SVA capability to the guest
> > > > should only expose the first level page tables, implying all
> > > > invalidation requests from the guest will include a valid PASID"
> > > >  
> > > Sounds good.
> > >  
> > > > > + *
> > > > > + * For example, to find the VT-d granularity encoding for
> > > > > IOTLB
> > > > > + * type and page selective granularity within PASID:
> > > > > + * X: indexed by iommu cache type
> > > > > + * Y: indexed by enum iommu_inv_granularity
> > > > > + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
> > > > > + *
> > > > > + * Granu_map array indicates validity of the table. 1:
> > > > > valid, 0: invalid
> > > > > + *
> > > > > + */
> > > > > +const static int
> > > > >  
> > > inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_  
> > > > > NR] = {
> > > > > +	/*
> > > > > +	 * PASID based IOTLB invalidation: PASID selective
> > > > > (per PASID),
> > > > > +	 * page selective (address granularity)
> > > > > +	 */
> > > > > +	{0, 1, 1},
> > > > > +	/* PASID based dev TLBs, only support all PASIDs or
> > > > > single PASID */
> > > > > +	{1, 1, 0},  
> > > >
> > > > Is this combination correct? when single PASID is being
> > > > specified, it is essentially a page-selective invalidation
> > > > since you need provide Address and Size.
> > > >  
> > > This is for translation between generic UAPI granu to VT-d granu,
> > > it has nothing to do with address and size.  
> > 
> > Generic UAPI defines three granularities: domain, pasid and addr.
> > from the definition domain applies all entries related to did, pasid
> > applies to all entries related to pasid, while addr is specific for
> > a range.
> > 
> > from what we just confirmed internally with VT-d spec owner, our
> > PASID based dev TLB invalidation always requires addr and size,
> > while current uAPI doesn't support multiple PASIDs based range
> > invaliation. It sounds to me that you want to use domain to replace
> > multiple PASIDs case (G=1), but it then changes the meaning of
> > the domain granularity and easily lead to confusion.
> >
> > I feel Eric's proposal makes more sense. Here we'd better use {0,
> > 0, 1} to indicate only addr range invalidation is allowed, matching
> > the spec definition. We may use a special flag in
> > iommu_inv_addr_info to indicate G=1 case, if necessary.  
> 
> I agree. G=1 case should be supported. I think we had a flag for
> global as there is GL bit in p_iotlb_inv_dsc (a.k.a
> ext_iotlb_inv_dsc), but it was dropped as 3.0 spec dropped GL bit.
> Let's add it back as for DevTLB flush case.
> 
Make sense. I will change that to

--- a/drivers/iommu/intel-iommu.c                                                                      
+++ b/drivers/iommu/intel-iommu.c                                                                      
@@ -5741,7 +5741,7 @@ const static int inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] 
         */                                                                                            
        {0, 1, 1},                                                                                     
        /* PASID based dev TLBs, only support all PASIDs or single PASID */                            
-       {1, 1, 0},                                                                                     
+       {0, 0, 1},                                                                                     
        /* PASID cache */                                                                              
        {1, 1, 0}                                                                                      
 };                                                                                                    
@@ -5750,7 +5750,7 @@ const static int inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_N 
        /* PASID based IOTLB */                                                                        
        {0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},                                                    
        /* PASID based dev TLBs */                                                                     
-       {QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},                                       
+       {0, 0, QI_DEV_IOTLB_GRAN_PASID_SEL},                                                           
        /* PASID cache */                                                                              
        {QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},                                                        
 };                                                                                                    

> > > e.g.
> > > If user passes IOMMU_INV_GRANU_PASID for the single PASID case as
> > > you mentioned, this map table shows it is valid.
> > >
> > > Then the lookup result will get VT-d granu:
> > > QI_DEV_IOTLB_GRAN_PASID_SEL, which means G=0.
> > >
> > >  
> > > > > +	/* PASID cache */  
> > > >
> > > > PASID cache is fully managed by the host. Guest PASID cache
> > > > invalidation is interpreted by vIOMMU for bind and unbind
> > > > operations. I don't think we should accept any PASID cache
> > > > invalidation from userspace or guest.
> > > >  
> > >
> > > True for vIOMMU, this is here for completeness. Can be used by
> > > virtio IOMMU, since PC flush is inclusive (IOTLB, devTLB), it is
> > > more efficient.  
> > 
> > I think it is not correct in concept. We should not allow the
> > userspace or guest to request an operation which is beyond its
> > privilege (just because doing so may bring some performance
> > benefit). You can always introduce new cmd for such purpose.  
> 
> I guess it was added for the pasid table binding case? Now, our
> platform doesn't support it. So I guess we can just make it as
> unsupported in the 2D table.
Sounds good.
