Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CB149CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 22:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAZVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 16:08:43 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:37254 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgAZVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 16:08:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id DA703837F24A;
        Sun, 26 Jan 2020 21:08:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2828:2899:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7576:7903:10004:10400:10848:10967:11026:11232:11658:11914:12294:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:14819:21080:21451:21627:21939:30012:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: year52_86035b18a9e04
X-Filterd-Recvd-Size: 2054
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jan 2020 21:08:40 +0000 (UTC)
Message-ID: <5b221ac7e49666b76cd9ca368b37e721cfb4aa9c.camel@perches.com>
Subject: Re: [for-next][PATCH 7/7] tracing: Use pr_err() instead of WARN()
 for memory failures
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 26 Jan 2020 13:07:36 -0800
In-Reply-To: <20200126155013.5cfc23aa@rorschach.local.home>
References: <20200126191932.984391723@goodmis.org>
         <20200126192021.350763989@goodmis.org>
         <e70ff75e9712478704fad44ac6b66c86a45df6a6.camel@perches.com>
         <20200126155013.5cfc23aa@rorschach.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-01-26 at 15:50 -0500, Steven Rostedt wrote:
> On Sun, 26 Jan 2020 12:38:55 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > On Sun, 2020-01-26 at 14:19 -0500, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > As warnings can trigger panics, especially when "panic_on_warn" is set,
> > > memory failure warnings can cause panics and fail fuzz testers that are
> > > stressing memory.
> > > 
> > > Create a MEM_FAIL() macro to use instead of WARN() in the tracing code
> > > (perhaps this should be a kernel wide macro?), and use that for memory
> > > failure issues. This should stop failing fuzz tests due to warnings.  
> > 
> > It looks as if most of these could just be removed instead
> > as there is an existing dump_stack() on failure.
> 
> That sounds more generic. This is specific for my own tracing tests to
> look for. As the point is, it is *not* to dump_stack, and still report
> the error.

__GFP_NOWARN is available too.


