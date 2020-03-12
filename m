Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3561832A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 15:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCLORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 10:17:09 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:45724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727123AbgCLORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:17:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 51ABE8139;
        Thu, 12 Mar 2020 14:17:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2740:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:10004:10400:10450:10455:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:13869:14040:14096:14097:14659:14721:19904:19999:21080:21611:21627:30005:30012:30041:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: music20_5b3c53998c133
X-Filterd-Recvd-Size: 2957
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 14:17:06 +0000 (UTC)
Message-ID: <520264e86bcba45ba8cb721ca54b81e56e5df42e.camel@perches.com>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use
 fallthrough;
From:   Joe Perches <joe@perches.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Mar 2020 07:15:23 -0700
In-Reply-To: <20200312134712.GE7159@mit.edu>
References: <cover.1583896344.git.joe@perches.com>
         <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
         <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
         <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com>
         <20200312085606.GA154268@kroah.com>
         <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
         <fa07756217b3c033c7e5af495a03ff5655947450.camel@perches.com>
         <20200312134712.GE7159@mit.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 09:47 -0400, Theodore Y. Ts'o wrote:
> On Thu, Mar 12, 2020 at 02:37:31AM -0700, Joe Perches wrote:
> > As I have suggested a few times, better still
> > would be to have a mechanism for scripted patches
> > applied possibly as single treewide patch.
> > 
> > Likely applied only at an -rc1.
> > 
> > The stated negatives to a treewide mechanism
> > have been difficulty to backport to -stable.
> 
> Any time we do a massive, disruptive change to the code base, it's
> going to cause problems to -stable.  It means that bug fix patches
> won't necessarily auto-apply, and some will require manual fixups
> afterwards

That's mostly a tools problem than a real problem.

> Given that this change doesn't really fix any bugs, I'd have to ask
> the question --- is it *worth* it?  We really need to apply a certain
> amount of cost/benefit analysis around this.
> 
> If it were really important, the thing we could do is to apply a
> single treewide patch at some point after the merge window.  I'd
> suggest after -rc2, myself, but reasonable people can differ.  And
> then, if it were *really* important we could run the same script on
> the stable kernels.
> 
> But for changing "/* fallthrough */" to "fallthrough;"
> 
> Does this ***really*** matter?

That depends a bit on whether clang is your
compiler of choice.

> Why are we tying ourselves up in knots
> trying to do this all at once?

Discretely or treewide, all at once or done over time,
the impact problem to backports is the same.


