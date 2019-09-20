Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A07EB93F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392660AbfITP2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 11:28:22 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:52282 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729019AbfITP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:28:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8364D18224510;
        Fri, 20 Sep 2019 15:28:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3352:3622:3866:3867:3868:3870:3872:4250:4321:4605:5007:6630:6742:7875:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:30054:30070:30075:30091,0,RBL:113.22.183.150:@perches.com:.lbl8.mailshell.net-62.14.241.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: rings76_2abf686031616
X-Filterd-Recvd-Size: 2580
Received: from XPS-9350 (unknown [113.22.183.150])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Sep 2019 15:28:13 +0000 (UTC)
Message-ID: <0f291158f7d788c001212bcbb13843fbff571eeb.camel@perches.com>
Subject: Re: [PATCH 07/32] x86: Use pr_warn instead of pr_warning
From:   Joe Perches <joe@perches.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Robert Richter <rric@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Date:   Fri, 20 Sep 2019 08:28:11 -0700
In-Reply-To: <7a517b43-7e86-79ba-5954-dd746c309c87@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
         <20190920062544.180997-8-wangkefeng.wang@huawei.com>
         <20190920092850.26usohzmatmqrlor@rric.localdomain>
         <7a517b43-7e86-79ba-5954-dd746c309c87@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-20 at 19:57 +0800, Kefeng Wang wrote:
> On 2019/9/20 17:28, Robert Richter wrote:
> > On 20.09.19 14:25:19, Kefeng Wang wrote:
> > > As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> > > pr_warning"), removing pr_warning so all logging messages use a
> > > consistent <prefix>_warn style. Let's do it.
[]
> > > diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
[]
> > > @@ -665,7 +664,7 @@ static __init int init_amd_gatt(struct agp_kern_info *info)
> > >  
> > >   nommu:
> > >  	/* Should not happen anymore */
> > > -	pr_warning("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
> > > +	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
> > >  	       "falling back to iommu=soft.\n");
> > This indentation should be fixed too, while at it.
> Will update later, thanks.

trivia:

likely better as a single line output:

	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU - falling back to iommu=soft\n");


