Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E854E0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 08:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFUG6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 02:58:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51284 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfFUG6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Tnch/Sz3nSK1305rU1ReOn7HOERMkppOQquxyzD7msE=; b=n6sH1PgXYQ4VKuW8IFwJSkIRs
        U7VsDc8oFgwmoYXQAYeGzAGbDj2+VrQ+8tis3mWuG2lkAv7VbG0Sdgl6TRgzbOIeueQWoNTxR74Si
        DorfbJIqPdacsmI9OywE9SBFXqYR9TmPMfO3xgORZsiRMOhAMC7By0TSOnh70UwQIsZohShrqFUXp
        lgtPn9tEzy0Op4/pCbd84v18B7Lq361jbAqQNBlnu9hod04pcGOTSrcIEPocIyr0qpZPjr2RkU8TO
        rOq9ZiJRNxf5ge1qWT3MRAybnucjQ9eZR5c07EhUb1zX/YtPdBnQvNz6lFwgMmgaD89Ig3hTxW1+v
        q+S2CaTTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heDVU-0007Tt-SS; Fri, 21 Jun 2019 06:58:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F2BF209D5698; Fri, 21 Jun 2019 08:58:42 +0200 (CEST)
Date:   Fri, 21 Jun 2019 08:58:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] sched/isolation: Prefer housekeeping cpu in local node
Message-ID: <20190621065842.GF3436@hirez.programming.kicks-ass.net>
References: <1561080911-22655-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561080911-22655-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:35:11AM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> In real product setup, there will be houseeking cpus in each nodes, it 
> is prefer to do housekeeping from local node, fallback to global online 
> cpumask if failed to find houseeking cpu from local node.
> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

Looks good; did it actually work? :-)

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 63184cf..3d3fb04 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1726,6 +1726,20 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
>  
>  #endif /* CONFIG_NUMA */


Please double check this function; I wrote it in a hurry :-) Also maybe
add a wee comment on top like:

/*
 * sched_numa_file_closest() - given the NUMA topology, find the cpu
 *                             closest to @cpu from @cpumask.
 * cpumask: cpumask to find a cpu from
 * cpu: cpu to be close to
 *
 * returns: cpu, or >= nr_cpu_ids when nothing found (or !NUMA).
 */

> +int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> +{
> +#ifdef CONFIG_NUMA
> +	int i, j = cpu_to_node(cpu);
> +
> +	for (i = 0; i < sched_domains_numa_levels; i++) {
> +		cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
> +		if (cpu < nr_cpu_ids)
> +			return cpu;
> +	}
> +#endif
> +	return nr_cpu_ids;
> +}
