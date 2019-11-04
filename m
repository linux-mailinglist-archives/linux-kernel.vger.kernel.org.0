Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB82EE0BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 14:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfKDNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 08:11:45 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:49452 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727236AbfKDNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:11:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AA5684DBD;
        Mon,  4 Nov 2019 13:11:43 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2693:2895:3138:3139:3140:3141:3142:3352:3622:3743:3865:3866:3867:3870:3871:3872:3874:5007:6119:6261:6742:7875:9108:10004:10400:10848:10967:11026:11232:11658:11914:12043:12297:12663:12740:12760:12895:13069:13311:13357:13439:13618:14181:14659:14721:21080:21627:30054:30070:30090:30091,0,RBL:146.247.46.6:@goodmis.org:.lbl8.mailshell.net-62.14.41.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: bat51_e8cae9c64d2a
X-Filterd-Recvd-Size: 1974
Received: from grimm.local.home (unknown [146.247.46.6])
        (Authenticated sender: rostedt@goodmis.org)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 13:11:39 +0000 (UTC)
Date:   Mon, 4 Nov 2019 08:11:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191104081136.645e9b1a@grimm.local.home>
In-Reply-To: <daad0785-a33f-3cfb-cf0f-657b6c677257@arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
        <20191029165832.33606-2-mark.rutland@arm.com>
        <daad0785-a33f-3cfb-cf0f-657b6c677257@arm.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2019 17:49:00 +0530
Amit Daniel Kachhap <amit.kachhap@arm.com> wrote:

> Now that ftrace_init_nop is also an arch implemented function so it may 
> be added in Documentation/trace/ftrace-design.rst along with 
> ftrace_make_nop.
> In general also, adding some description about patchable-function-entry
> in kernel Documentation will be useful.

I think this part is outside the scope of this patch set. Honestly, I
need to chisel out some time to rewrite the ftrace-design document, as
that's been long needed. But that can come at a later time. I'm
currently rewriting some of it now, so it will be best to not waste
effort to update a document that will soon become stale. ;-)

-- Steve
