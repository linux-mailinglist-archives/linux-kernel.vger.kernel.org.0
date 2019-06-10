Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E63BC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfFJTMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 15:12:48 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:35034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbfFJTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:12:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6460E100E86C2;
        Mon, 10 Jun 2019 19:12:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3872:4321:5007:6117:7903:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12438:12679:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21080:21433:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: noise96_8c799a9dcb15d
X-Filterd-Recvd-Size: 2203
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Jun 2019 19:12:45 +0000 (UTC)
Message-ID: <cd2fe2492251187acf62744a191cf6d76732f9e7.camel@perches.com>
Subject: Re: [PATCH 3/5] random: Add and use pr_fmt()
From:   Joe Perches <joe@perches.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, tytso@mit.edu, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 10 Jun 2019 12:12:44 -0700
In-Reply-To: <20190607182517.28266-3-tiny.windzz@gmail.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
         <20190607182517.28266-3-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-07 at 14:25 -0400, Yangtao Li wrote:
> Prefix all printk/pr_<level> messages with "random: " to make the
> logging a bit more consistent.
> 
> Miscellanea:
> 
> o Convert a printks to pr_notice
> o Whitespace to align to open parentheses
> o Remove embedded "random: " from pr_* as pr_fmt adds it
[]
> diff --git a/drivers/char/random.c b/drivers/char/random.c
[]
> @@ -1031,15 +1033,15 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
>  		crng_init = 2;
>  		process_random_ready_list();
>  		wake_up_interruptible(&crng_init_wait);
> -		pr_notice("random: crng init done\n");
> +		pr_notice("crng init done\n");
>  		if (unseeded_warning.missed) {
> -			pr_notice("random: %d get_random_xx warning(s) missed "
> +			pr_notice("%d get_random_xx warning(s) missed "
>  				  "due to ratelimiting\n",

Trivia:

It'd be nice to coalesce the format string fragments
into a single line at the same time too.

			pr_notice("%d get_random_xx warning(s) missed due to ratelimiting\n",
 				  unseeded_warning.missed);

>  			unseeded_warning.missed = 0;
>  		}
>  		if (urandom_warning.missed) {
> -			pr_notice("random: %d urandom warning(s) missed "
> +			pr_notice("%d urandom warning(s) missed "
>  				  "due to ratelimiting\n",

etc...



