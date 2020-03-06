Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39A17C611
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 20:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCFTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 14:12:16 -0500
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:58410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbgCFTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F3F49182CED5B;
        Fri,  6 Mar 2020 19:12:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4425:5007:6691:6742:7903:10004:10400:11232:11658:11914:12043:12297:12740:12760:12895:13019:13069:13311:13357:13439:13869:14181:14659:14721:21080:21324:21611:21627:21660:21740:21741:30005:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:14,LUA_SUMMARY:none
X-HE-Tag: shelf13_870d94afc7347
X-Filterd-Recvd-Size: 2547
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Mar 2020 19:12:07 +0000 (UTC)
Message-ID: <4ec4c6915c23545a9d45f37df9ab4eb6a422b234.camel@perches.com>
Subject: Re: [PATCH] sched/cputime: silence a -Wunused-function warning
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Fri, 06 Mar 2020 11:10:32 -0800
In-Reply-To: <CAKwvOdmdaDL4bhJc+7Xms=f4YXDw-Rr+WQAknd0Jv6UWOBUcEA@mail.gmail.com>
References: <1583509304-28508-1-git-send-email-cai@lca.pw>
         <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
         <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com>
         <442b7ace85a414c6a01040368f05d6d219f86536.camel@perches.com>
         <CAKwvOdmdaDL4bhJc+7Xms=f4YXDw-Rr+WQAknd0Jv6UWOBUcEA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 11:02 -0800, Nick Desaulniers wrote:
> On Fri, Mar 6, 2020 at 10:39 AM Joe Perches <joe@perches.com> wrote:
[]
> > Turns out there are hundreds of unused static inline
> > functions in kernel .h files.
> > 
> > A trivial script to find some of them (with likely
> > false positives as some might actually be used via ##
> > token pasting mechanisms).
> > 
> > (and there's almost certainly a better way to do this
> >  too as it takes a _very_ long time to run)
> > 
> > $ grep-2.5.4 -rP --include=*.h '^[ \t]*static\s+inline\s+(?:\w+\s+){1,3}\w+[ \t]*\(' * | \
> >   grep -P -oh '\w+\s*\(' | \
> >   sort | uniq -c | sort -n | grep -P '^\s+1\b' | \
> >   sed -r -e 's/^\s+1\s+//' -e 's/\(//' | \
> >   while read line ; do \
> >     echo -n "$line: " ; git grep -w $line | wc -l ; \
> >   done | \
> >   grep ": 1$"
> 
> Please start sending patches to remove them and I'll review.  If this
> is a good amount of work, I have newbies that are looking to
> contribute and can help.

That's not a task I care to take on.

I could run the script and post the results through
if you can not.



