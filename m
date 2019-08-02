Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC567FE67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 18:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbfHBQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 12:16:11 -0400
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:36721 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728853AbfHBQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:16:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 432EA181D3419;
        Fri,  2 Aug 2019 16:16:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2898:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6120:6742:9025:10004:10400:10848:11026:11232:11658:11914:12043:12114:12297:12438:12555:12679:12740:12760:12895:12986:13069:13255:13311:13357:13439:13845:14096:14097:14181:14659:14721:21080:21611:21627:21811:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: dad84_52659459e0a12
X-Filterd-Recvd-Size: 2820
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 16:16:06 +0000 (UTC)
Message-ID: <36351fc3177bce273ecf47dd00b013306026aa2c.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 02 Aug 2019 09:16:04 -0700
In-Reply-To: <201908020907.4E056142@keescook>
References: <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
         <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
         <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
         <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
         <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
         <20190801122429.GY31398@hirez.programming.kicks-ass.net>
         <0BCDEED9-0B72-4412-909F-76C20D54983E@zytor.com>
         <CANiq72kg+duBe_srpcco-P17=3OC2c1ys=rGMVY8Z9FxZ69sdw@mail.gmail.com>
         <20190802110042.GA6957@hmswarspite.think-freely.org>
         <20190802123418.GA3722@amd> <201908020907.4E056142@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 09:09 -0700, Kees Cook wrote:
> On Fri, Aug 02, 2019 at 02:34:18PM +0200, Pavel Machek wrote:
> > I like the "fallthrough". It looks like "return" and it should, no
> > need to have __'s there..
> 
> Yeah, it would have the same feel as "break", "continue", "return"...
> 
> The only place I see this already used is in net/sctp/sm_make_chunk.c,
> as a label, which would be trivial to adjust...

Yeah.

From the RFC patch:

For allow compilation of a kernel that includes net/sctp, this patch
also requires a rename of the use of fallthrough as a label in
net/sctp/sm_make_chunk.c that was submitted as:

https://lore.kernel.org/lkml/e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com/


