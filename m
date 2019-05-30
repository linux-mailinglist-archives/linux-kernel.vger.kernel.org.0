Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2F2FFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfE3Pwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 11:52:44 -0400
Received: from foss.arm.com ([217.140.101.70]:38952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Pwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:52:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5546C341;
        Thu, 30 May 2019 08:52:43 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53F3F3F59C;
        Thu, 30 May 2019 08:52:42 -0700 (PDT)
Subject: Re: [PATCH 1/4] coresight: tmc-etr: Do not call smp_processor_id()
 from preemptible
To:     robin.murphy@arm.com, mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1557480663-16759-1-git-send-email-suzuki.poulose@arm.com>
 <1557480663-16759-2-git-send-email-suzuki.poulose@arm.com>
 <319d4d63-326b-9bb5-6a24-f7aa8ec549f9@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b3e5dd32-5231-36fa-fe97-136aa98f1bef@arm.com>
Date:   Thu, 30 May 2019 16:52:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <319d4d63-326b-9bb5-6a24-f7aa8ec549f9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 10/05/2019 11:38, Robin Murphy wrote:
> Hi Suzuki,
> 
> On 10/05/2019 10:31, Suzuki K Poulose wrote:
>> Instead of using smp_processor_id() to figure out the node,
>> use the numa_node_id() for the current CPU node to avoid
>> splats like :


>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 793639f..cae9d8a 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1323,13 +1323,11 @@ static struct etr_perf_buffer *
>>    tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>>    		       int nr_pages, void **pages, bool snapshot)
>>    {
>> -	int node, cpu = event->cpu;
>> +	int node;
>>    	struct etr_buf *etr_buf;
>>    	struct etr_perf_buffer *etr_perf;
>>    
>> -	if (cpu == -1)
>> -		cpu = smp_processor_id();
>> -	node = cpu_to_node(cpu);
>> +	node = (event->cpu == -1) ? numa_node_id() : cpu_to_node(event->cpu);
> 
> If cpu == -1 represents a "don't care" scenario, it might be clearer to
> just use NUMA_NO_NODE instead, and let the allocator handle it.

Thanks for the suggestion, will use that instead

Cheers
Suzuki
