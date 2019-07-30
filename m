Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1359179D42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 02:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfG3AQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 20:16:40 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:51011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728195AbfG3AQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:16:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 25656100E86C2;
        Tue, 30 Jul 2019 00:16:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3874:4321:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: duck20_742442808ff0f
X-Filterd-Recvd-Size: 2479
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 30 Jul 2019 00:16:37 +0000 (UTC)
Message-ID: <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
Subject: Re: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 17:16:35 -0700
In-Reply-To: <20190729151505.9660-1-hslester96@gmail.com>
References: <20190729151505.9660-1-hslester96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-29 at 23:15 +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone.
> We had better use newly introduced
> str_has_prefix() instead of it.
[]
> diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
[]
> @@ -11,10 +11,10 @@
>  
>  int _braille_console_setup(char **str, char **brl_options)
>  {
> -	if (!strncmp(*str, "brl,", 4)) {
> +	if (str_has_prefix(*str, "brl,")) {
>  		*brl_options = "";
>  		*str += 4;
> -	} else if (!strncmp(*str, "brl=", 4)) {
> +	} else if (str_has_prefix(*str, "brl=")) {
>  		*brl_options = *str + 4;

Better to get rid of the += 4 uses too by storing the result
of str_has_prefix and using that as the addend.

Perhaps
	size_t len;

	if ((len = str_has_prefix(*str, "brl,"))) {
		*brl_options = "";
		*str += len;
	} else if ((len = str_has_prefix(*str, "brl="))) {
		etc...

>  		*str = strchr(*brl_options, ',');
>  		if (!*str) {
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> @@ -121,13 +121,13 @@ static int __control_devkmsg(char *str)
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strncmp(str, "on", 2)) {
> +	if (str_has_prefix(str, "on")) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_ON;
>  		return 2;
> -	} else if (!strncmp(str, "off", 3)) {
> +	} else if (str_has_prefix(str, "off")) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
>  		return 3;
> -	} else if (!strncmp(str, "ratelimit", 9)) {
> +	} else if (str_has_prefix(str, "ratelimit")) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
>  		return 9;
>  	}

here too.


