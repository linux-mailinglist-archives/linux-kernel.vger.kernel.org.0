Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAE4E26C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 00:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392706AbfJWW5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 18:57:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:43380 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfJWW5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:57:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 15:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="202133555"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 23 Oct 2019 15:57:31 -0700
Date:   Wed, 23 Oct 2019 16:01:52 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 02/10] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20191023160152.07305918@jacob-builder>
In-Reply-To: <0a0f33b8-e3d8-3d29-ca71-552f1875bc62@linux.intel.com>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571788403-42095-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20191023005129.GC100970@otc-nc-03>
        <0a0f33b8-e3d8-3d29-ca71-552f1875bc62@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 10:21:51 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> >> +#ifdef CONFIG_INTEL_IOMMU_SVM  
> > 
> > Maybe move them to intel-svm.c instead? that's where the bulk
> > of the svm support is?  
> 
> I think this is a generic PASID allocator for guest IOMMU although
> vSVA is currently the only consumer. Instead of making it SVM
> specific, I'd like to suggest moving it to intel-pasid.c and replace
> the @svm parameter with a void * one in intel_ioasid_free().

make sense to use void*, no need to tie that to svm bind data type.

In terms of location, perhaps we can move if we have more consumers of
custom allocator?
