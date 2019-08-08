Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A007485A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 08:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfHHGRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 02:17:35 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:36025 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728167AbfHHGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:17:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0DC5D45A6;
        Thu,  8 Aug 2019 06:17:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:152:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:8531:10004:10400:10848:10967:11232:11658:11914:12043:12297:12663:12679:12740:12895:13069:13311:13357:13894:14659:14721:21080:21433:21611:21627:30041:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: hand05_7ba727567155
X-Filterd-Recvd-Size: 2020
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 06:17:32 +0000 (UTC)
Message-ID: <2f54e9d0f32dfc66163c3773e93fec14ee1c8c6c.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 07 Aug 2019 23:17:31 -0700
In-Reply-To: <56763.1565244495@turing-police>
References: <33485.1565228181@turing-police>
         <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
         <56763.1565244495@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 02:08 -0400, Valdis Klētnieks wrote:
> On Wed, 07 Aug 2019 22:50:47 -0700, Joe Perches said:
> > On Wed, 2019-08-07 at 21:36 -0400, Valdis Kltnieks wrote:
> > >  				^.DEFINE_$Ident\(\Q$name\E\)|
> > >  				^.DECLARE_$Ident\(\Q$name\E\)|
> > >  				^.LIST_HEAD\(\Q$name\E\)|
> > > -				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> > > +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> > 
> > Perhaps also better to convert all the '\Q$name\E' to '\s*\Q$name\E\s*'
> 
> Yes, but that would need to be a separate patch.

Maybe so.

I'm just not a big fan of micro patches.

> The question would be if we
> consider 'DEFINE_foo( barbaz )' and similar with whitespace to be desirable
> style or not.

Oh, it would definitely be an uncomfortable style,
it's just allowing it in the regex.

btw: I'm also fine with it being a separate global patch.

cheers, Joe

> We already have the \s* in one place. Somebody else can decide if it should
> be in the other 5 places or not. :)

Is that supposed to be me? ;)


