Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5DE26C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 00:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392731AbfJWW7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 18:59:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:52756 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392721AbfJWW7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:59:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 15:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="398217103"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2019 15:59:42 -0700
Date:   Wed, 23 Oct 2019 16:04:03 -0700
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
Message-ID: <20191023160403.1bc56772@jacob-builder>
In-Reply-To: <20191022210400.357e69a9@jacob-builder>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571788403-42095-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20191023005129.GC100970@otc-nc-03>
        <20191022210400.357e69a9@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 21:04:00 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> > > +		if (cap_caching_mode(iommu->cap) &&
> > > sm_supported(iommu)) {    
> > 
> > do you need to check against cap_caching_mode() or ecap_vcmd?
> >   
> I guess ecap_vcmd() will suffice. Kind of redundant.
Actually, we can check vcmd and vcmd_pasid here, then we dont need to
check it on every alloc/free calls.

Thanks,

Jacob
