Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375897E3AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 22:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388903AbfHAT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 15:58:13 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:53768 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388600AbfHAT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:58:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 006F340FC;
        Thu,  1 Aug 2019 19:58:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:4321:5007:10004:10226:10400:10848:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13141:13230:13311:13357:13439:14040:14659:14721:21080:21433:21627:21740:30012:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: bird94_47673eb66b536
X-Filterd-Recvd-Size: 1978
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 19:58:09 +0000 (UTC)
Message-ID: <98acdfce0da0d7c3b33571528064935c107cbbc5.camel@perches.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Update comment about
 simple_strto<foo>() functions
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Date:   Thu, 01 Aug 2019 12:58:08 -0700
In-Reply-To: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
References: <20190801192904.41087-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 22:29 +0300, Andy Shevchenko wrote:
> There were discussions in the past about use cases for
> simple_strto<foo>() functions and, in some rare cases,
> they have a benefit over kstrto<foo>() ones.
[]
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
[]
> @@ -334,8 +334,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> - * be checked.
> + * Used as a replacement for the simple_strtoull. Return code must be checked.

Using 'the' here is unnecessary and somewhat confusing.

Perhaps:

 * Preferred over simple_strtoull() unless the end position is required
 * Return value must be checked

> 

