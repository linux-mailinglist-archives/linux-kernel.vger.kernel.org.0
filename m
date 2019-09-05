Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F03A9A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 08:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfIEGWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 02:22:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbfIEGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:22:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8567v9J174268
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 02:22:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uttnt5ptp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:22:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 5 Sep 2019 07:22:16 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 07:22:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x856MArT48431298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 06:22:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BF7AAE051;
        Thu,  5 Sep 2019 06:22:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78EE9AE058;
        Thu,  5 Sep 2019 06:22:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.51.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 06:22:07 +0000 (GMT)
Subject: Re: [RFC PATCH 2/9] sched: add search limit as per latency-nice
To:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, patrick.bellasi@arm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-3-subhra.mazumdar@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 5 Sep 2019 11:52:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190830174944.21741-3-subhra.mazumdar@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090506-0008-0000-0000-000003114EBB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090506-0009-0000-0000-00004A2FA6B4
Message-Id: <5b7d3790-2510-f8b1-6515-bb9d307bba25@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/19 11:19 PM, subhra mazumdar wrote:
> Put upper and lower limit on CPU search in select_idle_cpu. The lower limit
> is set to amount of CPUs in a core  while upper limit is derived from the
> latency-nice of the thread. This ensures for any architecture we will
> usually search beyond a core. Changing the latency-nice value by user will
> change the search cost making it appropriate for given workload.
> 
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  kernel/sched/fair.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b08d00c..c31082d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	u64 avg_cost, avg_idle;
>  	u64 time, cost;
>  	s64 delta;
> -	int cpu, nr = INT_MAX;
> +	int cpu, floor, nr = INT_MAX;
> 
>  	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>  	if (!this_sd)
> @@ -6205,11 +6205,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  		return -1;
> 
>  	if (sched_feat(SIS_PROP)) {
> -		u64 span_avg = sd->span_weight * avg_idle;
> -		if (span_avg > 4*avg_cost)
> -			nr = div_u64(span_avg, avg_cost);
> -		else
> -			nr = 4;
> +		floor = cpumask_weight(topology_sibling_cpumask(target));
> +		if (floor < 2)
> +			floor = 2;
> +		nr = (p->latency_nice * sd->span_weight) / LATENCY_NICE_MAX;

I see you defined LATENCY_NICE_MAX = 100,
So is the value 100 an experimental value?
I was hoping to be something in the power of 2 resulting in just ">>>" rather than
the heavy division operation.

> +		if (nr < floor)
> +			nr = floor;
>  	}
> 
>  	time = local_clock();
> 

