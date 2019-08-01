Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868B77E478
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfHAUrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 16:47:55 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:49324 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbfHAUrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:47:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4F2E0180A8152;
        Thu,  1 Aug 2019 20:47:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6120:6742:9025:10004:10400:10848:11232:11658:11914:12043:12114:12219:12297:12438:12555:12663:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21324:21365:21451:21627:30012:30054:30074:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: hall48_444b58505c34e
X-Filterd-Recvd-Size: 3249
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 20:47:49 +0000 (UTC)
Message-ID: <e31f3918342683a4f56302be301208137e60566f.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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
Date:   Thu, 01 Aug 2019 13:47:47 -0700
In-Reply-To: <CANiq72kg+duBe_srpcco-P17=3OC2c1ys=rGMVY8Z9FxZ69sdw@mail.gmail.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731171429.GA24222@amd>
         <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
         <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
         <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
         <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
         <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
         <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
         <20190801122429.GY31398@hirez.programming.kicks-ass.net>
         <0BCDEED9-0B72-4412-909F-76C20D54983E@zytor.com>
         <CANiq72kg+duBe_srpcco-P17=3OC2c1ys=rGMVY8Z9FxZ69sdw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 22:26 +0200, Miguel Ojeda wrote:
> On Thu, Aug 1, 2019 at 10:10 PM <hpa@zytor.com> wrote:
> > I'm not disagreeing... I think using a macro makes sense.
> 
> It is either a macro or waiting for 5+ years (while we keep using the
> comment style) :-)
> 
> In case it helps to make one's mind about whether to go for it or not,
> I summarized the advantages and a few other details in the patch I
> sent in October:
> 
>   https://github.com/ojeda/linux/commit/668f011a2706ea555987e263f609a5deba9c7fc4
> 
> It would be nice, however, to discuss whether we want __fallthrough or
> fallthrough.

I was happy enough with either though after a bit of
playing around with both, I think the pseudo-keyword
reads quite a bit better.

linux-kernel is a constrained code base and using
underscored prefixes is not really necessary.

For instance:

_Bool is c99, but the kernel uses bool
uint8_t also, but the kernel uses u8, etc...

Yes it requires a bit of 'local knowledge',
but simpler is better.


