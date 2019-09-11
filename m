Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287E2AF397
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 02:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfIKAPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 20:15:21 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:46332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725916AbfIKAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:15:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0058818224519;
        Wed, 11 Sep 2019 00:15:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:334:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:6121:7903:10007:10400:10450:10455:10848:11026:11232:11473:11658:11914:12050:12296:12297:12663:12740:12760:12895:13439:14659:14721:19904:19999:21080:21324:21433:21451:21627:21740:30012:30034:30054:30060:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:1:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: cream93_8578525e7b644
X-Filterd-Recvd-Size: 4049
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Sep 2019 00:15:17 +0000 (UTC)
Message-ID: <95a9f6fbc8fc2cf81e9eadc6f7fef8dd3592e60b.camel@perches.com>
Subject: Re: [PATCH v2] printf: add support for printing symbolic error codes
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Date:   Tue, 10 Sep 2019 17:15:15 -0700
In-Reply-To: <CAHp75Vdpd5uMCM-n+4vAZLwUpN=-cHnHs1uxoV2MDd5fk+CQig@mail.gmail.com>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
         <20190909203826.22263-1-linux@rasmusvillemoes.dk>
         <CAHp75Vdpd5uMCM-n+4vAZLwUpN=-cHnHs1uxoV2MDd5fk+CQig@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 18:26 +0300, Andy Shevchenko wrote:
> On Mon, Sep 9, 2019 at 11:39 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > It has been suggested several times to extend vsnprintf() to be able
> > to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
> > another attempt. Rather than adding another %p extension, simply teach
> > plain %p to convert ERR_PTRs. While the primary use case is
> > 
> >   if (IS_ERR(foo)) {
> >     pr_err("Sorry, can't do that: %p\n", foo);
> >     return PTR_ERR(foo);
> >   }
> > 
> > it is also more helpful to get a symbolic error code (or, worst case,
> > a decimal number) in case an ERR_PTR is accidentally passed to some
> > %p<something>, rather than the (efault) that check_pointer() would
> > result in.
> > 
> > With my embedded hat on, I've made it possible to remove this.
> > 
> > I've tested that the #ifdeffery in errcode.c is sufficient to make
> > this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
> > 0day bot will tell me which ones I've missed.
> > 
> > The symbols to include have been found by massaging the output of
> > 
> >   find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'
> > 
> > In the cases where some common aliasing exists
> > (e.g. EAGAIN=EWOULDBLOCK on all platforms, EDEADLOCK=EDEADLK on most),
> > I've moved the more popular one (in terms of 'git grep -w Efoo | wc)
> > to the bottom so that one takes precedence.
> > +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
> > +#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = #err
> 
> From long term prospective 300 and 550 hard coded here may be forgotten.
> 
> > +const char *errcode(int err)
> We got long, why not to use long type for it?
> 
> > +{
> > +       /* Might as well accept both -EIO and EIO. */
> > +       if (err < 0)
> > +               err = -err;
> > +       if (err <= 0) /* INT_MIN or 0 */
> > +               return NULL;
> > +       if (err < ARRAY_SIZE(codes_0))
> > +               return codes_0[err];
> 
> It won't work if one of the #ifdef:s in the array fails.
> Would it?
> 
> > +       if (err >= 512 && err - 512 < ARRAY_SIZE(codes_512))
> > +               return codes_512[err - 512];
> > +       /* But why? */
> > +       if (IS_ENABLED(CONFIG_MIPS) && err == EDQUOT) /* 1133 */
> > +               return "EDQUOT";
> > +       return NULL;
> > +}
> > +               long err = PTR_ERR(ptr);
> > +               const char *sym = errcode(-err);
> 
> Do we need additional sign change if we already have such check inside
> errcode()?

How is EBUSY differentiated from ZERO_SIZE_PTR ?


