Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8851CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfFXU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 16:57:57 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:41993 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728831AbfFXU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:57:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6B714182CED2A;
        Mon, 24 Jun 2019 20:57:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6742:7875:7903:7904:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21324:21451:21627:30054:30055:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: rat41_7ecbaa5e0e910
X-Filterd-Recvd-Size: 2801
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 20:57:51 +0000 (UTC)
Message-ID: <f3138138a67107d84ba014d363df6ca9deba50c5.camel@perches.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Shawn Landden <shawn@git.icu>
Date:   Mon, 24 Jun 2019 13:57:49 -0700
In-Reply-To: <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
References: <20190624161913.GA32270@embeddedor>
         <20190624193123.GI3436@hirez.programming.kicks-ass.net>
         <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
         <20190624203737.GL3436@hirez.programming.kicks-ass.net>
         <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 15:53 -0500, Gustavo A. R. Silva wrote:
> On 6/24/19 3:37 PM, Peter Zijlstra wrote:
> > On Mon, Jun 24, 2019 at 12:45:54PM -0700, Joe Perches wrote:
> > > On Mon, 2019-06-24 at 21:31 +0200, Peter Zijlstra wrote:
> > > > I still consider it an abomination that the C parser looks at comments
> > > > -- other than to delete them, but OK I suppose, I'll take it.
> > > I still believe Arnaldo's/Miguel's/Shawn's/my et al. suggestion of
> > > #define __fallthrough __attribute__((fallthrough))
> > > is far better.
> > Oh yes, worlds better. Please, can we haz that instead?
> Once the C++17 `__attribute__((fallthrough))` is more widely handled by C compilers,
> static analyzers, and IDEs, we can switch to using that instead.
> Also, we are a few
> warnings away (less than five) from being able to enable -Wimplicit-fallthrough. After
> this option has been finally enabled (in v5.3) we can easily go and replace the comments
> to whatever we agree upon.

I doubt waiting is better.
If the latest compilers catch it, it's
probably good enough.

fallthrough or __fallthrough.  I don't care which.

I also doubt most static analyzers will parse all
#include headers to find the #define.


