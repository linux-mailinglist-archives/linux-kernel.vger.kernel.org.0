Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C616441A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 13:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBSMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 07:21:58 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:51037 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgBSMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:21:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CD4B71801D023;
        Wed, 19 Feb 2020 12:21:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:4321:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21080:21433:21611:21627:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bean98_8543dd22e971c
X-Filterd-Recvd-Size: 1765
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 12:21:55 +0000 (UTC)
Message-ID: <f3bac52dffc9e5402eb6c6106256dffaf550ee90.camel@perches.com>
Subject: Re: [PATCH 03/24] n_hdlc: convert debuglevel use to pr_debug
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Feb 2020 04:20:33 -0800
In-Reply-To: <20200219084118.26491-3-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
         <20200219084118.26491-3-jslaby@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-19 at 09:40 +0100, Jiri Slaby wrote:
> With pr_debug we have a fine-grained control about debugging prints. So
> convert the use of global debuglevel variable and tests to a commonly
> used pr_debug. And drop debuglevel completely.
> 
> This also implicitly adds a loglevel to the messages (KERN_DEBUG) as it
> was missing on most of them.
[]
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
[]
> @@ -310,11 +306,9 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
>  {
>  	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
>  
> -	if (debuglevel >= DEBUG_LEVEL_INFO)	
> -		printk("%s(%d)n_hdlc_tty_open() called (device=%s)\n",
> -		__FILE__,__LINE__,
> -		tty->name);
> -		
> +	pr_debug("%s(%d)%s() called (device=%s)\n",
> +			__FILE__, __LINE__, __func__, tty->name);

Perhaps remove all the __FILE__ and __LINE__ arguments as
dynamic debug could emit module and __LINE__ when necessary.



