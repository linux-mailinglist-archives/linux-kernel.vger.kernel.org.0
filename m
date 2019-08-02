Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C597EA9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfHBDNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 23:13:10 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:47735 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfHBDNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:13:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B6B4B180295BD;
        Fri,  2 Aug 2019 03:13:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21611:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: bone24_5581e2d354449
X-Filterd-Recvd-Size: 2113
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 03:13:07 +0000 (UTC)
Message-ID: <df75fa45950ab7bb67da52fe4b711209790e52ef.camel@perches.com>
Subject: Re: [PATCH v2 06/10] printk: Replace strncmp with str_has_prefix
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Aug 2019 20:13:06 -0700
In-Reply-To: <20190802014718.8952-1-hslester96@gmail.com>
References: <20190802014718.8952-1-hslester96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 09:47 +0800, Chuhong Yuan wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix
> to substitute such strncmp.
[]
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> @@ -118,18 +118,20 @@ static unsigned int __read_mostly devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
>  
>  static int __control_devkmsg(char *str)
>  {
> +	size_t len;
> +
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strncmp(str, "on", 2)) {
> +	if ((len = str_has_prefix(str, "on"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_ON;
> -		return 2;
> -	} else if (!strncmp(str, "off", 3)) {
> +		return len;
> +	} else if ((len = str_has_prefix(str, "off"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
> -		return 3;
> -	} else if (!strncmp(str, "ratelimit", 9)) {
> +		return len;
> +	} else if ((len = str_has_prefix(str, "ratelimit"))) {
>  		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
> -		return 9;
> +		return len;
>  	}
>  	return -EINVAL;
>  }

All of the else uses above could also be removed.

