Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44688CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 21:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfHJTU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 15:20:27 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:46310 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbfHJTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:20:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B155B180A7F88;
        Sat, 10 Aug 2019 19:20:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:4321:4605:5007:7514:7875:9036:9121:10004:10400:10848:11026:11232:11473:11658:11914:12297:12555:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:21740:30030:30054:30060:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: war91_78006327e2207
X-Filterd-Recvd-Size: 2979
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 19:20:24 +0000 (UTC)
Message-ID: <d45d8c64ece1da4a2463afa91ea21dc9150a26c7.camel@perches.com>
Subject: Re: [PATCH v2 1/2] linux/bits.h: Clarify macro argument names
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 10 Aug 2019 12:20:23 -0700
In-Reply-To: <CAK7LNASA1CszgXAvH78qnLOr11Po97s090rGujnNQ=zTHaSDDA@mail.gmail.com>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <20190801230358.4193-1-rikard.falkeborn@gmail.com>
         <CAK7LNASA1CszgXAvH78qnLOr11Po97s090rGujnNQ=zTHaSDDA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 12:46 +0900, Masahiro Yamada wrote:
> On Fri, Aug 2, 2019 at 8:04 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> > Be a little more verbose to improve readability.
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> 
> BTW, I do not understand what the improvement is.
> I tend to regard this as a noise commit.

Non verbose naming clarity is good.

Perhaps adding kernel-doc is good too.

> 
> > ---
> > Changes in v2:
> >   - This patch is new in v2
> > 
> >  include/linux/bits.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 669d69441a62..d4466aa42a9c 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -14,16 +14,16 @@
> >  #define BITS_PER_BYTE          8
> > 
> >  /*
> > - * Create a contiguous bitmask starting at bit position @l and ending at
> > - * position @h. For example
> > + * Create a contiguous bitmask starting at bit position @low and ending at
> > + * position @high. For example
> >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> >   */
> > -#define GENMASK(h, l) \
> > -       (((~UL(0)) - (UL(1) << (l)) + 1) & \
> > -        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > +#define GENMASK(high, low) \
> > +       (((~UL(0)) - (UL(1) << (low)) + 1) & \
> > +        (~UL(0) >> (BITS_PER_LONG - 1 - (high))))
> > 
> > -#define GENMASK_ULL(h, l) \
> > -       (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> > -        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > +#define GENMASK_ULL(high, low) \
> > +       (((~ULL(0)) - (ULL(1) << (low)) + 1) & \
> > +        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (high))))
> > 
> >  #endif /* __LINUX_BITS_H */
> > --
> > 2.22.0
> > 
> 
> 

