Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C382088F48
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 05:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHKDyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 23:54:25 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:46405 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfHKDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 23:54:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 75143182CED2A;
        Sun, 11 Aug 2019 03:54:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2559:2564:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:7903:9025:10004:10400:10848:11232:11658:11914:12043:12114:12297:12555:12663:12740:12760:12895:13019:13069:13255:13311:13357:13439:14181:14659:14721:21080:21222:21366:21433:21451:21627:21740:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: eye33_6065040b72711
X-Filterd-Recvd-Size: 2953
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 11 Aug 2019 03:54:22 +0000 (UTC)
Message-ID: <0c96ff086dc1b92034a8ca19d341f2db16cc802c.camel@perches.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Date:   Sat, 10 Aug 2019 20:54:21 -0700
In-Reply-To: <20190811031715.GA22334@archlinux-threadripper>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
         <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
         <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
         <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
         <20190811020442.GA22736@archlinux-threadripper>
         <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
         <20190811031715.GA22334@archlinux-threadripper>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-10 at 20:17 -0700, Nathan Chancellor wrote:
> On Sat, Aug 10, 2019 at 08:06:05PM -0700, Joe Perches wrote:
> > On Sat, 2019-08-10 at 19:04 -0700, Nathan Chancellor wrote:
> > > On a tangential note, how are you planning on doing the fallthrough
> > > comment to attribute conversion? The reason I ask is clang does not
> > > support the comment annotations, meaning that when Nathan Huckleberry's
> > > patch is applied to clang (which has been accepted [1]), we are going
> > > to get slammed by the warnings. I just ran an x86 defconfig build at
> > > 296d05cb0d3c with his patch applied and I see 27673 instances of this
> > > warning... (mostly coming from some header files so nothing crazy but it
> > > will be super noisy).
> > > 
> > > If you have something to share like a script or patch, I'd be happy to
> > > test it locally.
> > > 
> > > [1]: https://reviews.llvm.org/D64838
> > 
> > Something like this patch:
> > 
> > https://lore.kernel.org/patchwork/patch/1108577/
> > 
> > Maybe use:
> > 
> > #define fallthrough [[fallthrough]]
> > 
> > if the compiler supports that notation
> > 
> 
> That patch as it stands will work with D64838, as it is adding support
> for the GNU fallthrough attribute.
> 
> However, I assume that all of the /* fall through */ comments will need
> to be converted to the attribute macro, was that going to be done with
> Coccinelle or something else?

Coccinelle doesn't support transforming comments
so I am using a perl script for those transforms
that I will post when I'm happy enough with it.



