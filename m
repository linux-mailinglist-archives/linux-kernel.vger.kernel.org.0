Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2ACB10F15A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 21:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfLBULW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 15:11:22 -0500
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:60319 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727586AbfLBULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:11:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D8FE5181D341E;
        Mon,  2 Dec 2019 20:11:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 40,2.5,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3871:3872:3874:4250:4321:4385:5007:6119:7903:9010:10011:10400:10848:11026:11232:11658:11914:12043:12048:12295:12297:12438:12740:12760:12895:13069:13311:13357:13439:13972:14096:14097:14659:14721:21080:21611:21627:30054:30056:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: whip27_45b83b744b756
X-Filterd-Recvd-Size: 2912
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Dec 2019 20:11:18 +0000 (UTC)
Message-ID: <d3dd39dabf20814174c11f60dc22c2401490e4ca.camel@perches.com>
Subject: Re: [PATCH v5 8/8] iommu/vt-d: Misc macro clean up for SVM
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
Date:   Mon, 02 Dec 2019 12:10:45 -0800
In-Reply-To: <1575316709-54903-9-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1575316709-54903-1-git-send-email-jacob.jun.pan@linux.intel.com>
         <1575316709-54903-9-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-02 at 11:58 -0800, Jacob Pan wrote:
> Use combined macros for_each_svm_dev() to simplify SVM device iteration
> and error checking.
[]
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
[]
> @@ -427,40 +430,36 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
[]
> +	for_each_svm_dev(sdev, svm, dev) {
> +		ret = 0;
> +		sdev->users--;
> +		if (!sdev->users) {

This might be better by reducing indentation here too

		if (sdev->users)
			break;

> +			list_del_rcu(&sdev->list);

to reduce indentation 1 level below this

> +			/* Flush the PASID cache and IOTLB for this device.
> +			 * Note that we do depend on the hardware *not* using
> +			 * the PASID any more. Just as we depend on other
> +			 * devices never using PASIDs that they have no right
> +			 * to use. We have a *shared* PASID table, because it's
> +			 * large and has to be physically contiguous. So it's
> +			 * hard to be as defensive as we might like. */
> +			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> +			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> +			kfree_rcu(sdev, rcu);
> +
> +			if (list_empty(&svm->devs)) {
> +				ioasid_free(svm->pasid);
> +				if (svm->mm)
> +					mmu_notifier_unregister(&svm->notifier, svm->mm);
> +				list_del(&svm->list);
> +				/* We mandate that no page faults may be outstanding
> +				 * for the PASID when intel_svm_unbind_mm() is called.
> +				 * If that is not obeyed, subtle errors will happen.
> +				 * Let's make them less subtle... */
> +				memset(svm, 0x6b, sizeof(*svm));
> +				kfree(svm);
>  			}
> -			break;
>  		}
> +		break;
>  	}
>   out:
>  	mutex_unlock(&pasid_mutex);

