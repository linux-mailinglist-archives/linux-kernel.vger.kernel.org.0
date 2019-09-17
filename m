Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DACB57F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfIQW0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 18:26:47 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:50117 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbfIQW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:26:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E206918225B0E;
        Tue, 17 Sep 2019 22:26:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:5007:6120:6742:7903:7904:8531:10004:10400:10471:10848:11232:11658:11914:12050:12114:12297:12663:12740:12760:12895:13019:13069:13161:13229:13255:13311:13357:13439:14096:14097:14659:21080:21433:21627,0,RBL:14.161.9.139:@perches.com:.lbl8.mailshell.net-62.14.241.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:43,LUA_SUMMARY:none
X-HE-Tag: bulb69_1c956a5c79822
X-Filterd-Recvd-Size: 2973
Received: from XPS-9350 (unknown [14.161.9.139])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Sep 2019 22:26:36 +0000 (UTC)
Message-ID: <45dd0d8dffa6718d8cbcd24720e9e39dddb08134.camel@perches.com>
Subject: Re: treewide replacement of fallthrough comments with "fallthrough"
 macro (was Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use)
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 Sep 2019 15:26:32 -0700
In-Reply-To: <201909161516.A68C8239A@keescook>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731171429.GA24222@amd>
         <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
         <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
         <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
         <201907311301.EC1D84F@keescook> <201908151049.809B9AFBA9@keescook>
         <201909161516.A68C8239A@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 15:19 -0700, Kees Cook wrote:
> On Thu, Aug 15, 2019 at 11:15:53AM -0700, Kees Cook wrote:
> > With that out of the way, yes, let's do a mass conversion. As mentioned
> > before, I think "fallthrough;" should be used here (to match "break;").
> > Let's fork the C language. :)
> 
> FWIW, last week I asked Linus at the maintainer's summit which he
> preferred ("__fallthrough" or "fallthrough") and he said "fallthrough".

Nice.  I think that's better style/taste.

> Joe, if you've still got the series ready, do you want to send it for
> this merge window before -rc1 gets cut?

The first bits that add fallthrough and converts the one existing
use of fallthrough as a label can be sent now.  I'll do that in
a few days as I'm not able to do that right now.

Sending any actual comment conversion patches before -rc1 might
require changes in already queued up and tested patches

I do think a scripted conversion by major subsystem/directory
might be a better mechanism than individual patches, especially
if applied directly before releasing what will be -rc1.



