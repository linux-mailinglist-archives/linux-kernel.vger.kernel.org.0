Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52311E37B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 13:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfLMMUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 07:20:06 -0500
Received: from foss.arm.com ([217.140.110.172]:57216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfLMMUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:20:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CCC511B3;
        Fri, 13 Dec 2019 04:20:05 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DED93F718;
        Fri, 13 Dec 2019 04:20:04 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, chenwandun@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com, huawei.libin@huawei.com,
        bobo.shaobowang@huawei.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
 <20191212152406.GB2827@hirez.programming.kicks-ass.net>
 <d40ac385-626f-e86f-b2cb-69adf10a193a@huawei.com>
 <6d188305-66ab-81cf-6340-34d155dcaf3b@arm.com>
 <20191213120913.GB2844@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <0a0744f4-24cf-f8b6-cc91-f63847560675@arm.com>
Date:   Fri, 13 Dec 2019 12:20:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213120913.GB2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2019 12:09, Peter Zijlstra wrote:
>> Like you said the gains here would probably be small - the highest SMT
>> count I'm aware of is SMT8 (POWER9). Still, if we end up with both
>> select_idle_core() and select_idle_cpu() using that pattern, it would make
>> sense IMO to align select_idle_smt() with those.
> 
> The cpumask_and() operation added would also have cost. I really don't
> see that paying off.
> 
> The other sites have the problem that we combine an iteration limit with
> affinity constraints. This loop doesn't do that and therefore doesn't
> suffer the problem.
> 

select_idle_core() doesn't really have an iteration limit, right? That
being said, yeah, the cpumask_and() for e.g. SMT2 systems would be
mostly wasteful.
