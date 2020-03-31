Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D4A1997CD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgCaNse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 09:48:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38034 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgCaNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S5n7yDRQamti9CgoL/ypn1YynciA+zLihEOrWDF9zgo=; b=0AASjRuFb0QrDXRVsB0bJX/FtL
        JSRmmzAkL8BJdmtP0MwBUhWbvLXIwv40bvlX/gIAOoQqZTcDe4Kef70K8ZdIXBPCmRMd7fzY5LqZS
        mH6VlRCkCWblJZfi0nz/CXXLbOLpoWbuR9OSE71yxKAad7NDGwpMmCVmbgEyeY70PAQ0k2+gX4evf
        IpOHXEJBdNLbkr5WuthBjVd597SaOrLjtv2M9oAjEp2jStLGojAE/UwK6h0KtayviNT5FrSmqQdcD
        IATwZkheUvX6XDeDub9oz7/dv7ZJXoFpkQoqRh3ORCHevrUKQn6RqZKY8iYbq4FYim8EjdzGOlYtm
        7/WHbAdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJHFa-0002bY-Qi; Tue, 31 Mar 2020 13:48:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03A0330477A;
        Tue, 31 Mar 2020 15:48:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC27E29DA6117; Tue, 31 Mar 2020 15:48:13 +0200 (CEST)
Date:   Tue, 31 Mar 2020 15:48:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [GIT PULL] scheduler changes for v5.7
Message-ID: <20200331134813.GQ20730@hirez.programming.kicks-ass.net>
References: <20200330173159.GA128106@gmail.com>
 <20200331103333.GM3772@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331103333.GM3772@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:33:33AM +0100, Mel Gorman wrote:
> On Mon, Mar 30, 2020 at 07:31:59PM +0200, Ingo Molnar wrote:
> > Linus,
> > 
> > Please pull the latest sched-core-for-linus git tree from:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus
> > 
> >    # HEAD: 313f16e2e35abb833eab5bdebc6ae30699adca18 Merge branch 'sched/rt' into sched/core, to pick up completed topic tree
> > 
> > The main changes in this cycle are:
> > 
> >  - Various NUMA scheduling updates: harmonize the load-balancer and NUMA 
> >    placement logic to not work against each other. The intended result is 
> >    better locality, better utilization and fewer migrations.
> > 
> 
> Thanks Ingo.
> 
> I noticed that the following patch did not make it to the list.
> 
> sched/fair: Fix negative imbalance in imbalance calculation
> https://lore.kernel.org/lkml/1585201349-70192-1-git-send-email-aubrey.li@intel.com/

I have it, we'll get it in before the next release.
