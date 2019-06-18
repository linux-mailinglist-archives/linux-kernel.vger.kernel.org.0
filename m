Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6350749D40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 11:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfFRJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 05:30:41 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:36303 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbfFRJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:30:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F029D837F24D;
        Tue, 18 Jun 2019 09:30:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:1981:2194:2199:2393:2525:2559:2564:2682:2685:2689:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:9025:9040:10004:10400:10848:11232:11233:11658:11914:12043:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14181:14581:14659:14721:21060:21080:21451:21627:21740:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: form78_227b3de72b623
X-Filterd-Recvd-Size: 2187
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Jun 2019 09:30:36 +0000 (UTC)
Message-ID: <3499a5a2058c246d48f8eb96682ce371833563b2.camel@perches.com>
Subject: Re: [PATCH] Use fall-through attribute rather than magic comments
From:   Joe Perches <joe@perches.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Shawn Landden <shawn@git.icu>, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Andy Whitcroft <apw@canonical.com>
Date:   Tue, 18 Jun 2019 02:30:35 -0700
In-Reply-To: <20190618073407.GA786@amd>
References: <20190316033841.7659-1-shawn@git.icu>
         <20190617155643.GA32544@amd>
         <45e070039e66b1cb1490a78d4805bc73cc09f571.camel@perches.com>
         <20190618073407.GA786@amd>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 09:34 +0200, Pavel Machek wrote:
> On Mon 2019-06-17 09:25:56, Joe Perches wrote:
> > On Mon, 2019-06-17 at 17:56 +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > +/*
> > > > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-fallthrough
> > > > + *   gcc: https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
> > > > + */
> > > > +#if __has_attribute(__fallthrough__)
> > > > +# define __fallthrough                    __attribute__((__fallthrough__))
> > > > +#else
> > > > +# define __fallthrough
> > > > +#endif
> > > 
> > > Is it good idea to add the __'s ? They look kind of ugly. 
> > 
> > Dunno.
> > 
> > I agree it's kind of ugly, but it should always work.
> > 
> > I think the generic problem is introducing a new unprefixed
> > reserved identifier.  Underscored identifiers are reserved.
> 
> We are not userland, and we control whole codebase. These rules don't
> apply.

except include/uapi where some static inline switch might

> We can use unprefixed identifier and fix up any problems... I don't
> expect too many.

but there aren't any existing uses there.


