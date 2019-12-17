Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73359122C51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 13:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfLQMy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 07:54:27 -0500
Received: from foss.arm.com ([217.140.110.172]:36180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfLQMy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:54:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD2BF31B;
        Tue, 17 Dec 2019 04:54:26 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF393F719;
        Tue, 17 Dec 2019 04:54:24 -0800 (PST)
Subject: Re: [Patch v6 2/7] sched: Add hook to read per cpu thermal pressure.
To:     Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-3-git-send-email-thara.gopinath@linaro.org>
 <20191216143539.GR2844@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <51954bed-6981-2f7d-1618-128e291a5c22@arm.com>
Date:   Tue, 17 Dec 2019 13:54:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216143539.GR2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2019 15:35, Peter Zijlstra wrote:
> On Wed, Dec 11, 2019 at 11:11:43PM -0500, Thara Gopinath wrote:

minor: in subject: s/sched/sched/topology


>> Introduce arch_scale_thermal_capacity to retrieve per cpu thermal
>> pressure.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  include/linux/sched/topology.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index f341163..f1e22f9 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -225,6 +225,14 @@ unsigned long arch_scale_cpu_capacity(int cpu)
>>  }
>>  #endif
>>  
>> +#ifndef arch_scale_thermal_capacity
>> +static __always_inline
>> +unsigned long arch_scale_thermal_capacity(int cpu)
>> +{
>> +	return 0;
>> +}
>> +#endif
> 
> This is confusing, the return value is not a capacity, it is a reduction
> in capacity. Either a comment of a better name would be appreciated.

+1, the patch-set uses: thermal_capacity, thermal_pressure,
capped_capacity.
