Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44D15D713
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgBNMDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 07:03:12 -0500
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:59051 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728004AbgBNMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:03:11 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id E6029FB108
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:03:09 +0000 (GMT)
Received: (qmail 18957 invoked from network); 14 Feb 2020 12:03:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Feb 2020 12:03:09 -0000
Date:   Fri, 14 Feb 2020 12:03:07 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/12] sched/numa: Stop an exhastive search if a
 reasonable swap candidate or idle CPU is found
Message-ID: <20200214120307.GH3466@techsingularity.net>
References: <20200214081324.26859-1-mgorman@techsingularity.net>
 <20200214114746.10792-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200214114746.10792-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 07:47:46PM +0800, Hillf Danton wrote:
> > +
> > +	/*
> > +	 * If a move to idle is allowed because there is capacity or load
> > +	 * balance improves then stop the search. While a better swap
> > +	 * candidate may exist, a search is not free.
> > +	 */
> > +	if (maymove && !cur && env->best_cpu >= 0 && idle_cpu(env->best_cpu))
> > +		stopsearch = true;
> > +
> > +	/*
> > +	 * If a swap candidate must be identified and the current best task
> > +	 * moves its preferred node then stop the search.
> > +	 */
> > +	if (!maymove && env->best_task &&
> > +	    env->best_task->numa_preferred_nid == env->src_nid) {
> > +		return true;
> 
> Take another look at the lock left behind please.
> 

/me slaps self

Thanks

-- 
Mel Gorman
SUSE Labs
