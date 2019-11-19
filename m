Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167AD102A61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfKSRCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:02:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:23294 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfKSRCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:02:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 09:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="289664932"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2019 09:01:53 -0800
Date:   Tue, 19 Nov 2019 09:06:28 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 01/10] iommu/vt-d: Introduce native SVM capable flag
Message-ID: <20191119090628.7295cd7d@jacob-builder>
In-Reply-To: <efe5a47d-1209-2c09-bc66-b1ebbc671439@linux.intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574106153-45867-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <cb44724d-a396-0291-63c4-0039788fd26b@redhat.com>
        <20191118134809.66b9fda4@jacob-builder>
        <efe5a47d-1209-2c09-bc66-b1ebbc671439@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 10:55:29 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 11/19/19 5:48 AM, Jacob Pan wrote:
> > On Mon, 18 Nov 2019 21:33:53 +0100
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 11/18/19 8:42 PM, Jacob Pan wrote:  
> >>> Shared Virtual Memory(SVM) is based on a collective set of
> >>> hardware features detected at runtime. There are requirements for
> >>> matching CPU and IOMMU capabilities.
> >>>
> >>> This patch introduces a flag which will be used to mark and test
> >>> the capability of SVM.
> >>>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> >>> ---
> >>>   include/linux/intel-iommu.h | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/include/linux/intel-iommu.h
> >>> b/include/linux/intel-iommu.h index ed11ef594378..63118991824c
> >>> 100644 --- a/include/linux/intel-iommu.h
> >>> +++ b/include/linux/intel-iommu.h
> >>> @@ -433,6 +433,7 @@ enum {
> >>>   
> >>>   #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
> >>>   #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
> >>> +#define VTD_FLAG_SVM_CAPABLE		(1 << 2)  
> >>
> >> I think I would rather squash this into the next patch as there is
> >> no user here.
> >>  
> > Sure, I don't have strong preference. Baolu, what is your call?  
> 
> It's okay for me.
> 
will squash then.
Thanks!
> Best regards,
> baolu

[Jacob Pan]
