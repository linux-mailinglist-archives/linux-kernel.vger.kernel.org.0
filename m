Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44135CCF04
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 08:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfJFGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 02:35:48 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:33599 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbfJFGfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 02:35:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A0577182CED2A;
        Sun,  6 Oct 2019 06:35:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2840:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:7775:8985:9025:10004:10400:10848:11232:11596:11658:11914:12043:12050:12297:12555:12663:12700:12737:12740:12760:12895:13069:13071:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21433:21451:21627:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:332,LUA_SUMMARY:none
X-HE-Tag: price21_6c2dfa516272e
X-Filterd-Recvd-Size: 3059
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Oct 2019 06:35:43 +0000 (UTC)
Message-ID: <52794b248ba13e88ab4c30c9b6ea55a7be30df5d.camel@perches.com>
Subject: Re: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in
 various ways
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Sat, 05 Oct 2019 23:35:42 -0700
In-Reply-To: <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
References: <cover.1570292505.git.joe@perches.com>
         <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
         <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-05 at 19:31 +0200, Miguel Ojeda wrote:
> Hi Joe,

Hello.

> On Sat, Oct 5, 2019 at 6:47 PM Joe Perches <joe@perches.com> wrote:
[]
> > As for the commit itself: while I am sure this tool is very useful
> (and certainly you put a *lot* of effort into this tool), I don't see
> how it is related to the fallthrough remapping (at least the
> non-fallthrough parts).

It's not particularly related.

It's a 10 year old script that I just extended because it's
convenient for me.

I think I first posted it in 2011, but I started it as a
complement to checkpatch in 2010.

https://lwn.net/Articles/380161/

Doing the regexes for the fallthrough conversions took me
a couple hours.

> Also, we should consider whether we want more tools like this now or
> simply put the efforts into moving to clang-format.

I think clang-format could not do this sort of conversion.
Nor could coccinelle or checkpatch.

Anyway, it's not really necessary for this particular patch
to be applied, but it's a convenient way to show the script
has the capability to do fallthrough comment conversions.

I think it does conversions fairly reasonably but likely
some files could not compile without adding an #include
like:

#include <linux/compiler.h>


