Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9A114232
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 15:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfLEOEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 09:04:04 -0500
Received: from foss.arm.com ([217.140.110.172]:35414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbfLEOEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:04:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42AE5328;
        Thu,  5 Dec 2019 06:04:03 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BEE03F68E;
        Thu,  5 Dec 2019 06:04:00 -0800 (PST)
Subject: Re: [RFC 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, pavel@ucw.cz,
        dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <450fc7e2-49d5-d809-281f-7d9a99d3e530@arm.com>
 <c26f7909-0e4e-a897-bf84-0aa9e5389a0d@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <838f233e-fa4c-d5a3-9b50-69e2e121edda@arm.com>
Date:   Thu, 5 Dec 2019 15:03:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c26f7909-0e4e-a897-bf84-0aa9e5389a0d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2019 11:49, Valentin Schneider wrote:
>  
> On 05/12/2019 09:24, Dietmar Eggemann wrote:
>> On 25/11/2019 10:46, Parth Shah wrote:
>>> This patch series is based on the discussion started as the "Usecases for
>>> the per-task latency-nice attribute"[1]
>>>
>>> This patch series introduces a new per-task attribute latency_tolerance to
>>> provide the scheduler hints about the latency requirements of the task.
>>
>> I forgot but is there a chance to have this as a per-taskgroup attribute
>> as well?
>>
> 
> Peter argued we should go for task attributes first, and then
> cgroup/taskgroups later on:
> 
> https://lore.kernel.org/lkml/20190905083127.GA2332@hirez.programming.kicks-ass.net/

OK, I went through this thread again. So Google or we have to provide
the missing per-taskgroup API via cpu controller's attributes (like for
uclamp) for the EAS usecase.

After reading:

https://lore.kernel.org/r/20190905114030.GL2349@hirez.programming.kicks-ass.net

IMHO the following mapping of the existing Android (binary)
latency_sensitive per-taskgroup flag makes sense:

latency_sensitive=1 -> latency_tolerance*[-20 .. -1] (less tolerant,
more sensitive)

latency_sensitive=0 -> latency_tolerance[0 .. 19] (more tolerant, less
sensitive)

Default value is 0 so not latency_sensitive.

* Since we use [-20 .. 19] as values for latency_tolerance we could name
it latency_nice. It's shorter ... ?
