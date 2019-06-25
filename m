Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDB55C40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 01:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFYX0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 19:26:03 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:38045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfFYX0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:26:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E441A18225E09;
        Tue, 25 Jun 2019 23:25:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:6238:6742:7903:7904:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12438:12555:12663:12740:12760:12895:13161:13229:13439:14096:14097:14659:14721:21080:21451:21627:21740:30012:30054:30055:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: paper48_16be84a42890e
X-Filterd-Recvd-Size: 4401
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Jun 2019 23:25:56 +0000 (UTC)
Message-ID: <c32b1f6381d0fcdc2a054c778e233b95dc728068.camel@perches.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Chandler Carruth <chandlerc@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Tue, 25 Jun 2019 16:25:53 -0700
In-Reply-To: <CAKwvOdnzrMOCo4RRsfcR=K5ELWU8obgMqtOGZnx_avLrArjpRQ@mail.gmail.com>
References: <20190624161913.GA32270@embeddedor>
         <20190624193123.GI3436@hirez.programming.kicks-ass.net>
         <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
         <20190624203737.GL3436@hirez.programming.kicks-ass.net>
         <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
         <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
         <20190625071846.GN3436@hirez.programming.kicks-ass.net>
         <CANiq72=zzZ+Cx8uM+5UW7HeB9XtbXRhXmC2y2tz5EzPX77gHMw@mail.gmail.com>
         <CAKwvOdn5j8Hkc_jrLMbhg-4jbNya+agtMJi=c9o01RPCno1Q+w@mail.gmail.com>
         <1336988f46fb7ffda925ab86a6e4d5437cfdb275.camel@perches.com>
         <CAKwvOdnzrMOCo4RRsfcR=K5ELWU8obgMqtOGZnx_avLrArjpRQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 15:57 -0700, Nick Desaulniers wrote:
> consider most other GNU C extensions.  How do I
> test whether they exist in my compiler or not?  Is it everything or
> nothing (do they all have to exist?).

Until such time as the linux source code supports alternate
mechanisms for existing gcc extension uses, I think yes.

> In those cases you either end
> up shelling out to something like autoconf (which is what I consider
> the current infra around CONFIG_CC_HAS_ASM_GOTO), or code filled with
> tons of version checks for specific compilers which are brittle.

Or just one...

> Of the two cases, now consider what happens when my compiler that
> previously did not support a particular feature now does.  In the
> first case, the guards were compiler agnostic, and I *don't have to
> change the source* to make use of the feature in the new compiler.  In
> the second case, I *need to modify the source* to update the version
> checks to be correct.
[]
> Back to your point about adding a minimal version of Clang to the
> kernel; I don't really want to do this.  For non-x86 architectures,
> people are happily compiling their kernels with versions of clang as
> old as clang-4.

Perhaps:

#if defined(CONFIG_X86_32) || defined(CONFIG_X86_64)
#define CLANG_MINIMUM_VERSION 90000
#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
#define CLANG_MINIMUM_VERSION 40000
#else
etc...
#endif

#if CLANG_VERSION < CLANG_MINIMUM_VERSION
etc...
#endif

> and if it continues to work for them; I'm happy.  And
> if it doesn't, and they raise an alarm, we're happy to take a look.
> Old LTS distros may have ancient builds of clang, so maybe some kind
> of hint would be nice, but I'd also like to support older versions
> where we can and I think choosing clang-9 for x86's sake is too
> x86-centric.  A version check on CONFIG_JUMP_LABEL is maybe more
> appropriate, so it cannot be selected if you're using clang && your
> version of clang is not clang-9 or greater?

The now non-portable nature of .config files might be
improved.


