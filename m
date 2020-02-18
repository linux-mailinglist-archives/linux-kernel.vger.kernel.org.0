Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401BA16263E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 13:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgBRMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 07:37:59 -0500
Received: from foss.arm.com ([217.140.110.172]:51322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgBRMh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:37:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DB051FB;
        Tue, 18 Feb 2020 04:37:58 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A6B3F6CF;
        Tue, 18 Feb 2020 04:37:56 -0800 (PST)
Subject: Re: [PATCH v2 2/5] sched/numa: Replace runnable_load_avg by load_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-3-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ecbf5317-e6cf-fc20-9871-4ea06a987952@arm.com>
Date:   Tue, 18 Feb 2020 13:37:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214152729.6059-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 16:27, Vincent Guittot wrote:

[...]

>  	/*
>  	 * The load is corrected for the CPU capacity available on each node.
>  	 *
> @@ -1788,10 +1831,10 @@ static int task_numa_migrate(struct task_struct *p)
>  	dist = env.dist = node_distance(env.src_nid, env.dst_nid);
>  	taskweight = task_weight(p, env.src_nid, dist);
>  	groupweight = group_weight(p, env.src_nid, dist);
> -	update_numa_stats(&env.src_stats, env.src_nid);
> +	update_numa_stats(&env, &env.src_stats, env.src_nid);

This looks strange. Can you do:

-static void update_numa_stats(struct task_numa_env *env,
+static void update_numa_stats(unsigned int imbalance_pct,
                              struct numa_stats *ns, int nid)

-    update_numa_stats(&env, &env.src_stats, env.src_nid);
+    update_numa_stats(env.imbalance_pct, &env.src_stats, env.src_nid);

[...]

> +static unsigned long cpu_runnable_load(struct rq *rq)
> +{
> +	return cfs_rq_runnable_load_avg(&rq->cfs);
> +}
> +

Why not remove cpu_runnable_load() in this patch rather moving it?

kernel/sched/fair.c:5492:22: warning: ‘cpu_runnable_load’ defined but
not used [-Wunused-function]
 static unsigned long cpu_runnable_load(struct rq *rq)


