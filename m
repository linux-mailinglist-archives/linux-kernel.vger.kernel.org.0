Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3682A22F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 02:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEYA4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 20:56:36 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:32786 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbfEYA4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:56:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 468474430;
        Sat, 25 May 2019 00:56:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3873:3874:4321:5007:7808:10004:10400:10848:11026:11232:11473:11658:11914:12295:12438:12533:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30012:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: need28_735f329e4561a
X-Filterd-Recvd-Size: 2467
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 May 2019 00:56:32 +0000 (UTC)
Message-ID: <6b56ca73a5686513fc4ce9d3e07e402cfeeac544.camel@perches.com>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 24 May 2019 17:56:31 -0700
In-Reply-To: <df46bdfa-d149-4823-d6b8-e350275cd8f0@i-love.sakura.ne.jp>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
         <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
         <df46bdfa-d149-4823-d6b8-e350275cd8f0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-25 at 09:14 +0900, Tetsuo Handa wrote:
> On 2019/05/25 2:17, Linus Torvalds wrote:
> > A config option or two that help syzbot doesn't sound like a bad idea to me.
> 
> Thanks for suggestion. I think that #ifdef'ing
> 
>   static bool suppress_message_printing(int level)
>   {
>   	return (level >= console_loglevel && !ignore_loglevel);
>   }
> 
> is simpler.
[]
> On 2019/05/25 2:55, Linus Torvalds wrote:
> > On Fri, May 24, 2019 at 10:41 AM Joe Perches <joe@perches.com> wrote:
> > > That could also help eliminate unnecessary pr_<foo> output
> > > from object code.
> > 
> > Indeed. The small-config people might like it (if they haven't already
> > given up..)
> 
> Do you mean doing e.g.
> 
>   #define pr_debug(fmt, ...) no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> 
> depending on the minimal console loglevel kernel config option? Then, OK.

Yes.

Perhaps something like the below (or an equivalent generic wrapper)

#define pr_info(fmt, ...) \
do { \
	if (CONFIG_STATIC_CONSOLE_LEVEL >= LOGLEVEL_INFO) \
		printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__); \
	else \
		no_printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__); \
} while (0)

for each pr_<level>, dev_<level> and netdev_<level>


