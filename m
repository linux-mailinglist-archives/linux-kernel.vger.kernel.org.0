Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8ECE6DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 09:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfJ1IIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 04:08:32 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:36683 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731255AbfJ1IIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:08:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DDE991800AC9D;
        Mon, 28 Oct 2019 08:08:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:6691:7903:8603:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:30029:30051:30054:30070:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: worm22_ff7ace23cd13
X-Filterd-Recvd-Size: 2208
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 08:08:29 +0000 (UTC)
Message-ID: <8e34d30364b9306465a72c283ff59f453f8ea232.camel@perches.com>
Subject: Re: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 28 Oct 2019 01:08:24 -0700
In-Reply-To: <20191028071856.GA1944@kadam>
References: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
         <20191028071856.GA1944@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 10:18 +0300, Dan Carpenter wrote:
> On Sat, Oct 26, 2019 at 12:46:08PM -0700, Joe Perches wrote:
> > Initialization is not guaranteed to zero padding bytes so
> > use an explicit memset instead to avoid leaking any kernel
> > content in any possible padding bytes.
[]
> > diff --git a/kernel/sys.c b/kernel/sys.c
[]
> > @@ -1279,11 +1279,13 @@ SYSCALL_DEFINE1(uname, struct old_utsname __user *, name)
> >  
> >  SYSCALL_DEFINE1(olduname, struct oldold_utsname __user *, name)
> >  {
> > -	struct oldold_utsname tmp = {};
> > +	struct oldold_utsname tmp;
> 
> oldold_utsname doesn't have an struct holes.  It looks like this:

It's not struct holes that could be a problem.
It's possible struct padding after the last element.

> struct oldold_utsname {
>         char sysname[9];
>         char nodename[9];
>         char release[9];
>         char version[9];
>         char machine[9];
> };

Nominally 45 bytes.

A compiler _could_ pad to 48 for arbitrary alignment.
gcc does not pad and the struct size actually is 45
so for gcc (and I did not check clang), it's not a
real problem.

The patch still is a possible trivial improvement as
the memset is not done when name is NULL.


