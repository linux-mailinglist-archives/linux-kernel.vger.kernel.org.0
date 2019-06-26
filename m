Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B156DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfFZPgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 11:36:37 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:55605 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbfFZPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:36:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CBB8E18225DEA;
        Wed, 26 Jun 2019 15:36:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:421:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6248:6691:7903:7974:9010:10004:10400:10848:11232:11658:11914:12296:12297:12663:12740:12760:12895:13069:13076:13095:13311:13357:13439:13618:14093:14096:14097:14659:14721:14777:21080:21324:21433:21627:21819:30022:30054:30056:30060:30083:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:52,LUA_SUMMARY:none
X-HE-Tag: pest84_397bcb5d8fa2a
X-Filterd-Recvd-Size: 2614
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Jun 2019 15:36:34 +0000 (UTC)
Message-ID: <b007126ee329ba5094d84f0af91c0c8eafecbed4.camel@perches.com>
Subject: Re: [PATCH v2] get_maintainer: Add --prefix option
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Jun 2019 08:36:33 -0700
In-Reply-To: <20190626093635.GK3419@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
         <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
         <20190625163701.xcb2ue7phpskvfnz@linutronix.de>
         <8d416a7b0dad3933ceb8d12c9efaad541f7cf269.camel@perches.com>
         <20190626093635.GK3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-26 at 11:36 +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2019 at 10:23:34AM -0700, Joe Perches wrote:
[]
> > I want to proposed patches to moderated lists
> > and believe everyone really should too.
> > 
> > I don't care if moderated lists send a
> > "waiting for moderation" message as long as the
> > list gets the proposed patch eventually.
> > 
> > I think only Peter cares about those, to him,
> > superfluous "being moderated" messages.
> 
> I'm really not alone in that. Not only do you get those annoying
> messages, the people reading that list might get the discussion in
> fragments, because some people that reply are subscribed and do not
> require moderation while others do get caught in the moderation thing
> and then delayed.

<shrug> email moderation time is up to any moderator.

> It also puts a burden on the moderator, do they allow the whole
> discussion or only part. What if they deem the thing off-topic and want
> to kill it, but then some of their whitelisted people do reply.

Please remember any moderated list entries originate here
by using get_maintainers.pl for a proposed patch or discuss
a particular subsystem.

If a moderator of a list decides an email chain about a
patch is somehow off-topic and does not forward the email,
likely that moderated list should be removed from MAINTAINERS.

Under what use case would you want to use get_maintainer and
_not_ cc a particular mailing list?


