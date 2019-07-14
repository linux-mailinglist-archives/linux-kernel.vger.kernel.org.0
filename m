Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E873681AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 01:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfGNXfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 19:35:12 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:36255 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728925AbfGNXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 19:35:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id ECCF418016695;
        Sun, 14 Jul 2019 23:35:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3873:4321:5007:7974:9586:10004:10400:10848:11026:11232:11657:11658:11914:12043:12295:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21325:21451:21627:30054:30056:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: crook09_2cf3c5f3b423e
X-Filterd-Recvd-Size: 1915
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Jul 2019 23:35:08 +0000 (UTC)
Message-ID: <62147462c38b7764eca3a97405fef536846be034.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add new entry for pidfd api
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab+samsung@kernel.org
Date:   Sun, 14 Jul 2019 16:35:07 -0700
In-Reply-To: <20190714223228.f32lkszztbuencbn@brauner.io>
References: <20190714193344.29100-1-christian@brauner.io>
         <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
         <20190714223228.f32lkszztbuencbn@brauner.io>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 00:32 +0200, Christian Brauner wrote:
> On Sun, Jul 14, 2019 at 03:10:06PM -0700, Joe Perches wrote:
> > On Sun, 2019-07-14 at 21:33 +0200, Christian Brauner wrote:
> > > Add me as a maintainer for pidfd stuff. This way we can easily see when
> > > changes come in and people know who to yell at.
> > []
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > []
> > > @@ -12567,6 +12567,18 @@ F:	arch/arm/boot/dts/picoxcell*
[]
> > > +PIDFD API
[]
> > > +K:	\b(clone_args|kernel_clone_args)\b
> > > +N:	pidfd
> > 
> > This one I'd suggest using 2 F: patterns instead
> > as the patterns are more comprehensive and do not
> > use git history when looked up with get_maintainer
> 
> Just to clarify, you suggest removing N: pidfd and just leaving in the
> two F: patterns for samples/pidfd and tools/testing/selftests/pidfd/
> below?
> 
> > F:	samples/pidfd/
> > F:	tools/testing/selftests/pidfd/

Yes.


