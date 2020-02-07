Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8222E155802
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 13:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGM6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 07:58:42 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:39613 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbgBGM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:58:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9BCF4182CF66A;
        Fri,  7 Feb 2020 12:58:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:305:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3867:3868:3870:3871:3872:3873:3874:4321:5007:7903:10004:10400:10471:10848:11026:11232:11473:11658:11914:12296:12297:12555:12663:12679:12740:12760:12895:13019:13069:13072:13255:13311:13357:13439:14181:14659:14721:14777:21080:21433:21451:21611:21627:21819:30003:30022:30029:30054:30055:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: offer22_2e74bd6f96125
X-Filterd-Recvd-Size: 3248
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri,  7 Feb 2020 12:58:39 +0000 (UTC)
Message-ID: <65c84256f27fd0231176ed726ef2cd95a644147b.camel@perches.com>
Subject: Re: Checkpatch being daft, Was: [PATCH -v2 08/10] m68k,mm: Extend
 table allocator for multiple sizes
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        sean.j.christopherson@intel.com
Date:   Fri, 07 Feb 2020 04:57:26 -0800
In-Reply-To: <20200207123035.GI14914@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
         <20200131125403.882175409@infradead.org>
         <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
         <20200207113417.GG14914@hirez.programming.kicks-ass.net>
         <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
         <20200207123035.GI14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-07 at 13:30 +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2020 at 01:11:54PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Feb 7, 2020 at 12:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Fri, Feb 07, 2020 at 11:56:40AM +0100, Geert Uytterhoeven wrote:
> > > > WARNING: Missing Signed-off-by: line by nominal patch author 'Peter
> > > > Zijlstra <peterz@infradead.org>'
> > > > (in all patches)
> > > > 
> > > > I can fix that (the From?) up while applying.
> > > 
> > > I'm not sure where that warning comes from, but if you feel it needs
> > > fixing, sure. I normally only add the (Intel) thing to the SoB. I've so
> > > far never had complaints about that.
> > 
> > Checkpatch doesn't like this.
> 
> Ooh, I see, that's a relatively new warning, pretty daft if you ask me.
> 
> Now I have to rediscover how I went about teaching checkpatch to STFU ;-)
> 
> Joe, should that '$email eq $author' not ignore rfc822 comments? That
> is:
> 
> 	Peter Zijlstra <peterz@infradead.org>
> 
> and:
> 
> 	Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> are, in actual fact, the same.

checkpatch doesn't really have an rfc822 parser and would
likely require some fairly involved changes to use one.

For instance: adding
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f3b8434..959b8ef 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1164,6 +1164,7 @@ sub parse_email {
 
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
+	$name =~ s/\s*\([^\)]+\)\s*//;
 	$address = trim($address);
 	$address =~ s/^\<|\>$//g;
 
---

Into the parse_email function to strip rfc822 comments from
email addresses would just create a couple different warnings.

For now, how about adding --ignore=NO_AUTHOR_SIGN_OFF



