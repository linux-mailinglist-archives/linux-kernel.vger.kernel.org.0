Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B6AF401F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 06:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKHFuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 00:50:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfKHFuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:50:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4D05130B7E651556B2F6;
        Fri,  8 Nov 2019 13:50:13 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 8 Nov 2019
 13:50:06 +0800
Subject: Re: [PATCH v3] lib: optimize cpumask_local_spread()
To:     Andrew Morton <akpm@linux-foundation.org>
References: <1573091048-10595-1-git-send-email-zhangshaokun@hisilicon.com>
 <20191107194942.734bc867e1c9578d07cf1712@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, yuqi jin <jinyuqi@huawei.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        "Michal Hocko" <mhocko@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <ebc1b33d-ee59-a662-89ae-ae5a7e340d56@hisilicon.com>
Date:   Fri, 8 Nov 2019 13:50:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20191107194942.734bc867e1c9578d07cf1712@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2019/11/8 11:49, Andrew Morton wrote:
> On Thu, 7 Nov 2019 09:44:08 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> In the multi-processors and NUMA system, I/O driver will find cpu cores
>> that which shall be bound IRQ. When cpu cores in the local numa have
>> been used, it is better to find the node closest to the local numa node,
>> instead of choosing any online cpu immediately.
>>
>> On Huawei Kunpeng 920 server, there are 4 NUMA node(0 -3) in the 2-cpu
>> system(0 - 1). We perform PS (parameter server) business test, the
>> behavior of the service is that the client initiates a request through
>> the network card, the server responds to the request after calculation. 
>> When two PS processes run on node2 and node3 separately and the
>> network card is located on 'node2' which is in cpu1, the performance
>> of node2 (26W QPS) and node3 (22W QPS) was different.
>> It is better that the NIC queues are bound to the cpu1 cores in turn,
>> then XPS will also be properly initialized, while cpumask_local_spread
>> only considers the local node. When the number of NIC queues exceeds
>> the number of cores in the local node, it returns to the online core
>> directly. So when PS runs on node3 sending a calculated request,
>> the performance is not as good as the node2. It is considered that
>> the NIC and other I/O devices shall initialize the interrupt binding,
>> if the cores of the local node are used up, it is reasonable to return
>> the node closest to it.
>>
>> Let's optimize it and find the nearest node through NUMA distance for the
>> non-local NUMA nodes. The performance will be better if it return the
>> nearest node than the random node.
>>
>> After this patch, the performance of the node3 is the same as node2
>> that is 26W QPS when the network card is still in 'node2'. Since it will
>> return the closest non-local NUMA code rather than random node, it is no
>> harm to others at least.
> 
> This is a little nicer:
> 
> --- a/lib/cpumask.c~lib-optimize-cpumask_local_spread-v3-fix
> +++ a/lib/cpumask.c
> @@ -254,7 +254,6 @@ static unsigned int __cpumask_local_spre
>  	BUG();
>  }
>  
> -static DEFINE_SPINLOCK(spread_lock);
>  /**
>   * cpumask_local_spread - select the i'th cpu with local numa cpu's first
>   * @i: index number
> @@ -270,6 +269,7 @@ unsigned int cpumask_local_spread(unsign
>  {
>  	static int node_dist[MAX_NUMNODES];
>  	static bool used[MAX_NUMNODES];
> +	static DEFINE_SPINLOCK(spread_lock);

Good catch, thanks for fixing it.

Shaokun.

>  	unsigned long flags;
>  	int cpu, j, id;
>  
> _
> 
> 
> .
> 

