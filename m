Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8EAD1439
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfJIQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 12:38:39 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:59804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731824AbfJIQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:38:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id AE55918224D75;
        Wed,  9 Oct 2019 16:38:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2691:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:8660:9108:10004:10400:10848:10967:11232:11658:11914:12297:12663:12740:12895:13069:13148:13230:13311:13357:13894:14181:14659:14721:21080:21627:21790:21881:30054:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: cry32_10c0bd5169c3e
X-Filterd-Recvd-Size: 2450
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Oct 2019 16:38:34 +0000 (UTC)
Message-ID: <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Oct 2019 09:38:33 -0700
In-Reply-To: <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
         <20191009110943.7ff3a08a@gandalf.local.home>
         <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 09:13 -0700, Nick Desaulniers wrote:
> On Wed, Oct 9, 2019 at 8:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 9 Oct 2019 14:14:28 +0200 Markus Elfring <Markus.Elfring@web.de> wrote:
[]
> > > Several functions return values with which useful data processing
> > > should be performed. These values must not be ignored then.
> > > Thus use the annotation “__must_check” in the shown function declarations.
[]
> > I'm curious. How many warnings showed up when you applied this patch?
> 
> I got zero for x86_64 and arm64 defconfig builds of linux-next with
> this applied.  Hopefully that's not an argument against the more
> liberal application of it?  I view __must_check as a good thing, and
> encourage its application, unless someone can show that a certain
> function would be useful to call without it.

stylistic trivia, neither agreeing nor disagreeing with the patch
as I generally avoid reading Markus' patches.

I believe __must_check is best placed before the return type as
that makes grep for function return type easier to parse.

i.e. prefer
	[static inline] __must_check <type> <function>(<args...>);
over
	[static inline] <type> __must_check <function>(<args...>);

