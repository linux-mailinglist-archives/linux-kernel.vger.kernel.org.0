Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3615246E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgBEBSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 20:18:51 -0500
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:33389 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727673AbgBEBSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:18:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 292C9100E7B42;
        Wed,  5 Feb 2020 01:18:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6737:7903:10004:10400:10848:11232:11658:11914:12048:12050:12297:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14659:14721:21080:21433:21451:21611:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cap53_4cbb811b77b29
X-Filterd-Recvd-Size: 2755
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Feb 2020 01:18:47 +0000 (UTC)
Message-ID: <ee9b52c291fe7f090d6516397db978eaaae6c657.camel@perches.com>
Subject: Re: [PATCH v2 1/2] kernel.h: Split out min()/max() et al helpers
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Trond@black.fi.intel.com,
        Myklebust@black.fi.intel.com, trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 04 Feb 2020 17:17:36 -0800
In-Reply-To: <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
References: <20200204170412.30106-1-andriy.shevchenko@linux.intel.com>
         <c02c86a1-5df3-1b94-78a7-3948bd9e64cb@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 00:23 +0100, Rasmus Villemoes wrote:
> On 04/02/2020 18.04, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt to start cleaning it up by splitting out min()/max()
> > et al helpers.
> > 
> > At the same time convert users in header and lib folder to use new header.
> > Though for time being include new header back to kernel.h to avoid twisted
> > indirected includes for existing users.
> 
> This is definitely long overdue, so thanks for taking this on. I think
> minmax.h is fine as a header on its own, but for the other one, I think
> you should go even further - and perhaps all these should go in a
> include/math/ dir (include/linux/ has ~1200 files), so we'd have
> math/minmax.h, math/round.h, math/ilog2.h, math/gcd.h etc., each
> containing just enough #includes to be self-contained (so if there's a
> declaration of something taking a u32, there's no way around having it
> include types.h (or wherever that's defined).

I think that's not at all desirable.

kernel.h as a monolithic include block is pretty useful.

Separating out the various bits into separate files is
OK, but kernel.h should #include them all.

One day a precompiled header of just kernel.h would be
useful to reduce overall compilation time.  Converting
all the other source files that use a small part of the
existing kernel.h into multiple includes would not allow
precompiled headers to work efficiently.



