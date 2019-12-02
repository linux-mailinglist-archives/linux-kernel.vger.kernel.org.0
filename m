Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D916E10EEF6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 19:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfLBSLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 13:11:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:48020 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbfLBSLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:11:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 10:11:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="213113529"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2019 10:11:10 -0800
Date:   Mon, 2 Dec 2019 10:15:53 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 8/8] iommu/vt-d: Misc macro clean up for SVM
Message-ID: <20191202101553.079898a3@jacob-builder>
In-Reply-To: <38d4586f3aeb21bb08028525db89868acb34e9fd.camel@perches.com>
References: <1574371588-65634-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574371588-65634-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <38d4586f3aeb21bb08028525db89868acb34e9fd.camel@perches.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 13:37:10 -0800
Joe Perches <joe@perches.com> wrote:

> On Thu, 2019-11-21 at 13:26 -0800, Jacob Pan wrote:
> > Use combined macros for_each_svm_dev() to simplify SVM device
> > iteration and error checking.  
> []
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c  
> []
> > +#define for_each_svm_dev(sdev, svm, d)			\
> > +	list_for_each_entry((sdev), &(svm)->devs, list)	\
> > +		if ((d) != (sdev)->dev) {} else
> > +
> >  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> > struct svm_dev_ops *ops) {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > @@ -274,15 +278,13 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ goto out;
> >  			}
> >  
> > -			list_for_each_entry(sdev, &svm->devs,
> > list) {
> > -				if (dev == sdev->dev) {
> > -					if (sdev->ops != ops) {
> > -						ret = -EBUSY;
> > -						goto out;
> > -					}
> > -					sdev->users++;
> > -					goto success;
> > +			for_each_svm_dev(sdev, svm, dev) {
> > +				if (sdev->ops != ops) {
> > +					ret = -EBUSY;
> > +					goto out;
> >  				}
> > +				sdev->users++;
> > +				goto success;
> >  			}  
> 
> I think this does not read better as this is now a
> for_each loop that exits the loop on the first match.
> 
I think one of the benefits is reduced indentation. What do you
recommend?

> >  
> >  			break;
> > @@ -427,43 +429,36 @@ int intel_svm_unbind_mm(struct device *dev,
> > int pasid) goto out;
> >  	}
> >  
> > -	if (!svm)
> > -		goto out;
> > -
> > -	list_for_each_entry(sdev, &svm->devs, list) {  
> []
> > +	for_each_svm_dev(sdev, svm, dev) {  
> 
> I think this should not remove the !svm test above.
> 
Yeah, !svm test should have been part of 6/8. I will fix that.

Thanks,

Jacob 
> 

[Jacob Pan]
