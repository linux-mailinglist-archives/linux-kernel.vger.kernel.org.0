Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC791F6BB4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 23:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKJWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 17:01:03 -0500
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:55209 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727080AbfKJWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 17:01:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 310B9100E7B40;
        Sun, 10 Nov 2019 22:01:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3868:3871:4321:4605:5007:7904:8603:8999:10004:10400:10848:11026:11232:11658:11914:12296:12297:12438:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: river90_25ddd2f9e5c25
X-Filterd-Recvd-Size: 2113
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Nov 2019 22:01:00 +0000 (UTC)
Message-ID: <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 10 Nov 2019 14:00:44 -0800
In-Reply-To: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-11-10 at 10:21 +0000, Thomas Gleixner wrote:
> A small fix for a stacktrace regression. Saving a stacktrace for a foreign
> task skipped an extra entry which makes e.g. the output of /proc/$PID/stack
> incomplete.
[]
> ------------------>
> Jiri Slaby (1):
>       stacktrace: Don't skip first entry on noncurrent tasks
[]
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
[]
> @@ -141,7 +141,8 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
>  	struct stacktrace_cookie c = {
>  		.store	= store,
>  		.size	= size,
> -		.skip	= skipnr + 1,
> +		/* skip this function if they are tracing us */
> +		.skip	= skipnr + !!(current == tsk),

trivia:

This idiom '!!(logical test)' is odd and redundant.
Logical test result is already 0 or 1, no !! is unnecessary.

>  	};
>  
>  	if (!try_get_task_stack(tsk))
> @@ -298,7 +299,8 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
>  	struct stack_trace trace = {
>  		.entries	= store,
>  		.max_entries	= size,
> -		.skip		= skipnr + 1,
> +		/* skip this function if they are tracing us */
> +		.skip	= skipnr + !!(current == task),
>  	};
>  
>  	save_stack_trace_tsk(task, &trace);
> 
> 

