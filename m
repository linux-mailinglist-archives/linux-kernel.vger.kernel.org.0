Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE977BD47
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfGaJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 05:34:35 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:52694 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbfGaJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:34:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5DD26180A8145;
        Wed, 31 Jul 2019 09:34:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:6120:6691:6742:7903:9040:10004:10400:10848:11232:11658:11914:12043:12114:12297:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21063:21080:21433:21611:21627:21740:30054:30055:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: owl74_618f7876cda40
X-Filterd-Recvd-Size: 2772
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 09:34:30 +0000 (UTC)
Message-ID: <11f7da029d8b053c0069a02ec2c06f98280cddb5.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 02:34:28 -0700
In-Reply-To: <20190731090211.GP31381@hirez.programming.kicks-ass.net>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731090211.GP31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 11:02 +0200, Peter Zijlstra wrote:
> On Tue, Jul 30, 2019 at 10:35:18PM -0700, Joe Perches wrote:
> > Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> > various case block /* fallthrough */ style comments to appear to be an
> > actual reserved word with the same gcc case block missing fallthrough
> > warning capability.
> > 
> > All switch/case blocks now must end in one of:
> > 
> > 	break;
> > 	fallthrough;
> > 	goto <label>;
> > 	return [expression];
> > 
> > fallthough is gcc's __attribute__((__fallthrough__)) which was introduced
> > in gcc version 7..
> > 
> > fallthrough devolves to an empty "do {} while (0)" if the compiler version
> > (any version less than gcc 7) does not support the attribute.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> _MUCH_ better than that silly comment, thanks for doing this!
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I also hacked up a little perl script to do most of the
conversions and realignments for the 4200+ current comments.

I'll work on it a bit more and then post it when it's
presentable.

