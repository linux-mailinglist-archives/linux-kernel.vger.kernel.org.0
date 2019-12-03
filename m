Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E141102C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLCQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 11:45:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:59606 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfLCQpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:45:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 08:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="222883231"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2019 08:45:43 -0800
Date:   Tue, 3 Dec 2019 08:50:26 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        kevin.tian@intel.com, Eric Auger <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/5] iommu/vt-d: Consolidate various cache flush ops
Message-ID: <20191203085026.1785292b@jacob-builder>
In-Reply-To: <f703c267-c946-30cf-7e0e-4de16edcde18@linux.intel.com>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
        <20191202120252.45606c47@jacob-builder>
        <f703c267-c946-30cf-7e0e-4de16edcde18@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 10:44:45 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 12/3/19 4:02 AM, Jacob Pan wrote:
> > On Fri, 22 Nov 2019 11:04:44 +0800
> > Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> Intel VT-d 3.0 introduces more caches and interfaces for software
> >> to flush when it runs in the scalable mode. Currently various
> >> cache flush helpers are scattered around. This consolidates them
> >> by putting them in the existing iommu_flush structure.
> >>
> >> /* struct iommu_flush - Intel IOMMU cache invalidation ops
> >>   *
> >>   * @cc_inv: invalidate context cache
> >>   * @iotlb_inv: Invalidate IOTLB and paging structure caches when
> >> software
> >>   *             has changed second-level tables.
> >>   * @p_iotlb_inv: Invalidate IOTLB and paging structure caches when
> >> software
> >>   *               has changed first-level tables.
> >>   * @pc_inv: invalidate pasid cache
> >>   * @dev_tlb_inv: invalidate cached mappings used by
> >> requests-without-PASID
> >>   *               from the Device-TLB on a endpoint device.
> >>   * @p_dev_tlb_inv: invalidate cached mappings used by
> >> requests-with-PASID
> >>   *                 from the Device-TLB on an endpoint device
> >>   */
> >> struct iommu_flush {
> >>          void (*cc_inv)(struct intel_iommu *iommu, u16 did,
> >>                         u16 sid, u8 fm, u64 type);
> >>          void (*iotlb_inv)(struct intel_iommu *iommu, u16 did, u64
> >> addr, unsigned int size_order, u64 type);
> >>          void (*p_iotlb_inv)(struct intel_iommu *iommu, u16 did,
> >> u32 pasid, u64 addr, unsigned long npages, bool ih);
> >>          void (*pc_inv)(struct intel_iommu *iommu, u16 did, u32
> >> pasid, u64 granu);
> >>          void (*dev_tlb_inv)(struct intel_iommu *iommu, u16 sid,
> >> u16 pfsid, u16 qdep, u64 addr, unsigned int mask);
> >>          void (*p_dev_tlb_inv)(struct intel_iommu *iommu, u16 sid,
> >> u16 pfsid, u32 pasid, u16 qdep, u64 addr,
> >>                                unsigned long npages);
> >> };
> >>
> >> The name of each cache flush ops is defined according to the spec
> >> section 6.5 so that people are easy to look up them in the spec.
> >>  
> > Nice consolidation. For nested SVM, I also introduced cache flushed
> > helpers as needed.
> > https://lkml.org/lkml/2019/10/24/857
> > 
> > Should I wait for yours to be merged or you want to extend the this
> > consolidation after SVA/SVM cache flush? I expect to send my v8
> > shortly. 
> 
> Please base your v8 patch on this series. So it could get more chances
> for test.
> 
Sounds good.

> I will queue this patch series for internal test after 5.5-rc1 and if
> everything goes well, I will forward it to Joerg around rc4 for linux-
> next.
> 
> Best regards,
> baolu

[Jacob Pan]
