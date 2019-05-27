Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2DE2B95F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfE0RV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 13:21:29 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:36033 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726758AbfE0RV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:21:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E4B51180206CE;
        Mon, 27 May 2019 17:21:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6742:7808:7903:8957:9025:9040:10004:10400:10848:11026:11232:11658:11914:12043:12114:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21324:21451:21627:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: lake84_639e874c37e55
X-Filterd-Recvd-Size: 2297
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 May 2019 17:21:24 +0000 (UTC)
Message-ID: <810a0dae47c90c39015903c413303fcee89ab5eb.camel@perches.com>
Subject: Re: [PATCH v2] rcu: Don't return a value from rcu_assign_pointer()
From:   Joe Perches <joe@perches.com>
To:     paulmck@linux.ibm.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>, apw@canonical.com
Date:   Mon, 27 May 2019 10:21:22 -0700
In-Reply-To: <20190527161050.GK28207@linux.ibm.com>
References: <1558946997-25559-1-git-send-email-andrea.parri@amarulasolutions.com>
         <20190527161050.GK28207@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-27 at 09:10 -0700, Paul E. McKenney wrote:
> On Mon, May 27, 2019 at 10:49:57AM +0200, Andrea Parri wrote:
> > Quoting Paul [1]:
> > 
> >   "Given that a quick (and perhaps error-prone) search of the uses
> >    of rcu_assign_pointer() in v5.1 didn't find a single use of the
> >    return value, let's please instead change the documentation and
> >    implementation to eliminate the return value."
> > 
> > [1] https://lkml.kernel.org/r/20190523135013.GL28207@linux.ibm.com
> 
> Queued, thank you!
> 
> Adding the checkpatch maintainers on CC as well.  The "do { } while
> (0)" prevents the return value from being used, by design.  Given the
> checkpatch complaint, is there some better way to achieve this?

Not sure what the checkpatch complaint is here.
Reading the link above, there seems to be a compiler warning.

Perhaps a statement expression macro with no return value?

#define rcu_assign_pointer(p, v)	({ (p) = (v); ; })


