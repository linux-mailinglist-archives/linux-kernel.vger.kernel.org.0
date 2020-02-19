Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7661646A8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 15:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBSOQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 09:16:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgBSOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:16:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JE9GCs187390;
        Wed, 19 Feb 2020 14:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=f/O2jeHf4ajunXhbuuhXwEpKZ33CEDPKTaHg5Z7Sxl4=;
 b=SVBn0pcVfmiBsgA8ZHCsXyol3fhEfr0F7YC0B2XwMCZ3wOtCvsLl92T4s8Zd9HrkAyY2
 Shllpb8aLHtkFYRYvu4XThFqNmKK5Lb2hVQNQ2It70nuhzB+tS47OXvZNrDjkE1x+7kv
 5+Gf/4ty37Lr1PhHQKGd8N47ozF90EpVMxvgyCk03SKhLA0QxczwP1iGm4fhHOef6rNR
 Ld5UNsBf8LeWziR0DeZY5q64WNWaijmGRvermWOjvsgX1Xz8Wf6FJ4MSOf0fj9TcUXGA
 5b2OdsMKZOqDz9+p75uziau9jnYl/5cLLTuT0nwic37l6hCFjzly/zxsxTyPD3bN5+fR 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y8udkb8qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 14:15:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JE7gCp077276;
        Wed, 19 Feb 2020 14:15:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y8ud187pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 14:15:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01JEFgVK027741;
        Wed, 19 Feb 2020 14:15:42 GMT
Received: from [192.168.0.195] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 06:15:42 -0800
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
To:     Parth Shah <parth@linux.ibm.com>, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        dhaval.giani@oracle.com, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, qais.yousef@arm.com, pavel@ucw.cz,
        qperret@qperret.net, David.Laight@ACULAB.COM, pjt@google.com,
        tj@kernel.org
References: <20200116120230.16759-1-parth@linux.ibm.com>
 <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <971909ed-d4e0-6afa-d20b-365ede5a195e@linux.ibm.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <8e984496-e89b-d96c-d84e-2be7f0958ea4@oracle.com>
Date:   Wed, 19 Feb 2020 09:15:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <971909ed-d4e0-6afa-d20b-365ede5a195e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/20 5:09 AM, Parth Shah wrote:
> Hi Chris,
> 
> On 2/19/20 4:30 AM, chris hyser wrote:
>> On 2/17/20 3:57 AM, Parth Shah wrote:
>>>
>>>
>>> On 1/16/20 5:32 PM, Parth Shah wrote:
>>>> This is the 3rd revision of the patch set to introduce
>>>> latency_{nice/tolerance} as a per task attribute.
>>>>
>>>> The previous version can be found at:
>>>> v1: https://lkml.org/lkml/2019/11/25/151
>>>> v2: https://lkml.org/lkml/2019/12/8/10
>>>>
>>>> Changes in this revision are:
>>>> v2 -> v3:
>>>> - This series changes the longer attribute name to "latency_nice" as per
>>>>     the comment from Dietmar Eggemann https://lkml.org/lkml/2019/12/5/394
>>>> v1 -> v2:
>>>> - Addressed comments from Qais Yousef
>>>> - As per suggestion from Dietmar, moved content from newly created
>>>>     include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
>>>> - Extend sched_setattr() to support latency_tolerance in tools headers UAPI
>>>>
>>>>
>>>> Introduction:
>>>> ==============
>>>> This patch series introduces a new per-task attribute latency_nice to
>>>> provide the scheduler hints about the latency requirements of the task [1].
>>>>
>>>> Latency_nice is a ranged attribute of a task with the value ranging
>>>> from [-20, 19] both inclusive which makes it align with the task nice
>>>> value.
>>>>
>>>> The value should provide scheduler hints about the relative latency
>>>> requirements of tasks, meaning the task with "latency_nice = -20"
>>>> should have lower latency requirements than compared to those tasks with
>>>> higher values. Similarly a task with "latency_nice = 19" can have higher
>>>> latency and hence such tasks may not care much about latency.
>>>>
>>>> The default value is set to 0. The usecases discussed below can use this
>>>> range of [-20, 19] for latency_nice for the specific purpose. This
>>>> patch does not implement any use cases for such attribute so that any
>>>> change in naming or range does not affect much to the other (future)
>>>> patches using this. The actual use of latency_nice during task wakeup
>>>> and load-balancing is yet to be coded for each of those usecases.
>>>>
>>>> As per my view, this defined attribute can be used in following ways for a
>>>> some of the usecases:
>>>> 1 Reduce search scan time for select_idle_cpu():
>>>> - Reduce search scans for finding idle CPU for a waking task with lower
>>>>     latency_nice values.
>>>>
>>>> 2 TurboSched:
>>>> - Classify the tasks with higher latency_nice values as a small
>>>>     background task given that its historic utilization is very low, for
>>>>     which the scheduler can search for more number of cores to do task
>>>>     packing.  A task with a latency_nice >= some_threshold (e.g, == 19)
>>>>     and util <= 12.5% can be background tasks.
>>>>
>>>> 3 Optimize AVX512 based workload:
>>>> - Bias scheduler to not put a task having (latency_nice == -20) on a
>>>>     core occupying AVX512 based workload.
>>>>
>>>>
>>>> Series Organization:
>>>> ====================
>>>> - Patch 1: Add new attribute latency_nice to task_struct.
>>>> - Patch 2: Clone parent task's attribute to the child task on fork
>>>> - Patch 3: Add support for sched_{set,get}attr syscall to modify
>>>>              latency_nice of the task
>>>>
>>>>
>>>> The patch series can be applied on tip/sched/core at the
>>>> commit 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
>>>>
>>>>
>>>> References:
>>>> ============
>>>> [1]. Usecases for the per-task latency-nice attribute,
>>>>        https://lkml.org/lkml/2019/9/30/215
>>>> [2]. Task Latency-nice, "Subhra Mazumdar",
>>>>        https://lkml.org/lkml/2019/8/30/829
>>>> [3]. Introduce per-task latency_tolerance for scheduler hints,
>>>>        https://lkml.org/lkml/2019/12/8/10
>>>>
>>>>
>>>> Parth Shah (3):
>>>>     sched: Introduce latency-nice as a per-task attribute
>>>>     sched/core: Propagate parent task's latency requirements to the child
>>>>       task
>>>>     sched: Allow sched_{get,set}attr to change latency_nice of the task
>>>>
>>>>    include/linux/sched.h            |  1 +
>>>>    include/uapi/linux/sched.h       |  4 +++-
>>>>    include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
>>>>    kernel/sched/core.c              | 21 +++++++++++++++++++++
>>>>    kernel/sched/sched.h             | 18 ++++++++++++++++++
>>>>    tools/include/uapi/linux/sched.h |  4 +++-
>>>>    6 files changed, 65 insertions(+), 2 deletions(-)
>>>>
>>>
>>> Its been a long time and few revisions since the beginning of the
>>> discussion around the latency-nice. Hence thought of asking if there is/are
>>> any further work that needs to be done for adding latency-nice attribute or
>>> am I missing any piece in here?
>>
>> All, I was asked to take a look at the original latency_nice patchset.
>> First, to clarify objectives, Oracle is not interested in trading
>> throughput for latency. What we found is that the DB has specific tasks
>> which do very little but need to do this as absolutely quickly as possible,
>> ie extreme latency sensitivity. Second, the key to latency reduction in the
>> task wakeup path seems to be limiting variations of "idle cpu" search. The
>> latter particularly interests me as an example of "platform size based
>> latency" which I believe to be important given all the varying size VMs and
>> containers.
>>
>> Parth, I've been using your v3 patchset as the basis of an investigation
>> into the measurable effects of short-circuiting this search. I'm not quite
>> ready to put anything out, but the patchset is working well. The only
> 
> That's a good news as you are able to get a usecase of this patch-set.
> 
>> feedback I have is that currently non-root can set the value negative which
>> is inconsistent with 'nice' and I would think a security hole.
>>
> 
> I would assume you mean 'latency_nice' here.
> 
>  From my testing, I was not able to set values for any root owned task's
> latency_nice value by the non-root user. Also, my patch-set just piggybacks
> on the already existing sched_setattr syscall and hence it should not allow
> non-root user to do any modifications. Can you confirm this by changing
> nice (renice) value of a root task from non-root user.
> 
> I have done the sanity check in the code and thinking where it could
> possibly have gone wrong. So, can you please specify what values were you
> able to set outside the [-20, 19] range?

The checks prevent being outside that range. But negative numbers -20 to -1 did not need root. Let me dig some more. I 
verified this explicitly before sending the email so something is up.

-chrish

