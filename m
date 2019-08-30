Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C06A407A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfH3WVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 18:21:05 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:33339 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728122AbfH3WVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:21:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7F6FA180A68BC;
        Fri, 30 Aug 2019 22:21:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3874:4321:5007:6119:6691:7903:10004:10400:10848:11026:11232:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30012:30054:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: heart65_6059c6a33e92b
X-Filterd-Recvd-Size: 2060
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 22:21:01 +0000 (UTC)
Message-ID: <92108c09c37a9355566b579db152a05e19f54ccf.camel@perches.com>
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 15:21:00 -0700
In-Reply-To: <9fecd3a9-e1ae-a1f9-a0c5-f5db3430c81d@rasmusvillemoes.dk>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
         <64a000cc3b0fcd7c99b5cd41b0db7f1b5e9e6db7.camel@perches.com>
         <9fecd3a9-e1ae-a1f9-a0c5-f5db3430c81d@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-31 at 00:03 +0200, Rasmus Villemoes wrote:
> On 30/08/2019 23.53, Joe Perches wrote:
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > []
> > > @@ -2178,8 +2204,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> > >  		return flags_string(buf, end, ptr, spec, fmt);
> > >  	case 'O':
> > >  		return kobject_string(buf, end, ptr, spec, fmt);
> > > -	case 'x':
> > > -		return pointer_string(buf, end, ptr, spec);
> > >  	}
> > >  
> > >  	/* default is to _not_ leak addresses, hash before printing */
> > 
> > why remove this?
> > 
> 
> The handling of %px is moved above the test for ptr being an ERR_PTR, so
> that %px, ptr continues to be (roughly) equivalent to %08lx, (long)ptr.

Ah.
Pity the flow of the switch/case is disrupted.
That now deserves a separate comment.

But why not just extend check_pointer_msg?


