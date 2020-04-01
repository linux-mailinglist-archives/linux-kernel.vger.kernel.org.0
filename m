Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1619AF35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgDAP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 11:59:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:30397 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733088AbgDAP7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:59:54 -0400
IronPort-SDR: gcYTy3hWCS0yvfPxvnqTc0zilER19c5BZLCXxKzQumUKk0PF8LtezAuQlKAoSB4/66mFSdFCmE
 tcJBM5BS2LEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 08:59:53 -0700
IronPort-SDR: /dRVQ3HhcSP6LMP7LWA7jzfcYR845BctVHtxdSsb9DvF/zIObODCMg97exc+KTbYoOTsmcEEeA
 xEav+PC/2/Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
   d="scan'208";a="450606822"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga006.fm.intel.com with ESMTP; 01 Apr 2020 08:59:52 -0700
Date:   Wed, 1 Apr 2020 09:05:40 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20200401090540.135fd760@jacob-builder>
In-Reply-To: <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
        <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
        <20200331135807.4e9976ab@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
        <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
        <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 09:32:37 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> >> devtlb
> >> descriptor, that is why Eric suggests {0, 0, 1}.  
> > 
> > I think it should be {0, 0, 1} :-) addr field and S field are must,
> > pasid field depends on G bit.  
> 
> On my side, I understood from the spec that addr/S are always used
> whatever the granularity, hence the above suggestion.
> 
> As a comparison, for PASID based IOTLB invalidation, it is clearly
> stated that if G matches PASID selective invalidation, address field
> is ignored. This is not written that way for PASID-based device TLB
> inv.
> > 
I misread the S bit. It all makes sense now. Thanks for the proposal
and explanation.

Jacob
