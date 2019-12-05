Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C065C113DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 10:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfLEJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 04:24:54 -0500
Received: from foss.arm.com ([217.140.110.172]:55202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfLEJYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:24:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB6E328;
        Thu,  5 Dec 2019 01:24:53 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2AF3F68E;
        Thu,  5 Dec 2019 01:24:50 -0800 (PST)
Subject: Re: [RFC 1/3] Introduce latency-tolerance as an per-task attribute
To:     Parth Shah <parth@linux.ibm.com>, Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-2-parth@linux.ibm.com>
 <20191203083654.3ctttimdiujdt7tl@e107158-lin.cambridge.arm.com>
 <59044b60-a7d8-9508-4975-06afdcfd33cd@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d6a1d7ae-fe5e-7f52-60b5-4daac9a70107@arm.com>
Date:   Thu, 5 Dec 2019 10:24:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <59044b60-a7d8-9508-4975-06afdcfd33cd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 16:47, Parth Shah wrote:
> 
> On 12/3/19 2:06 PM, Qais Yousef wrote:
>> On 11/25/19 15:16, Parth Shah wrote:
>>> Latency-tolerance indicates the latency requirements of a task with respect
>>> to the other tasks in the system. The value of the attribute can be within
>>> the range of [-20, 19] both inclusive to be in-line with the values just
>>> like task nice values.
>>>
>>> latency_tolerance = -20 indicates the task to have the least latency as
>>> compared to the tasks having latency_tolerance = +19.
>>>
>>> The latency_tolerance may affect only the CFS SCHED_CLASS by getting
>>> latency requirements from the userspace.

[...]

>>> diff --git a/include/linux/sched/latency_tolerance.h b/include/linux/sched/latency_tolerance.h

Do we really need an extra header file for this? I know there is
linux/sched/prio.h but couldn't this go into kernel/sched/sched.h?

[...]
