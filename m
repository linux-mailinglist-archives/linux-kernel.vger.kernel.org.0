Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5296614C93E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgA2LE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 06:04:58 -0500
Received: from foss.arm.com ([217.140.110.172]:39420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgA2LE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:04:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4C31FB;
        Wed, 29 Jan 2020 03:04:57 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93A4B3F67D;
        Wed, 29 Jan 2020 03:04:56 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a2f9e7d1-08c6-2545-2088-e0226ffd79e0@arm.com>
Date:   Wed, 29 Jan 2020 12:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200126200934.18712-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2020 21:09, Valentin Schneider wrote:

[...]

> +static int select_idle_capacity(struct task_struct *p, int target)
> +{
> +	unsigned long best_cap = 0;
> +	struct sched_domain *sd;
> +	struct cpumask *cpus;
> +	int best_cpu = -1;
> +	struct rq *rq;
> +	int cpu;
> +
> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
> +		return -1;
> +
> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> +	if (!sd)
> +		return -1;
> +
> +	sync_entity_load_avg(&p->se);
> +
> +	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
> +	for_each_cpu_wrap(cpu, cpus, target) {
> +		rq = cpu_rq(cpu);
> +
> +		if (!available_idle_cpu(cpu))
> +			continue;
> +		if (task_fits_capacity(p, rq->cpu_capacity))
> +			return cpu;
> +
> +		/*
> +		 * It would be silly to keep looping when we've found a CPU
> +		 * of highest available capacity. Just check that it's not been
> +		 * too pressured lately.
> +		 */
> +		if (rq->cpu_capacity_orig == READ_ONCE(rq->rd->max_cpu_capacity) &&

There is a similar check in check_misfit_status(). Common helper function?

> +		    !check_cpu_capacity(rq, sd))
> +			return cpu;

I wonder how this special treatment of a big CPU behaves in (LITTLE,
medium, big) system like Pixel4 (Snapdragon 855):

 flame:/ $ cat /sys/devices/system/cpu/cpu*/cpu_capacity

261
261
261
261
871
871
871
1024

Or on legacy systems where the sd->imbalance_pct is 25% instead of 17%?
