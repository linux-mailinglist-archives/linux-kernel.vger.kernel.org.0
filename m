Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C524371BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbfGWPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:39:55 -0400
Received: from smtprelay0127.hostedemail.com ([216.40.44.127]:41191 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbfGWPjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:39:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DB889182CF665;
        Tue, 23 Jul 2019 15:39:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2689:2828:2915:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7903:8603:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21324:21627:21740:30012:30054:30056:30069:30079:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: fowl35_38e5e5eee520d
X-Filterd-Recvd-Size: 2880
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 15:39:50 +0000 (UTC)
Message-ID: <c9ef2b56eaf36c8e5449b751ab6e5971b6b34311.camel@perches.com>
Subject: Re: [PATCH V2 1/2] string: Add stracpy and stracpy_pad mechanisms
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 23 Jul 2019 08:39:49 -0700
In-Reply-To: <ce1320d8-60df-7c54-2348-6aabac63c24d@rasmusvillemoes.dk>
References: <cover.1563889130.git.joe@perches.com>
         <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
         <ce1320d8-60df-7c54-2348-6aabac63c24d@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 16:37 +0200, Rasmus Villemoes wrote:
> On 23/07/2019 15.51, Joe Perches wrote:
> > Several uses of strlcpy and strscpy have had defects because the
> > last argument of each function is misused or typoed.
> > 
> > Add macro mechanisms to avoid this defect.
> > 
> > stracpy (copy a string to a string array) must have a string
> > array as the first argument (dest) and uses sizeof(dest) as the
> > count of bytes to copy.
> > 
> > These mechanisms verify that the dest argument is an array of
> > char or other compatible types like u8 or s8 or equivalent.
> Sorry, but "compatible types" has a very specific meaning in C, so
> please don't use that word.

I think you are being overly pedantic here but
what wording do you actually suggest?

>  And yes, the kernel disables -Wpointer-sign,
> so passing an u8* or s8* when strscpy() expects a char* is silently
> accepted, but does such code exist?

u8 definitely, s8 I'm not sure.

I don't find via grep a use of s8 foo[] = "bar";
or "signed char foo[] = "bar";

I don't think it bad to allow it.

> > V2: Use __same_type testing char[], signed char[], and unsigned char[]
> >     Rename to, from, and size, dest, src and count
> 
> count is just as bad as size in terms of "the expression src might
> contain that identifier". But there's actually no reason to even declare
> a local variable, just use ARRAY_SIZE() directly as the third argument
> to strscpy().

I don't care about that myself.
It's a macro local identifier and shadowing in a macro
is common.  I'm not a big fan of useless underscores.

I think either works.


