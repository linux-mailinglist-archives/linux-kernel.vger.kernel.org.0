Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B9AC334C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfJALsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:48:20 -0400
Received: from foss.arm.com ([217.140.110.172]:47810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733130AbfJALsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:48:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CFA1337;
        Tue,  1 Oct 2019 04:48:19 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439CF3F534;
        Tue,  1 Oct 2019 04:48:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] sched/fair: Move active balance logic to its own
 function
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, qais.yousef@arm.com
References: <20190815145107.5318-1-valentin.schneider@arm.com>
 <20190815145107.5318-3-valentin.schneider@arm.com>
 <20191001111601.GA32306@linux.vnet.ibm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4ecdbee5-9eb5-a18c-80c4-3473d3f1124c@arm.com>
Date:   Tue, 1 Oct 2019 12:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001111601.GA32306@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2019 12:36, Srikar Dronamraju wrote:
>> +unlock:
>> +	raw_spin_unlock_irqrestore(&busiest->lock, flags);
>> +
>> +	if (status == started)
>> +		stop_one_cpu_nowait(cpu_of(busiest),
>> +				    active_load_balance_cpu_stop, busiest,
>> +				    &busiest->active_balance_work);
>> +
>> +	/* We've kicked active balancing, force task migration. */
>> +	if (status != cancelled_affinity)
>> +		sd->nr_balance_failed = sd->cache_nice_tries + 1;
> 
> Should we really update nr_balance_failed if status is cancelled?
> I do understand this behaviour was present even before this change. But
> still dont understand why we need to update if the current operation didn't
> kick active_load_balance.
> 

Agreed, I kept it as is to keep this as pure a code movement as possible,
but I don't see why this wouldn't be valid wouldn't be valid
(PoV of the current code):

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1fac444a4831..59f9e3583482 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9023,10 +9023,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 				stop_one_cpu_nowait(cpu_of(busiest),
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
-			}
 
-			/* We've kicked active balancing, force task migration. */
-			sd->nr_balance_failed = sd->cache_nice_tries+1;
+				/* We've kicked active balancing, force task migration. */
+				sd->nr_balance_failed = sd->cache_nice_tries+1;
+			}
 		}
 	} else
 		sd->nr_balance_failed = 0;
---

Or even better, fold it in active_load_balance_cpu_stop(). I could add that
after the move.
