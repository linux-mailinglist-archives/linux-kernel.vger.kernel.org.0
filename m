Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D565F163AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 04:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgBSDKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 22:10:35 -0500
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:53137 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728230AbgBSDKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:10:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 491D4181D3417;
        Wed, 19 Feb 2020 03:10:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6120:8603:8985:9025:10004:10400:10848:10967:11026:11232:11658:11854:11914:12043:12297:12438:12555:12663:12740:12760:12895:12986:13069:13311:13357:13439:13869:14096:14097:14181:14659:14721:21080:21611:21627:21811:30005:30029:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mice02_792c93b56d712
X-Filterd-Recvd-Size: 1893
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 03:10:32 +0000 (UTC)
Message-ID: <899e4e41c4cf5c62a4fbce0923e5796141ef46f0.camel@perches.com>
Subject: Re: [RFC PATCH 0/2] trace: Move trace data to new section
 _ftrace_data
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 19:09:10 -0800
In-Reply-To: <20200218215328.16744447@gandalf.local.home>
References: <cover.1582077698.git.joe@perches.com>
         <20200218215328.16744447@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 21:53 -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2020 18:03:16 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > Move the trace data to a separate section to make it easier to
> > examine the amount of actual data in an object file.
> 
> Not that I'm against this patch set, but can you elaborate more on
> "make it easier to examine the amount of actual data in an object file".

size -A <object> would now show each section of an
object file separating normal data from trace data.

It makes it easier to identify data that could be const like
https://lore.kernel.org/lkml/60559197a1af9e0af7f329cc3427989e5756846f.camel@perches.com/

> Also, don't use "_ftrace" as the section name. "ftrace" should be
> reserved for the function hook part of tracing, which trace events do
> not apply to. "_trace_event_data" would be more appropriate.

I don't care about the section name at all.

I used that name for consistency with _ftrace_event
in the same file. 
Perhaps the _ftrace_event section
name could be renamed to something
intelligible too.


