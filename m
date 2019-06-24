Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0820451B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfFXTqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:46:00 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:47796 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbfFXTp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:45:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 797CD1801C5E9;
        Mon, 24 Jun 2019 19:45:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::,RULES_HIT:41:152:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2566:2570:2682:2685:2691:2703:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3353:3622:3865:3866:3867:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7514:7875:7904:8985:9025:10004:10400:11658:12740:13069,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: run93_50df21c86a335
X-Filterd-Recvd-Size: 3000
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 19:45:55 +0000 (UTC)
Message-ID: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
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
Date:   Mon, 24 Jun 2019 12:45:54 -0700
In-Reply-To: <20190624193123.GI3436@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
         <20190624193123.GI3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 21:31 +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2019 at 11:19:13AM -0500, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > cases where we are expecting to fall through.
> > 
> > This patch fixes the following warnings:
> > 
> > arch/x86/events/intel/core.c: In function ‘intel_pmu_init’:
> > arch/x86/events/intel/core.c:4959:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    pmem = true;
> >    ~~~~~^~~~~~
> > arch/x86/events/intel/core.c:4960:2: note: here
> >   case INTEL_FAM6_SKYLAKE_MOBILE:
> >   ^~~~
> > arch/x86/events/intel/core.c:5008:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    pmem = true;
> >    ~~~~~^~~~~~
> > arch/x86/events/intel/core.c:5009:2: note: here
> >   case INTEL_FAM6_ICELAKE_MOBILE:
> >   ^~~~
> > 
> > Warning level 3 was used: -Wimplicit-fallthrough=3
> > 
> > This patch is part of the ongoing efforts to enable
> > -Wimplicit-fallthrough.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I still consider it an abomination that the C parser looks at comments
> -- other than to delete them, but OK I suppose, I'll take it.

I still believe Arnaldo's/Miguel's/Shawn's/my et al. suggestion of

#define __fallthrough __attribute__((fallthrough))

is far better.

https://lkml.org/lkml/2017/2/9/845
https://lkml.org/lkml/2017/2/10/485
https://lore.kernel.org/lkml/20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com/
https://lore.kernel.org/lkml/20190617155643.GA32544@amd/



