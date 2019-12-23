Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 450B6129995
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLWRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 12:52:16 -0500
Received: from foss.arm.com ([217.140.110.172]:47498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:52:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10FDF328;
        Mon, 23 Dec 2019 09:52:15 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A70023F68F;
        Mon, 23 Dec 2019 09:52:14 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:52:13 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 5/7] sched/fair: update cpu_capacity to reflect
 thermal pressure
Message-ID: <20191223175213.GB31446@arm.com>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-6-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-6-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Dec 2019 at 23:11:46 (-0500), Thara Gopinath wrote:
> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
> pressure on a cpu means this maximum available capacity is reduced. This
> patch reduces the average thermal pressure for a cpu from its maximum

Maybe we can introduce two terms here: maximum possible capacity and
maximum currently available capacity.
I think using these two terms the message can become more clear:

cpu_capacity initially reflects the maximum possible capacity of a cpu
(capacity orig). Thermal pressure on a cpu means this maximum
possible capacity of a cpu is not available due to thermal events.
This patch subtracts the average thermal pressure for a cpu from the
cpu's maximum possible capacity so that cpu_capacity reflects the
actual maximum currently available capacity.

Kind regards,
Ionela.

> available capacity so that cpu_capacity reflects the actual
> available capacity.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e12a375..4840655 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7725,8 +7725,15 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>  	if (unlikely(irq >= max))
>  		return 1;
>  
> +	/*
> +	 * avg_rt.util avg and avg_dl.util track binary signals
> +	 * (running and not running) with weights 0 and 1024 respectively.
> +	 * avg_thermal.load_avg tracks thermal pressure and the weighted
> +	 * average uses the actual delta max capacity.
> +	 */
>  	used = READ_ONCE(rq->avg_rt.util_avg);
>  	used += READ_ONCE(rq->avg_dl.util_avg);
> +	used += READ_ONCE(rq->avg_thermal.load_avg);
>  
>  	if (unlikely(used >= max))
>  		return 1;
> -- 
> 2.1.4
> 
