Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE06103A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 13:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfKTMaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 07:30:14 -0500
Received: from foss.arm.com ([217.140.110.172]:38652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfKTMaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:30:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04206328;
        Wed, 20 Nov 2019 04:30:14 -0800 (PST)
Received: from [10.1.194.51] (macbook.cambridge.arm.com [10.1.194.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12C113F703;
        Wed, 20 Nov 2019 04:30:12 -0800 (PST)
Subject: Re: [PATCH] arm: Fix topology setup in case of CPU hotplug for
 CONFIG_SCHED_MC
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Russell King <linux@armlinux.org.uk>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191120104212.14791-1-dietmar.eggemann@arm.com>
 <20191120110911.GA31600@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b5f99e82-0640-72e6-2499-16e99b1aeae0@arm.com>
Date:   Wed, 20 Nov 2019 12:30:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120110911.GA31600@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.19 11:09, Sudeep Holla wrote:
> Hi Dietmar, Lukasz,
> 
> Thanks for digging this bug and fixing it.
> 
> On Wed, Nov 20, 2019 at 10:42:12AM +0000, Dietmar Eggemann wrote:

[...]

>> @@ -231,14 +230,14 @@ void store_cpu_topology(unsigned int cpuid)
>>  		cpuid_topo->package_id = -1;
>>  	}
>>
>> -	update_siblings_masks(cpuid);
>> -
>>  	update_cpu_capacity(cpuid);
>>
>>  	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
>> -		cpuid, cpu_topology[cpuid].thread_id,
>> -		cpu_topology[cpuid].core_id,
>> -		cpu_topology[cpuid].package_id, mpidr);
>> +		cpuid, cpuid_topo->thread_id, cpuid_topo->core_id,
>> +		cpuid_topo->package_id, mpidr);
>> +
> 
> [nit] The above is a clearly cosmetic cleanup and shouldn't be part of
> this fix as they will be backported automatically. So I prefer to drop
> this or make it separate patch if required.

I can get rid of this cleanup in v2. Thanks for the review!
