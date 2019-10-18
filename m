Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D6DC8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634337AbfJRPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 11:33:33 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:44671 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410630AbfJRPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:33:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 760951B268D1B;
        Fri, 18 Oct 2019 15:33:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:334:355:368:369:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3873:3874:4321:5007:7903:9121:10004:10400:11232:11233:11658:11914:12043:12048:12262:12297:12438:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21365:21627:30054:30070:30089:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: rest37_758ca69fedf36
X-Filterd-Recvd-Size: 2388
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Oct 2019 15:33:27 +0000 (UTC)
Message-ID: <5348febc85ad3460f4e06ff11bf58ec70f6b3a48.camel@perches.com>
Subject: Re: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Lars Poeschel <poeschel@lemonage.de>,
        Vadim Bendebury <vbendeb@chromium.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 08:33:26 -0700
In-Reply-To: <CANiq72m0V5CBxp97Q4h70Gup1DCoZj4ZFa6VWQLk0jyurxeztQ@mail.gmail.com>
References: <20191016082430.5955-1-poeschel@lemonage.de>
         <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
         <20191017080741.GA17556@lem-wkst-02.lemonage>
         <CANiq72m0V5CBxp97Q4h70Gup1DCoZj4ZFa6VWQLk0jyurxeztQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-18 at 17:08 +0200, Miguel Ojeda wrote:
> On Thu, Oct 17, 2019 at 10:07 AM Lars Poeschel <poeschel@lemonage.de> wrote:
[]
> > Oh by the way: Do you know what I can do to make checkpatch happy with
> > its describing of the config symbol ? I tried writing a help paragraph
> > for the config symbols in Kconfig, but that did not help.
> 
> CC'ing Joe.

add
	--ignore=CONFIG_DESCRIPTION
or
	--min-conf-desc-length=1 (default is 4)

to the checkpatch command line, or just ignore it.

AK: I guess there's still some debate as to the proper
minimum length of a Kconfig help section paragraph.

commit 3354957a4f8b9bb4b43625232acdf0626851c82f
Author: Andi Kleen <ak@linux.intel.com>
Date:   Mon May 24 14:33:29 2010 -0700

    checkpatch: add check for too short Kconfig descriptions
    
    I've seen various new Kconfigs with rather unhelpful one liner
    descriptions.  Add a Kconfig warning for a minimum length of the Kconfig
    help section.
    
    Right now I arbitarily chose 4. The exact value can be debated.
 

