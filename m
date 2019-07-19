Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28676EC91
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbfGSWoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 18:44:16 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:60273 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727344AbfGSWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:44:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 15343180A68C8;
        Fri, 19 Jul 2019 22:44:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3165:3352:3622:3865:3866:3868:3871:3872:3873:4250:4321:4384:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12043:12114:12262:12297:12438:12555:12679:12740:12895:12986:13069:13255:13311:13357:13894:14181:14659:14721:21080:21365:21451:21627:30054:30064:30075:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: rail92_24b7b27a6db47
X-Filterd-Recvd-Size: 2601
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jul 2019 22:44:12 +0000 (UTC)
Message-ID: <511eb129bc0a6c92e3547c69a6e55695241dfe4a.camel@perches.com>
Subject: Re: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask()
 for tlb_is_not_lazy()
From:   Joe Perches <joe@perches.com>
To:     Nadav Amit <namit@vmware.com>, Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Date:   Fri, 19 Jul 2019 15:44:10 -0700
In-Reply-To: <6847D7A3-4618-4BC3-97B6-EC53F6985504@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
         <20190719005837.4150-4-namit@vmware.com>
         <8bf005e2-7ac7-f1cf-eca1-0e152dd912a7@intel.com>
         <6847D7A3-4618-4BC3-97B6-EC53F6985504@vmware.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-19 at 18:41 +0000, Nadav Amit wrote:
> > On Jul 19, 2019, at 11:36 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > On 7/18/19 5:58 PM, Nadav Amit wrote:
> > > @@ -865,7 +893,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > > 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
> > > 		lockdep_assert_irqs_enabled();
> > > 		local_irq_disable();
> > > -		flush_tlb_func_local(&full_flush_tlb_info);
> > > +		flush_tlb_func_local((void *)&full_flush_tlb_info);
> > > 		local_irq_enable();
> > > 	}
> > 
> > This looks like superfluous churn.  Is it?
> 
> Unfortunately not, since full_flush_tlb_info is defined as const. Without it
> you would get:
> 
> warning: passing argument 1 of ‘flush_tlb_func_local’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> 
> And flush_tlb_func_local() should get (void *) argument since it is also
> used by the SMP infrastructure.

huh?

commit 3db6d5a5ecaf0a778d721ccf9809248350d4bfaf
Author: Nadav Amit <namit@vmware.com>
Date:   Thu Apr 25 16:01:43 2019 -0700

[]

-static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
+static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)

