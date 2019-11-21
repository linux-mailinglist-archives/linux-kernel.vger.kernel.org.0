Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22401105C20
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 22:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKUVhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 16:37:37 -0500
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:39566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbfKUVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:37:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 215181806ECD0;
        Thu, 21 Nov 2019 21:37:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3871:3874:4250:4321:5007:6119:9010:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30056:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: toes80_25057537f620a
X-Filterd-Recvd-Size: 2697
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Nov 2019 21:37:34 +0000 (UTC)
Message-ID: <38d4586f3aeb21bb08028525db89868acb34e9fd.camel@perches.com>
Subject: Re: [PATCH v4 8/8] iommu/vt-d: Misc macro clean up for SVM
From:   Joe Perches <joe@perches.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Date:   Thu, 21 Nov 2019 13:37:10 -0800
In-Reply-To: <1574371588-65634-9-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1574371588-65634-1-git-send-email-jacob.jun.pan@linux.intel.com>
         <1574371588-65634-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-21 at 13:26 -0800, Jacob Pan wrote:
> Use combined macros for_each_svm_dev() to simplify SVM device iteration
> and error checking.
[]
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
[]
> +#define for_each_svm_dev(sdev, svm, d)			\
> +	list_for_each_entry((sdev), &(svm)->devs, list)	\
> +		if ((d) != (sdev)->dev) {} else
> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -274,15 +278,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  				goto out;
>  			}
>  
> -			list_for_each_entry(sdev, &svm->devs, list) {
> -				if (dev == sdev->dev) {
> -					if (sdev->ops != ops) {
> -						ret = -EBUSY;
> -						goto out;
> -					}
> -					sdev->users++;
> -					goto success;
> +			for_each_svm_dev(sdev, svm, dev) {
> +				if (sdev->ops != ops) {
> +					ret = -EBUSY;
> +					goto out;
>  				}
> +				sdev->users++;
> +				goto success;
>  			}

I think this does not read better as this is now a
for_each loop that exits the loop on the first match.

>  
>  			break;
> @@ -427,43 +429,36 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  		goto out;
>  	}
>  
> -	if (!svm)
> -		goto out;
> -
> -	list_for_each_entry(sdev, &svm->devs, list) {
[]
> +	for_each_svm_dev(sdev, svm, dev) {

I think this should not remove the !svm test above.


