Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0DF100E05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 22:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfKRVnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 16:43:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:26992 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKRVnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:43:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 13:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="407535608"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2019 13:43:34 -0800
Date:   Mon, 18 Nov 2019 13:48:09 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 01/10] iommu/vt-d: Introduce native SVM capable flag
Message-ID: <20191118134809.66b9fda4@jacob-builder>
In-Reply-To: <cb44724d-a396-0291-63c4-0039788fd26b@redhat.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574106153-45867-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <cb44724d-a396-0291-63c4-0039788fd26b@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 21:33:53 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 11/18/19 8:42 PM, Jacob Pan wrote:
> > Shared Virtual Memory(SVM) is based on a collective set of hardware
> > features detected at runtime. There are requirements for matching
> > CPU and IOMMU capabilities.
> > 
> > This patch introduces a flag which will be used to mark and test the
> > capability of SVM.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  include/linux/intel-iommu.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index ed11ef594378..63118991824c
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -433,6 +433,7 @@ enum {
> >  
> >  #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
> >  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
> > +#define VTD_FLAG_SVM_CAPABLE		(1 << 2)  
> 
> I think I would rather squash this into the next patch as there is no
> user here.
> 
Sure, I don't have strong preference. Baolu, what is your call?

> Thanks
> 
> Eric
> >  
> >  extern int intel_iommu_sm;
> >  
> >   
> 

[Jacob Pan]
