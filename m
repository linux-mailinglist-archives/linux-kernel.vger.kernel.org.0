Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4801075CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 17:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKVQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 11:29:09 -0500
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:39181 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbfKVQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:29:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5E36A182CED2A;
        Fri, 22 Nov 2019 16:29:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2899:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:3872:3873:4250:4321:5007:6119:7903:8660:10004:10400:10450:10455:10848:11026:11232:11658:11914:12043:12050:12295:12296:12297:12555:12740:12760:12895:12986:13069:13148:13230:13311:13357:13439:13868:14659:14721:19904:19999:21080:21433:21451:21627:21740:30054:30055:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mom43_1547a037e0e3d
X-Filterd-Recvd-Size: 2884
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Nov 2019 16:29:06 +0000 (UTC)
Message-ID: <799a49ee8fc8041a00332e0866554ddc04a2b8b0.camel@perches.com>
Subject: Re: [PATCH v2] iommu/iova: silence warnings under memory pressure
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Nov 2019 08:28:41 -0800
In-Reply-To: <1574434760.9585.18.camel@lca.pw>
References: <20191122025510.4319-1-cai@lca.pw>
         <7fd08d481a372ea0b600f95c12166ab54ed5e267.camel@perches.com>
         <1574434760.9585.18.camel@lca.pw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-22 at 09:59 -0500, Qian Cai wrote:
> On Thu, 2019-11-21 at 20:37 -0800, Joe Perches wrote:
> > On Thu, 2019-11-21 at 21:55 -0500, Qian Cai wrote:
> > > When running heavy memory pressure workloads, this 5+ old system is
> > > throwing endless warnings below because disk IO is too slow to recover
> > > from swapping. Since the volume from alloc_iova_fast() could be large,
> > > once it calls printk(), it will trigger disk IO (writing to the log
> > > files) and pending softirqs which could cause an infinite loop and make
> > > no progress for days by the ongoimng memory reclaim. This is the counter
> > > part for Intel where the AMD part has already been merged. See the
> > > commit 3d708895325b ("iommu/amd: Silence warnings under memory
> > > pressure"). Since the allocation failure will be reported in
> > > intel_alloc_iova(), so just call printk_ratelimted() there and silence
> > > the one in alloc_iova_mem() to avoid the expensive warn_alloc().
> > 
> > []
> > > v2: use dev_err_ratelimited() and improve the commit messages.
> > 
> > []
> > > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > 
> > []
> > > @@ -3401,7 +3401,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
> > >  	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> > >  				   IOVA_PFN(dma_mask), true);
> > >  	if (unlikely(!iova_pfn)) {
> > > -		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
> > > +		dev_err_ratelimited(dev, "Allocating %ld-page iova failed",
> > > +				    nrpages);
> > 
> > Trivia:
> > 
> > This should really have a \n termination on the format string
> > 
> > 		dev_err_ratelimited(dev, "Allocating %ld-page iova failed\n",
> > 
> > 
> 
> Why do you say so? It is right now printing with a newline added anyway.
> 
>  hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed

If another process uses pr_cont at the same time,
it can be interleaved.


