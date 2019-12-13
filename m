Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DFD11E2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLML2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 06:28:03 -0500
Received: from foss.arm.com ([217.140.110.172]:55622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLML2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:28:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3912BDA7;
        Fri, 13 Dec 2019 03:28:02 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5403F718;
        Fri, 13 Dec 2019 03:28:00 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
To:     "chengjian (D)" <cj.chengjian@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        chenwandun@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        huawei.libin@huawei.com, bobo.shaobowang@huawei.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
 <20191212152406.GB2827@hirez.programming.kicks-ass.net>
 <d40ac385-626f-e86f-b2cb-69adf10a193a@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6d188305-66ab-81cf-6340-34d155dcaf3b@arm.com>
Date:   Fri, 13 Dec 2019 11:28:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d40ac385-626f-e86f-b2cb-69adf10a193a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2019 09:57, chengjian (D) wrote:
> 
> in select_idle_smt()
> 
> /*
>  * Scan the local SMT mask for idle CPUs.
>  */
> static int select_idle_smt(struct task_struct *p, int target)
> {
>     int cpu, si_cpu = -1;
> 
>     if (!static_branch_likely(&sched_smt_present))
>         return -1;
> 
>     for_each_cpu(cpu, cpu_smt_mask(target)) {
>         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>             continue;
>         if (available_idle_cpu(cpu))
>             return cpu;
>         if (si_cpu == -1 && sched_idle_cpu(cpu))
>             si_cpu = cpu;
>     }
> 
>     return si_cpu;
> }
> 
> 
> Why don't we do the same thing in this function,
> 
> although cpu_smt_present () often has few CPUs.
> 
> it is better to determine the 'p->cpus_ptr' first.
> 
> 

Like you said the gains here would probably be small - the highest SMT
count I'm aware of is SMT8 (POWER9). Still, if we end up with both
select_idle_core() and select_idle_cpu() using that pattern, it would make
sense IMO to align select_idle_smt() with those.

> 
> 
> 
