Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47E7D6A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfHAHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 03:52:13 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:39461 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbfHAHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:52:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7541F180A68C4;
        Thu,  1 Aug 2019 07:52:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:421:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2393:2525:2553:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6120:6742:7514:8599:9025:9072:9388:10004:10049:10400:10848:11232:11658:11914:12043:12114:12297:12740:12760:12895:13019:13069:13255:13311:13357:13439:14181:14659:14721:14764:14849:21080:21451:21627:21740:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: salt52_87225dffc9104
X-Filterd-Recvd-Size: 2881
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 07:52:08 +0000 (UTC)
Message-ID: <bc1d19db30ce5ccbbb936144b0f28518a37e8a6c.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     hpa@zytor.com, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
Date:   Thu, 01 Aug 2019 00:52:06 -0700
In-Reply-To: <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731171429.GA24222@amd>
         <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
         <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
         <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
         <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
         <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
         <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 23:10 -0700, hpa@zytor.com wrote:
> On July 31, 2019 4:55:47 PM PDT, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Wed, Jul 31, 2019 at 11:01 PM <hpa@zytor.com> wrote:
> > > The standard is moving toward adding this as an attribute with the
> > [[fallthrough]] syntax; it is in C++17, not sure when it will be in C
> > be if it isn't already.
> > 
> > Not yet, but it seems to be coming:
> > 
> >  http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf
> > 
> > However, even if C2x gets it, it will be quite a while until the GCC
> > minimum version gets bumped up to that, so...
> > 
> > Cheers,
> > Miguel
> 
> The point was that we should plan ahead in whatever we end up doing.

Using a local keyword will allow any compiler to work successfully.

It's pretty simple to modify this to something like

#define fallback [[fallback]]



