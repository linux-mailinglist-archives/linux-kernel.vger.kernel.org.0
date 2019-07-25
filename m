Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA5750AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfGYOM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 10:12:58 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:43583 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbfGYOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:12:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 10C05100E96EA;
        Thu, 25 Jul 2019 14:12:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3874:4321:4362:5007:6117:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21324:21627:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: army43_8e08c24f85a19
X-Filterd-Recvd-Size: 2302
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 14:12:55 +0000 (UTC)
Message-ID: <eaef283741c0a6a718040f99a17bdb9882bde665.camel@perches.com>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jul 2019 07:12:54 -0700
In-Reply-To: <alpine.DEB.2.21.1907250856450.2555@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
           <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
           <alpine.DEB.2.21.1907231546090.2551@hadrien>
           <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
         <alpine.DEB.2.21.1907232252260.2539@hadrien>
           <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
           <alpine.DEB.2.21.1907232326360.2539@hadrien>
           <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>
           <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
         <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>
          <alpine.DEB.2.21.1907242040490.10108@hadrien>
         <a0e892c3522f4df2991119a2a30cd62ec14c76cc.camel@perches.com>
         <alpine.DEB.2.21.1907250856450.2555@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 08:58 -0500, Julia Lawall wrote:
> On Thu, 25 Jul 2019, Joe Perches wrote:
[]
> > Just for completeness and correctness, as I at
> > least don't find an existing use:
> > 
> > Perhaps this "x =" should also include += and +
> > and the various other operators that are possible
> > or does SmPL grammar already do that?
> 
> I could do this.  One might though think that if someone went to the
> trouble of computing +=, these would be cases that we don't want to
> change?

Maybe I quoted the wrong bit.  But exactly.

Anywhere the return value of strlcpy is used, not just as
an assignment, is an instance that should not be changed.

Thanks for doing this.

