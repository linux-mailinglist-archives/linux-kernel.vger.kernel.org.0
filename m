Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8869C196223
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 00:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgC0Xru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 19:47:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:31878 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgC0Xru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:47:50 -0400
IronPort-SDR: Y7WQqg/HsDBfayPv+H0M24Y+Y2meJHsSi0LjxvpTO6uDd43ON+Jv9of/EDg3OKIkcBat48g0zB
 9tAzxQl26QuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 16:47:50 -0700
IronPort-SDR: qlJo1yoZnNpykM2wi0KZD8GSGBaxeWa+7YA/XlRIpYQ3fJ2YnszxrD/P8TWLiGXMMqLuYuMWj6
 c5hhbWPQFp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="447595129"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2020 16:47:49 -0700
Date:   Fri, 27 Mar 2020 16:53:35 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200327165335.397f24a3@jacob-builder>
In-Reply-To: <20200327074702.GA27959@infradead.org>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200326092316.GA31648@infradead.org>
        <20200326094442.5be042ce@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
        <20200327074702.GA27959@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 00:47:02 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:
> > If those API calls are inter-dependent for composing a feature
> > (e.g. SVA), shouldn't we need a way to check them together before
> > exposing the feature to the guest, e.g. through a
> > iommu_get_uapi_capabilities interface?  
> 
> Yes, that makes sense.  The important bit is to have a capability
> flags and not version numbers.

The challenge is that there are two consumers in the kernel for this.
1. VFIO only look for compatibility, and size of each data struct such
that it can copy_from_user.

2. IOMMU driver, the "real consumer" of the content.

For 2, I agree and we do plan to use the capability flags to check
content and maintain backward compatibility etc.

For VFIO, it is difficult to do size look up based on capability flags.


Jacob
