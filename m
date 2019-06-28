Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E18259BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfF1Mja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:39:30 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:57514 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726675AbfF1Mj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:39:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4C9CD180AA4E7;
        Fri, 28 Jun 2019 12:39:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3874:4321:5007:9012:10004:10400:10848:11026:11232:11473:11658:11914:12043:12294:12297:12438:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30054:30060:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: heart62_527ff926a3836
X-Filterd-Recvd-Size: 2281
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Jun 2019 12:39:26 +0000 (UTC)
Message-ID: <951e47de7dd6d86516c25ceb855c4b64f13fb65d.camel@perches.com>
Subject: Re: [PATCH 1/9] hrtimer: Use a bullet for the returns bullet list
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 28 Jun 2019 05:39:25 -0700
In-Reply-To: <8176c9089f66796de6f62e74499eb3d3015f785d.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
         <8176c9089f66796de6f62e74499eb3d3015f785d.1561723736.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 09:12 -0300, Mauro Carvalho Chehab wrote:
> That gets rid of this warning:
> 
> 	./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> and displays nicely both at the source code and at the produced
> documentation.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  kernel/time/hrtimer.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index edb230aba3d1..5ee77f1a8a92 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1114,9 +1114,10 @@ EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
>   * @timer:	hrtimer to stop
>   *
>   * Returns:
> - *  0 when the timer was not active
> - *  1 when the timer was active
> - * -1 when the timer is currently executing the callback function and
> + *
> + *  *  0 when the timer was not active
> + *  *  1 when the timer was active
> + *  * -1 when the timer is currently executing the callback function and
>   *    cannot be stopped

I think this last line should be indented 3 more spaces too


