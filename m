Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99C415CFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 03:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgBNCGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 21:06:35 -0500
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:60624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbgBNCGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:06:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CD9F01802297C;
        Fri, 14 Feb 2020 02:06:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1461:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:7904:9040:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21611:21627:21740:21939:21990:30025:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: trees78_905cfe3f6200e
X-Filterd-Recvd-Size: 3084
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Feb 2020 02:06:31 +0000 (UTC)
Message-ID: <cb37f342635b045639d877034c9f6d175b5d80cd.camel@perches.com>
Subject: Re: [PATCH] sched/fair: Replace zero-length array with
 flexible-array member
From:   Joe Perches <joe@perches.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 18:05:13 -0800
In-Reply-To: <1d420ee4-7078-26d9-83ad-eb5f12106116@arm.com>
References: <20200213151951.GA32363@embeddedor>
         <20200213164518.GI14914@hirez.programming.kicks-ass.net>
         <9d516501-2624-f915-32be-13ba6f881019@embeddedor.com>
         <20200213170639.GK14914@hirez.programming.kicks-ass.net>
         <c7df22d3f248c784e8960841c79fe2836d7ea8ab.camel@perches.com>
         <1d420ee4-7078-26d9-83ad-eb5f12106116@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 00:25 +0000, Valentin Schneider wrote:
> On 13/02/2020 22:02, Joe Perches wrote:
> > That might be a somewhat difficult thing to add to checkpatch
> > as it is effectively a per-line scanner:
> > 
> > Try something like:
> > 
> > $ git grep -P -A1 '^\s*(?!return)(\w+\s+){1,3}\w+\[0\];' -- '*.[ch]'
> > 
> > and look at the results.
> > 
> > In checkpatch that could be something like:
> > 
> > 	if ($line =~ /^.\s*$Type\s+$Ident\s*\[\s*0\s*\]\s*;/) {
> > 		warn...
> > 	}
> > 
> 
> So FWIW I felt like doing some coccinelle and ended up with this:
> 
> This patches up valid ZLAs:
>   $ spatch -D patch zero_length_array.cocci kernel/sched/fair.c
> 
> This prints out the location of invalid ZLAs:
>   $ spatch -D report zero_length_array.cocci kernel/sched/fair.c
> 
> ---
> virtual patch
> virtual report
> 
> @valid_zla depends on patch@
> identifier struct_name;
> type T;
> identifier zla;
> position pos;
> @@
> struct struct_name {
>        ...
>        T zla@pos
> - [0];
> + [];
> };
> 
> @invalid_zla depends on report@
> identifier struct_name;
> type T1;
> identifier zla;
> type T2;
> identifier tail;
> position pos;
> @@
> struct struct_name {
>        ...
>        T1 zla[0]@pos;
>        T2 tail;
>        ...
> };
> 
> @script:python depends on invalid_zla@
> pos << invalid_zla.pos;
> @@
> coccilib.report.print_report(pos[0], "Invalid ZLA!");
> ---

Nice.
It would miss a few forms like:

	typedef struct tagfoo {
		...
		type t[0];
	} foo;

and

	struct {
		...
		type t[0];
	} foo;

and

	struct foo {
		...
		type t[0];
	} *foo;

etc...


