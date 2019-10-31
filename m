Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B74F8EAFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJaMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 08:00:25 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:41929 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbfJaMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:00:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5C90518081312;
        Thu, 31 Oct 2019 12:00:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3167:3352:3622:3868:3871:3872:3874:4321:4605:5007:6117:7903:8603:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21740:30003:30054:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: cub46_2047b2e81a122
X-Filterd-Recvd-Size: 2173
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Oct 2019 12:00:21 +0000 (UTC)
Message-ID: <be4803c67e2e1f9e91e59bfd7b23f938619f66e8.camel@perches.com>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() +
 WARN_ON_ONCE()
From:   Joe Perches <joe@perches.com>
To:     zhong jiang <zhongjiang@huawei.com>, Borislav Petkov <bp@alien8.de>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Oct 2019 05:00:13 -0700
In-Reply-To: <5DBAC74E.5080001@huawei.com>
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>
         <20191031110304.GE21133@nazgul.tnic> <5DBAC74E.5080001@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-31 at 19:36 +0800, zhong jiang wrote:
> On 2019/10/31 19:03, Borislav Petkov wrote:
> > On Wed, Oct 30, 2019 at 04:57:18PM +0800, zhong jiang wrote:
> > > WARN_ONCE is more clear and simpler. Just replace it.
[]
> > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
[]
> > > @@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
> > >  		return NULL;
> > >  
> > >  	if (!phys_addr_valid(phys_addr)) {
> > > -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
> > > -		       (unsigned long long)phys_addr);
> > > -		WARN_ON_ONCE(1);
> > > +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
> > > +			  (unsigned long long)phys_addr);
> > Does
> > 	WARN_ONCE(!phys_addr_valid(phys_addr),
> > 		  "ioremap: invalid physical address %llx\n",
> > 		  (unsigned long long)phys_addr);
> > 
> > work too?
> > 
> Thanks, That is better. Will repost.

Perhaps this is not good patch concept as now each
invalid physical address will not be emitted.

Before:
	each invalid physical address printed
	one stack dump

After:
	one stck dump with first invalid physical address.


