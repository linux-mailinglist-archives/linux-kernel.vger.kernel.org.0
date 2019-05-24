Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AAF29D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391317AbfEXRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:41:02 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:47426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbfEXRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:41:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8BD81181D3377;
        Fri, 24 May 2019 17:41:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7808:7903:10004:10400:10848:11026:11232:11658:11914:12438:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30034:30054:30056:30062:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: oven15_5ff195265d71a
X-Filterd-Recvd-Size: 2257
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 May 2019 17:40:59 +0000 (UTC)
Message-ID: <bc58c62d67f60678c980539fb3259683ea8bd21d.camel@perches.com>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 24 May 2019 10:40:56 -0700
In-Reply-To: <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
         <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 10:17 -0700, Linus Torvalds wrote:
> > This patch is intended for testing on linux-next.git only, and
> > will be removed after we found what is wrong.
> 
> Honestly, wouldn't it be much better to try to come up with a patch
> that might be acceptable in general.
> 
> For example, how about a config option that just hardcodes
> console_loglevel as a compile-time constant, and where you can't
> change it at all? There are not that many paths that set the console
> log-level, and the few that do could be made to use
> 
>     set_console_log_level(x);
> 
> instead of
> 
>     console_loglevel = x;
> 
> like they do.
> 
> We already have a number of loglevel config options, adding another
> that says "fix log levels at compile time" doesn't sound too bad, and
> I suspect a patch that introduces that set_console_log_level() kind of
> model and just makes "console_loglevel" a constant #define wouldn't be
> too ugly.
> 
> A config option or two that help syzbot doesn't sound like a bad idea to me.
> 
> Hmm?

That could also help eliminate unnecessary pr_<foo> output
from object code.



