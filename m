Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52B113FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 11:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfLEKuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 05:50:01 -0500
Received: from foss.arm.com ([217.140.110.172]:58226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfLEKuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:50:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A576031B;
        Thu,  5 Dec 2019 02:50:00 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F30E3F52E;
        Thu,  5 Dec 2019 02:49:58 -0800 (PST)
Subject: Re: [RFC 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, pavel@ucw.cz,
        dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <450fc7e2-49d5-d809-281f-7d9a99d3e530@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c26f7909-0e4e-a897-bf84-0aa9e5389a0d@arm.com>
Date:   Thu, 5 Dec 2019 10:49:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <450fc7e2-49d5-d809-281f-7d9a99d3e530@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/12/2019 09:24, Dietmar Eggemann wrote:
> On 25/11/2019 10:46, Parth Shah wrote:
>> This patch series is based on the discussion started as the "Usecases for
>> the per-task latency-nice attribute"[1]
>>
>> This patch series introduces a new per-task attribute latency_tolerance to
>> provide the scheduler hints about the latency requirements of the task.
> 
> I forgot but is there a chance to have this as a per-taskgroup attribute
> as well?
> 

Peter argued we should go for task attributes first, and then
cgroup/taskgroups later on:

https://lore.kernel.org/lkml/20190905083127.GA2332@hirez.programming.kicks-ass.net/

