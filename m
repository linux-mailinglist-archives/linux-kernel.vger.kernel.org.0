Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A109C17E96D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCIT45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:56:57 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:39101 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725992AbgCIT45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:56:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BB3C3182CED2A;
        Mon,  9 Mar 2020 19:56:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:2393:2525:2553:2565:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4384:4605:5007:7875:7903:7974:8526:8531:9025:10004:10400:10848:10967:11232:11658:11914:12043:12291:12296:12297:12555:12663:12683:12698:12737:12740:12760:12895:13149:13230:13255:13439:14096:14097:14157:14180:14181:14659:14721:21080:21324:21433:21451:21627:21740:30012:30041:30045:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fork76_769655216b051
X-Filterd-Recvd-Size: 4485
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 19:56:54 +0000 (UTC)
Message-ID: <e8db6d1a92001b02bbe2c2a1fc3413e1d44aa0a4.camel@perches.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 09 Mar 2020 12:55:14 -0700
In-Reply-To: <CAKwvOdkzc3AtpkRcZU06yvAEzp_bjw55HkpGui6RsAcy=FhnJw@mail.gmail.com>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
         <20200220162114.138f976ae16a5e58e13a51ae@linux-foundation.org>
         <CAKwvOdkzc3AtpkRcZU06yvAEzp_bjw55HkpGui6RsAcy=FhnJw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 12:36 -0700, Nick Desaulniers wrote:
> On Thu, Feb 20, 2020 at 4:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 20 Feb 2020 12:30:21 -0800 Joe Perches <joe@perches.com> wrote:
> > 
> > > Convert /* fallthrough */ style comments to the pseudo-keyword fallthrough
> > > to allow clang 10 and higher to work at finding missing fallthroughs too.
> > > 
> > > Requires a git repository and overwrites the input files.
> > > 
> > > Typical command use:
> > >     ./scripts/cvt_fallthrough.pl <path|file>
> > > 
> > > i.e.:
> > > 
> > >    $ ./scripts/cvt_fallthrough.pl block
> > >      converts all files in block and its subdirectories
> > >    $ ./scripts/cvt_fallthrough.pl drivers/net/wireless/zydas/zd1201.c
> > >      converts a single file
> > > 
> > > A fallthrough comment with additional comments is converted akin to:
> > > 
> > > -             /* fall through - maybe userspace knows this conn_id. */
> > > +             fallthrough;    /* maybe userspace knows this conn_id */
> > > 
> > > A fallthrough comment or fallthrough; between successive case statements
> > > is deleted.
> > > 
> > > e.g.:
> > > 
> > >     case FOO:
> > >       /* fallthrough */ (or fallthrough;)
> > >     case BAR:
> > > 
> > > is converted to:
> > > 
> > >     case FOO:
> > >     case BAR:
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  scripts/cvt_fallthrough.pl | 215 +++++++++++++++++++++++++++++++++++++
> > 
> > Do we need this in the tree long-term?  Or is it a matters of "hey
> > Linus, please run this" then something like add a checkpatch rule to
> > catch future slipups?
> 
> Just for some added context, please see
> https://reviews.llvm.org/D73852, where support for parsing some forms
> of fallthrough statements was added to Clang in a broken state by a
> contributor, but then ripped out by the code owner (of the clang front
> end to LLVM, and also happens to be the C++ ISO spec editor).  He
> provides further clarification
> https://bugs.llvm.org/show_bug.cgi?id=43465#c37.
> 
> I'm inclined to agree with him; to implement this, we need to keep
> around comments for semantic analyses, a later phase of compilation
> than preprocessing.  It feels like a layering violation to either not
> discard comments as soon as possible, or emit diagnostics from the
> preprocessor.  And as Joe's data shows, there's the classic issue
> faced when using regexes to solve a problem; suddenly you now have two
> problems.
> https://xkcd.com/1171/
> 
> I would like to see this patch landed, though I am curious as toward's
> Andrew's question ('Or is it a matters of "hey Linus, please run
> this"') of what's the imagined workflow here, since it seems like the
> script needs to be run per file. I suppose you could still do that
> treewide, but is that the intention, or is it to do so on a per
> subsystem level?

A single treewide run of a script like this really could make
it quite hard to later backport various fixes to stable trees.

A depth-first per-maintained subsystem run of the script with
commits could be useful and would much more easily allow backports.

Unfortunately there's no tool to apply such a script to the tree
per subsystem as far as I know.

Such a depth-first apply and commit tool could really be quite
useful though.


