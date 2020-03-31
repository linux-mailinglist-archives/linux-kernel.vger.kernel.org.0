Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99750199E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgCaTCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:02:23 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:33844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbgCaTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:02:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CDAFE182CF668;
        Tue, 31 Mar 2020 19:02:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:30025:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stamp41_31887f240cb3a
X-Filterd-Recvd-Size: 1891
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Mar 2020 19:02:20 +0000 (UTC)
Message-ID: <ae25b7b1efcfe4eda9465c4fb4712ede928a33c4.camel@perches.com>
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
Date:   Tue, 31 Mar 2020 12:00:25 -0700
In-Reply-To: <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
         <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
         <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 20:56 +0200, Rasmus Villemoes wrote:
> On 31/03/2020 20.20, Joe Perches wrote:
> > On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:
> > >  #define compiletime_assert(condition, msg) \
> > > -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> > > +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > 
> > This might be better using something like __LINE__ ## _ ## __COUNTER__
> > 
> > as line # is somewhat useful to identify the specific assert in a file.
> > 
> 
> Eh, if the assert fires, doesn't the compiler's diagnostics already
> contain all kinds of location information?

I presume if that were enough,
neither __LINE__ nor __COUNTER__
would be useful.


