Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAE7CAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfGaRvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:51:45 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:47545 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbfGaRvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:51:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6FD1983777ED;
        Wed, 31 Jul 2019 17:51:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2110:2194:2199:2393:2525:2559:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:6120:6742:7903:9025:9121:10004:10400:10848:11232:11233:11658:11914:12043:12114:12297:12346:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14096:14097:14181:14581:14659:14721:21063:21080:21433:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: play80_48dac36c2b030
X-Filterd-Recvd-Size: 3029
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 17:51:40 +0000 (UTC)
Message-ID: <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 10:51:37 -0700
In-Reply-To: <20190731171429.GA24222@amd>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731171429.GA24222@amd>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 19:14 +0200, Pavel Machek wrote:
> On Tue 2019-07-30 22:35:18, Joe Perches wrote:
> > Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> > various case block /* fallthrough */ style comments to appear to be an
> > actual reserved word with the same gcc case block missing fallthrough
> > warning capability.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> > +/*
> > + * Add the pseudo keyword 'fallthrough' so case statement blocks
> > + * must end with any of these keywords:
> > + *   break;
> > + *   fallthrough;
> > + *   goto <label>;
> > + *   return [expression];
> > + *
> > + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
> > + */
> > +#if __has_attribute(__fallthrough__)
> > +# define fallthrough                    __attribute__((__fallthrough__))
> > +#else
> > +# define fallthrough                    do {} while (0)  /* fallthrough */
> > +#endif
> > +
> 
> Will various checkers (and gcc) recognize, that comment in a macro,
> and disable the warning accordingly?

Current non-gcc tools:  I doubt it.

And that's unlikely as the comments are supposed to be stripped
before the macro expansion phase.

gcc 7+, which by now probably most developers actually use, will
though
and likely that's sufficient.

> Explanation that the comment is "magic" might not be a bad idea.

The comment was more for the reader.

cheers, Joe

