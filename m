Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BADE05C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfJTUQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 16:16:24 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:38572 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbfJTUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 16:16:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5D9B3182CED28;
        Sun, 20 Oct 2019 20:16:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:5007:6119:7903:7904:9010:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21433:21622:21740:30054:30070:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: wheel18_5490528770d3c
X-Filterd-Recvd-Size: 2507
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 20:16:21 +0000 (UTC)
Message-ID: <7ef650e0a6487a3eefc8df9eaf0ab20b5d26bad1.camel@perches.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v1 1/5] staging: wfx: fix
 warnings of no space is necessary
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Date:   Sun, 20 Oct 2019 13:16:19 -0700
In-Reply-To: <alpine.DEB.2.21.1910202149140.10441@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
          <20191019140719.2542-2-jbi.octave@gmail.com>
         <20191019142443.GH24678@kadam>
          <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
          <20191019180514.GI24678@kadam>
          <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
         <20191020191759.GJ24678@kadam>
         <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
         <alpine.DEB.2.21.1910202149140.10441@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-20 at 21:52 +0200, Julia Lawall wrote:
> On Sun, 20 Oct 2019, Joe Perches wrote:
[]
> > There's probably a generic cocci mechanism to check function
> > prototypes and then remove uses of unnecessary void pointer casts
> > in function calls.  I'm not going to try to figure out that syntax.
> 
> With the --recursive-includes option, perhaps:
> 
> @r@
> identifier f;
> parameter list[n] ps;
> type T;
> identifier i;
> @@
> 
> T f(ps, void *i, ...);
> 
> @@
> expression e;
> identifier r.f;
> expression list[r.n] es;
> @@
> 
> f(es,
> - (void *)(e)
> + e
>   ,...)
> 
> This of course only works for functions that have prototypes, and not for
> macros.  It will also run slowly.

You are not kidding about slow, but it doesn't seem to work
for mem<foo>, maybe because system includes aren't analyzed.

Single file processing time on an XPS13 averages more than
100 seconds per file.

Also:

	expression e;

could probably be better as:

	type T;
	T *p;

as some of the expressions cast to void are int or size_t
and it's probably better to restrict the conversions to
just pointer or array types.


