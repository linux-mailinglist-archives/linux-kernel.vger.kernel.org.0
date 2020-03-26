Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC435193573
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 02:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgCZB5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 21:57:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:36580 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgCZB5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:57:11 -0400
IronPort-SDR: rJpCWNkn/4EtTym+i/UD7tYgQmaefImmhXRhRhU14m7tboJRx1w9Ag1k/VIxlAsC//HOKqrUD6
 cdlGdV4bZh4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 18:57:11 -0700
IronPort-SDR: +yNBM/Ogmbhnt+JW3Z+txpINj9BeBiqj4oi/vNKw+3JEM3FV4u3XNvndHjxfGgm7oOEnkqfCcT
 siciUsa6fjjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="357996982"
Received: from unknown (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2020 18:57:07 -0700
Subject: Re: [PATCH] sched/fair: Don't pull task if local group is more loaded
 than busiest group
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, vpillai@digitalocean.com,
        joel@joelfernandes.org
References: <1585140388-61802-1-git-send-email-aubrey.li@intel.com>
 <20200325135818.GA8201@vingu-book>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <3d2e2667-f90f-6e59-9d0f-4bb1cf0c4923@linux.intel.com>
Date:   Thu, 26 Mar 2020 09:57:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200325135818.GA8201@vingu-book>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/25 21:58, Vincent Guittot wrote:
> Le mercredi 25 mars 2020 à 20:46:28 (+0800), Aubrey Li a écrit :
>> A huge number of load imbalance was observed when the local group
>> type is group_fully_busy, and the average load of local group is
>> greater than the selected busiest group, so the imbalance calculation
>> returns a negative value actually. Fix this problem by comparing the
> 
> Do you see any wrong task migration ? because if imbalance is < 0, detach_tasks should return early

I didn't see wrong task migration, in this case the busiest group has only one CPU intensive
workload running.

> 
>> average load before local group type check.
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>  kernel/sched/fair.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index c1217bf..c524369 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8862,17 +8862,17 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>>  		goto out_balanced;
>>  
>>  	/*
>> +	 * If the local group is more loaded than the selected
>> +	 * busiest group don't try to pull any tasks.
>> +	 */
>> +	if (local->avg_load >= busiest->avg_load)
> 
> If local is not overloaded, local->avg_load is null because it has not been already computed.
> 
> You should better add such test in calculate_imbalance after we computed local->avg_load and set imbalance to NULL

This makes more sense, will refine the patch for this.

Thanks,
-Aubrey

> 
> something like:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9e544e702f66..62f0861cefc0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9152,6 +9152,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> 
>                 sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
>                                 sds->total_capacity;
> +
> +               /*
> +                * If the local group is more loaded than the selected
> +                * busiest group don't try to pull any tasks.
> +                */
> +               if (local->avg_load >= busiest->avg_load) {
> +                       env->imbalance =0;
> +                       return;
> +               }
>         }
> 
>         /*
> 
> 
>> +		goto out_balanced;
>> +
>> +	/*
>>  	 * When groups are overloaded, use the avg_load to ensure fairness
>>  	 * between tasks.
>>  	 */
>>  	if (local->group_type == group_overloaded) {
>> -		/*
>> -		 * If the local group is more loaded than the selected
>> -		 * busiest group don't try to pull any tasks.
>> -		 */
>> -		if (local->avg_load >= busiest->avg_load)
>> -			goto out_balanced;
>> -
>>  		/* XXX broken for overlapping NUMA groups */
>>  		sds.avg_load = (sds.total_load * SCHED_CAPACITY_SCALE) /
>>  				sds.total_capacity;
>> -- 
>> 2.7.4
>>

