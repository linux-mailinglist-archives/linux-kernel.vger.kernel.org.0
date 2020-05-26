Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD619BA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 04:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgDBCSu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Apr 2020 22:18:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:34550 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDBCSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:18:50 -0400
IronPort-SDR: 9GA2uHQqSiqHBufk3vdeWyBnmYb/dYfoBdUTeWUarEnzbkiiyZ1QyIqjRBotn0k3T6KuJ8C0cq
 mgcNazVhA52Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 19:18:49 -0700
IronPort-SDR: At2PHfk0Cat/OKF/L/gHFtIAA2nviRopy3ceblCTYsXveKeE3Mkqiv3ruSZlPR8IHb71eBeglI
 kfsM5tlGkJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,334,1580803200"; 
   d="scan'208";a="328664467"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2020 19:18:48 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 19:18:48 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 19:18:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Thu, 2 Apr 2020 10:18:46 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH V10 11/11] iommu/vt-d: Add custom allocator for IOASID
Thread-Topic: [PATCH V10 11/11] iommu/vt-d: Add custom allocator for IOASID
Thread-Index: AQHV/w5iKgLPE4QoKUCYLVGE8Jzvsahd07AggAYh7YCAATUIgA==
Date:   Thu, 2 Apr 2020 02:18:45 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D805FAF@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-12-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA146@SHSMSX104.ccr.corp.intel.com>
 <20200401084759.575b38c4@jacob-builder>
In-Reply-To: <20200401084759.575b38c4@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, April 1, 2020 11:48 PM
> 
> On Sat, 28 Mar 2020 10:22:41 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Saturday, March 21, 2020 7:28 AM
> > >
> > > When VT-d driver runs in the guest, PASID allocation must be
> > > performed via virtual command interface. This patch registers a
> > > custom IOASID allocator which takes precedence over the default
> > > XArray based allocator. The resulting IOASID allocation will always
> > > come from the host. This ensures that PASID namespace is system-
> > > wide.
> > >
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/iommu/intel-iommu.c | 84
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/intel-iommu.h |  2 ++
> > >  2 files changed, 86 insertions(+)
> > >
> > > diff --git a/drivers/iommu/intel-iommu.c
> > > b/drivers/iommu/intel-iommu.c index a76afb0fd51a..c1c0b0fb93c3
> > > 100644 --- a/drivers/iommu/intel-iommu.c
> > > +++ b/drivers/iommu/intel-iommu.c
> > > @@ -1757,6 +1757,9 @@ static void free_dmar_iommu(struct
> intel_iommu
> > > *iommu)
> > >  		if (ecap_prs(iommu->ecap))
> > >  			intel_svm_finish_prq(iommu);
> > >  	}
> > > +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> > > +
> > > ioasid_unregister_allocator(&iommu->pasid_allocator); +
> > >  #endif
> > >  }
> > >
> > > @@ -3291,6 +3294,84 @@ static int copy_translation_tables(struct
> > > intel_iommu *iommu)
> > >  	return ret;
> > >  }
> > >
> > > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > > void *data)
> >
> > the name is too generic... can we add vcmd in the name to clarify
> > its purpose, e.g. intel_vcmd_ioasid_alloc?
> >
> I feel the intel_ prefix is a natural extension of a generic API, we do
> that for other IOMMU APIs, right?

other IOMMU APIs have no difference between host and guest, but
this one only applies to guest with vcmd interface. 

> 
> > > +{
> > > +	struct intel_iommu *iommu = data;
> > > +	ioasid_t ioasid;
> > > +
> > > +	if (!iommu)
> > > +		return INVALID_IOASID;
> > > +	/*
> > > +	 * VT-d virtual command interface always uses the full 20
> > > bit
> > > +	 * PASID range. Host can partition guest PASID range based
> > > on
> > > +	 * policies but it is out of guest's control.
> > > +	 */
> > > +	if (min < PASID_MIN || max > intel_pasid_max_id)
> > > +		return INVALID_IOASID;
> > > +
> > > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > > +		return INVALID_IOASID;
> > > +
> > > +	return ioasid;
> > > +}
> > > +
> > > +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> > > +{
> > > +	struct intel_iommu *iommu = data;
> > > +
> > > +	if (!iommu)
> > > +		return;
> > > +	/*
> > > +	 * Sanity check the ioasid owner is done at upper layer,
> > > e.g. VFIO
> > > +	 * We can only free the PASID when all the devices are
> > > unbound.
> > > +	 */
> > > +	if (ioasid_find(NULL, ioasid, NULL)) {
> > > +		pr_alert("Cannot free active IOASID %d\n", ioasid);
> > > +		return;
> > > +	}
> >
> > However the sanity check is not done in default_free. Is there a
> > reason why using vcmd adds such  new requirement?
> >
> Since we don't support nested guest. This vcmd allocator is only used
> by the guest IOMMU driver not VFIO. We expect IOMMU driver to have
> control of the free()/unbind() ordering.
> 
> For default_free, it can come from user space and host VFIO which can
> be out of order. But we will solve that issue with the blocking
> notifier.
> 
> > > +	vcmd_free_pasid(iommu, ioasid);
> > > +}
> > > +
> > > +static void register_pasid_allocator(struct intel_iommu *iommu)
> > > +{
> > > +	/*
> > > +	 * If we are running in the host, no need for custom
> > > allocator
> > > +	 * in that PASIDs are allocated from the host system-wide.
> > > +	 */
> > > +	if (!cap_caching_mode(iommu->cap))
> > > +		return;
> >
> > is it more accurate to check against vcmd capability?
> >
> I think this is sufficient. The spec says if vcmd is present, we must
> use it but not the other way.

No, what about an vIOMMU implementation reports CM but not
VCMD? I didn't get the rationale why we check an indirect capability
when there is already one well defined for the purpose.

> 
> > > +
> > > +	if (!sm_supported(iommu)) {
> > > +		pr_warn("VT-d Scalable Mode not enabled, no PASID
> > > allocation\n");
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Register a custom PASID allocator if we are running in
> > > a guest,
> > > +	 * guest PASID must be obtained via virtual command
> > > interface.
> > > +	 * There can be multiple vIOMMUs in each guest but only one
> > > allocator
> > > +	 * is active. All vIOMMU allocators will eventually be
> > > calling the same
> >
> > which one? the first or last?
> >
> All allocators share the same ops, so first=last. IOASID code will
> inspect the ops function and see if they are shared with others then
> use the same ops.

ok, got you.

> 
> > > +	 * host allocator.
> > > +	 */
> > > +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap)) {
> > > +		pr_info("Register custom PASID allocator\n");
> > > +		iommu->pasid_allocator.alloc = intel_ioasid_alloc;
> > > +		iommu->pasid_allocator.free = intel_ioasid_free;
> > > +		iommu->pasid_allocator.pdata = (void *)iommu;
> > > +		if
> > > (ioasid_register_allocator(&iommu->pasid_allocator)) {
> > > +			pr_warn("Custom PASID allocator failed,
> > > scalable mode disabled\n");
> > > +			/*
> > > +			 * Disable scalable mode on this IOMMU if
> > > there
> > > +			 * is no custom allocator. Mixing SM
> > > capable vIOMMU
> > > +			 * and non-SM vIOMMU are not supported.
> > > +			 */
> > > +			intel_iommu_sm = 0;
> >
> > since you register an allocator for every vIOMMU, means previously
> > registered allocators should also be unregistered here?
> >
> True, but it is not necessary for two reasons:
> 1. This should not happen unless something went seriously wrong.
> All vIOMMU shares the same alloc/free function, so they are put under
> the same bucket by IOASID. So the case for the first vIOMMU to succeed
> then fail in later vIOMMU registration should not happen. Unless kernel
> run out of memory etc.
> 
> 2. Once SM is disabled, there is no user of ioasid allocator.
> 
> > > +		}
> > > +	}
> > > +}
> > > +#endif
> > > +
> > >  static int __init init_dmars(void)
> > >  {
> > >  	struct dmar_drhd_unit *drhd;
> > > @@ -3408,6 +3489,9 @@ static int __init init_dmars(void)
> > >  	 */
> > >  	for_each_active_iommu(iommu, drhd) {
> > >  		iommu_flush_write_buffer(iommu);
> > > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > > +		register_pasid_allocator(iommu);
> > > +#endif
> > >  		iommu_set_root_entry(iommu);
> > >  		iommu->flush.flush_context(iommu, 0, 0, 0,
> > > DMA_CCMD_GLOBAL_INVL);
> > >  		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
> > > DMA_TLB_GLOBAL_FLUSH);
> > > diff --git a/include/linux/intel-iommu.h
> > > b/include/linux/intel-iommu.h index 9cbf5357138b..9c357a325c72
> > > 100644 --- a/include/linux/intel-iommu.h
> > > +++ b/include/linux/intel-iommu.h
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/iommu.h>
> > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > >  #include <linux/dmar.h>
> > > +#include <linux/ioasid.h>
> > >
> > >  #include <asm/cacheflush.h>
> > >  #include <asm/iommu.h>
> > > @@ -563,6 +564,7 @@ struct intel_iommu {
> > >  #ifdef CONFIG_INTEL_IOMMU_SVM
> > >  	struct page_req_dsc *prq;
> > >  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> > > +	struct ioasid_allocator_ops pasid_allocator; /* Custom
> > > allocator for PASIDs */
> > >  #endif
> > >  	struct q_inval  *qi;            /* Queued invalidation
> > > info */ u32 *iommu_state; /* Store iommu states between suspend and
> > > resume.*/
> > > --
> > > 2.7.4
> >
> 
> [Jacob Pan]
