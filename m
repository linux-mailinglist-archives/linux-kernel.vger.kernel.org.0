Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E717C44A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFR1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 12:27:07 -0500
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:60088 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgCFR1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:27:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5A66D1802929C;
        Fri,  6 Mar 2020 17:27:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7808:7903:8660:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12663:12740:12760:12895:13148:13230:13439:14096:14097:14181:14659:14721:21080:21433:21450:21451:21627:21660:21939:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: iron26_5add7c5902505
X-Filterd-Recvd-Size: 3551
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Mar 2020 17:27:04 +0000 (UTC)
Message-ID: <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com>
Subject: Re: [PATCH] sched/cputime: silence a -Wunused-function warning
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>, Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Fri, 06 Mar 2020 09:25:29 -0800
In-Reply-To: <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
References: <1583509304-28508-1-git-send-email-cai@lca.pw>
         <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 09:13 -0800, Nick Desaulniers wrote:
> On Fri, Mar 6, 2020 at 7:42 AM Qian Cai <cai@lca.pw> wrote:
> > account_other_time() is only used when CONFIG_IRQ_TIME_ACCOUNTING=y (in
> > irqtime_account_process_tick()) or CONFIG_VIRT_CPU_ACCOUNTING_GEN=y (in
> > get_vtime_delta()). When both are off, it will generate a compilation
> > warning from Clang,
> > 
> > kernel/sched/cputime.c:255:19: warning: unused function
> > 'account_other_time' [-Wunused-function]
> > static inline u64 account_other_time(u64 max)
> > 
> > Rather than wrapping around this function with a macro expression,
> > 
> >  if defined(CONFIG_IRQ_TIME_ACCOUNTING) || \
> >     defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
> > 
> > just use __maybe_unused for this small function which seems like a good
> > trade-off.
> 
> Generally, I'm not a fan of __maybe_unused.  It is a tool in the
> toolbox for solving this issue, but it's my least favorite.  Should
> the call sites be eliminated, this may mask an unused and entirely
> dead function from being removed.  Preprocessor guards based on config
> give more context into *why* a particular function may be unused.
> 
> So let's take a look at the call sites of account_other_time().  Looks
> like irqtime_account_process_tick() (guarded by
> CONFIG_IRQ_TIME_ACCOUNTING) and get_vtime_delta() (guarded by
> CONFIG_VIRT_CPU_ACCOUNTING_GEN).  If it were one config guard, then I
> would prefer to move the definition to be within the same guard, just
> before the function definition that calls it, but we have a more
> complicated case here.
> 
> The next thing I'd check to see is if there's a dependency between
> configs.  In this case, both CONFIG_IRQ_TIME_ACCOUNTING and
> CONFIG_VIRT_CPU_ACCOUNTING_GEN are defined in init/Kconfig.  In this
> case there's also no dependency between configs, so specifying one
> doesn't imply the other; so guarding on one of the two configs is also
> not an option.
> 
> So, as much as I'm not a fan of __maybe_unused, it is indeed the
> simplest option.  Though, I'd still prefer the ifdef you describe
> instead, maybe the maintainers can provide guidance/preference?

Another option might be to move static inline functions
where possible to an #include file (like sched.h) but the
same possible dead function issue would still exist.


