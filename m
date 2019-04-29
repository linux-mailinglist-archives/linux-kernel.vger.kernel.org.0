Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3CFE7F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfD2Qmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 12:42:36 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:41947 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728520AbfD2Qmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:42:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0722318224D9E;
        Mon, 29 Apr 2019 16:42:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:8660:10004:10400:10450:10455:10848:11026:11232:11658:11914:12740:12760:12895:13069:13146:13148:13230:13311:13357:13439:14096:14097:14659:14721:19904:19999:21080:21627:30041:30054:30091,0,RBL:213.83.164.10:@perches.com:.lbl8.mailshell.net-62.14.73.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: card60_1622dbbbc1d5d
X-Filterd-Recvd-Size: 2277
Received: from XPS-9350 (unknown [213.83.164.10])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Apr 2019 16:42:31 +0000 (UTC)
Message-ID: <3078981761ff2a37354221eb79a1c24e43c30896.camel@perches.com>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        me@tobin.cc, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 29 Apr 2019 09:42:30 -0700
In-Reply-To: <20190429103925.6233e45f@gandalf.local.home>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
         <20190426130204.23a5a05c@gandalf.local.home>
         <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
         <20190429091320.019e726b@gandalf.local.home>
         <20190429143037.3qu5fzdo6g26rsmf@pathway.suse.cz>
         <20190429103925.6233e45f@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-29 at 10:39 -0400, Steven Rostedt wrote:
> [ added Joe ]
> > Good question. I have just double checked it. And pointer_string() with
> > "noinline_for_stack" does not make any difference in the stack
> > usage here.
> > 
> > I actually played with this before:
> > 
> > "noinline_for_stack" is a black magic added by
> > the commit cf3b429b03e827c7180 ("vsprintf.c: use noinline_for_stack").
> 
> From what I understand, "noinline_for_stack" is just noinline and the
> "for_stack" part is just to document that the noinline is used for
> stack purposes. If the compiler doesn't inline the function without the
> noinline, then it wont make any difference.
> 
> The point was to not inline the function because it can be used in
> stack critical areas, and that it's better to do the call than to
> increase the stack.

It was added because of %pV is recursive and recursive
functions can eat
a lot of stack.

Using noinline_for_stack was just a bit more self-documenting.

I do still think it's a useful notation.

