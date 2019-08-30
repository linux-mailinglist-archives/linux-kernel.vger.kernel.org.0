Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26E3A3FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 23:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfH3Vxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 17:53:30 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:41443 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728111AbfH3Vxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:53:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B5135181D341A;
        Fri, 30 Aug 2019 21:53:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:4250:4321:4362:5007:6119:6691:10004:10400:10848:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:30012:30054:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: mouth94_111052b6051b
X-Filterd-Recvd-Size: 1865
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 21:53:27 +0000 (UTC)
Message-ID: <64a000cc3b0fcd7c99b5cd41b0db7f1b5e9e6db7.camel@perches.com>
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:53:25 -0700
In-Reply-To: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 23:46 +0200, Rasmus Villemoes wrote:
> It has been suggested several times to extend vsnprintf() to be able
> to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
> another attempt. Rather than adding another %p extension, simply teach
> plain %p to convert ERR_PTRs. While the primary use case is

Thanks, this all this seems reasonable except for

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -2178,8 +2204,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return flags_string(buf, end, ptr, spec, fmt);
>  	case 'O':
>  		return kobject_string(buf, end, ptr, spec, fmt);
> -	case 'x':
> -		return pointer_string(buf, end, ptr, spec);
>  	}
>  
>  	/* default is to _not_ leak addresses, hash before printing */

why remove this?

