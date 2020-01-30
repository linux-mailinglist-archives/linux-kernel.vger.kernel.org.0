Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83814D6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 07:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgA3Gkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 01:40:42 -0500
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:42661 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgA3Gkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:40:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 187D6182CED2A;
        Thu, 30 Jan 2020 06:40:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:966:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2196:2199:2393:2525:2560:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4385:4605:5007:7875:8603:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12663:12740:12760:12895:13069:13095:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21063:21080:21433:21451:21627:21795:21939:21966:30012:30041:30051:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: chalk31_40013548c1333
X-Filterd-Recvd-Size: 2693
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Jan 2020 06:40:39 +0000 (UTC)
Message-ID: <f099965dc5de82fc5fb60ba10371cd9f1aed2d94.camel@perches.com>
Subject: Re: -Wfortify-source in kernel/printk/printk.c
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Wed, 29 Jan 2020 22:39:32 -0800
In-Reply-To: <20200130051711.GF115889@google.com>
References: <20200130021648.GA32309@ubuntu-x2-xlarge-x86>
         <20200130051711.GF115889@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-30 at 14:17 +0900, Sergey Senozhatsky wrote:
> On (20/01/29 19:16), Nathan Chancellor wrote:
> > Hi all,
> > 
> > After commit 6d485ff455e ("Improve static checks for sprintf and
> > __builtin___sprintf_chk") in clang [1], the following warning appears
> > when CONFIG_PRINTK is disabled (e.g. allnoconfig):
> > 
> > ../kernel/printk/printk.c:2416:10: warning: 'sprintf' will always
> > overflow; destination buffer has size 0, but format string expands
> > to at least 33 [-Wfortify-source]
> >                         len = sprintf(text,
> >                               ^
> > 1 warning generated.
> > 
> > Specifically referring to
> > https://elixir.bootlin.com/linux/v5.5/source/kernel/printk/printk.c#L2416.
> 
> Good catch.
> 
> > It isn't wrong, given that when CONFIG_PRINTK is disabled, text's length
> > is 0 (LOG_LINE_MAX and PREFIX_MAX are both zero). How should this
> > warning be dealt this? I am not familiar enough with the printk code to
> > say myself.
> 
> It's not wrong.
> 
> Unless I'm missing something completely obvious: with disabled printk()
> we don't have any functions that can append messages to the logbuf, hence
> we can't overflow it. So the error in question should never trigger.
> 
> - Normal printk() is void, so kernel cannot append messages;
> - dev_printk() is void, so drivers cannot append messages and dicts;
> - devkmsg_write() is void, so user space cannot write to logbuf.
> 
> So I think we should never trigger that overflow (assuming that I
> didn't miss something) message.
> 
> In any case feel free to submit a patch - switch it to snprintf().

and/or make the code depend on CONFIG_PRINTK


