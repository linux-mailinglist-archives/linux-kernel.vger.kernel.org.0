Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA6B57F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 00:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfIQW2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 18:28:39 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:54611 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726902AbfIQW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:28:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D6F1818038B43;
        Tue, 17 Sep 2019 22:28:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:4605:5007:6120:7776:7980:8531:9025:10004:10400:10848:11026:11232:11257:11658:11914:12043:12297:12438:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14777:21080:21433:21451:21627:21819:30022:30029:30054:30079:30083:30090:30091,0,RBL:14.161.9.139:@perches.com:.lbl8.mailshell.net-62.8.241.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:36,LUA_SUMMARY:none
X-HE-Tag: doll51_2dc9165fbe829
X-Filterd-Recvd-Size: 2939
Received: from XPS-9350 (unknown [14.161.9.139])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Sep 2019 22:28:34 +0000 (UTC)
Message-ID: <d6d30d81aa73404cbb5479b373bce2b14850577b.camel@perches.com>
Subject: Re: [rfc patch script] treewide conversion of __section(foo) to
 section("foo");
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 17 Sep 2019 15:28:31 -0700
In-Reply-To: <CAKwvOd=uzQJ_098ua5VuUuDaWqGQHncED4WWjNwNS0-CdE5mfw@mail.gmail.com>
References: <7ef58eb00bc46b4ea3fe49a8c45cd2ff06292247.camel@perches.com>
         <CAKwvOdn6bMGZFAwH8iS5xD+Ce7oV8U6Fgi_SrFpCjo2-1hEUrw@mail.gmail.com>
         <a8290101e2720cac8b06613ec4cb91ffbfd69f05.camel@perches.com>
         <CAKwvOd=uzQJ_098ua5VuUuDaWqGQHncED4WWjNwNS0-CdE5mfw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-16 at 12:45 -0700, Nick Desaulniers wrote:
> On Thu, Sep 12, 2019 at 4:50 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2019-09-12 at 15:45 -0700, Nick Desaulniers wrote:
> > > If you want to email me just the patch file (so I don't have to
> > > copy+pasta from an email),
> > 
> > Lazy... ;)
> Says the Perl programmer...http://threevirtues.com/ ;)

Everyone here has most of those.  You too.

> > > I'd be happy to apply it and compile+boot test a few more arch's
> > > than x86.
> 
> Looks like arm defconfig has an error:

Thanks.

> arch/arm/mach-omap2/omap-wakeupgen.c:634:1: error: expected ';' after
> top level declarator
> ./include/linux/irqchip.h:27:43: note: expanded from macro 'IRQCHIP_DECLARE'
> #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name,
> compat, fn)
>                                           ^
> ./include/linux/of.h:1304:3: note: expanded from macro 'OF_DECLARE_2'
>                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
>                 ^
> ./include/linux/of.h:1284:10: note: expanded from macro '_OF_DECLARE'
>                 __used __section("__" ## table ## "_of_table")          \

Thanks, I stuffed up the # concatenation.  I'll fix and send the
script again.
> 
> and modpost is broken:
> drivers/cpufreq/cpufreq_conservative.mod.c:12:11: error: expected expression
> __section(.gnu.linkonce.this_module) = {
>           ^
> 1 error generated.

This one is because:

scripts/mod/modpost.c:  buf_printf(b, "__section(.gnu.linkonce.this_module) = {\n");

Easy to add quotes here,  I'll add it to the script.

> Same problem (token pasting then concatenation of strings).

right...


