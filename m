Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A39887EB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 06:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfHJEUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 00:20:53 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:57877 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbfHJEUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 00:20:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 29E67181D33FB;
        Sat, 10 Aug 2019 04:20:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3165:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4470:5007:6119:7903:8792:9010:9025:9108:9388:10004:10049:10400:10848:11026:11232:11658:11914:12043:12297:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14106:14181:14659:14721:21080:21451:21627:21740:21781:30054:30070:30083:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: vest68_7baf73a3d031c
X-Filterd-Recvd-Size: 2960
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 04:20:49 +0000 (UTC)
Message-ID: <667995275e6a1cbcdaa93029c1b33e6b52fc6803.camel@perches.com>
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 09 Aug 2019 21:20:48 -0700
In-Reply-To: <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
         <20190805032441.GO9017@brightrain.aerifal.cx>
         <20190809195630.GA15606@roeck-us.net>
         <5f26547f-b48e-4b9f-b8ef-858283915e3d@embeddedor.com>
         <20190809215608.GA11065@roeck-us.net>
         <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 21:47 -0500, Gustavo A. R. Silva wrote:
> On 8/9/19 4:56 PM, Guenter Roeck wrote:
> > On Fri, Aug 09, 2019 at 04:36:01PM -0500, Gustavo A. R. Silva wrote:
> > > On 8/9/19 2:56 PM, Guenter Roeck wrote:
> > > > On Sun, Aug 04, 2019 at 11:24:41PM -0400, Rich Felker wrote:
> > > > > On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
> > > > > > Since commit a035d552a93b ("Makefile: Globally enable fall-through
> > > > > > warning"), all sh builds fail with errors such as
> > > > > > 
> > > > > > arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> > > > > > arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> > > > > > 
> > > > > > Since this effectively disables all build and boot tests for the
> > > > > > architecture, let's drop -Werror from the sh kernel Makefile until
> > > > > > the problems are fixed.
[]
> On second thought it seems to me that this is not a good idea, at least
> for mainline. For the time being I'll take this patch for linux-next only.
> 
> Who is the maintainer of sh?

But whoever it may be, isn't particularly active.

MAINTAINERS-SUPERH
MAINTAINERS-M:  Yoshinori Sato <ysato@users.sourceforge.jp>
MAINTAINERS-M:  Rich Felker <dalias@libc.org>
MAINTAINERS-L:  linux-sh@vger.kernel.org
MAINTAINERS-Q:  http://patchwork.kernel.org/project/linux-sh/list/
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  Documentation/sh/
MAINTAINERS:F:  arch/sh/
MAINTAINERS-F:  drivers/sh/

> The best solution is to fix those fall-through warnings you see. Could you
> please send me all the warnings you see? I can try to fix them.

It's true it's a warning, but adding -Werror is rarely
a good idea as gcc error output can change with every
version.


