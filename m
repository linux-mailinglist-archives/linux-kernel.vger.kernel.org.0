Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517B01046E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 00:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKTXPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 18:15:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:4527 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfKTXPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 18:15:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 15:15:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="209709357"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 20 Nov 2019 15:15:10 -0800
Date:   Wed, 20 Nov 2019 15:19:46 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 6/8] iommu/vt-d: Replace Intel specific PASID
 allocator with IOASID
Message-ID: <20191120151946.2a94c1ee@jacob-builder>
In-Reply-To: <5ead3e84-d6b6-8f97-c83b-236bbe53be86@redhat.com>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574186193-30457-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <5ead3e84-d6b6-8f97-c83b-236bbe53be86@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 22:06:24 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 11/19/19 6:56 PM, Jacob Pan wrote:
> > Make use of generic IOASID code to manage PASID allocation,
> > free, and lookup. Replace Intel specific code.
> > IOASID allocator is inclusive for both start and end of the
> > allocation range. The current code is based on IDR, which is
> > exclusive for the end of the allocation range. This patch fixes the
> > off-by-one error in intel_svm_bind_mm, where pasid_max - 1 is used
> > for the end of allocation range.  
> no more as this is handled in 5/8
oops, forgot that. will remove this comment.
Thanks!
>  [...]  
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
