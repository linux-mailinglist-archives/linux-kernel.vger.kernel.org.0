Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44A1ECE3F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKBLJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 07:09:11 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:49612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbfKBLJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:09:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 70F2218013501;
        Sat,  2 Nov 2019 11:09:09 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3866:3871:5007:6119:6261:7514:7809:7875:10004:10400:10848:10967:11232:11658:11914:12043:12297:12555:12731:12737:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:21740:21795:30012:30051:30054:30090:30091,0,RBL:185.117.82.237:@goodmis.org:.lbl8.mailshell.net-62.14.41.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: bath43_89db76ab05803
X-Filterd-Recvd-Size: 2405
Received: from grimm.local.home (vin.openfest.org [185.117.82.237])
        (Authenticated sender: rostedt@goodmis.org)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Nov 2019 11:09:07 +0000 (UTC)
Date:   Sat, 2 Nov 2019 07:09:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add VSPRINTF
Message-ID: <20191102070901.6c3bd88f@grimm.local.home>
In-Reply-To: <20191031133337.9306-1-pmladek@suse.com>
References: <20191031133337.9306-1-pmladek@suse.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 14:33:37 +0100
Petr Mladek <pmladek@suse.com> wrote:

> printk maintainers have been reviewing patches against vsprintf code last
> few years. Most changes have been committed via printk.git last two years.
> 
> New group is used because printk() is not the only vsprintf() user.
> Also the group of interested people is not the same.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6c34d04ce95..4181a83bd30a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17441,6 +17441,16 @@ S:	Maintained
>  F:	drivers/net/vrf.c
>  F:	Documentation/networking/vrf.txt
>  
> +VSPRINTF
> +M:	Petr Mladek <pmladek@suse.com>
> +M:	Steven Rostedt <rostedt@goodmis.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> +M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
> +S:	Maintained
> +F:	lib/vsprintf.c
> +F:	lib/test_printf.c
> +F:	Documentation/core-api/printk-formats.rst
> +
>  VT1211 HARDWARE MONITOR DRIVER
>  M:	Juerg Haefliger <juergh@gmail.com>
>  L:	linux-hwmon@vger.kernel.org

