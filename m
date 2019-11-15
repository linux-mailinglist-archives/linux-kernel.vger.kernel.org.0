Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140B9FE737
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 22:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKOVdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 16:33:17 -0500
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:33454 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbfKOVdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:33:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B5F14180220B5;
        Fri, 15 Nov 2019 21:33:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:979:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4383:5007:6119:10004:10400:10450:10455:10848:10967:11232:11658:11914:12043:12297:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:19904:19999:21063:21080:21450:21451:21611:21627:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: blade42_5685b2467e420
X-Filterd-Recvd-Size: 2369
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Nov 2019 21:33:14 +0000 (UTC)
Message-ID: <cddb7f4f3e247aacd54132d418009bba03308ed0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 15 Nov 2019 13:32:54 -0800
In-Reply-To: <20191115092943.7c79f81e@lwn.net>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
         <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
         <20191115154627.GA2187@lxhi-065.adit-jv.com>
         <20191115092943.7c79f81e@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 09:29 -0700, Jonathan Corbet wrote:
> On Fri, 15 Nov 2019 16:46:27 +0100
> Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> 
> > On Fri, Nov 15, 2019 at 07:09:17AM -0800, Joe Perches wrote:
> > > On Fri, 2019-11-15 at 16:02 +0100, Eugeniu Rosca wrote:  
> > > > Oftentimes [1], the contributor would like to honor or give credits [2]
> > > > to somebody's original ideas in the submission/reviewing process. While
> > > > "Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
> > > > employed for this purpose, they are not ideal.  
> > > 
> > > You need to get the use of this accepted into Documentation/process
> > > before adding it to checkpatch  
> > 
> > If the change [*] makes sense to you, I can submit an update to
> > Documentation/process/submitting-patches.rst
> 
> So there appear to be 89 patches with Originally-by in the entire Git
> history, which isn't a a lot; there are 3x as many Co-developed-by tags,
> which still isn't a huge number.  I do wonder if it's worth recognizing
> yet another tag with a subtly different shade of meaning here?  My own
> opinion doesn't matter a lot, but I'd like to have a sense that there is
> wider acceptance of this tag before adding it to the docs.

I am also not a proponent of adding this as a new tag/signature.


