Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA04112999E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLWRzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 12:55:01 -0500
Received: from foss.arm.com ([217.140.110.172]:47528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:55:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0D3328;
        Mon, 23 Dec 2019 09:54:59 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DA573F68F;
        Mon, 23 Dec 2019 09:54:59 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:54:58 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 6/7] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Message-ID: <20191223175458.GC31446@arm.com>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-7-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-7-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Dec 2019 at 23:11:47 (-0500), Thara Gopinath wrote:
[...]
> @@ -430,6 +430,10 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  				 unsigned long state)
>  {
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +	struct cpumask *cpus;
> +	unsigned int frequency;
> +	unsigned long capacity;
> +	int ret;
>  
>  	/* Request state should be less than max_level */
>  	if (WARN_ON(state > cpufreq_cdev->max_level))
> @@ -441,8 +445,19 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  
>  	cpufreq_cdev->cpufreq_state = state;
>  
> -	return freq_qos_update_request(&cpufreq_cdev->qos_req,
> -				get_state_freq(cpufreq_cdev, state));
> +	frequency = get_state_freq(cpufreq_cdev, state);
> +
> +	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
> +
> +	if (ret > 0) {
> +		cpus = cpufreq_cdev->policy->cpus;
> +		capacity = frequency *
> +				arch_scale_cpu_capacity(cpumask_first(cpus));
> +		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;
> +		arch_set_thermal_pressure(cpus, capacity);

Given that you already get a CPU's capacity (orig) here, why don't
you pass thermal pressure directly to arch_set_thermal_pressure,
rather than passing the capped capacity and subtracting it later from
the same CPU capacity (arch_scale_cpu_capacity)?

If my math is correct this would work nicely:
                pressure = cpufreq_cdev->policy->cpuinfo.max_freq;
		pressure -= frequency;
		pressure *= arch_scale_cpu_capacity(cpumask_first(cpus);
		pressure /= cpufreq_cdev->policy->cpuinfo.max_freq;

Thanks,
Ionela.

> +	}
> +
> +	return ret;
>  }
>  
>  /* Bind cpufreq callbacks to thermal cooling device ops */
> -- 
> 2.1.4
> 
