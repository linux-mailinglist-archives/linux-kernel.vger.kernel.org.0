Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0614270B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 10:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATJUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 04:20:13 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:53119 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgATJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:20:12 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 479371802D512;
        Mon, 20 Jan 2020 09:20:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3870:3871:3874:4321:5007:7903:10004:10400:11232:11658:11914:12048:12297:12740:12895:13069:13161:13229:13311:13357:13439:13894:14180:14659:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lamp39_15b12ba1e401
X-Filterd-Recvd-Size: 1607
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Jan 2020 09:20:09 +0000 (UTC)
Message-ID: <1d375eb78623261eb334caaa3980905115aa1bf8.camel@perches.com>
Subject: Re: [PATCH 0/2] printf: add support for %de
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 20 Jan 2020 01:19:09 -0800
In-Reply-To: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
References: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-20 at 09:55 +0100, Uwe Kleine-König wrote:
> Hello,
> 
> this is an reiteration of my patch from some time ago that introduced
> %dE with the same semantic. Back then this resulted in the support for
> %pe which was less contentious.
> 
> I still consider %de (now with a small 'e' to match %pe) useful.

I still think this is not a good idea at all.

There really should be no need to introduce more
odd vsprintf extensions.

%p<foo> should be enough.


