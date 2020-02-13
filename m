Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18315BFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgBMNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 08:46:59 -0500
Received: from outbound-smtp42.blacknight.com ([46.22.139.226]:50400 "EHLO
        outbound-smtp42.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730076AbgBMNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:46:59 -0500
Received: from mail.blacknight.com (unknown [81.17.254.10])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id 6111DD69
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:46:57 +0000 (GMT)
Received: (qmail 24842 invoked from network); 13 Feb 2020 13:46:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2020 13:46:57 -0000
Date:   Thu, 13 Feb 2020 13:46:55 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Message-ID: <20200213134655.GX3466@techsingularity.net>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-3-vincent.guittot@linaro.org>
 <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net>
 <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
 <20200213131658.9600-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200213131658.9600-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:16:58PM +0800, Hillf Danton wrote:
> > -	load = task_h_load(env->p);
> > -	dst_load = env->dst_stats.load + load;
> > -	src_load = env->src_stats.load - load;
> > -
> >  	/*
> > -	 * If the improvement from just moving env->p direction is better
> > -	 * than swapping tasks around, check if a move is possible.
> > +	 * If dst node has spare capacity, then check if there is an
> > +	 * imbalance that would be overruled by the load balancer.
> >  	 */
> > -	maymove = !load_too_imbalanced(src_load, dst_load, env);
> > +	if (env->dst_stats.node_type == node_has_spare) {
> > +		unsigned int imbalance;
> > +		int src_running, dst_running;
> > +
> > +		/* Would movement cause an imbalance? */
> > +		src_running = env->src_stats.nr_running - 1;
> > +		dst_running = env->src_stats.nr_running + 1;
> > +		imbalance = max(0, dst_running - src_running);
> 
> Have trouble working out why 2 is magician again to make your test data nicer :P
> 

This is calculating what the nr_running would be after the move and
checking if an imbalance exists after the move forcing the load balancer
to intervene.

-- 
Mel Gorman
SUSE Labs
