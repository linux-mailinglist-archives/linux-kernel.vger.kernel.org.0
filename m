Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6100E17D223
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 08:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCHHED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 03:04:03 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:42323 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgCHHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 03:04:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C87A4181D3417;
        Sun,  8 Mar 2020 07:04:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7903:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:21080:21627:21740:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: form16_5f6d69e56317
X-Filterd-Recvd-Size: 2200
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 07:04:00 +0000 (UTC)
Message-ID: <259f405155a948f90229d3fc8cad928d434b46f9.camel@perches.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com
Date:   Sat, 07 Mar 2020 23:02:23 -0800
In-Reply-To: <6773b7e3-8ce4-55d1-8bb7-bde6d9f6e887@embeddedor.com>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
         <576fe2ab-7937-4698-b32a-8599813d6ad1@embeddedor.com>
         <4304de54a44b7c8c22d8c2d9249d716664cf5ce8.camel@perches.com>
         <6773b7e3-8ce4-55d1-8bb7-bde6d9f6e887@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 00:46 -0600, Gustavo A. R. Silva wrote:
> 
> On 3/7/20 21:01, Joe Perches wrote:
> > On Sat, 2020-03-07 at 15:30 -0600, Gustavo A. R. Silva wrote:
> > > Some people consistently add blank lines as part of their code style,
> > > and if I were
> > > one of those people, I wouldn't like to have such lines removed.
> > 
> > It's a patch generator, it's not perfect.
> > Nothing is nor ever will be.
> 
> Wise words. The thing is that this is feedback over a proposed
> patch.
> 
> > It's quite simple to add blank lines if that's
> > what any maintainer desires.
> > 
> 
> I'm not sure if you are saying that it's not a problem to
> update your proposed patch,

It's not a problem with my proposed patch.
Consistency is good.

Nearly all uses in mm do not have blank lines
after break.

> or if you are suggesting that
> the maintainers will have the predisposition of applying
> patches that will modify their coding style and then go and
> willingly fix that. I doubt the latter, though.

If any do actually use the script, I guess we'll see.

> --
> Gustavo

