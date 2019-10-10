Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD986D32D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfJJUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 16:48:43 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:38196 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbfJJUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:48:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 88169781C;
        Thu, 10 Oct 2019 20:48:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2840:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:8985:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12740:12760:12895:12986:13069:13149:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21324:21433:21451:21627:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: dolls38_4b7237beba646
X-Filterd-Recvd-Size: 2857
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Oct 2019 20:48:38 +0000 (UTC)
Message-ID: <4b2ed594c5054138562c80cc94dee8b5398c9064.camel@perches.com>
Subject: Re: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in
 various ways
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Date:   Thu, 10 Oct 2019 13:48:37 -0700
In-Reply-To: <201910101338.59F36A33@keescook>
References: <cover.1570292505.git.joe@perches.com>
         <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
         <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
         <52794b248ba13e88ab4c30c9b6ea55a7be30df5d.camel@perches.com>
         <201910101338.59F36A33@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 13:39 -0700, Kees Cook wrote:
> On Sat, Oct 05, 2019 at 11:35:42PM -0700, Joe Perches wrote:
[]
> > I think clang-format could not do this sort of conversion.
> > Nor could coccinelle or checkpatch.
> > 
> > Anyway, it's not really necessary for this particular patch
> > to be applied, but it's a convenient way to show the script
> > has the capability to do fallthrough comment conversions.
> > 
> > I think it does conversions fairly reasonably but likely
> > some files could not compile without adding an #include
> > like:
> > 
> > #include <linux/compiler.h>
> 
> I think this is a nice tool to add -- at the very least it serves as
> infrastructure for future similar conversions. And small cleanups can be
> generated from it for people looking to clean up subsystems, etc.

Another similar tool that used checkpatch and also compile
tested and created git commits was reformat_with_checkpatch

https://lore.kernel.org/lkml/1405128087.6751.12.camel@joe-AO725/


