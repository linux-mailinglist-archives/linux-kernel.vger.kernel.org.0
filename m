Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7844F21BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbfKFWeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 17:34:11 -0500
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:38489 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727196AbfKFWeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:34:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 130DC1260;
        Wed,  6 Nov 2019 22:34:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:4250:4321:5007:6119:8603:10004:10400:10848:11026:11232:11658:11914:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: bean84_5e4a6809fff01
X-Filterd-Recvd-Size: 1842
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 22:34:07 +0000 (UTC)
Message-ID: <a9e2f6b65d4c098ab027ea849120d3cf61858e67.camel@perches.com>
Subject: Re: [PATCH] xtensa: improve stack dumping
From:   Joe Perches <joe@perches.com>
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Petr Mladek <pmladek@suse.com>
Date:   Wed, 06 Nov 2019 14:33:55 -0800
In-Reply-To: <20191106181617.1832-1-jcmvbkbc@gmail.com>
References: <20191106181617.1832-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 10:16 -0800, Max Filippov wrote:
> Collect whole stack dump lines in a buffer and print the whole buffer
> when it's ready with pr_info instead of pr_cont. This makes stack dump
> lines consistent in SMP case and relies less on pr_cont/printk
> differences related to timestamps.
> Make size of stack dump configurable.
> Drop extra newline output in show_trace as its output format does not
> depend on CONFIG_KALLSYMS.
[]
> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
[]
> @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
>  	for (i = 0; i < kstack_depth_to_print; i++) {
>  		if (kstack_end(sp))
>  			break;
> -		pr_cont(" %08lx", *sp++);
> +		sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
>  		if (i % 8 == 7)
> -			pr_cont("\n");
> +			pr_info("%s\n", buf);
>  	}
> +	if (i % 8)
> +		pr_info("%s\n", buf);

Could this be done using hex_dump_to_buffer
by precalculating kstack_end ?


