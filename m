Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D01585F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 00:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBJXJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 18:09:39 -0500
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:47410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727435AbgBJXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:09:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E5A4B4995E6;
        Mon, 10 Feb 2020 23:09:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:10004:10400:10432:10433:10848:10967:11232:11658:11914:12297:12679:12740:12760:12895:13019:13069:13072:13255:13311:13357:13439:14096:14097:14181:14659:14721:14777:19903:19997:21080:21433:21611:21627:21660:21819:30003:30012:30022:30029:30030:30054:30055:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: list10_19c1c018fc60e
X-Filterd-Recvd-Size: 2767
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 23:09:36 +0000 (UTC)
Message-ID: <dcd8b6f57578f6ec0250b68206f0930b4aa64864.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove email address comment from email
 address comparisons
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Feb 2020 15:08:21 -0800
In-Reply-To: <20200210142532.432a0900bbacd6087349efe4@linux-foundation.org>
References: <20200131124531.623136425@infradead.org>
         <20200131125403.882175409@infradead.org>
         <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
         <20200207113417.GG14914@hirez.programming.kicks-ass.net>
         <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
         <20200207123035.GI14914@hirez.programming.kicks-ass.net>
         <20200207123334.GT14946@hirez.programming.kicks-ass.net>
         <ebaa2f7c8f94e25520981945cddcc1982e70e072.camel@perches.com>
         <20200210142532.432a0900bbacd6087349efe4@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 14:25 -0800, Andrew Morton wrote:
> On Mon, 10 Feb 2020 10:52:16 -0800 Joe Perches <joe@perches.com> wrote:
> 
> > About 2% of the last 100K commits have email addresses that include an
> > RFC2822 compliant comment like:
> > 
> > 	Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > checkpatch currently does a comparison of the complete name and address
> > to the submitted author to determine if the author has signed-off and
> > emits a warning if the exact email names and addresses do not match.
> 
> Yes, I've seen this a few times.
> 
> > Unfortunately, the author email address can be written without the comment
> > like:
> > 
> > 	Peter Zijlstra <peterz@infradead.org>
> > 
> > Add logic to compare the comment stripped email addresses to avoid this
> > warning.
> 
> Where "stripped" means "after removing stuff in parentheses"?

Basically, yes.

> Why do we consider the display name at all?  It's the
> "peterz@infradead.org" part which matters for comparison purposes?

True, but if people are going to author a patch with
one name and sign it with a different one, then some
warning should probably be emitted.

btw:

This code is case sensitive and probably should not be.

I'll probably send a new patch, but the generic use of
'fc' is not supported for older perl versions and so it'll
likely use 'lc' instead.



