Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086AC10FA40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 09:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCI4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 03:56:52 -0500
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:37562 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbfLCI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:56:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A8A5718037C64;
        Tue,  3 Dec 2019 08:56:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:2908:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3874:4321:4605:5007:7875:10004:10400:10450:10455:10848:11232:11658:11914:12043:12297:12663:12740:12760:12895:13019:13069:13311:13357:13439:14181:14659:14721:19904:19999:21080:21433:21451:21627:21740:21939:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: taste11_3b9cb87ae0b31
X-Filterd-Recvd-Size: 2898
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Dec 2019 08:56:49 +0000 (UTC)
Message-ID: <ea57f41e30f962227855d4f60a93c89a6bf0b2f0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date:   Tue, 03 Dec 2019 00:56:16 -0800
In-Reply-To: <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
References: <1574906800-19901-1-git-send-email-krzk@kernel.org>
         <87a78gnyaz.fsf@intel.com>
         <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com>
         <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-03 at 16:40 +0800, Krzysztof Kozlowski wrote:
> On Thu, 28 Nov 2019 at 17:35, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2019-11-28 at 11:29 +0200, Jani Nikula wrote:
> > > On Thu, 28 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > Kconfig should be indented with one tab for first level and tab+2 spaces
> > > > for second level.  There are many mixups of this so add a checkpatch
> > > > rule.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > 
> > > I agree unifying the indentation is nice, and without something like
> > > this it'll start bitrotting before Krzysztof's done fixing them all... I
> > > think there's been quite a few fixes merged lately.
> > > 
> > > I approve of the idea, but I'm clueless about the implementation.
> > 
> > I think that a grammar, or a least an array of words
> > that are supposed to start on a tab should be used here.
> 
> This won't work for wrong indentation of help text. This is quite
> popular Kconfig indentation violation so worth checking. I can then
> check for:
> 1. any white-space violations before array of Kconfig words - that
> 2. spaces mixed with tab before any text,
> 3. just spaces before any text,
> 4. tab + wrong number of spaces before any text.
> 
> It would look like:
> +               if ($realfile =~ /Kconfig/ &&
> +                   (($rawline =~
> /^\+\s+(?:config|menuconfig|choice|endchoice|if|endif|menu|endmenu|source|bool|tristate|prompt|help|---help---|depends|select)\b/

Many of these are not correct.

config, menuconfig, choice, endchoice, source
are primarily used at the beginning of a line.

if is odd as it's a logical block or test

It really needs a lex grammar to work properly.



