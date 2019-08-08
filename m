Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8145885768
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 03:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfHHBIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 21:08:35 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:59323 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730467AbfHHBIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:08:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D47CE8368EFD;
        Thu,  8 Aug 2019 01:08:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2692:2693:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4641:5007:6119:6691:7903:7974:10004:10400:10450:10455:10848:11232:11658:11914:12297:12555:12740:12760:12895:12986:13255:13439:14040:14096:14097:14181:14659:19904:19999:21080:21324:21325:21433:21451:21627:21740:21796:30006:30036:30054:30060:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: ear68_4a95da1cc8d30
X-Filterd-Recvd-Size: 4032
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 01:08:32 +0000 (UTC)
Message-ID: <f469bc5c8ae2386af57296df0a8a17b7c223a476.camel@perches.com>
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Aug 2019 18:08:31 -0700
In-Reply-To: <c4157db4-dbda-5ab1-2092-83c4a3b0f19e@roeck-us.net>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-2-rikard.falkeborn@gmail.com>
         <20190807142728.GA16360@roeck-us.net>
         <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
         <099e07d4b4ecca9798404b95dc78c89bc3dd9f7f.camel@perches.com>
         <c4157db4-dbda-5ab1-2092-83c4a3b0f19e@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-07 at 17:58 -0700, Guenter Roeck wrote:
> On 8/7/19 5:07 PM, Joe Perches wrote:
> > On Wed, 2019-08-07 at 23:55 +0900, Masahiro Yamada wrote:
> > > On Wed, Aug 7, 2019 at 11:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > []
> > > > Who is going to fix the fallout ? For example, arm64:defconfig no longer
> > > > compiles with this patch applied.
> > > > 
> > > > It seems to me that the benefit of catching misuses of GENMASK is much
> > > > less than the fallout from no longer compiling kernels, since those
> > > > kernels won't get any test coverage at all anymore.
> > > 
> > > We cannot apply this until we fix all errors.
> > > I do not understand why Andrew picked up this so soon.
> > 
> > I think it makes complete sense to break -next (not mainline)
> > and force people to fix defects.  Especially these types of
> > defects that are trivial to fix.
> > 
> 
> I don't think this (from next-20190807):
> 
> Build results:
> 	total: 158 pass: 137 fail: 21
> Qemu test results:
> 	total: 391 pass: 318 fail: 73
> 
> is very useful. The situation is bad enough for newly introduced problems.
> It is all but impossible to get fixes for all problems discovered (or introduced)
> by adding checks like this one. In some cases, no one will care. In others,
> no one will pick up patches. Sometimes people won't know or realize that
> they are expected to fix something. Making the situation worse, the failures
> introduced by the new checks will hide other accumulating problems.
> 
> arch/sh has failed to build in mainline since 7/27 and in -next since
> next-20190711, due to the added "fallthrough" warning. I don't think
> that is too useful either. Ok, that situation may be a sign that the
> architecture isn't maintained as well as it should, but I don't think
> that this warrants breaking it on purpose in the hope to trigger
> some kind of reaction.
> 
> I don't mind if new checks are introduced, and I agree that it is useful
> and makes sense. But the checks should only be introduced after a reasonable
> attempt was made to fix _all_ associated problems. That doesn't mean that
> the entire work has to be done by the person introducing the check, but I
> do see that person responsible for making sure (or a reasonable definition
> of "make sure") that all problems are fixed before actually introducing
> the check. Yes, I understand, this is a lot of work, but adding checks
> and letting all hell break loose can not be the answer.

No hell is unleashed.

It's -next, an integration build, not mainline.


